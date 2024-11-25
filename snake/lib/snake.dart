import 'package:flutter/material.dart';
import 'dart:math';

class Snake {
  int maxRowCnt = 20;
  int maxColumnCnt = 10;
  late List<Point> locations;
  late Point foodPoint;

  Snake(maxRowCnt, maxColumnCnt) {
    this.maxRowCnt = maxRowCnt;
    this.maxColumnCnt = maxColumnCnt;
    resetLocation();
  }

  void resetLocation() {
    this.locations = [];
    Point point =
        Point((this.maxRowCnt / 2).toInt(), (this.maxColumnCnt / 2).toInt());
    this.locations.add(point);
    this.locations.add(point.left());
    this.locations.add(point.left().left());
    generateFoodPoint();
  }

  Point getHead() {
    return this.locations[0];
  }

  void generateFoodPoint() {
    Random rand = Random();
    int rowIndex = rand.nextInt(maxRowCnt);
    int columnIndex = rand.nextInt(maxColumnCnt);

    // TODO: make sure the food point does not collide with the snake
    this.foodPoint = Point(rowIndex, columnIndex);
  }

  void move(String direction) {
    // TODO: snake 暴露的东西太多了，location, foodpoint, 不应该让其他模块修改这些内部变量
    Point head_next_location = this.getHead();

    if (direction == "left") {
      head_next_location = this.getHead().left();
    } else if (direction == "right") {
      head_next_location = this.getHead().right();
    } else if (direction == "up") {
      head_next_location = this.getHead().up();
    } else {
      head_next_location = this.getHead().down();
    }

    // TODO: 不正确的吃掉了 foodpoint
    if (head_next_location == this.foodPoint) {
      generateFoodPoint();
      this.locations.insert(0, this.foodPoint);
      return;
    } else {
      this.locations.insert(0, head_next_location);
      this.locations.removeLast();
    }
  }

  bool isHitWall() {
    Point head = this.getHead();
    if (head.rowIndex == -1 ||
        head.rowIndex == this.maxRowCnt ||
        head.columnIndex == -1 ||
        head.columnIndex == maxColumnCnt) {
      return true;
    }
    return false;
  }
}

class Point {
  int rowIndex;
  int columnIndex;

  Point(this.rowIndex, this.columnIndex);

  Point left() {
    return Point(this.rowIndex, this.columnIndex - 1);
  }

  Point right() {
    return Point(this.rowIndex, this.columnIndex + 1);
  }

  Point up() {
    return Point(this.rowIndex - 1, this.columnIndex);
  }

  Point down() {
    return Point(this.rowIndex + 1, this.columnIndex);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Point) return false;

    return this.rowIndex == other.rowIndex &&
        this.columnIndex == other.columnIndex;
  }
}
