import 'package:drift/drift.dart';
import 'package:todo/db/type/customdate.dart';
import 'package:todo/db/type/customtime.dart';
import 'package:todo/db/type/customlist.dart';

// entity 是数据库表格的对象化, 更接近数据库，因此数据格式定义使用数据库的格式
class Plans extends Table {
  // TODO: 为什么要多加一组括号？
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  // date format: 2024-01-02
  late final startDate= text().map(CustomDateConverter())();
  // time format: 11:30
  late final startTime = text().map(CustomTimeTypeConverter())();
  //weekdays format: 星期一，星期二
  late final weekdays = text().map(CustomListConverter()).nullable()();
  late final endDate = dateTime().nullable()();
  late final createdOn = dateTime()();
  late final modifiedOn = dateTime()();
}