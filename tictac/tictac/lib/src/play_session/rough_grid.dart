import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictac/src/style/palette.dart';

class RoughGrid extends StatelessWidget {
  final int width;
  final int height;

  const RoughGrid(this.width, this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final lineColor = palette.ink;

    return CustomPaint(
      painter: _RoughGridPainter(
        width,
        height,
        lineColor: lineColor,
      )
    );
  }

}

class _RoughGridPainter extends CustomPainter {
  final int width;
  final int height;
  final Color lineColor;

  _RoughGridPainter(
    this.width, 
    this.height, 
    { 
      this.lineColor = Colors.black, 
    }
  );
  
  @override
  void paint(Canvas canvas, Size size) {
    const padding = 10.0;
    final widthStep = size.width / width;
    final heightStep = size.height / height;
    final paint = Paint()
      ..color = lineColor 
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    // vertical lines
    for(var i = 1; i < width; i++) {
      var x = i * widthStep;
      var start = Offset(x, padding);
      var end = Offset(x, size.height - 2 * padding);
      canvas.drawLine(start, end, paint);
    }

    // horizontal lines
    for(var j = 1; j < height; j++) {
      var y = heightStep * j;
      var start = Offset(padding, y);
      var end = Offset(size.width - 2 * padding, y);
      canvas.drawLine(start, end, paint);
    }
  }
  
  @override
  bool shouldRepaint(_RoughGridPainter oldDelegate) {
    return oldDelegate.width != width ||
          oldDelegate.height != height ||
          oldDelegate.lineColor != lineColor;
  }
}