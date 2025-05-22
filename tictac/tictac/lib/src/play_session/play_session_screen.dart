import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tictac/src/level_selection/levels.dart';
import 'package:tictac/src/play_session/board_setting.dart';
import 'package:tictac/src/play_session/board_state.dart';
import 'package:tictac/src/play_session/game_board.dart';
import 'package:tictac/src/play_session/progress.dart';
import 'package:tictac/src/settings/settings.dart';
import 'package:tictac/src/style/confetti.dart';

class PlaySessionScreen extends StatefulWidget {
  final GameLevel level;
  const PlaySessionScreen(this.level, {super.key});

  @override
  State<PlaySessionScreen> createState() => _PlaySessionScreenState();

}

class _PlaySessionScreenState extends State<PlaySessionScreen> {
  bool _duringCelebration = false;
  static const _celebrationDuration = Duration(milliseconds: 1000);

  void _playerWon() async {
    Progress progress = context.read<Progress>();
    progress.updateLevel(widget.level.number);

    setState(() {
      _duringCelebration = true;
    });

    await Future.delayed(_celebrationDuration);
    if (!mounted) return;

    GoRouter.of(context).go('/play/won');
    //GoRouter.of(context).pop();
  }

  void _aiOpponentWon() async {
    _playerWon();
  }

  @override
  Widget build(BuildContext context) {
    BoardSetting boardSetting = widget.level.setting;
    String playerName = context.read<SettingsController>().playerName.value;

    return LayoutBuilder(
      builder:(context, constraints) { 
        final size = constraints.biggest;
        final padding = EdgeInsets.all(size.shortestSide / 30);

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) {
                BoardState state = BoardState.clean(boardSetting);
                state.initialize();
                state.playerWon.addListener(_playerWon);
                state.aiOpponentWon.addListener(_aiOpponentWon);
                return state;
              },
            ),
          ],
          child: Builder(
            builder: (context) {
              return Scaffold(
                body: SafeArea(
                  child: Stack(
                    children: [ Column(
                      children: [
                        Padding(
                          padding: padding,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkResponse(
                                onTap: () {
                                  GoRouter.of(context).pop();
                                },
                                child: Tooltip(
                                  message: 'Back',
                                  child: Image.asset('assets/images/back.png'),
                                ),
                              ),
                              Text(
                                '$playerName vs ai',
                                style: TextStyle(
                                  fontFamily: 'Permanent Marker',
                                  fontSize: 30,
                                ),
                              ),
                              InkResponse(
                                onTap: () {
                                  GoRouter.of(context).go('/settings');
                                },
                                child: Tooltip(
                                  message: 'Settings',
                                  child: Image.asset('assets/images/settings.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Board(
                          key: const Key('main board'),
                          setting: BoardSetting(m: boardSetting.m, n: boardSetting.n, k: boardSetting.k),
                        ),
                        InkResponse(
                          onTap:() {
                            context.read<BoardState>().clearBoard();
                            if (!mounted) return;
              
                            context.read<BoardState>().initialize();
                          },
                          child: Column(
                            children: [
                              Image.asset('assets/images/restart.png'),
                              Text(
                                'Restart',
                                style: TextStyle(
                                  fontFamily: 'Permanent Marker',
                                  fontSize: 16,
                                )
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox.expand(
                      child: Visibility(
                        visible: _duringCelebration,
                        child: IgnorePointer(
                          child: Confetti(
                            isStopped: !_duringCelebration
                          )
                        )
                      ),
                    ),
                  ]
                  ),
                ),
              );
            }
          ),
        );
     }
    );
  }
}
