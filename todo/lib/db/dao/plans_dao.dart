import 'package:drift/drift.dart';
import 'package:intl/intl.dart';
import '../database.dart';
import '../model/plans.dart';

part 'plans_dao.g.dart';


@DriftAccessor(tables: [Plans])
class PlansDao extends DatabaseAccessor<AppDatabase> with _$PlansDaoMixin {
  PlansDao(AppDatabase db) : super(db);

  Future<void> endPlan(int id, DateTime startDate) async {
    // set the endDate to startDate - 1
  }

  Future<void> splitPlan(int id, DateTime startDate) async {
    // split the plan to two items, one ends at startDate - 1, another starts from startDate + 1
  }

  Future<Plan> getPlan(int id) async {

  }

  Future<void> updatePlan(int id, PlansCompanion item) async {

  }

  Future<void> insertPlan(PlansCompanion item) async {

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
    final results = await db.customSelect(
                              'select * from plans where startDate<=? and (endDate>=? or endDate is null)',
                              variables: [Variable(todayString), Variable(todayString)]
                            ).get();
    return results.map((row) => plans.map(row.data)).toList();
  }

}