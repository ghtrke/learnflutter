import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:todo/db/deprecated/execution_service.dart';

import 'plan.dart';
import 'execution.dart';

// TODO: database instance 使用的有点随意, 改造成连接池
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();

    return _database!;
  }

  Future<ExecutionService> get executionService async {
    Database db = await database;
    return ExecutionService(db);
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'manage.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute('''CREATE TABLE plans (
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          title TEXT, 
          startDate TEXT, 
          endDate TEXT,
          startTime TEXT,
          weekdays TEXT,
          createdOn TEXT, 
          modifiedOn TEXT
         );''').then((_) {
        return db.execute('''CREATE TABLE executions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          planId INTEGER,
          isChecked INTEGER DEFAULT 0,
          title TEXT,
          startDate TEXT,
          startTime TEXT,
          createdOn TEXT,
          modifiedOn TEXT,
          FOREIGN KEY (planId) REFERENCES plans(id)
         );''');
      });
    });
  }


  Future<List<Plan>?> getValidPlans(Database db) async { 
    String todayString = DateFormat('yyyy-MM-dd').format(DateTime.now());

    List<Map<String, dynamic>> qr = await db.query(
      'plans',
      where: 'startDate<=? AND (endDate >=? OR endDate is NULL)',
      whereArgs: [todayString, todayString],
    );

    return Plan.toPlans(qr);
  }

  Future<List<Execution>> getExecutions() async {
    //List<Execution> executions = await getTodayExecutions();
    //if(executions != null && executions.isNotEmpty) {
    //  return executions;
    //}

    await generateExecutions();
    List<Execution> executions = await getTodayExecutions();

    return executions;
  }

  Future<List<Execution>> getTodayExecutions() async {
    Database db = await database; 

    List<Map<String, dynamic>> qr = await db.query(
      'executions',
      where: 'startDate=?',
      whereArgs:[DateFormat('yyyy-MM-dd').format(DateTime.now())],
    );

    return Execution.toExecutionList(qr);
  }

  Future<Plan> getPlan(int id) async {
    Database db = await database;

    List results = await db.query(
      'plans',
      where: 'id=?',
      whereArgs: [id],
    );

    return Plan.toPlan(results[0])!;
  }

  Future<int> insertPlan({required String title, 
                          required DateTime startDate,
                          required TimeOfDay startTime,
                          List<String>? weekdays,
                          }) async {
    Database db = await database;
    String weekdayValues = "";
    if (weekdays != null && weekdays.isNotEmpty) {
      weekdayValues = weekdays.join(',');
    }
    String startTimeValue = '';
    if (startTime.minute == 0) {
      startTimeValue = '${startTime.hour}:0${startTime.minute}';
    } else {
      startTimeValue = '${startTime.hour}:${startTime.minute}';
    }
    return await db.insert(
      'plans', 
      {
        'title': title,
        'startDate': DateFormat('yyyy-MM-dd').format(startDate),
        'startTime': startTimeValue,
        'weekdays': weekdayValues,
        'createdOn': DateTime.now().toIso8601String(),
        'modifiedOn': DateTime.now().toIso8601String(),
      }
    );
  }

  Future<int> updatePlan(int id, {required String title, 
                                  required DateTime startDate, 
                                  required TimeOfDay startTime, 
                                  List<String>? weekdays, }) async {
    Database db = await database;
    String weekdayValues = "";
    if (weekdays != null && weekdays.isNotEmpty) {
      weekdayValues = weekdays.join(',');
    }

    return await db.update(
      'plans', 
      {
        'title': title,
        'startDate': DateFormat('yyyy-MM-dd').format(startDate),
        'startTime': "${startTime.hour}:${startTime.minute}",
        'weekdays': weekdayValues,
        'modifiedOn': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> removeItem(int id) async {
    Database db = await database;

    return await db.delete(
      'plans',
      where: 'id=?',
      whereArgs: [id],
    );
  }

  Future<void> insertExecutions(Database db, List<Execution>? es) async {
    if (es != null && es.isNotEmpty) {
      for (Execution e in es) {
        await insertExecution(db, e);
      }
    }
  }

  Future<int> insertExecution(Database db, Execution e) async {
    String startTimeValue = '';
    if (e.startTime!.minute == 0) {
      startTimeValue = '${e.startTime!.hour}:0${e.startTime!.minute}';
    } else {
      startTimeValue = '${e.startTime!.hour}:${e.startTime!.minute}';
    }

    return await db.insert('executions', {
      'title': e.title,
      'planId': e.planId,
      'isChecked': e.isChecked ? 1 : 0,
      'startDate': DateFormat('yyyy-MM-dd').format(e.startDate),
      'startTime': startTimeValue,
      'createdOn': DateTime.now().toIso8601String(),
      'modifiedOn': DateTime.now().toIso8601String(),
    });
  }

  Future<void> removeExecution(int id) async {
    Database db = await database;

    await db.execute('DELETE FROM executions where id=?', [id]);
  }

  Future<void> splitPlan(int planId, DateTime startDate) async {
    Plan plan = await getPlan(planId);

    await endPlan(planId, startDate);
    
    await insertPlan(
      title: plan.title, 
      startDate: startDate.add(const Duration(days: 1)), 
      startTime: plan.startTime,
      weekdays: plan.weekdays,
    );
  }

  Future<void> removeExecutions(DateTime startDate, int planId) async {
    Database db = await database;
   
    await db.execute(
      'DELETE FROM executions where startDate>=? AND planId=?',
      [DateFormat('yyyy-MM-dd').format(startDate), planId],
    );
  }

  Future<void> endPlan(int planId, startDate) async {
    // TODO: database 实例使用混乱
    // TODO: update 语句使用 int 返回还是 void 更好
    // TODO: db, plan, execution 拆分混乱
    // TODO: plan 的处理：当 startDate > enddate 时，删除这条 plan
    Database db = await database;

    DateTime yesterday = startDate.subtract(const Duration(days: 1));
    
    await db.update(
      'plans', 
      {
        'endDate': DateFormat('yyyy-MM-dd').format(yesterday),
        'modifiedOn': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [planId],
    );
  }
}

