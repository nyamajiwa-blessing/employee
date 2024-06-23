import 'package:employee/database_hepler_class.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Details());
}

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TextFieldEntriesScreen(),
    );
  }
}

class TextFieldEntriesScreen extends StatefulWidget {
  @override
  _TextFieldEntriesScreenState createState() => _TextFieldEntriesScreenState();
}

class _TextFieldEntriesScreenState extends State<TextFieldEntriesScreen> {
  final TextEditingController _textController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  void _saveEntry() {
    String entry = _textController.text;
    _databaseHelper.insertEntry(entry);
    _textController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save Employee Details'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Enter text')),
          ElevatedButton(
              onPressed: _saveEntry, child: const Text('Save Entry')),
          FutureBuilder(
            future: _databaseHelper.getEntries(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                final entries = snapshot.data as List<Map<String, dynamic>>;
                return Column(
                  children:
                      entries.map((entry) => Text(entry['entry'])).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
