
import 'package:tictac/src/ai/ai_opponent.dart';
import 'package:tictac/src/play_session/board_state.dart';
import 'package:tictac/src/play_session/tile.dart';

class RandomOpponent implements AiOpponent {

  @override
  Tile? chooseNextMove(BoardState state) {
    final options = <Tile>[];
    for(var x = 0; x < state.setting.m; x++) {
      for (var y = 0; y < state.setting.n; y++) {
        final tile = Tile(x, y);
        if(state.whoIsAt(tile) == Side.none) {
          options.add(tile);
        }
      }
    }

    return options[0];
  }
}