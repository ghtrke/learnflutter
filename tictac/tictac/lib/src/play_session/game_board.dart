import 'package:flutter/material.dart';
import 'package:tictac/src/play_session/board_setting.dart';
import 'package:tictac/src/play_session/board_tile.dart';
import 'package:tictac/src/play_session/rough_grid.dart';
import 'package:tictac/src/play_session/tile.dart';

class Board extends StatefulWidget {
  final BoardSetting setting;

  const Board({super.key, required this.setting});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.setting.m / widget.setting.n,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 画线
          RoughGrid(widget.setting.m, widget.setting.n), 
          // 填充 widget
          Column(
            children: [
              for (var y = 0; y < widget.setting.n; y++) 
                Expanded(
                  child: Row(
                    children: [
                      for (var x = 0; x < widget.setting.m; x++)
                        Expanded(
                          child: BoardTile(Tile(x, y))
                        )
                    ],
                  )
                )
            ],
          ),
        ]
      )
    );
  }
}