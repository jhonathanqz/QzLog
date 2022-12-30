import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qz_log/src/model/qz_log_model.dart';

class DatabaseStrings {
  static const name = 'qz_log.db';

  static const logTable = 'Qzlog';
  static const logTableScript =
      'CREATE TABLE $logTable (id INTEGER PRIMARY KEY AUTOINCREMENT, createdAt TEXT, log TEXT, exception TEXT)';
}

class DatabaseHelper {
  static Database? _database;

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute(DatabaseStrings.logTableScript);
  }

  static Future<Database> get database async {
    final path = join(
      await getDatabasesPath(),
      DatabaseStrings.name,
    );

    _database ??= await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );

    return _database!;
  }

  static Future<List<QzLogModel>> get() async {
    List<QzLogModel> _list = [];
    try {
      final tmpDb = await database;

      final result = await tmpDb.query(DatabaseStrings.logTable);

      if (result.isEmpty) {
        //throw DatabaseNotFoundException('Nenhum dado encontrado');
        return _list;
      }

      result.forEach((e) {
        final _model = QzLogModel.fromJson(e);
        _list.add(_model);
      });

      return _list;
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> insert(QzLogModel logModel) async {
    try {
      final tmpDb = await database;

      await tmpDb.insert(
        DatabaseStrings.logTable,
        logModel.toJson(),
      );
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> deleteAll() async {
    try {
      final tmpDb = await database;

      await tmpDb.delete(DatabaseStrings.logTable);
    } catch (_) {
      rethrow;
    }
  }
}
