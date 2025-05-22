import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Transform Scale Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 正常大小的容器
              Container(
                width: 100,
                height: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              // 放大 1.5 倍的容器
              Transform.scale(
                scale: 1.5,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 20),
              // 缩小为原来 0.5 倍的容器
              Transform.scale(
                scale: 0.5,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
    