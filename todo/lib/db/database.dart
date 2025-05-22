import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dao/executions_dao.dart';
import 'dao/plans_dao.dart';
import 'model/executions.dart';
import 'model/plans.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Plans, Executions], daos:[PlansDao, ExecutionsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'todo_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationDocumentsDirectory,
      )
    );
  }

  void test() {
    select(executions).get();
  }
  
}

class DatabaseInstance {
  static final DatabaseInstance _instance = DatabaseInstance._internal();
  factory DatabaseInstance() => _instance;
  DatabaseInstance._internal();

  static AppDatabase? _database;

  AppDatabase get database {
    if (_database != null) return _database!;
    _database = AppDatabase();

    return _database!;
  }

  ExecutionsDao get executionsDao {
    return database.executionsDao;
  }

  PlansDao get plansDao {
    return database.plansDao;
  }
}