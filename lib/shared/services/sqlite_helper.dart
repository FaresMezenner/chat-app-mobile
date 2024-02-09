import 'package:chat_app/core/constants/enums/tables.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHelper {
  static final instance = SqliteHelper._();
  factory SqliteHelper() => instance;
  SqliteHelper._();

  Database? _db;
  Future<Database> getDatabase() async {
    if (_db == null) {
      final String path = join(await getDatabasesPath(), 'database.db');
      _db = await openDatabase(path, onCreate: (db, version) async {
        await db.execute('CREATE TABLE ${Tables.contacts.getName()}('
            'id TEXT PRIMARY KEY, '
            'phone TEXT, '
            'name TEXT)');
      }, version: 1);
    }
    return _db!;
  }

  Future<int> insert(Map<String, dynamic> data, String table) async {
    final Database db = await getDatabase();

    return db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final Database db = await getDatabase();
    return db.query(table);
  }

  Future<int> update(Map<String, dynamic> data, String table) async {
    final Database db = await getDatabase();
    return db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  Future<int> delete(String id, String table) async {
    final Database db = await getDatabase();
    return db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Map<String, dynamic>> getOne(String id, String table) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.first;
  }

  Future<List<Map<String, dynamic>>> getByField(
      String field, String value, Tables table) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      table.getName(),
      where: '$field = ?',
      whereArgs: [value],
    );
    return maps;
  }
}
