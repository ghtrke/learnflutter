import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InkResponse Hover Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('InkResponse Hover Highlight')),
        body: Center(
          child: InkResponse(
            highlightShape: BoxShape.rectangle,
            hoverColor: Colors.blue.withOpacity(0.5),
            onTap: (){
              print("Tapped");
            },
            child: Row(
              children: [
                const Text("Name", style: TextStyle(fontSize: 50)),
                const SizedBox(width: 100),
                Expanded(
                  child: Text("Click to change", style: TextStyle(fontSize: 50)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
