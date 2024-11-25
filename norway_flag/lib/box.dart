import 'package:flutter/material.dart';

class FlagLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RedMiddleRedRow(),
        WhiteBlueWhiteRow(),
        BlueStripeRow(),
        WhiteBlueWhiteRow(),
        RedMiddleRedRow(),
      ]
    );
  }
}

class RedMiddleRedRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SmallRedBox(),
      SmallWhiteBox(),
      SmallBlueBox(),
      SmallWhiteBox(),
      BigRedBox(),
    ]);
  }
}

class WhiteBlueWhiteRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LongWhiteBox(),
        TinyBlueBox(),
        ExtraLongWhiteBox(),
      ],
    );
  }
}

class BlueStripeRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      StretchBlueBox(),
    ]);
  }
}

class SizeUtil {
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getFullWidth(BuildContext context) {
    return getScreenSize(context).width;
  }

  static double getBasicWidth(BuildContext context) {
    return getScreenSize(context).width / 22;
  }

  static double getBasicHeight(BuildContext context) {
    return getScreenSize(context).height / 16;
  }

  static double getWidth2(BuildContext context) {
    return getBasicWidth(context) * 2;
  }

  static double getHeight2(BuildContext context) {
    return getBasicHeight(context) * 2;
  }

  static double getWidth6(BuildContext context) {
    return getBasicWidth(context) * 6;
  }

  static double getHeight6(BuildContext context) {
    return getBasicHeight(context) * 6;
  }

  static double getWidth7(BuildContext context) {
    return getBasicWidth(context) * 7;
  }

  static double getWidth12(BuildContext context) {
    return getBasicWidth(context) * 12;
  }

  static double getWidth13(BuildContext context) {
    return getBasicWidth(context) * 13;
  }
}

class SmallRedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BuildBox(color:Colors.red, width: SizeUtil.getWidth6(context), height: SizeUtil.getHeight6(context));
  }
}

class SmallWhiteBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BuildBox(color:Colors.white, width: SizeUtil.getBasicWidth(context), height: SizeUtil.getHeight6(context));
  }
}

class SmallBlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BuildBox(color:Colors.blue, width: SizeUtil.getWidth2(context), height: SizeUtil.getHeight6(context));
  }
}

class BigRedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BuildBox(color:Colors.red, width: SizeUtil.getWidth12(context), height: SizeUtil.getHeight6(context));
  }
}

class LongWhiteBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BuildBox(color:Colors.white, width: SizeUtil.getWidth7(context), height: SizeUtil.getBasicHeight(context));
  }
}

class TinyBlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BuildBox(color:Colors.blue, width: SizeUtil.getWidth2(context), height: SizeUtil.getBasicHeight(context));
  }
}

class ExtraLongWhiteBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BuildBox(color:Colors.white, width: SizeUtil.getWidth13(context), height: SizeUtil.getBasicHeight(context));
  }
}

class StretchBlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BuildBox(color:Colors.blue, width: SizeUtil.getFullWidth(context), height: SizeUtil.getHeight2(context));
  }
}

class BuildBox extends StatelessWidget {
  final Color color;
  final double width;
  final double height;

  BuildBox({super.key, required this.color, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: width,
      height: height,
    );
  }
}