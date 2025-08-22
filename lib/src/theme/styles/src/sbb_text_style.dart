import 'package:flutter/material.dart';

class SBBTextStyle {
  SBBTextStyle({
    this.textStyle,
    this.textStyleDisabled,
  });

  final TextStyle? textStyle;
  final TextStyle? textStyleDisabled;

  SBBTextStyle copyWith({
    TextStyle? textStyle,
    TextStyle? textStyleDisabled,
  }) => SBBTextStyle(
    textStyle: textStyle ?? this.textStyle,
    textStyleDisabled: textStyleDisabled ?? this.textStyleDisabled,
  );

  SBBTextStyle lerp(SBBTextStyle? other, double t) => SBBTextStyle(
    textStyle: TextStyle.lerp(textStyle, other?.textStyle, t),
    textStyleDisabled: TextStyle.lerp(textStyleDisabled, other?.textStyleDisabled, t),
  );
}

extension SBBTextStyleExtension on SBBTextStyle? {
  SBBTextStyle merge(SBBTextStyle? other) {
    if (this == null) return other ?? SBBTextStyle();
    return this!.copyWith(
      textStyle: this!.textStyle ?? other?.textStyle,
      textStyleDisabled: this!.textStyleDisabled ?? other?.textStyleDisabled,
    );
  }
}
