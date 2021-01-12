import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    final path = join(dbPath, 'todo.db');
    return await sql.openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks (id TEXT PRIMARY KEY, title TEXT, description TEXT)',
        );
      },
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<void> deleteTask(String table, String id) async {
    final db = await DBHelper.database();
    final count = await db.delete(table, where: 'id = ?', whereArgs: ['$id']);
  }
}
