// DO: data class 的变量是否都应该做成 private 的？不应该，因为 data class 本质上是提供一个数据的聚合，如果不允许访问成员变量，那么这个类也没有什么意义了
// TODO: 如何避免 Execution 实例被随意修改
// TODO: 如何尽量保证实例的数据正确性
//   - 数据库层面添加约束
//   - 代码层面添加约束: 无论从哪种入口创建数据，都要符合约束

// CRUD
// 定时生成周期
// 加载的执行数量

// 执行生成策略：
// - 计划和执行的关系：
//    - 执行已经过期时，不允许编辑或者删除
//    - 编辑/删除执行时，已经过期的执行不变(需要生成新计划), 对已经生成的执行即刻生效
//    - 编辑/删除执行时，允许用户选择影响当前执行还是后续执行, 对已经生成的执行即刻生效
// - 生成执行策略
//    - 定时生成: 每天凌晨 1 点开始生成执行, 确保每天的执行都会生成
//    - 列表加载时，根据计划计算当日执行，更新数据库中的执行
import 'package:flutter/material.dart';
import 'plan.dart';

class Execution {
  int? id;
  bool isChecked;
  late int planId;
  late String title;
  // done: date 类型使用什么方式表达更合理？使用普通数据库时，可以使用专门的时间格式来提升效率；sqlite 没有专门的时间格式，所以只能使用普通数据格式，例如 text
  late DateTime startDate;
  TimeOfDay? startTime;
  DateTime? createdOn;
  DateTime? modifiedOn;

  Execution(
    {
      this.id, 
      this.isChecked = false,
      required this.planId,
      required this.title, 
      required this.startDate,
      this.startTime,
      this.createdOn,
      this.modifiedOn
    }
  );

  // TODO: 当查询不到内容时，返回 null 还是空列表更合适？
  static List<Execution> toExecutionList(List<Map<String, dynamic>> items) {
    List<Execution> result = [];

    for (Map<String, dynamic> i in items) {
      Execution? e = toExecution(i);

      if (e !=null) {
        result.add(e);
      }
    }
    return result; 
  }

  static Execution? toExecution(Map<String, dynamic>? item) {
    return item == null ? null : Execution(
      id: item['id'],
      planId: item['planId'],
      isChecked: item['isChecked'] == 1 ? true : false,
      title: item['title'],
      startDate: DateTime.parse(item['startDate']),
      startTime: item['startTime'] == null ? null : Plan.parseStringToTime(item['startTime']),
      createdOn: item['createdOn'] == null ? DateTime.now() : DateTime.parse(item['createdOn']),
      modifiedOn: item['modifiedOn'] == null ? DateTime.now() : DateTime.parse(item['modifiedOn'])
    );
  }

  static List<Execution>? calculateExecutions(List<Plan>? plans) {
    if(plans == null || plans.isEmpty) {
      return null;
    }

    List<Execution>? executions = [];
    for(Plan plan in plans) {
    // if startTime == today, generate an execution
      if(plan.startDate == DateTime.now()) {
        executions.add(convertPlanToExecution(plan));
      } else if (plan.weekdays != null && plan.weekdays!.isNotEmpty){
        // if startTime < today && weekdays isNotEmpty, check whether weekdays match today
        String todayWeekday = getWeekdayName(DateTime.now().weekday);
        if(plan.weekdays!.contains(todayWeekday)) {
          executions.add(convertPlanToExecution(plan));
        }
      }
    }
    return executions;
  }

  static Execution convertPlanToExecution(Plan plan) {
    return Execution( 
      id: null, 
      isChecked: false,
      planId: plan.id!, 
      title: plan.title,
      startDate: plan.startDate,
      startTime: plan.startTime
    );
  }

  static getWeekdayName(int number) {
    switch(number) {
      case 1:
        return '星期一';
      case 2:
        return '星期二';
      case 3:
        return '星期三';
      case 4:
        return '星期四';
      case 5:
        return '星期五';
      case 6:
        return '星期六';
      case 7:
        return '星期日';
      default:
        return '无效的日期';
    }
  }
}
