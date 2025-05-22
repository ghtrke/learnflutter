
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:tictac/src/play_session/board_state.dart';
import 'package:tictac/src/play_session/tile.dart';
import 'package:tictac/src/style/palette.dart';

class BoardTile extends StatefulWidget {
  final Tile tile;

  const BoardTile(this.tile, {super.key});
  
  static final Logger _log = Logger("_BoardTile");

  @override
  State<BoardTile> createState() => _BoardTileState();

}

class _BoardTileState extends State<BoardTile> {
  late Widget representation;

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final color = palette.ink;

    // done: 为什么要使用 context.select
    // select vs read vs watch
    final owner = context.select((BoardState state) => state.whoIsAt(widget.tile));
    switch (owner) {
      case Side.none:
        representation = const SizedBox.expand();
        break;
      case Side.x:
        representation = _Sketch(
          color: color,
          side: Side.x
        );
      case Side.o:
        representation = _Sketch(
          color: color,
          side: Side.o
        );
    }
    return InkResponse(
      onTap: () {
        final BoardState state = context.read<BoardState>();
        if (!state.canTake(widget.tile)) {
          BoardTile._log.info("Cannot take ${widget.tile}");
        } else if (state.isLocked) {
          BoardTile._log.info("${widget.tile} is locked");
        } else {
          state.take(widget.tile);
        }
      },
      child: representation,
    );
  }
}

class _Sketch extends StatelessWidget {
  final Color color;
  final Side side;

  const _Sketch({required this.color, required this.side});
  
  @override
  Widget build(BuildContext context) {
    String image;
    if (side == Side.x) {
      image = "assets/images/cross.png";
    } else {
      image = "assets/images/circle.png";
    }

    return Image.asset(image);
  }
}