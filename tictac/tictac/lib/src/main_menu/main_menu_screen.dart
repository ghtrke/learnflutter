import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tictac/src/settings/settings.dart';
import 'package:tictac/src/style/palette.dart';
import 'package:tictac/src/style/responsive_screen.dart';
import 'package:tictac/src/style/rough.dart';

class MainMenuScreen extends StatelessWidget{
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final settingsController = context.watch<SettingsController>();

    return Scaffold(
      backgroundColor: palette.redPen,
      body: ResponsiveScreen(
        mainAreaProminence: 0.45,
        squarishMainArea: Center(
          child: Transform.scale(
            scale: 1.2,
            child: Image.asset(
              "assets/images/main-menu.png",
              fit: BoxFit.cover,
            )
          )
        ),
        rectangularMenuArea: Column( 
          children: [
            RoughButton(
              onTap: () {
                GoRouter.of(context).go('/play');
              },
              drawRectangle: true,
              textColor: palette.redPen,
              fontSize: 42,
              child: Text("Play"),
            ),
            RoughButton(
              onTap: () {
                GoRouter.of(context).go('/settings');
              },
              textColor: palette.ink,
              drawRectangle: false,
              child: Text("Settings"),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: settingsController.muted,
              builder: (context, muted, child) { 
                return IconButton(
                icon: Icon(
                  muted ? Icons.volume_off : Icons.volume_up,
                  color: palette.trueWhite,
                ),
                onPressed: () => settingsController.toggleMuted(),
              );
              },
            ),
          ]
        )
      )
    );
  }
}