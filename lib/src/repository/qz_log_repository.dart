import 'dart:io';

import 'package:csv/csv.dart';
import 'package:external_path/external_path.dart';

import 'package:qz_log/src/database/helper/database_helper.dart';
import 'package:qz_log/src/model/qz_log_model.dart';

class QzLogRepository {
  Future<List<QzLogModel>> get() async {
    try {
      final _response = await DatabaseHelper.get();
      return _response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insert({
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
      await DatabaseHelper.deleteAll();
      final _directory = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      final _rootDirectory = _directory;
      final _appDirectory = '$_rootDirectory/QzLog';

      if (Directory(_appDirectory).existsSync()) {
        Directory(_appDirectory).deleteSync(recursive: true);
      }
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

  Future<File?> exportLogs() async {
    try {
      final _directory = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);

      final _headers = [];
      final _listOfCollects = <List<dynamic>>[_headers];

      final _response = await get();
      String _lastNow = '';

      if (_response.isNotEmpty) {
        _response.forEach((e) {
          final _createdAt = 'createdAt: ${e.createdAt}';
          final _log = 'Log: ${e.log}';
          final _exception = 'Exception: ${e.exception}';

          _listOfCollects.add([_createdAt, _log, _exception]);
          _lastNow = e.createdAt ?? DateTime.now().toString();
        });

        final csv = const ListToCsvConverter().convert(_listOfCollects);

        final _rootDirectory = _directory;
        final _appDirectory = '$_rootDirectory/QzLog';

        if (!Directory(_appDirectory).existsSync()) {
          Directory(_appDirectory).createSync();
        }

        final _newDirectory = Directory(_appDirectory).path;

        final _fileName = 'QzLog_$_lastNow';
        final file = File('$_newDirectory/$_fileName.txt');
        if (file.existsSync()) {
          file.deleteSync();
        }
        await file.writeAsString(csv);
        return file;
      }
    } catch (e) {
      rethrow;
    }
  }
}
