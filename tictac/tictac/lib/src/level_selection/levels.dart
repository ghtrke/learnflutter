import 'package:tictac/src/play_session/board_setting.dart';

final gameLevels = [
  GameLevel(
    number: 1,
    setting: BoardSetting(m: 3, n: 3, k: 3)
  ),
  GameLevel(
    number: 2, 
    setting: BoardSetting(m: 5, n: 5, k: 4)
  ),
  GameLevel(
    number: 3,
    setting: BoardSetting(m: 6, n: 6, k: 4)
  ),
  GameLevel(
    number: 4, 
    setting: BoardSetting(m: 8, n: 8, k: 5)
  ),
  GameLevel(
    number: 5,
    setting: BoardSetting(m: 9, n: 9, k: 5)
  ),
  GameLevel(
    number: 6, 
    setting: BoardSetting(m: 9, n: 9, k: 5)
  ),
  GameLevel(
    number: 7,
    setting: BoardSetting(m: 10, n: 10, k: 5)
  ),
  GameLevel(
    number: 8, 
    setting: BoardSetting(m: 10, n: 10, k: 5)
  ),
  GameLevel(
    number: 9,
    setting: BoardSetting(m: 11, n: 11, k: 5)
  ),
];

class GameLevel {
  final int number;
  final BoardSetting setting;

  const GameLevel({required this.number, required this.setting});
}