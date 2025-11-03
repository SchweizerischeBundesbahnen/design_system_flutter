import 'dart:math' as math;

import 'package:flutter/material.dart';

class PopoverNotch {
  static double get outerHeight => 12.0;

  static double get outerWidth => 30.0;

  static Path get facingUp => _path.shift(Offset(-PopoverNotch.outerWidth / 2, 0));

  static Path get facingDown => _path.transform(Matrix4.rotationZ(math.pi).storage).shift(Offset(outerWidth / 2, 0));

  static Path get facingLeft => _path.transform(Matrix4.rotationZ(-_piHalf).storage).shift(Offset(0, outerWidth / 2));

  static Path get facingRight => _path.transform(Matrix4.rotationZ(_piHalf).storage).shift(Offset(0, -outerWidth / 2));

  static double get _piHalf => math.pi / 2;

  /// imported from Figma SVG and ran through https://github.com/flutter-clutter/svg-to-flutter-path-converter
  static Path get _path =>
      Path()
        ..lineTo(outerWidth, outerHeight)
        ..cubicTo(outerWidth, outerHeight, 0, outerHeight, 0, outerHeight)
        ..cubicTo(
          outerWidth * 0.05,
          outerHeight,
          outerWidth * 0.1,
          outerHeight * 0.94,
          outerWidth * 0.13,
          outerHeight * 0.84,
        )
        ..cubicTo(
          outerWidth * 0.13,
          outerHeight * 0.84,
          outerWidth * 0.39,
          outerHeight * 0.13,
          outerWidth * 0.39,
          outerHeight * 0.13,
        )
        ..cubicTo(
          outerWidth * 0.42,
          outerHeight * 0.05,
          outerWidth * 0.46,
          0,
          outerWidth / 2,
          0,
        )
        ..cubicTo(
          outerWidth * 0.54,
          0,
          outerWidth * 0.58,
          outerHeight * 0.05,
          outerWidth * 0.61,
          outerHeight * 0.13,
        )
        ..cubicTo(
          outerWidth * 0.61,
          outerHeight * 0.13,
          outerWidth * 0.87,
          outerHeight * 0.84,
          outerWidth * 0.87,
          outerHeight * 0.84,
        )
        ..cubicTo(
          outerWidth * 0.9,
          outerHeight * 0.94,
          outerWidth * 0.95,
          outerHeight,
          outerWidth,
          outerHeight,
        )
        ..cubicTo(
          outerWidth,
          outerHeight,
          outerWidth,
          outerHeight,
          outerWidth,
          outerHeight,
        );
}
