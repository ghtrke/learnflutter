import 'package:drift/drift.dart';
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

  Future<List<Execution>> getExecutions(){
    // generate all executions for today
    prepExecutions(DateTime.now());

    // get today's executions
    return await _getUpdatedExecutions(DateTime.now());
  }

  Future<void> _prepExecutions(DateTime date) {
    //

  }

  Future<List<Execution>> _getUpdatedExecutions(DateTime date) {

  }

  Future<void> removeExecution(int id) async {
    db.select(executions).get();
    await db.managers.executions
      .filter((e) => e.id.equals(id))
      .delete();
  }

  Future<void> removeExecutions(DateTime startDate, int planId) async {
    // remove all executions >= startDate generated from planId

  }

}