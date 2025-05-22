import 'package:tictac/src/ai/ai_opponent.dart';
import 'package:tictac/src/play_session/board_state.dart';
import 'package:tictac/src/play_session/tile.dart';

class HumanLikeOpponent implements AiOpponent {
  static const  aiScores = [0, 200, 400, 600, 800, 1000];
  static const playerScores = [0, 100, 200, 300, 400, 500];

  @override
  Tile? chooseNextMove(BoardState state) {
    // iterate through all empty tiles, calculate the score for each tile
    // and return the tile with the highest score
    final options = <Tile>[];
    for (var x = 0; x < state.setting.m; x++) {
      for (var y = 0; y < state.setting.n; y++) {
        final tile = Tile(x, y);
        if (state.whoIsAt(tile) == Side.none) {
          options.add(tile);
        }
      }
    } 

    if (options.isEmpty) {
      return null;
    }

    Map<Tile, int> scores = {};
    for (var tile in options) {
      scores[tile] = _calculateScore(state, tile);
    }
    // sort the scores in descending order
    scores = Map.fromEntries(scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value)));
    // return the tile with the highest score
    return scores.keys.first;
  }

  int _calculateScore(BoardState state, Tile tile) {
    // calculate the score for the tile
    int score = 0;
    for(var line in state.getValidLinesThrough(tile)) {
      int playerTiles = line.where((tile) => state.whoIsAt(tile) == Side.x).length;
      int aiTiles = line.where((tile) => state.whoIsAt(tile) == Side.o).length;
      if (playerTiles > 0 && aiTiles > 0) {
        // both player and AI have tiles in this line, ignore it
        continue;
      }
      if (playerTiles > 0) {
        // player has tiles in this line, add the score for the player
        score += playerScores[playerTiles];
      } else if (aiTiles > 0) {
        // AI has tiles in this line, add the score for the AI
        score += aiScores[aiTiles];
      }
    }

    return score;
  }
}