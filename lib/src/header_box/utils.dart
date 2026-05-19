import 'package:flutter/material.dart';

/// Returns the height of [widget] if it is not null, calculates the height if a [fallbackText] is given, and otherwise
/// returns 0.0.
double calculateHeightWithTextFallback(
  PreferredSizeWidget? widget,
  String? fallbackText,
  TextStyle? textStyle,
  TextScaler textScaler,
) {
  if (widget != null) {
    return widget.preferredSize.height;
  }

  if (fallbackText != null && textStyle != null) {
    return textStyle.height! * textScaler.scale(textStyle.fontSize!);
  }

  return 0.0;
}
