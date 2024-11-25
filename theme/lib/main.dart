import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.blue,
      ),
      // home: Scaffold(
      //   body: HomePage(),
      // )
      home: Scaffold(
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
        )
      )
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Theme.of(context).scaffoldBackgroundColor,
      color: Color(0xfffef7ff)
    );
  }
}