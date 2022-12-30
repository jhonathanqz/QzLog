import 'package:qz_log/src/model/qz_log_model.dart';
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

  Future<void> insertLog({
    required String log,
    String? exception,
  }) async {
    try {
      await _repository.insert(
        log: log,
        exception: exception,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<QzLogModel>> get() async {
    try {
      return await _repository.get();
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

  Future<void> exportLogs() async {
    try {
      await _repository.exportLogs();
    } catch (e) {
      rethrow;
    }
  }
}
