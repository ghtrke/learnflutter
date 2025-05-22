import 'package:flutter/material.dart';
import 'package:todo/listpage.dart';
import 'package:intl/intl.dart';
import 'db/database.dart';
import 'db/dao/plans_dao.dart';


final List<String> _timeSelections = List<String>.generate(48, (i) {
  int hour = i ~/ 2;
  int minute = (i % 2) * 30;

  return '$hour:${minute == 0 ? '00': '30'}';
});

final List<String> _weekdays = [
  '星期一',
  '星期二',
  '星期三',
  '星期四',
  '星期五',
  '星期六',
  '星期日',
];

class ItemFormPage extends StatefulWidget {
  // DO: 想把这个变量做成 private, 但是 named parameter 不能以下划线开头. 因为 named parameter 是用户想要传递的一个值，但是下划线开头又代表这是一个私有变量，二者相互矛盾
  final int? planId;

  // ignore: prefer_const_constructors_in_immutables
  ItemFormPage({super.key, this.planId});

  @override
  State<ItemFormPage> createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();

  // date selection
  String _selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  // time selection
  String? _selectedTime;

  // reoccurrences
  List<String>? _selectedWeekdays;
  String _weekdayButtonText = 'Weekdays';

  // DO: 卡得太厉害了，不应该在 initState 中调用异步函数，那怎么办呢？
  // 方法一：使用 futurebuilder
  // 方法二：将异步调用拆分到另一个方法中，在 initState 方法中不使用 await 调用异步函数。
  // 在另一个方法中，当取到数据时，调用 setState 方法重构 UI
  @override
  void initState() {
    super.initState();

    if(widget.planId == null) {
      _titleController = TextEditingController();
      _selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      _selectedWeekdays = [];
    } else {
      _loadItem();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _loadItem() async {
    Plan item = await DatabaseInstance().plansDao.getPlan(widget.planId!);

    setState(() {
      _titleController = TextEditingController(text: item.title);
      _selectedDate = item.startDate;
      _selectedTime = item.startTime;
      if(item.weekdays != null && item.weekdays!.isNotEmpty) {
        _selectedWeekdays = item.weekdays!.split(',');
      } else {
        _selectedWeekdays = [];
      }
      if(_selectedWeekdays == null) {
        _weekdayButtonText = '';
      } else {
        _weekdayButtonText = _selectedWeekdays!.isNotEmpty ? _selectedWeekdays!.join(','): 'Weekdays';
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState((){
        _selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _showMultiSelectDialog() async {
    await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Weekdays'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: ListBody(
                  children: _weekdays.map((weekday){
                    return CheckboxListTile(
                      value: _selectedWeekdays!.contains(weekday),
                      title: Text(weekday),
                      onChanged: (bool? value) {
                        setState((){
                          if(value == true) {
                            _selectedWeekdays!.add(weekday);
                          } else {
                            _selectedWeekdays!.remove(weekday);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
    // TODO: 在控件间传值的方式，navigator.pop. 总结不同控件的返回值方式，包括 controller, value 等等
    if(_selectedWeekdays != null && _selectedWeekdays!.isNotEmpty) {
      setState((){
        _weekdayButtonText = _selectedWeekdays!.isNotEmpty ? _selectedWeekdays!.join(','): 'Weekdays';
      });
    }
  }

  void _insertOrUpdateData() {
    if (widget.planId != null){
      // TODO: 需要同时更新 execution
      DatabaseInstance().plansDao.updatePlan(
        widget.planId!, 
        title: _titleController.text,
        startDate: _selectedDate,
        startTime: _selectedTime!,
        weekdays: _weekdayButtonText,
      );
    } else {
      // TODO: 需要同时更新 execution
      DatabaseInstance().plansDao.insertPlan(
        title: _titleController.text,
        startDate: _selectedDate,
        startTime: _selectedTime!,
        weekdays: _weekdayButtonText,
      );
    }

    if (context.mounted) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => const MyHomePage()));
     }
  }

  @override
  Widget build(BuildContext context) {
    //if (widget.itemIndex == null) {
    //  return Scaffold(
    //    appBar: AppBar(
    //      title: Text(widget.itemIndex != null ? 'Edit Item':'New Item')
    //    ),
    //    body: Text('Loading data...')
    //  );
    //}
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.planId != null ? 'Edit Item' : 'New Item'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Input title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Empty title not allowed';
                }
                return null;
              },
            ),
            // TODO: 使用更合适的方式定义控件之间的间隔
            const SizedBox(height: 16),
            // 日期选择
            TextField(
              readOnly: true,
              controller: TextEditingController(text: _selectedDate),
              decoration: const InputDecoration(
                labelText: 'Select Date',
                border: OutlineInputBorder(),
              ),
              onTap: () {
                _selectDate(context);
              },
            ),
            // 起始时间, 使用 dropdownbutton
            DropdownButton<String>(
              items: _timeSelections.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(), 
              onChanged: (String? newValue) {
                setState((){
                  _selectedTime = newValue;
                });
              },
              value: _selectedTime,
              hint: const Text('Start Time'),
            ),
            // 重复方式选择, 需要多选的实现方式
            ElevatedButton(
              child: Text(_weekdayButtonText),
              onPressed: () {
                _showMultiSelectDialog();
              },
            ),
            const SizedBox(height: 16),
            IconButton(
              icon: const Icon(Icons.save,),
              onPressed: () {
                // TODO: 如何指定控件的必填校验
                if (_formKey.currentState!.validate()) {
                  _insertOrUpdateData();
                }
              },
            )
          ]
        ),
      )
    );
  }
}