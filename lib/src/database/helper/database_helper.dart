import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qz_log/src/model/qz_log_model.dart';

class DatabaseStrings {
  //database name
  static const name = 'qz_log.db';
  //Table name to store the logs
  static const logTable = 'Qzlog';
  //Script to create a table in the database, with the necessary fields.
  static const logTableScript =
      'CREATE TABLE $logTable (id INTEGER PRIMARY KEY AUTOINCREMENT, createdAt TEXT, log TEXT, exception TEXT)';
}

class DatabaseHelper {
  static Database? _database;
  //Create the database
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

  //Function to get the data from the database
  static Future<List<QzLogModel>> get() async {
    List<QzLogModel> _list = [];
    try {
      //Function to get the instance of the created database.
      final tmpDb = await database;
      //running the command to get the data from a table
      final result = await tmpDb.query(DatabaseStrings.logTable);

      if (result.isEmpty) {
        return _list;
      }

      //Going through the list of results and mapping the fields according to the model.
      for (var e in result) {
        final _model = QzLogModel.fromJson(e);
        _list.add(_model);
      }

      return _list;
    } catch (_) {
      rethrow;
    }
  }

  //Function to insert data into the database.
  static Future<void> insert(QzLogModel logModel) async {
    try {
      final tmpDb = await database;
      //Execution of the command, passing the parameter to be recorded in the database.
      await tmpDb.insert(
        DatabaseStrings.logTable,
        logModel.toJson(),
      );
    } catch (_) {
      rethrow;
    }
  }

  //Function to delete all database records.
  static Future<void> deleteAll() async {
    try {
      final tmpDb = await database;

      await tmpDb.delete(DatabaseStrings.logTable);
    } catch (_) {
      rethrow;
    }
  }
}
