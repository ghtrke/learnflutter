import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int index;
  final Function setIndex;
  const BottomNavBar(this.index, this.setIndex, {super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.index,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.timer),
          label: "Stopwatch",
       ),
       BottomNavigationBarItem(
        icon: Icon(Icons.slow_motion_video),
        label: "Timer",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
          )
      ],
      onTap: (value) {
        widget.setIndex(value);
      },
    );
  }
}