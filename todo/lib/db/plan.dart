import 'package:drift/drift.dart' show Table;
import 'package:flutter/material.dart';
import 'package:drift/drift.dart';

class Plan {
  int? id;
  late String title;
  // done: date 类型使用什么方式表达更合理？使用普通数据库时，可以使用专门的时间格式来提升效率；sqlite 没有专门的时间格式，所以只能使用普通数据格式，例如 text
  late DateTime startDate;
  late TimeOfDay startTime; 
  // TODO: Plan 代表的是从数据库中加载的值，还是要写入数据库的值，这里怎么设计更好？
  List<String>? weekdays;
  DateTime? endDate;
  DateTime? createdOn;
  DateTime? modifiedOn;

  Plan(
    {
      this.id, 
      required this.title, 
      required this.startDate,
      required this.startTime,
      this.endDate,
      this.weekdays,
      this.createdOn,
      this.modifiedOn,
    }
  );

  static Plan? toPlan(Map<String, dynamic>? item) {
    if (item == null) {
      return null;
    }

    return Plan(
      id: item['id'],
      title: item['title'],
      startDate: DateTime.parse(item['startDate']),
      endDate: item['endDate'] == null ? null : DateTime.parse(item['endDate']),
      startTime: parseStringToTime(item['startTime'])!,
      weekdays: item['weekdays']?.split(','),
      createdOn: item['createdOn'] == null ? DateTime.now() : DateTime.parse(item['createdOn']),
      modifiedOn: item['modifiedOn'] == null ? DateTime.now() : DateTime.parse(item['modifiedOn'])
    );
  }

  static List<Plan>? toPlans(List<Map<String, dynamic>>? items) {
    if (items == null) {
      return null;
    }

    List<Plan> plans = []; 
    for(Map<String, dynamic> item in items) {
      Plan? plan = Plan.toPlan(item);
      if (plan != null) {
        plans.add(plan);
      }
    }

    return plans;
  }

  static TimeOfDay? parseStringToTime(String? timeString) {
    if (timeString == null) {
      return null;
    }

    List<String> timeParts = timeString.split(':');
    int timeHour = int.parse(timeParts[0]);
    int timeMinute = int.parse(timeParts[1]);

    return TimeOfDay(hour: timeHour, minute: timeMinute);
  }

  static String? timeToString(TimeOfDay? time) {
    if (time == null) {
      return null;
    }

    if (time.minute == 0) {
      return '${time.hour}:0${time.minute}';
    } else {
      return '${time.hour}:${time.minute}';
    }
  }
}