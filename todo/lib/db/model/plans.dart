import 'package:drift/drift.dart';

// entity 是数据库表格的对象化, 更接近数据库，因此数据格式定义使用数据库的格式
class Plans extends Table {
  // TODO: 为什么要多加一组括号？
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  // format: 2025-3-24
  late final startDate= text()();
  // format: 11:30
  late final startTime = text()();
  // weekdays format: 星期一，星期二
  late final weekdays = text().nullable()();
  // format: 2025-3-26
  late final endDate = text().nullable()();
  late final createdOn = dateTime()();
  late final modifiedOn = dateTime()();
}