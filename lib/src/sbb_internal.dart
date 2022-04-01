import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SBBInternal {
  SBBInternal._();

  static const defaultButtonHeight = 44.0;
  static const defaultButtonHeightSmall = 32.0;

  static const barrierColor = Color(0x80000000);

  static const defaultBoxShadow = <BoxShadow>[
    BoxShadow(
      color: Color(0x18000000),
      blurRadius: 15,
    )
  ];

  /// Convenience method for easier use of [MaterialStateProperty.all].
  static MaterialStateProperty<T> all<T>(T value) {
    return MaterialStateProperty.all(value);
  }

  /// Convenience method for easier use of [MaterialStateProperty.resolveWith].
  static MaterialStateProperty<T?> resolveWith<T>(
      {required T defaultValue,
      T? pressedValue,
      T? disabledValue,
      T? hoveredValue}) {
    return MaterialStateProperty.resolveWith((states) {
      // disabled
      if (states.contains(MaterialState.disabled) && disabledValue != null)
        return disabledValue;

      // pressed / focused
      if (states.any({MaterialState.pressed, MaterialState.focused}.contains)) {
        return pressedValue;
      }
      // hovered
      if (states.contains(MaterialState.hovered) && hoveredValue != null)
        return hoveredValue;

      // default
      return defaultValue;
    });
  }
}
