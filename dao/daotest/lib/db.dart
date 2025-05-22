import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'person_dao.dart';

class DatabaseInstance {
  static final DatabaseInstance _instance = DatabaseInstance._internal();
  factory DatabaseInstance() => _instance;
  DatabaseInstance._internal();

  static Database? _database;

  Future<Database> _prepDatabase() async {
    if(_database != null) return _database!;

    _database = await _initDB();

    return _database!;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'person.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      create table person(
        id integer primary key autoincrement,
        name TEXT
      );
    ''');
  }

  Future<PersonDao> get personDao async {
    Database db = await _prepDatabase();

    return PersonDao(db);
  }
}