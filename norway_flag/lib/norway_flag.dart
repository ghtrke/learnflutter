import 'package:flutter/material.dart';


class NorwayFlag extends StatelessWidget {
  const NorwayFlag({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 6,
            child: Row(
              children: [
                BuildBox(6, Colors.red),
                BuildBox(1, Colors.white),
                BuildBox(2, Colors.blue),
                BuildBox(1, Colors.white),
                BuildBox(12, Colors.red),
              ],
            )),
        Expanded(
          flex: 4,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    BuildBox(7, Colors.white),
                    BuildBox(2, Colors.blue),
                    BuildBox(13, Colors.white)
                  ]
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    BuildBox(22, Colors.blue),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    BuildBox(7, Colors.white),
                    BuildBox(2, Colors.blue),
                    BuildBox(13, Colors.white)
                  ],
                )),
            ],
          )
        ),
        Expanded(
            flex: 6,
            child: Row(
              children: [
                BuildBox(6, Colors.red),
                BuildBox(1, Colors.white),
                BuildBox(2, Colors.blue),
                BuildBox(1, Colors.white),
                BuildBox(12, Colors.red),
              ],
            )),
      ],
    );
  }
}

class BuildBox extends StatelessWidget {
  final int flex;
  final Color color;

  const BuildBox(this.flex, this.color);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        color: color,
      ),
    );
  }
}