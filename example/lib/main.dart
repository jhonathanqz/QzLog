import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:qz_log/qz_log.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QzLog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final int _secondsInformation = 3;

  final _infColor = Colors.amber;
  final _errorColor = Colors.red;
  final _sucessColor = Colors.green;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async => await _insertLog(),
              child: const Text('Insert Log'),
            ),
            ElevatedButton(
              onPressed: () async => await _checkLogExists(),
              child: const Text('Check log exists'),
            ),
            ElevatedButton(
              onPressed: () async => await _exportLogs(),
              child: const Text('Export Log'),
            ),
            ElevatedButton(
              onPressed: () async => await _deleteAll(),
              child: const Text('Delete All Logs'),
            ),
            ElevatedButton(
              onPressed: () async => await _deleteLogFromDatabase(),
              child: const Text('Delete log from Database'),
            ),
            ElevatedButton(
              onPressed: () async => await _deleteAllFiles(),
              child: const Text('Delete All Files Logs'),
            ),
            ElevatedButton(
              onPressed: () async => await _checkAndReuqestPermission(),
              child: const Text('check and Request permissions'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _insertLog() async {
    try {
      _incrementCounter();
      await QzLog.insertLog(
          log: 'Test Log $_counter', exception: 'Function insert');
      _showSnack('insert sucess', null);
    } catch (e) {
      log('Error to insert log: $e');
    }
  }

  Future<void> _checkLogExists() async {
    try {
      final _response = await QzLog.logExists();
      if (_response) {
        _showSnack('Exists logs from external storage', null);
        return;
      }
      _showSnack('Not exists logs from external storage', _errorColor);
    } catch (e) {
      log('Error to check log: $e');
    }
  }

  Future<void> _exportLogs() async {
    try {
      final _response = await QzLog.exportLogs();
      if (_response != null) {
        return _showSnack('Export sucess', null);
      }
      _showSnack('Log is empty from database', _infColor);
    } catch (e) {
      log('Error to export log: $e');
      _showSnack('Error to export logs', _errorColor);
    }
  }

  Future<void> _deleteAll() async {
    try {
      await QzLog.deleteAll();
      _showSnack('Delete all sucess', null);
    } catch (e) {
      log('Error to delete all logs: $e');
    }
  }

  Future<void> _deleteLogFromDatabase() async {
    try {
      await QzLog.deleteLogFromDatabase();
      _showSnack('Delete log from database sucess', null);
    } catch (e) {
      log('Error to delete log from database: $e');
    }
  }

  Future<void> _deleteAllFiles() async {
    try {
      await QzLog.deleteAllFiles();
      _showSnack('Delete all files sucess', null);
    } catch (e) {
      log('Error to delete all files logs: $e');
    }
  }

  Future<void> _checkAndReuqestPermission() async {
    try {
      await QzLog.checkAndRequestPermission();
      _showSnack('Check and request sucess', null);
    } catch (e) {
      log('Error to check and request permission: $e');
    }
  }

  void _showSnack(String message, Color? color) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: color ?? _sucessColor,
        duration: Duration(
          seconds: _secondsInformation,
        ),
      ),
    );
  }
}
