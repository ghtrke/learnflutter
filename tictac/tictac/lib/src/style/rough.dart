import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictac/src/style/palette.dart';

class RoughButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? textColor;
  final bool drawRectangle;
  final double fontSize;
  //final SfxType soundEffect;

  const RoughButton({
    super.key,
    required this.onTap,
    required this.child,
    this.textColor,
    this.fontSize = 32,
    this.drawRectangle = false,
    //this.soundEffect = SfxType.buttonTap,
  });

  void _handleTap(BuildContext context) {
    assert(onTap != null, "Don't call _handleTap when onTap is null!");

    onTap!();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return InkResponse(
      onTap: onTap == null ? null : () => _handleTap(context),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          if (drawRectangle) 
            Image.asset("assets/images/bar.png"),
          DefaultTextStyle(
            style: TextStyle(
              fontFamily: 'Permanent Marker',
              fontSize: fontSize,
              color: onTap != null ? textColor : palette.ink,
            ), 
            child: child
          ) 
        ],
      ),
    );
  }

}