import 'dart:io';

import 'package:qz_log/src/model/qz_log_model.dart';
import 'package:qz_log/src/repository/permission_repository.dart';
import 'package:qz_log/src/repository/qz_log_repository.dart';

class QzLog {
  final _repository = QzLogRepository();
  Future<void> deleteAll() async {
    try {
      await _repository.deleteAll();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteLogFromDatabase() async {
    try {
      await _repository.deleteLogFromDatabase();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAllFiles() async {
    try {
      await _repository.deleteAllFiles();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insertLog({
    required String log,
    String? exception,
  }) async {
    try {
      await _repository.insertLog(
        log: log,
        exception: exception,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<QzLogModel>> getAllLogs() async {
    try {
      return await _repository.getAllLogs();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> logExists() async {
    try {
      return await _repository.logExists();
    } catch (e) {
      rethrow;
    }
  }

  Future<File?> exportLogs() async {
    try {
      return await _repository.exportLogs();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> checkAndRequestPermission() async {
    try {
      return await PermissionRepository.checkAndRequestPermission();
    } catch (e) {
      rethrow;
    }
  }
}
