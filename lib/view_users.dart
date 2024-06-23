import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static late Database _db;

  Future<Database> get db async {
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'main.db');
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE Results(id INTEGER PRIMARY KEY, result TEXT)');
  }

  Future<int> saveResult(String result) async {
    var dbClient = await db;
    int res = await dbClient.insert("Results", {'result': result});
    return res;
  }

  Future<List> getResults() async {
    var dbClient = await db;
    var res = await dbClient.query("Results");
    return res.toList();
  }
}

class ResultsTable extends StatefulWidget {
  const ResultsTable({super.key});

  @override
  _ResultsTableState createState() => _ResultsTableState();
}

class _ResultsTableState extends State<ResultsTable> {
  DatabaseHelper dbHelper = DatabaseHelper();
  late List results;

  @override
  void initState() {
    super.initState();
    dbHelper.getResults().then((value) {
      setState(() {
        results = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results Table'),
      ),
      body: results.isNotEmpty
          ? ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(results[index]['result']),
                );
              },
            )
          : const Center(
              child: Text('No entries'),
            ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ResultsTable(),
  ));
}