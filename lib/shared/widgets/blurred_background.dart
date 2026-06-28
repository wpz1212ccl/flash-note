import 'dart:ui';
import 'package:flutter/material.dart';

class BlurredBackground extends StatelessWidget {
  final Widget child;
  final double sigma;
  final Color? color;

  const BlurredBackground({
    super.key,
    required this.child,
    this.sigma = 20,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: DecoratedBox(
          decoration: BoxDecoration(color: color),
          child: child,
        ),
      ),
    );
  }
}
