import 'package:customtype/puredate.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'database.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp();
  
  @override
  Widget build(BuildContext context) {
    final database = AppDatabase();
    Stream<List<String>> itemNames = database.managers.todoItems.watch().map((list) {
      return list.map((map) => map.content ?? '').toList();
    });
    return MaterialApp(
      home: MyHomePage(dataStream: itemNames),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Stream<List<String>> dataStream;

  const MyHomePage({super.key, required this.dataStream});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream demo'),
      ),
      body: Center(
        child: StreamBuilder<List<String>>(
          stream: dataStream, 
          initialData: const [],
          builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot){
            if(snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('No stream');
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              case ConnectionState.active:
                final listData = snapshot.data;
                if(listData == null || listData.isEmpty) {
                  return const Text('No data in the list');
                }
                return ListView.builder(
                  itemCount: listData.length,
                  itemBuilder: (context, index){
                    return ListTile(
                        title: Text(listData[index]),
                      );
                  });
              case ConnectionState.done:
                return const Text('Stream is closed');
            }
          },
        ),
      )
    );
  }
}

//void main() async {
//  WidgetsFlutterBinding.ensureInitialized();
//
//  final database = AppDatabase();
//
//  //await database.into(database.todoItems).insert(TodoItemsCompanion.insert(
//  //  title: 'todo: finish drift setup',
//  //  content: 'we can now write queries'
//  //));
//
//  //List<TodoItem> allItems = await database.select(database.todoItems).get();
//
//  //print('items in database:$allItems');
//
//  TimeOfDay now = TimeOfDay.now();
//  TimeOfDay early = TimeOfDay.fromDateTime(DateTime.now().subtract(Duration(hours: 5)));
//  TimeOfDay after = TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 3)));
//  //await database.into(database.dateTests).insert(DateTestsCompanion.insert(date: now,));
//  //await database.into(database.dateTests).insert(DateTestsCompanion.insert(date: early,));
//  //await database.into(database.dateTests).insert(DateTestsCompanion.insert(date: after,));
//
//  List<DateTest> allDates = await database.select(database.dateTests).get();
//
//  print('dates in database: $allDates \n');
//
//  // TODO: 打印出生成的 sql
//  // TODO: custom sql converter: column.converter.tosql
//  final results = await database.customSelect('select * from date_tests where date>?', variables: [Variable(DateConverter().toSql(now))]) 
//                          .get();
//  //final results = await database.customSelect('select * from date_tests where date > 6').get();
//  List<DateTest> dates = results.map((row) => database.dateTests.map(row.data)).toList();
//
//  print('qualified data: $dates \n');
//}
//