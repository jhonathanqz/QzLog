import 'dart:io';

import 'package:qz_log/src/model/qz_log_model.dart';
import 'package:qz_log/src/repository/permission_repository.dart';
import 'package:qz_log/src/repository/qz_log_repository.dart';

//Class responsible only for controlling user calls
class QzLog {
  //Function to erase all log records in the database and exported files.
  static Future<void> deleteAll() async {
    try {
      await QzLogRepository.deleteAll();
    } catch (e) {
      rethrow;
    }
  }

  //Function to delete all logs stored in the database.
  static Future<void> deleteLogFromDatabase() async {
    try {
      await QzLogRepository.deleteLogFromDatabase();
    } catch (e) {
      rethrow;
    }
  }

  //Function to erase all exported files in the external memory of the device.
  static Future<void> deleteAllFiles() async {
    try {
      await QzLogRepository.deleteAllFiles();
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
      await QzLogRepository.insertLog(
        log: log,
        exception: exception,
      );
    } catch (e) {
      rethrow;
    }
  }

  //Function to obtain a list of all logs recorded in the database.
  static Future<List<QzLogModel>> getAllLogs() async {
    try {
      return await QzLogRepository.getAllLogs();
    } catch (e) {
      rethrow;
    }
  }

  //Function to check if there is any log recorded in the database.
  static Future<bool> logExists() async {
    try {
      return await QzLogRepository.logExists();
    } catch (e) {
      rethrow;
    }
  }

  //Function to export the logs to a file on the device's external storage.
  static Future<File?> exportLogs() async {
    try {
      return await QzLogRepository.exportLogs();
    } catch (e) {
      rethrow;
    }
  }

  //Check and if necessary obtain device storage permissions.
  static Future<void> checkAndRequestPermission() async {
    try {
      return await PermissionRepository.checkAndRequestPermission();
    } catch (e) {
      rethrow;
    }
  }
}
