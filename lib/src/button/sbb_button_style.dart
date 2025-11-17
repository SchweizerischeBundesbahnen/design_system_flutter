import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// Style for SBB Buttons. Use this to override e.g. all SBBPrimaryButton values within the [SBBTheme].
class SBBButtonStyle2 {
  const SBBButtonStyle2({
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.overlayColor,
    this.iconColor,
    this.borderColor,
  });

  /// The style for a button's [Text] widget descendants.
  ///
  /// The color of the [textStyle] is typically not used directly, the
  /// [foregroundColor] is used instead.
  final WidgetStateProperty<TextStyle?>? textStyle;

  /// The button's background fill color.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// The color for the button's [Text] widget descendants.
  ///
  /// This color is typically used instead of the color of the [textStyle].
  final WidgetStateProperty<Color?>? foregroundColor;

  /// The color used to indicate that the button is focused or pressed.
  final WidgetStateProperty<Color?>? overlayColor;

  /// The icon's color inside of the button.
  final WidgetStateProperty<Color?>? iconColor;

  /// The color of the button's outline.
  final WidgetStateProperty<Color?>? borderColor;

  SBBButtonStyle2 copyWith({
    WidgetStateProperty<TextStyle?>? textStyle,
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? foregroundColor,
    WidgetStateProperty<Color?>? overlayColor,
    WidgetStateProperty<Color?>? iconColor,
    WidgetStateProperty<Color?>? borderColor,
  }) {
    return SBBButtonStyle2(
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      overlayColor: overlayColor ?? this.overlayColor,
      iconColor: iconColor ?? this.iconColor,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  SBBButtonStyle2 merge(SBBButtonStyle2? other) {
    if (other == null) return this;

    return copyWith(
      textStyle: other.textStyle,
      backgroundColor: other.backgroundColor,
      foregroundColor: other.foregroundColor,
      overlayColor: other.overlayColor,
      iconColor: other.iconColor,
      borderColor: other.borderColor,
    );
  }

  static SBBButtonStyle2? lerp(SBBButtonStyle2? a, SBBButtonStyle2? b, double t) {
    if (identical(a, b)) return a;

    return SBBButtonStyle2(
      textStyle: WidgetStateProperty.lerp<TextStyle?>(a?.textStyle, b?.textStyle, t, TextStyle.lerp),
      foregroundColor: WidgetStateProperty.lerp<Color?>(a?.foregroundColor, b?.foregroundColor, t, Color.lerp),
      backgroundColor: WidgetStateProperty.lerp<Color?>(a?.backgroundColor, b?.backgroundColor, t, Color.lerp),
      overlayColor: WidgetStateProperty.lerp<Color?>(a?.overlayColor, b?.overlayColor, t, Color.lerp),
      iconColor: WidgetStateProperty.lerp<Color?>(a?.iconColor, b?.iconColor, t, Color.lerp),
      borderColor: WidgetStateProperty.lerp<Color?>(a?.borderColor, b?.borderColor, t, Color.lerp),
    );
  }
}

class SBBButtonStyle {
  SBBButtonStyle({
    this.backgroundColor,
    this.backgroundColorHighlighted,
    this.backgroundColorDisabled,
    this.backgroundColorLoading,
    this.borderColor,
    this.borderColorHighlighted,
    this.borderColorDisabled,
    this.borderColorLoading,
    this.textStyle,
    this.textStyleHighlighted,
    this.textStyleDisabled,
    this.textStyleLoading,
    this.iconColor,
    this.iconColorHighlighted,
    this.iconColorDisabled,
  });

  final Color? backgroundColor;
  final Color? backgroundColorHighlighted;
  final Color? backgroundColorDisabled;
  final Color? backgroundColorLoading;
  final Color? borderColor;
  final Color? borderColorHighlighted;
  final Color? borderColorDisabled;
  final Color? borderColorLoading;
  final TextStyle? textStyle;
  final TextStyle? textStyleHighlighted;
  final TextStyle? textStyleDisabled;
  final TextStyle? textStyleLoading;
  final Color? iconColor;
  final Color? iconColorHighlighted;
  final Color? iconColorDisabled;

  SBBButtonStyle copyWith({
    Color? backgroundColor,
    Color? backgroundColorHighlighted,
    Color? backgroundColorDisabled,
    Color? backgroundColorLoading,
    Color? borderColor,
    Color? borderColorHighlighted,
    Color? borderColorDisabled,
    Color? borderColorLoading,
    TextStyle? textStyle,
    TextStyle? textStyleHighlighted,
    TextStyle? textStyleDisabled,
    TextStyle? textStyleLoading,
    Color? iconColor,
    Color? iconColorHighlighted,
    Color? iconColorDisabled,
  }) => SBBButtonStyle(
    backgroundColor: backgroundColor ?? this.backgroundColor,
    backgroundColorHighlighted: backgroundColorHighlighted ?? this.backgroundColorHighlighted,
    backgroundColorDisabled: backgroundColorDisabled ?? this.backgroundColorDisabled,
    backgroundColorLoading: backgroundColorLoading ?? this.backgroundColorLoading,
    borderColor: borderColor ?? this.borderColor,
    borderColorHighlighted: borderColorHighlighted ?? this.borderColorHighlighted,
    borderColorDisabled: borderColorDisabled ?? this.borderColorDisabled,
    borderColorLoading: borderColorLoading ?? this.borderColorLoading,
    textStyle: textStyle ?? this.textStyle,
    textStyleHighlighted: textStyleHighlighted ?? this.textStyleHighlighted,
    textStyleDisabled: textStyleDisabled ?? this.textStyleDisabled,
    textStyleLoading: textStyleLoading ?? this.textStyleLoading,
    iconColor: iconColor ?? this.iconColor,
    iconColorHighlighted: iconColorHighlighted ?? this.iconColorHighlighted,
    iconColorDisabled: iconColorDisabled ?? this.iconColorDisabled,
  );

  SBBButtonStyle lerp(SBBButtonStyle? other, double t) => SBBButtonStyle(
    backgroundColor: Color.lerp(backgroundColor, other?.backgroundColor, t)!,
    backgroundColorHighlighted: Color.lerp(backgroundColorHighlighted, other?.backgroundColorHighlighted, t),
    backgroundColorDisabled: Color.lerp(backgroundColorDisabled, other?.backgroundColorDisabled, t),
    backgroundColorLoading: Color.lerp(backgroundColorLoading, other?.backgroundColorLoading, t),
    borderColor: Color.lerp(borderColor, other?.borderColor, t),
    borderColorHighlighted: Color.lerp(borderColorHighlighted, other?.borderColorHighlighted, t),
    borderColorDisabled: Color.lerp(borderColorDisabled, other?.borderColorDisabled, t),
    borderColorLoading: Color.lerp(borderColorLoading, other?.borderColorLoading, t),
    textStyle: TextStyle.lerp(textStyle, other?.textStyle, t),
    textStyleHighlighted: TextStyle.lerp(textStyleHighlighted, other?.textStyleHighlighted, t),
    textStyleDisabled: TextStyle.lerp(textStyleDisabled, other?.textStyleDisabled, t),
    textStyleLoading: TextStyle.lerp(textStyleLoading, other?.textStyleLoading, t),
    iconColor: Color.lerp(iconColor, other?.iconColor, t),
    iconColorHighlighted: Color.lerp(iconColorHighlighted, other?.iconColorHighlighted, t),
    iconColorDisabled: Color.lerp(iconColorDisabled, other?.iconColorDisabled, t),
  );

  ButtonStyle toButtonStyle() => ButtonStyle(
    overlayColor: SBBTheme.resolveStatesWith(defaultValue: backgroundColor!, pressedValue: backgroundColorHighlighted),
    backgroundColor: SBBTheme.resolveStatesWith(
      defaultValue: backgroundColor!,
      pressedValue: backgroundColor,
      disabledValue: backgroundColorDisabled,
    ),
    foregroundColor:
        textStyle == null
            ? null
            : SBBTheme.resolveStatesWith(
              defaultValue: textStyle!.color!,
              pressedValue: textStyleHighlighted?.color,
              disabledValue: textStyleDisabled?.color,
            ),
    textStyle:
        textStyle == null
            ? null
            : SBBTheme.resolveStatesWith(
              defaultValue: textStyle!,
              pressedValue: textStyleHighlighted,
              disabledValue: textStyleDisabled,
              parent: runtimeType.toString(),
            ),
    side:
        borderColor == null
            ? null
            : SBBTheme.resolveStatesWith(
              defaultValue: BorderSide(color: borderColor!),
              pressedValue: borderColorHighlighted == null ? null : BorderSide(color: borderColorHighlighted!),
              disabledValue: borderColorDisabled == null ? null : BorderSide(color: borderColorDisabled!),
            ),
    iconColor:
        iconColor != null
            ? SBBTheme.resolveStatesWith(
              defaultValue: iconColor!,
              pressedValue: iconColorHighlighted,
              disabledValue: iconColorDisabled,
            )
            : null,
  );

  ButtonStyle overrideButtonStyle(ButtonStyle? baseButtonStyle) => toButtonStyle().merge(baseButtonStyle);
}

extension ButtonStyleExtension on SBBButtonStyle? {
  SBBButtonStyle merge(SBBButtonStyle? other) {
    if (this == null) return other ?? SBBButtonStyle();
    return this!.copyWith(
      backgroundColor: this!.backgroundColor ?? other?.backgroundColor,
      backgroundColorHighlighted: this!.backgroundColorHighlighted ?? other?.backgroundColorHighlighted,
      backgroundColorDisabled: this!.backgroundColorDisabled ?? other?.backgroundColorDisabled,
      backgroundColorLoading: this!.backgroundColorLoading ?? other?.backgroundColorLoading,
      borderColor: this!.borderColor ?? other?.borderColor,
      borderColorHighlighted: this!.borderColorHighlighted ?? other?.borderColorHighlighted,
      borderColorDisabled: this!.borderColorDisabled ?? other?.borderColorDisabled,
      borderColorLoading: this!.borderColorLoading ?? other?.borderColorLoading,
      textStyle: this!.textStyle ?? other?.textStyle,
      textStyleHighlighted: this!.textStyleHighlighted ?? other?.textStyleHighlighted,
      textStyleDisabled: this!.textStyleDisabled ?? other?.textStyleDisabled,
      textStyleLoading: this!.textStyleLoading ?? other?.textStyleLoading,
      iconColor: this!.iconColor ?? other?.iconColor,
      iconColorHighlighted: this!.iconColorHighlighted ?? other?.iconColorHighlighted,
      iconColorDisabled: this!.iconColorDisabled ?? other?.iconColorDisabled,
    );
  }
}
