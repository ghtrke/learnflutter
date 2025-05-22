import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';

class Confetti extends StatefulWidget {
  static const _defaultColors = [
    Color(0xffd10841),
    Color(0xffd10841),
    Color(0xff1d75fb),
    Color(0xff0050bc),
    Color(0xffa2dcc7),
  ];

  final bool isStopped;
  final List<Color> colors;

  const Confetti({
    this.colors = _defaultColors,
    this.isStopped = false, 
    super.key
  });

  @override
  State<Confetti> createState() => _ConfettiState();
}

class _ConfettiState extends State<Confetti> 
    with SingleTickerProviderStateMixin{
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ConfettiPainter(
        animation: _controller,
        colors: widget.colors,
      ),
      child: const SizedBox.expand(),
    );
  }

  //TODO: 先不复写 didUpdateWidget 方法，看看会发生什么事情

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this
    );

    if(!widget.isStopped) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ConfettiPainter extends CustomPainter {
  AnimationController animation;
  Size? _size;
  late final List<_PaperSnipping> _snippings;
  final snippingsCount = 200;
  final UnmodifiableListView<Color> colors;
  DateTime _lastTime = DateTime.now();

  ConfettiPainter({required this.animation, required Iterable<Color> colors})
    : colors = UnmodifiableListView(colors),
      super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    if(_size == null) {
      _snippings = List.generate(
        snippingsCount, 
        (i) => _PaperSnipping(
          frontColor: colors[i % colors.length],
          bounds: size,
        )
      ); 
    }

    final didResize = _size != null && _size != size;
    final now = DateTime.now();
    final dt = now.difference(_lastTime);

    for (final snipping in _snippings) {
      if(didResize) {
        snipping.updateBounds(size);
      }
      snipping.update(dt.inMilliseconds / 1000);
      snipping.draw(canvas);
    }

    _lastTime = now;
    _size = size;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}

class _PaperSnipping {
  static final _random = Random();
  static const degToRad = pi / 180;
  static const backSideBlend = Color(0x70EEEEEE);

  final Color frontColor;
  Size _bounds;
  double time = _random.nextDouble();
  final double size = 7 + _random.nextDouble() * 10;
  late final _Vector position = _Vector(
    _random.nextDouble() * _bounds.width,
    _random.nextDouble() * _bounds.height,
  );
  final double angle = _random.nextDouble() * 360 * degToRad;
  late final List<_Vector> corners = List.generate(4, (i) {
    final angel = angle + degToRad * (45 + i * 90);
    return _Vector(cos(angel), sin(angel));
  });
  double cosA = 1.0;
  final double oscillationSpeed = 0.5 + _random.nextDouble() * 1.5;
  final double rotationSpeed = 800 + _random.nextDouble() * 600;
  double rotation = _random.nextDouble() * 360 * degToRad;
  final xSpeed = 40;
  final ySpeed = 100 + _random.nextDouble() * 60;

  final paint = Paint()..style = PaintingStyle.fill;
  late final backColor = Color.alphaBlend(backSideBlend, frontColor);

  _PaperSnipping({required this.frontColor, required bounds}): _bounds = bounds;

  void updateBounds(Size newBounds) {
    _bounds = newBounds;

    if (!newBounds.contains(Offset(position.x, position.y))) {
      position.x = _random.nextDouble() * newBounds.width;
      position.y = _random.nextDouble() * newBounds.height;
    }
  }

  void update(double dt) {
    time += dt;
    rotation += rotationSpeed * dt;
    cosA = cos(degToRad * rotation);
    position.x += cos(time * oscillationSpeed) * dt * xSpeed;
    position.y += dt * ySpeed; 

    if (position.y > _bounds.height) {
      position.x = _random.nextDouble() * _bounds.width;
      position.y = 0;
    }
  }

  void draw(Canvas canvas) {
    if (cosA > 0) {
      paint.color = frontColor;
    } else {
      paint.color = backColor;
    }
    final path = Path()
      ..addPolygon(
        List.generate(
          4, 
          (i) => Offset(
            position.x + corners[i].x * size,
            position.y + corners[i].y * size * cosA,
          )
        ),
        true,
      );
    canvas.drawPath(path, paint);
  }
}

class _Vector {
  double x;
  double y;
  _Vector(this.x, this.y);
}