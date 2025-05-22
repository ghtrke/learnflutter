import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tictac/src/play_session/progress.dart';
import 'package:tictac/src/style/palette.dart';
import 'package:tictac/src/style/responsive_screen.dart';
import 'package:tictac/src/style/rough.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: 使用 responsivescreen 封装
    final palette = context.watch<Palette>();
    final unlockedLevel = context.watch<Progress>().unlockedLevel;

    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection,
      body: ResponsiveScreen(
         squarishMainArea: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Select Level",
                style: TextStyle(fontFamily: 'Permanent Marker', fontSize: 50)
              ),
            ),
            SizedBox(height: 50.0),
            // GridView 生成 9 个 level
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  bool levelAvailable = index < unlockedLevel + 1;
                  return TextButton(
                    onPressed: levelAvailable ? (){
                      GoRouter.of(context).go('/play/session/${index + 1}');
                    } : null, 
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                        fontFamily: 'Permanent Marker', 
                        fontSize: 90.0,
                        color: levelAvailable ? palette.pen: palette.ink,
                      )
                    )
                  );
                },
              ),
            ),
          ],
        ),
        rectangularMenuArea: RoughButton(
          onTap: () {
            // TODO: pop 回去后，如果原页面有状态，原来的状态会被保留吗？
            GoRouter.of(context).pop();
          }, 
          textColor: palette.ink,
          child: Text(
            'Back',
          )
        )
      )
    );
  }

}