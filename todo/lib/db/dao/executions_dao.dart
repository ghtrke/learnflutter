import 'package:drift/drift.dart';
import 'package:intl/intl.dart';
import '../database.dart';
import '../model/executions.dart';

part 'executions_dao.g.dart';


@DriftAccessor(tables: [Executions])
class ExecutionsDao extends DatabaseAccessor<AppDatabase> with _$ExecutionsDaoMixin {
  ExecutionsDao(AppDatabase db) : super(db);

  Future<void> updateCheckStatus(int id, bool value) async {
    await db.managers.executions
      .filter((e) => e.id.equals(id)) 
      .update((n) => ExecutionsCompanion(isChecked: Value(value)));
  }

  Future<List<Execution>> getExecutions() async {
    // generate all executions for today
    await _prepExecutions(DateTime.now());

    // get today's executions
    List<Execution> executions = await _getExistingExecutions(DateTime.now());

    return executions;
  }

  Future<void> _prepExecutions(DateTime date) async {
    // get all plans valid to date
    List<Plan> plans = await db.plansDao.getValidPlansForDate(date);

    List<Execution> existingExecutions = await _getExistingExecutions(date);

    // update executions in db
    await _updateExecutions(existingExecutions, plans);
  }

  Future<List<Execution>> _getExistingExecutions(DateTime date) async {
    String dateString = DateFormat('yyyy-MM-dd').format(date);
    List<Execution> executions = await (db.select(db.executions)..where((f) => f.startDate.equals(dateString))).get();

    return executions;
  }

  Future<void> _updateExecutions(List<Execution> existingExecutions, List<Plan> plans) async {
    List<int> existingExecutionPlanIds = existingExecutions.map((row) => row.planId).toList();

    for(Plan plan in plans) {
      if (!existingExecutionPlanIds.contains(plan.id)) {
        await _generateExecution(plan);
      }
    }
  }

  Future<void> _generateExecution(Plan plan) async {
    await db.managers.executions.create(
                           (e) => e(
                            isChecked: false,
                            planId: plan.id,
                            title: plan.title,
                            startDate: plan.startDate,
                            startTime: plan.startTime,
                            createdOn: DateTime.now(),
                            modifiedOn: DateTime.now())
                          );
  }

  Future<void> removeExecution(int id) async {
    await db.managers.executions
      .filter((e) => e.id.equals(id))
      .delete();
  }

  Future<void> removeExecutions(String dateString, int planId) async {
    // remove all executions >= startDate generated from planId
    // TODO: 使用 DateTime, 时间全部填零
    // TODO: 使用 text, 比较操作
    await db.customUpdate('delete from executions where plan_id == ? and start_date >= ?', variables: [Variable(planId), Variable(dateString)]);
  }
}