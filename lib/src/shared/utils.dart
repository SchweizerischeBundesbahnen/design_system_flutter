import 'package:flutter/material.dart';

/// Applies provided [textStyle] and [foregroundColor] as default to [child].
Widget? addDefaultAncestorWithResolved({
  required Color? foregroundColor,
  int? maxLines,
  Widget? child,
  TextStyle? textStyle,
}) {
  if (child == null) return null;

  final resolvedTextStyle = textStyle?.copyWith(color: foregroundColor) ?? TextStyle(color: foregroundColor);

  child = DefaultTextStyle.merge(
    style: resolvedTextStyle,
    maxLines: maxLines,
    child: IconTheme.merge(
      data: IconThemeData(color: foregroundColor),
      child: child,
    ),
  );
  return child;
}
