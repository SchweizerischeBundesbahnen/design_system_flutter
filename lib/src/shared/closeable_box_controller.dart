import 'package:flutter/material.dart';

class CloseableBoxController {
  CloseableBoxController(TickerProvider vsync)
      : animation = AnimationController(
          vsync: vsync,
          value: 1.0,
          duration: kThemeAnimationDuration,
        );

  final AnimationController animation;

  Future<void> show() => animation.animateTo(1.0);

  Future<void> hide() => animation.animateTo(0.0);
}
