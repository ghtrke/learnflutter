
import 'package:tictac/src/play_session/board_setting.dart';

class Tile {
  final int x;
  final int y;

  const Tile(this.x, this.y);

  @override
  bool operator ==(Object other) {
    return other is Tile && other.x == x && other.y == y;
  }
  
  bool isValid(BoardSetting setting) {
    if(x < 0 || y < 0 || x >= setting.m || y >= setting.n) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hash(x, y);
}