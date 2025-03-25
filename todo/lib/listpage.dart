import 'package:flutter/material.dart';
import 'editpage.dart';
import 'package:intl/intl.dart';
import 'db/database.dart';
import 'db/dao/executions_dao.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(DateFormat('yyyy-MM-dd').format(DateTime.now())),
          const TODOList(),
          const IconList(),
        ],
      ),
    );
  }
}

class TODOList extends StatefulWidget {
  const TODOList({super.key});

  @override
  State<TODOList> createState() => _TODOListState();
}

class _TODOListState extends State<TODOList> {
  List<Execution> _items = [];

  //DO: initState 这个函数会在重建时被重新调用吗？不会
  //DO: 在一个函数中调用一个 async 函数就一定要声明为 async 吗？不一定
  //DO: 为什么要使用 async? 为了不阻碍其它函数执行，这是客户端编程常用方法
  //DO: 搞清楚 setstate 的机制
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    //在这里调用 setState, 触发页面重新 build
    // DO: deepcopy 类型有问题, 需要自己写，做更多研究
    // DO: setState 机制？
    // DO: setState 中不允许再 await, 为什么？

    List<Execution> items = await DatabaseInstance().executionsDao.getExecutions();

    setState(() {
      _items = items;
    });
  }

  Future<void> _updateCheckStatus(int id, bool isChecked) async {
    await DatabaseInstance().executionsDao.updateCheckStatus(id, isChecked);
  }

  Future<void> _removeExecution(int id) async {
    await DatabaseHelper().removeExecution(id);
  }

  Future<void> _removeExecutions(DateTime startDate, int planId) async {
    await DatabaseHelper().removeExecutions(startDate, planId);
  }

  Future<void> _splitPlan(int planId, DateTime startDate) async {
    await DatabaseHelper().splitPlan(planId, startDate);
  }

  Future<void> _endPlan(int planId, DateTime startDate) async {
    await DatabaseHelper().endPlan(planId, startDate);
  }

  // ask user if he wants to remove only this item or all consecutive ones
  void _showRemoveDialog(int index) {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Select an option'),
          actions: <Widget>[
            TextButton(
              child: const Text('Remove only the current item'),
              onPressed: () {
                setState(
                  () {
                    _removeExecution(_items[index].id!);
                    _splitPlan(_items[index].planId, _items[index].startDate);
                    _items.removeAt(index);
                  },
                );
                Navigator.of(context).pop();
              }
            ),
            TextButton(
              child: const Text('Remove all consecutive items'),
              onPressed: (){
                setState(() {
                  _removeExecutions(_items[index].startDate, _items[index].planId);
                  _endPlan(_items[index].planId, _items[index].startDate);
                  _items.removeAt(index);
                });
                Navigator.of(context).pop();
              }, 
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: (){
                Navigator.of(context).pop();
              }
            ),
          ],
        );
      }
    );
  }

  void _showOptionsDialog(BuildContext context, int index) {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Options'),
          content: const Text('Choose an option'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => ItemFormPage(planId: _items[index].planId,)
                  )
                );
              }
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Navigator.of(context).pop();
                _showRemoveDialog(index);
              }
            )
          ]
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: listview 的默认加载数量为 20， 向下滚动时，进行动态加载。
    // DO: final 关键字, const 关键字
    // DO: 状态变量更新才会触发 UI 重建，即重新调用 build 方法
    // DO: 笔记，感叹号和问号
    return Expanded(
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              Checkbox(
                value: _items[index].isChecked, 
                onChanged: (bool? newValue) async {
                  await _updateCheckStatus(_items[index].planId, newValue!);
                  setState(() {
                    _items[index].isChecked = newValue;
                  });
              }),
              GestureDetector(
                onTap: () => _showOptionsDialog(context, index),
                child: Text(
                  '${Plan.timeToString(_items[index].startTime)} ${_items[index].title}',
                  style: TextStyle(
                    fontWeight: _items[index].isChecked ? FontWeight.bold : FontWeight.normal
                  )),
              ),
            ]
          );
        },
      ),
    );
  }
}

class IconList extends StatelessWidget {
  const IconList({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => ItemFormPage(),
            )
          );
        },
      );
  }
}