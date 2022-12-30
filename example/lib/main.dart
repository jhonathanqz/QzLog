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
          ],
        ),
      ),
    );
  }

  Future<void> _insertLog() async {
    try {
      _incrementCounter();
      await QzLog()
          .insertLog(log: 'Test Log $_counter', exception: 'Function insert');
      _showSnack('insert sucess', null);
    } catch (e) {
      print('******Error to insert log: $e');
    }
  }

  Future<void> _checkLogExists() async {
    try {
      final _response = await QzLog().logExists();
      if (_response) {
        _showSnack('Exists logs from external storage', null);
        return;
      }
      _showSnack('Not exists logs from external storage', Colors.red);
    } catch (e) {
      print('******Error to check log: $e');
    }
  }

  Future<void> _exportLogs() async {
    try {
      await QzLog().exportLogs();
      _showSnack('Export sucess', null);
    } catch (e) {
      print('******Error to export log: $e');
    }
  }

  Future<void> _deleteAll() async {
    try {
      await QzLog().deleteAll();
      _showSnack('Delete all sucess', null);
    } catch (e) {
      print('******Error to delete all logs: $e');
    }
  }

  void _showSnack(String message, Color? color) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: color ?? Colors.green,
        duration: const Duration(
          seconds: 3,
        ),
      ),
    );
  }
}
