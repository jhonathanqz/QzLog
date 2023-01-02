import 'dart:io' as Io;

import 'package:csv/csv.dart';

import 'package:qz_log/src/database/helper/database_helper.dart';
import 'package:qz_log/src/model/qz_log_model.dart';
import 'package:qz_log/src/repository/ext_storage_repository.dart';

class QzLogRepository {
  Future<List<QzLogModel>> getAllLogs() async {
    try {
      final _response = await DatabaseHelper.get();
      return _response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insertLog({
    required String log,
    String? exception,
  }) async {
    try {
      final _newModel = QzLogModel(
        createdAt: DateTime.now().toString(),
        log: log,
        exception: exception,
      );
      return await DatabaseHelper.insert(_newModel);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAll() async {
    try {
      await deleteLogFromDatabase();
      await deleteAllFiles();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAllFiles() async {
    try {
      final _appDirectory = await ExtStorageRepository.getPathFolderApp(
          type: extPublicDir.Download, folderName: 'QzLog');

      if (Io.Directory(_appDirectory).existsSync()) {
        Io.Directory(_appDirectory).deleteSync(recursive: true);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteLogFromDatabase() async {
    try {
      await DatabaseHelper.deleteAll();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> logExists() async {
    try {
      final _response = await DatabaseHelper.get();
      if (_response.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<Io.File?> exportLogs() async {
    try {
      final _appDirectory =
          await ExtStorageRepository.createFolderInPublicDirectory(
              type: extPublicDir.Download, folderName: 'QzLog');

      final _headers = [];
      final _listOfCollects = <List<dynamic>>[_headers];

      final _response = await getAllLogs();
      String _lastNow = '';

      if (_response.isNotEmpty) {
        _response.forEach((e) {
          final _createdAt = 'createdAt: ${e.createdAt}';
          final _log = 'Log: ${e.log}';
          final _exception = 'Exception: ${e.exception}';

          _listOfCollects.add([_createdAt, _log, _exception]);
          _lastNow = e.createdAt ?? DateTime.now().toString();
        });

        final _csv = const ListToCsvConverter().convert(_listOfCollects);

        if (!Io.Directory(_appDirectory).existsSync()) {
          Io.Directory(_appDirectory).createSync(recursive: true);
        }

        final _newDirectory = _appDirectory;

        final _fileName = 'QzLog_$_lastNow';
        final _file = Io.File('$_newDirectory/$_fileName.txt');
        if (_file.existsSync()) {
          _file.deleteSync();
        }
        await _file.writeAsString(_csv);
        return _file;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
