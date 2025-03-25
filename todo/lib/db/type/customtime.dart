import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

class CustomTimeTypeConverter extends TypeConverter<TimeOfDay, String> {
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
    String minute = (value.minute == 0) ? '0${value.minute}': '${value.minute}';
    return '${value.hour}:$minute';
  }
}