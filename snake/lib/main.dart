import 'package:flutter/material.dart';
import 'snake.dart';
import 'dart:async';

// TODO: 这些 const 是用来干啥的？
void main() {
  runApp(const MyApp());
}

// TODO: 消除所有的 warning
// TODO: myapp 是一个 statelesswidget, 但是它包含的 widget 是一个 statefulwidget, 具体的渲染机制是？
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: GameLayout(),
        )
      )
    );
  }
}

class GameLayout extends StatefulWidget {
  const GameLayout({super.key});

  @override
  State<GameLayout> createState() => _GameLayoutState();
}

class _GameLayoutState extends State<GameLayout> {
  static const int columnElementCnt = 10;
  static const int rowElementCnt = 20;

  // TODO: 为什么 instance variable 需要给一个默认值, late 的使用场景
  String buttonLabel = "start";
  late Snake snake;
  bool isPlaying = true;
  String userDirection = "right";
  String direction = "right";

  _GameLayoutState() {
    // TODO: 这个 constructor 是否还需要调用父类的 constructor?
    this.buttonLabel = "start";
    this.snake = Snake(rowElementCnt, columnElementCnt);
  }

  void _moveSnake() {
    setState(() {
      this.snake.move(this.direction);
    });
  }

  bool _isGameOver() {
    if (isPlaying) {
      return this.snake.isHitWall();
    }

    return true;
  }

  void _startGame() {
    if (this.buttonLabel == "start") {
      this.buttonLabel = "end";
      this.isPlaying = true;
      this.snake.resetLocation();

      Timer.periodic(
        Duration(milliseconds: 10000), 
        (Timer timer){
          _moveSnake();
          if(_isGameOver()) {
            timer.cancel();
          }
        });
    } else {
      setState(() {
        this.buttonLabel = "start";
        isPlaying = false;
      });
    }
  }

  void _setDirection() {
    if(this.userDirection == "left" && this.direction != "right") {
      this.direction = "left";
    } else if (this.userDirection == "right" && this.direction != "left") {
      this.direction = "right";
    } else if (this.userDirection == "up" && this.direction != "down") {
      this.direction = "up";
    } else if (this.userDirection == "down" && this.direction != "up") {
      this.direction = "down";
    }
  }

  Widget _buildItem(BuildContext context, int index) {
    Color color = Colors.blueGrey;
    int x = (index / columnElementCnt).floor();
    int y = index % columnElementCnt;
    Point indexPoint = Point(x, y);

    if (indexPoint == snake.getHead()) {
      color = Colors.green;
    } else if (snake.locations.contains(indexPoint)) {
      color = Colors.red;
    } else if (indexPoint == snake.foodPoint) {
      color = Colors.blue;
    }

    return Container(
      color: color,
      margin: EdgeInsets.all(1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: 记忆了上一次的移动方向
    // TODO: 为什么 gesturedetector 会被多次触发？
    return Column(
      children: [
        Expanded(
          child: Center(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy < 0) {
                  this.userDirection = "up";
                } else if (details.delta.dy > 0){
                  this.userDirection = "down";
                }
                _setDirection();
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx < 0) {
                  this.userDirection = "left";
                } else if(details.delta.dx > 0) {
                  this.userDirection = "right";
                }
                _setDirection();
              },
              child: AspectRatio(
                aspectRatio: 1/2,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: columnElementCnt * rowElementCnt,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columnElementCnt,
                  ), 
                  itemBuilder: _buildItem,
                ),
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _startGame, 
          child: Text(buttonLabel)
        )
      ],
    );
  }
}