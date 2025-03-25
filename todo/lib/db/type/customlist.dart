import 'package:drift/drift.dart';

class CustomListConverter extends TypeConverter<List<String>, String> {
  @override
  List<String> fromSql(String fromDb) {
    List<String> items = [];
    if (fromDb.isNotEmpty) {
      items = fromDb.split(',');
    }

    return items;
  }

  @override
  String toSql(List<String> value) {
    return value.join(',');
  }
}