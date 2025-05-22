
import 'package:tictac/src/play_session/board_state.dart';

class BoardSetting {
  // columnNumber
  final int m;
  // rowNumber
  final int n;
  // number of tiles connected to win
  final int k;
  final Side playerSide;

  const BoardSetting({required this.m, required this.n, required this.k, this.playerSide = Side.x});
}