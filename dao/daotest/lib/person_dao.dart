import 'package:sqflite/sqflite.dart';

class PersonDao{
  Database db;

  PersonDao(this.db);

  Future<void> insert() async {
    await db.insert(
      'person',
      {
        'name': 'hgao',
      }
    );
  }
}