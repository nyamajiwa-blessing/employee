import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late Database _database;
  static const String tableName = 'user_entries';

  Future<Database> get database async {
    return _database;
  }
  

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_entries.db');

    return await openDatabase(path, version: 1, onCreate: (Database db, int version) {
      return db.execute('CREATE TABLE $tableName(id INTEGER PRIMARY KEY, entry TEXT)');
    });
  }

  Future<void> insertEntry(String entry) async {
    final db = await database;
    await db.insert(tableName, {'entry': entry});
  }

  Future<List<Map<String, dynamic>>> getEntries() async {
    final db = await database;
    return db.query(tableName);
  }

  DatabaseHelper(){
    initDatabase();
  }
}