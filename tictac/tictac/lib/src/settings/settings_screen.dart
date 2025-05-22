import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tictac/src/play_session/progress.dart';
import 'package:tictac/src/settings/custom_name_dialog.dart';
import 'package:tictac/src/settings/settings.dart';
import 'package:tictac/src/style/palette.dart';
import 'package:tictac/src/style/responsive_screen.dart';
import 'package:tictac/src/style/rough.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return Scaffold(
      //backgroundColor: palette.backgroundSettings,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          children: [
            Text("Settings", style: TextStyle(fontFamily: 'Permanent Marker', fontSize: 50)),
            SizedBox(height: 50.0),
            _NameLine(),
            Text("Sound FX", style: TextStyle(fontFamily: 'Permanent Marker', fontSize: 30)),
            _ToggleMusicLine(),
            _ResetProgressLine(),
          ],
        ),
        rectangularMenuArea: RoughButton(
          onTap: () {
            GoRouter.of(context).pop();
          }, 
          textColor: palette.ink,
          child: const Text("Back"),
        )
      )
    );
  }
}

class _NameLine extends StatelessWidget {
  const _NameLine();

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();

    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap:() => showCustomNameDialog(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Name", style: TextStyle(fontFamily: 'Permanent Marker', fontSize: 30)),
            const SizedBox(width: 50),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: settings.playerName, 
                builder: (context, name, child) {
                  return Text(
                    '‘$name’',
                    style: const TextStyle(fontFamily: 'Permanent Marker', fontSize: 30),
                    textAlign: TextAlign.end,
                  );
                }
              )
            ),
          ],
        ),
      ),
    );
  }
}

class _ToggleMusicLine extends StatelessWidget {
  const _ToggleMusicLine();

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();

    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => settings.toggleMuted(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Music", style: TextStyle(fontFamily: 'Permanent Marker', fontSize: 30)),
            const SizedBox(width: 50),
            ValueListenableBuilder<bool>(
              valueListenable: settings.muted,
              builder: (context, muted, child) {
                return Icon(
                  muted ? Icons.volume_off : Icons.volume_up,
                  color: context.watch<Palette>().ink,
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}

class _ResetProgressLine extends StatelessWidget {
  const _ResetProgressLine();

  @override
  Widget build(BuildContext context) {

    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => context.read<Progress>().reset(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Reset Progress", style: TextStyle(fontFamily: 'Permanent Marker', fontSize: 30)),
            const SizedBox(width: 50),
            Icon(Icons.delete),
          ],
        ),
      ),
    );
  }
}