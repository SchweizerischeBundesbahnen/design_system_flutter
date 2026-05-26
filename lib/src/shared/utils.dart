import 'package:flutter/material.dart';

/// Applies provided [textStyle] and [foregroundColor] as default to [child].
Widget? addDefaultAncestorWithResolved({
  required Color? foregroundColor,
  Widget? child,
  TextStyle? textStyle,
}) {
  if (child == null) return null;

  final resolvedTextStyle = textStyle?.copyWith(color: foregroundColor) ?? TextStyle(color: foregroundColor);

  return DefaultTextStyle.merge(
    style: resolvedTextStyle,
    child: IconTheme.merge(
      data: IconThemeData(color: foregroundColor),
      child: child,
    ),
  );
}
