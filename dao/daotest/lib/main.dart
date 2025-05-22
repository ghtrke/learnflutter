import 'package:flutter/material.dart';
import 'db.dart';
import 'person_dao.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PersonDao dao = await DatabaseInstance().personDao;
  print("initialization finished!");
  await dao.insert();
  print("done executing");
}
