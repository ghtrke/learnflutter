import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show TimeOfDay;

class DateConverter extends TypeConverter<TimeOfDay, String> {
  @override
  TimeOfDay fromSql(String fromDb) {
    List<String> parts = ['', ''];
    if (fromDb.isNotEmpty) {
      parts = fromDb.split(':');
    }
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  @override
  String toSql(TimeOfDay value) {
    return '${value.hour}:${value.minute}';
  }
}

class DateTests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text().map(DateConverter())();
}