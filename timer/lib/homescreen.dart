import 'package:flutter/material.dart';

import 'navbar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final List<Widget> screenList = [
    Center(child: Text("Screen 1")),
    Center(child: Text("Screen 2")),
    Center(child: Text("Screen 3")),
  ];

  void setIndex(int value) {
    setState(() {
      index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList[index],
      bottomNavigationBar: BottomNavBar(index, setIndex),
    );
  }
}