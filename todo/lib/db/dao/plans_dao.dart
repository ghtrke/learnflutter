import 'package:drift/drift.dart';
import 'package:intl/intl.dart';
import '../database.dart';
import '../model/plans.dart';

part 'plans_dao.g.dart';


@DriftAccessor(tables: [Plans])
class PlansDao extends DatabaseAccessor<AppDatabase> with _$PlansDaoMixin {
  PlansDao(AppDatabase db) : super(db);

  Future<void> endPlan(int id, String startDateString) async {
    DateTime newDate = DateTime.parse(startDateString).subtract(const Duration(days: 1));
    String newDateString = DateFormat('yyyy-MM-dd').format(newDate);
    // set the endDate to startDate - 1
    await db.managers.plans.filter((p) => p.id.equals(id)).update((p) => p(startDate: Value(newDateString)));
  }

  Future<void> splitPlan(int id, String startDateString) async {
    // split the plan to two items, one ends at startDate - 1, another starts from startDate + 1
    DateTime startDate = DateTime.parse(startDateString);
    String endDateString = DateFormat('yyyy-MM-dd').format(startDate.subtract(const Duration(days: 1)));
    String newStartString = DateFormat('yyyy-MM-dd').format(startDate.add(const Duration(days: 1)));

    db.managers.plans.filter((p) => p.id.equals(id)).update((p) => p(endDate: Value(endDateString)));

    Plan oldPlan = await db.managers.plans.filter((p) => p.id.equals(id)).getSingle();
    insertPlan(
            title: oldPlan.title,
            startDate: newStartString,
            startTime: oldPlan.startTime,
            weekdays: oldPlan.weekdays
    );
  }

  Future<Plan> getPlan(int id) async {
    return await db.managers.plans.filter((f) => f.id.equals(id)).getSingle();
  }

  Future<void> updatePlan(int id, { 
                                    String? title, 
                                    String? startDate,
                                    String? startTime,
                                    String? weekdays,
                                    }) async {
    await (update(plans)..where((p) => p.id.equals(id))).write(
      PlansCompanion(
        title: Value.absentIfNull(title),
        startDate: Value.absentIfNull(startDate),
        startTime: Value.absentIfNull(startTime),
        weekdays: Value.absentIfNull(weekdays),
        modifiedOn: Value(DateTime.now()),
      )
    );
  }

  Future<void> insertPlan({ required String title,
                            required String startDate,
                            required String startTime,
                            String? weekdays,
                            }) async {
    //TODO: 弄懂 managers 的 insert 逻辑
    await into(plans).insert(PlansCompanion(
      title: Value(title),
      startDate: Value(startDate),
      startTime: Value(startTime),
      weekdays: Value.absentIfNull(weekdays),
      createdOn: Value(DateTime.now()),
      modifiedOn: Value(DateTime.now())
    ));
  }

  // TODO: 往回退一步，也许在 drift 的场景下不太适合使用 custom type
  // - 使用 datetime
  // - 使用 custom query, 直接写 customSelect, 或者使用生成方法
  // - 使用 custom expression,
  // - 使用 floor orm, 如何简洁替换 orm 实现
  // - floor 和 drift 的设计
  // - 查看源代码，如何自己实现 custom type 的 filter
  Future<List<Plan>> getValidPlansForDate(DateTime date) async {
    String todayString = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String dateString = DateFormat('yyyy-MM-dd').format(date);
    final results = await db.customSelect(
                              'select * from plans where start_date <=? and (end_date >=? or end_date is null)',
                              variables: [Variable(todayString), Variable(todayString)]
                            ).get();
    List<Plan> allPlans = results.map((row) => db.plans.map(row.data)).toList();

    // read each plan, if it does not have weekdays setup, check if the startDate equals date;
    // if it does have weekdays setup, check if the weekday matches date
    List<Plan> validPlans = [];
    for(Plan plan in allPlans) {
      String? weekdays = plan.weekdays;
      if ((weekdays == null || weekdays.isEmpty)) {
        if(plan.startDate == dateString) {
          validPlans.add(plan);
        }
      } else {
        String dateWeekday = getWeekdayName(date.weekday);
        if (plan.weekdays!.contains(dateWeekday)) {
          validPlans.add(plan);
        }
      }
    }

    return validPlans;
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