// ignore_for_file: library_prefixes

import 'dart:io' as Io;

import 'package:csv/csv.dart';

import 'package:qz_log/src/database/helper/database_helper.dart';
import 'package:qz_log/src/model/qz_log_model.dart';
import 'package:qz_log/src/repository/ext_storage_repository.dart';

//Class responsible for processing the received parameters,
//and passing them on to the necessary functions.
class QzLogRepository {
  //Function to obtain a list of all logs recorded in the database.
  static Future<List<QzLogModel>> getAllLogs() async {
    try {
      final _response = await DatabaseHelper.get();
      return _response;
    } catch (e) {
      rethrow;
    }
  }

  //Function to insert a new record in the database.
  static Future<void> insertLog({
    required String log,
    String? exception,
  }) async {
    try {
      //Process the received data and convert it in the correct way to be stored.
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

  //Function to erase all log records in the database and exported files.
  static Future<void> deleteAll() async {
    try {
      await deleteLogFromDatabase();
      await deleteAllFiles();
    } catch (e) {
      rethrow;
    }
  }

  //Function to erase all exported files in the external memory of the device.
  static Future<void> deleteAllFiles() async {
    try {
      final _appDirectory = await ExtStorageRepository.getPathFolderApp(
          type: ExtPublicDir.Download, folderName: 'QzLog');

      if (Io.Directory(_appDirectory).existsSync()) {
        Io.Directory(_appDirectory).deleteSync(recursive: true);
      }
    } catch (e) {
      rethrow;
    }
  }

  //Function to delete all logs stored in the database.
  static Future<void> deleteLogFromDatabase() async {
    try {
      await DatabaseHelper.deleteAll();
    } catch (e) {
      rethrow;
    }
  }

  //Function to check if there is any log recorded in the database.
  static Future<bool> logExists() async {
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

  //Function to export the logs to a file on the device's external storage.
  static Future<Io.File?> exportLogs() async {
    try {
      //Get directory where file will be stored
      final _appDirectory =
          await ExtStorageRepository.createFolderInPublicDirectory(
              type: ExtPublicDir.Download, folderName: 'QzLog');

      final _headers = [];
      final _listOfCollects = <List<dynamic>>[_headers];

      //Gets a list of logs stored in the database
      final _response = await getAllLogs();
      String _lastNow = '';

      if (_response.isNotEmpty) {
        //Goes through the list of logs obtained and maps/processes the fields obtained,
        //recording them in a file to be exported in the device's memory
        for (var e in _response) {
          final _createdAt = 'CreatedAt: ${e.createdAt}';
          final _log = ' Log: ${e.log}';
          final _exception = ' Exception: ${e.exception}';

          _listOfCollects.add([_createdAt, _log, _exception]);
          _lastNow = e.createdAt ?? DateTime.now().toString();
        }

        //Convert the information to a String
        final _csv = const ListToCsvConverter().convert(_listOfCollects);

        //Checks if the directory already exists in the device storage, if not, it already creates it.
        if (!Io.Directory(_appDirectory).existsSync()) {
          Io.Directory(_appDirectory).createSync(recursive: true);
        }

        final _newDirectory = _appDirectory;

        final _fileName = 'QzLog_$_lastNow';
        final _file = Io.File('$_newDirectory/$_fileName.txt');
        if (_file.existsSync()) {
          _file.deleteSync();
        }
        //Writes the file to the specified directory
        await _file.writeAsString(_csv);
        return _file;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
