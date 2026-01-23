import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBInputDecoration].
///
/// Use this to set the default input decoration properties for all inputs within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbInputDecorationTheme`.
@immutable
class SBBInputDecorationThemeData extends ThemeExtension<SBBInputDecorationThemeData> with Diagnosticable {
  /// Creates an [SBBInputDecorationThemeData].
  const SBBInputDecorationThemeData({
    this.leadingForegroundColor,
    this.trailingForegroundColor,
    this.errorTextStyle,
    this.errorForegroundColor,
    this.labelTextStyle,
    this.labelForegroundColor,
    this.floatingLabelTextStyle,
    this.placeholderTextStyle,
    this.placeholderForegroundColor,
    this.borderColor,
  });

  /// The foreground color of the leading icon.
  final WidgetStateProperty<Color?>? leadingForegroundColor;

  /// The foreground color of the trailing icon.
  final WidgetStateProperty<Color?>? trailingForegroundColor;

  /// The foreground color of the error text.
  final WidgetStateProperty<Color?>? errorForegroundColor;

  /// The text style for the label.
  final TextStyle? labelTextStyle;

  /// The foreground color of the label text.
  final WidgetStateProperty<Color?>? labelForegroundColor;

  /// The text style for the floating label when the input is focused or has content.
  final TextStyle? floatingLabelTextStyle;

  /// The text style for the placeholder text.
  final TextStyle? placeholderTextStyle;

  /// The foreground color of the placeholder text.
  final WidgetStateProperty<Color?>? placeholderForegroundColor;

  /// The text style for the error text.
  final TextStyle? errorTextStyle;

  /// The color of the border around the input field.
  final WidgetStateProperty<Color?>? borderColor;

  @override
  SBBInputDecorationThemeData copyWith({
    WidgetStateProperty<Color?>? leadingForegroundColor,
    WidgetStateProperty<Color?>? trailingForegroundColor,
    WidgetStateProperty<Color?>? errorForegroundColor,
    TextStyle? labelTextStyle,
    WidgetStateProperty<Color?>? labelForegroundColor,
    TextStyle? floatingLabelTextStyle,
    TextStyle? placeholderTextStyle,
    WidgetStateProperty<Color?>? placeholderForegroundColor,
    TextStyle? errorTextStyle,
    WidgetStateProperty<Color?>? borderColor,
  }) {
    return SBBInputDecorationThemeData(
      leadingForegroundColor: leadingForegroundColor ?? this.leadingForegroundColor,
      trailingForegroundColor: trailingForegroundColor ?? this.trailingForegroundColor,
      errorForegroundColor: errorForegroundColor ?? this.errorForegroundColor,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      labelForegroundColor: labelForegroundColor ?? this.labelForegroundColor,
      floatingLabelTextStyle: floatingLabelTextStyle ?? this.floatingLabelTextStyle,
      placeholderTextStyle: placeholderTextStyle ?? this.placeholderTextStyle,
      placeholderForegroundColor: placeholderForegroundColor ?? this.placeholderForegroundColor,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  @override
  SBBInputDecorationThemeData lerp(SBBInputDecorationThemeData? other, double t) {
    if (other == null) return this;
    return SBBInputDecorationThemeData(
      leadingForegroundColor: WidgetStateProperty.lerp<Color?>(
        leadingForegroundColor,
        other.leadingForegroundColor,
        t,
        Color.lerp,
      ),
      trailingForegroundColor: WidgetStateProperty.lerp<Color?>(
        trailingForegroundColor,
        other.trailingForegroundColor,
        t,
        Color.lerp,
      ),
      errorForegroundColor: WidgetStateProperty.lerp<Color?>(
        errorForegroundColor,
        other.errorForegroundColor,
        t,
        Color.lerp,
      ),
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t),
      labelForegroundColor: WidgetStateProperty.lerp<Color?>(
        labelForegroundColor,
        other.labelForegroundColor,
        t,
        Color.lerp,
      ),
      floatingLabelTextStyle: TextStyle.lerp(floatingLabelTextStyle, other.floatingLabelTextStyle, t),
      placeholderTextStyle: TextStyle.lerp(placeholderTextStyle, other.placeholderTextStyle, t),
      placeholderForegroundColor: WidgetStateProperty.lerp<Color?>(
        placeholderForegroundColor,
        other.placeholderForegroundColor,
        t,
        Color.lerp,
      ),
      errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t),
      borderColor: WidgetStateProperty.lerp<Color?>(
        borderColor,
        other.borderColor,
        t,
        Color.lerp,
      ),
    );
  }

  @override
  int get hashCode => Object.hash(
    leadingForegroundColor,
    trailingForegroundColor,
    errorForegroundColor,
    labelTextStyle,
    labelForegroundColor,
    floatingLabelTextStyle,
    placeholderTextStyle,
    placeholderForegroundColor,
    errorTextStyle,
    borderColor,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBInputDecorationThemeData &&
        other.leadingForegroundColor == leadingForegroundColor &&
        other.trailingForegroundColor == trailingForegroundColor &&
        other.errorForegroundColor == errorForegroundColor &&
        other.labelTextStyle == labelTextStyle &&
        other.labelForegroundColor == labelForegroundColor &&
        other.floatingLabelTextStyle == floatingLabelTextStyle &&
        other.placeholderTextStyle == placeholderTextStyle &&
        other.placeholderForegroundColor == placeholderForegroundColor &&
        other.errorTextStyle == errorTextStyle &&
        other.borderColor == borderColor;
  }
}

extension SBBInputDecorationThemeDataX on SBBInputDecorationThemeData {
  SBBInputDecorationThemeData merge(SBBInputDecorationThemeData? other) {
    if (other == null) return this;
    return copyWith(
      leadingForegroundColor: other.leadingForegroundColor,
      trailingForegroundColor: other.trailingForegroundColor,
      errorForegroundColor: other.errorForegroundColor,
      labelTextStyle: other.labelTextStyle,
      labelForegroundColor: other.labelForegroundColor,
      floatingLabelTextStyle: other.floatingLabelTextStyle,
      placeholderTextStyle: other.placeholderTextStyle,
      placeholderForegroundColor: other.placeholderForegroundColor,
      errorTextStyle: other.errorTextStyle,
      borderColor: other.borderColor,
    );
  }
}

extension SBBInputDecorationThemeDataThemeDataX on ThemeData {
  SBBInputDecorationThemeData? get sbbInputDecorationTheme {
    return extension<SBBInputDecorationThemeData>();
  }
}
