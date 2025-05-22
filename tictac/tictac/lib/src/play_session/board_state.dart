import 'package:flutter/material.dart';
import 'package:tictac/src/ai/ai_opponent.dart';
import 'package:tictac/src/ai/human_like_opponent.dart';
import 'package:tictac/src/play_session/board_setting.dart';
import 'package:tictac/src/play_session/tile.dart';

class BoardState extends ChangeNotifier {
  BoardSetting setting;
  bool _isLocked = true;
  final Set<Tile> _xTaken;
  final Set<Tile> _oTaken;
  AiOpponent aiOpponent; 
  ChangeNotifier playerWon = ChangeNotifier();
  ChangeNotifier aiOpponentWon = ChangeNotifier();

  bool get isLocked => _isLocked;

  BoardState.clean(BoardSetting setting ) : this._(setting, HumanLikeOpponent(), {}, {});

  BoardState._(this.setting, this.aiOpponent, this._xTaken, this._oTaken);

  void initialize() {
    _isLocked = false;
  }

  void clearBoard() {
    _xTaken.clear();
    _oTaken.clear();
    _isLocked = true;
    notifyListeners();
  }

  bool canTake(Tile tile) {
    return whoIsAt(tile) == Side.none;
  }

  void take(Tile tile) {
    _takeTile(tile, Side.x);
    Side? playerJustWon = _getWinner();
    if(playerJustWon == Side.x) {
      playerWon.notifyListeners();
    }

    // AI 落子
    Tile? nextTile = aiOpponent.chooseNextMove(this);
    if (nextTile != null) {
      _takeTile(nextTile, Side.o);
      playerJustWon = _getWinner();
      if (playerJustWon == Side.o) {
        aiOpponentWon.notifyListeners();
      }
    }
    notifyListeners();
  }

  Side? _getWinner(){
    Set<Tile> allFilledTiles = {..._xTaken, ..._oTaken};
    for(Tile tile in allFilledTiles) {
      for(List<Tile> line in getValidLinesThrough(tile)) {
        final owner = whoIsAt(line.first);
        if (owner == Side.none) continue;
        if (line.every((tile) => whoIsAt(tile) == owner)) {
          return owner;
        }
      }
    }

    return null;
  }

  Iterable<List<Tile>> getValidLinesThrough(Tile tile) sync* {
    // 水平
    for(var startX = tile.x - setting.k + 1; startX <= tile.x; startX++) {
      final startTile = Tile(startX, tile.y);
      if(!startTile.isValid(setting)) continue;
      final endTile = Tile(startX + setting.k - 1, tile.y);
      if(!endTile.isValid(setting)) continue;

      yield [for (var i = startTile.x; i <= endTile.x; i++) Tile(i, tile.y)];
    }

    // 垂直
    for(var startY = tile.y - setting.k +1; startY <= tile.y; startY++) {
      final startTile = Tile(tile.x, startY);
      if(!startTile.isValid(setting)) continue;
      final endTile = Tile(tile.x, startY + setting.k - 1);
      if(!endTile.isValid(setting)) continue;

      yield [for (var i = startY; i <= endTile.y; i++) Tile(tile.x, i)];
    }
     // Downward diagonal lines.
    for (var xOffset = -setting.k + 1; xOffset <= 0; xOffset++) {
      var yOffset = xOffset;
      final startTile = Tile(tile.x + xOffset, tile.y + yOffset);
      if (!startTile.isValid(setting)) continue;
      final endTile =
          Tile(startTile.x + setting.k - 1, startTile.y + setting.k - 1);
      if (!endTile.isValid(setting)) continue;
      yield [
        for (var i = 0; i < setting.k; i++)
          Tile(startTile.x + i, startTile.y + i)
      ];
    }

    // Upward diagonal lines.
    for (var xOffset = -setting.k + 1; xOffset <= 0; xOffset++) {
      var yOffset = -xOffset;
      final startTile = Tile(tile.x + xOffset, tile.y + yOffset);
      if (!startTile.isValid(setting)) continue;
      final endTile =
          Tile(startTile.x + setting.k - 1, startTile.y - setting.k + 1);
      if (!endTile.isValid(setting)) continue;
      yield [
        for (var i = 0; i < setting.k; i++)
          Tile(startTile.x + i, startTile.y - i)
      ];
    }
  }

  void _takeTile(Tile tile, Side side) {
    if (side == Side.x) {
      _xTaken.add(tile);
    } else {
      _oTaken.add(tile);
    }
  }

  Side whoIsAt(Tile tile) {
    final bool takenByX = _xTaken.contains(tile);
    final bool takenByO = _oTaken.contains(tile);

    if (takenByX) {
      return Side.x;
    } else if (takenByO) {
      return Side.o;
    } else {
      return Side.none;
    }
  }
}

enum Side {
  x,
  o,
  none,
}