import 'package:tictac/src/play_session/board_state.dart';
import 'package:tictac/src/play_session/tile.dart';

abstract class AiOpponent {

  Tile? chooseNextMove(BoardState state);
}