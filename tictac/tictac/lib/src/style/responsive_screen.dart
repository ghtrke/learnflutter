import 'package:flutter/material.dart';

class ResponsiveScreen extends StatelessWidget {
  final Widget squarishMainArea;
  final Widget rectangularMenuArea;
  final Widget topMessageArea;
  final double mainAreaProminence;

  const ResponsiveScreen({
    required this.squarishMainArea,
    required this.rectangularMenuArea,
    this.topMessageArea = const SizedBox.shrink(),
    this.mainAreaProminence = 0.8,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        // TODO: /30 这个是怎么计算的?
        // 布局需要经过实验(例如 mainArea 的 scale， paddin, 等等)，需要更系统的学习，目前先略过
        final padding = EdgeInsets.all(size.shortestSide / 30);

        if (size.height >= size.width) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: padding,
                  // TODO: message 到底用于什么设置？
                  child: topMessageArea
                ),
              ),
              Expanded(
                // TODO: flex 为什么这么大？
                flex: (mainAreaProminence * 100).round(),
                child: SafeArea(
                  top: false,
                  bottom: false,
                  minimum: padding,
                  child: squarishMainArea,
                )
              ),
              SafeArea(
                top: false,
                // TODO：下面参数的作用
                maintainBottomViewPadding: true,
                child: Padding(
                  padding: padding,
                  child: rectangularMenuArea,
                ),
              ),
            ],
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TODO： 为什么这里使用 expanded, 竖屏没有?
              Expanded(
                // TODO: flex 根据屏幕大小进行调整
                flex: 7,
                child: SafeArea(
                  right: false,
                  maintainBottomViewPadding: true,
                  minimum: padding,
                  child: squarishMainArea,
                )
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    SafeArea(
                      bottom: false,
                      left: false,
                      maintainBottomViewPadding: true,
                      child: Padding(
                        padding: padding,
                        child: topMessageArea
                      )
                    ),
                    Expanded(
                      child: SafeArea(
                        top: false,
                        left: false,
                        child: Padding(
                          padding: padding,
                          child: rectangularMenuArea
                        )  
                      )
                    )
                  ],    
                ),
              )   
            ],
          );
        }
      }
    );
  }
}