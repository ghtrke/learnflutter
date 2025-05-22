import 'execution.dart';

class ExecutionService {
  Database db;
  ExecutionService(this.db);

  Future<int> updateCheckStatus(int id, bool isChecked) async {
    return await db.update(
      'executions', 
      {'isChecked': isChecked ? 1 :0},
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  Future<void> generateExecutions() async {
    // read plans, startDate <= today
    List<Plan>? plans = await getValidPlans(db);

    //generate execution that suits today
    List<Execution>? executions = Execution.calculateExecutions(plans);

    // read existing executions and leave only those that do not have the coresponding executions
    List<Execution> currentExecutions = await getTodayExecutions();
    List<int> currentPlanIds = [];
    for (Execution e in currentExecutions) {
      currentPlanIds.add(e.planId);
    }

    if (executions != null && executions.isNotEmpty) {
      for (Execution e in executions) {
        if (!currentPlanIds.contains(e.planId)) {
         insertExecution(db, e);
        }
      }
    }
  }
}