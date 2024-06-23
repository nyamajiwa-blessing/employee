import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  const EmployeeDetailsScreen({super.key});

  @override
  _EmployeeDetailsScreenState createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  final _textController = TextEditingController();
  String _selectedRadioButtonOption = '';

  final List<String> radioButtonOptions = ['Town Council', 'ZESA'];

  late Future<Database> _database;

  @override
  void initState() {
    super.initState();
    _database = _initDatabase();
  }

  Future<Database> _initDatabase() async {
    // Initialize the database
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/employee_database.db';

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    // Create the table for employee details
    await db.execute('''
      CREATE TABLE employee_details (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        option TEXT NOT NULL
      )
    ''');
  }

  Future<void> _saveEntry() async {
    final name = _textController.text;
    final option = _selectedRadioButtonOption;

    if (name.isNotEmpty && option.isNotEmpty) {
      final db = await _database;
      await db.insert('employee_details', {
        'name': name,
        'option': option,
      });

      _textController.clear();
      setState(() {
        _selectedRadioButtonOption = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save Employee Details'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Enter Employee Name: '),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: radioButtonOptions.map((option) {
                return RadioListTile<String>(
                  value: option,
                  groupValue: _selectedRadioButtonOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedRadioButtonOption = value!;
                    });
                  },
                  title: Text(option),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveEntry,
              child: const Text('Save Entry'),
            ),
          ],
        ),
      ),
    );
  }
}