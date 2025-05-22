import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tictac/src/style/responsive_screen.dart';

class WinGameScreen extends StatelessWidget{
  const WinGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveScreen(
        squarishMainArea: Center(
          child: Text("You Won!",
            style: TextStyle(
              fontFamily: 'Permanent Marker',
              fontSize: 50,
            ),
          ),
        ),
        rectangularMenuArea: InkResponse(
          onTap: () {
            GoRouter.of(context).pop();
          },
          child: Tooltip(
            message: 'Back',
            child: Image.asset('assets/images/back.png'),
          ),
        ),
      ),
    );
  }
}