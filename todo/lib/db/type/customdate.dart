import 'package:drift/drift.dart';
import 'package:intl/intl.dart';

class CustomDateConverter extends TypeConverter<DateTime, String> {
  @override
  DateTime fromSql(String fromDb) {
    return DateTime.parse(fromDb);
  }

  @override
  String toSql(DateTime value) {
    return DateFormat('yyyy-MM-dd').format(value);
  }
}