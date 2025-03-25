import 'package:drift/drift.dart';
import 'package:todo/db/type/customdate.dart';
import 'package:todo/db/type/customtime.dart';

class Executions extends Table {
  IntColumn get id => integer().autoIncrement()();
  late final isChecked = boolean()();
  late final planId = integer()();
  late final title = text()();
  // done: date 类型使用什么方式表达更合理？使用普通数据库时，可以使用专门的时间格式来提升效率；sqlite 没有专门的时间格式，所以只能使用普通数据格式，例如 text
  late final startDate = text().map(CustomDateConverter())();
  late final startTime = text().map(CustomTimeTypeConverter())();
  late final createdOn = dateTime()();
  late final modifiedOn = dateTime()();
}