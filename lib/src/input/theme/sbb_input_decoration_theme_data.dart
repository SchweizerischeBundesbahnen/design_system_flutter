import 'dart:ui' show lerpDouble;

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
    this.leadingInputGap,
    this.trailingForegroundColor,
    this.inputTrailingGap,
    this.errorTextStyle,
    this.errorForegroundColor,
    this.titleRowErrorGap,
    this.errorBottomPadding,
    this.labelTextStyle,
    this.labelForegroundColor,
    this.floatingLabelTextStyle,
    this.floatingLabelInputGap,
    this.placeholderTextStyle,
    this.placeholderForegroundColor,
    this.borderColor,
    this.contentPadding,
  });

  /// The foreground color of the leading icon.
  final WidgetStateProperty<Color?>? leadingForegroundColor;

  /// The gap between the leading widget and the input field.
  final double? leadingInputGap;

  /// The foreground color of the trailing icon.
  final WidgetStateProperty<Color?>? trailingForegroundColor;

  /// The gap between the input field and the trailing widget.
  final double? inputTrailingGap;

  /// The foreground color of the error text.
  final WidgetStateProperty<Color?>? errorForegroundColor;

  /// The text style for the label.
  final TextStyle? labelTextStyle;

  /// The foreground color of the label text.
  final WidgetStateProperty<Color?>? labelForegroundColor;

  /// The text style for the floating label when the input is focused or has content.
  final TextStyle? floatingLabelTextStyle;

  /// The gap between the floating label and the input field.
  final double? floatingLabelInputGap;

  /// The text style for the placeholder text.
  final TextStyle? placeholderTextStyle;

  /// The foreground color of the placeholder text.
  final WidgetStateProperty<Color?>? placeholderForegroundColor;

  /// The text style for the error text.
  final TextStyle? errorTextStyle;

  /// The gap between the title row and the error widget.
  final double? titleRowErrorGap;

  /// The padding below the error widget.
  final double? errorBottomPadding;

  /// The color of the border around the input field.
  final WidgetStateProperty<Color?>? borderColor;

  /// The padding surrounding all decoration content.
  ///
  /// If null, defaults to [EdgeInsets.zero].
  final EdgeInsetsGeometry? contentPadding;

  @override
  SBBInputDecorationThemeData copyWith({
    WidgetStateProperty<Color?>? leadingForegroundColor,
    double? leadingInputGap,
    WidgetStateProperty<Color?>? trailingForegroundColor,
    double? inputTrailingGap,
    WidgetStateProperty<Color?>? errorForegroundColor,
    TextStyle? labelTextStyle,
    WidgetStateProperty<Color?>? labelForegroundColor,
    TextStyle? floatingLabelTextStyle,
    double? floatingLabelInputGap,
    TextStyle? placeholderTextStyle,
    WidgetStateProperty<Color?>? placeholderForegroundColor,
    TextStyle? errorTextStyle,
    double? titleRowErrorGap,
    double? errorBottomPadding,
    WidgetStateProperty<Color?>? borderColor,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return SBBInputDecorationThemeData(
      leadingForegroundColor: leadingForegroundColor ?? this.leadingForegroundColor,
      leadingInputGap: leadingInputGap ?? this.leadingInputGap,
      trailingForegroundColor: trailingForegroundColor ?? this.trailingForegroundColor,
      inputTrailingGap: inputTrailingGap ?? this.inputTrailingGap,
      errorForegroundColor: errorForegroundColor ?? this.errorForegroundColor,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      labelForegroundColor: labelForegroundColor ?? this.labelForegroundColor,
      floatingLabelTextStyle: floatingLabelTextStyle ?? this.floatingLabelTextStyle,
      floatingLabelInputGap: floatingLabelInputGap ?? this.floatingLabelInputGap,
      placeholderTextStyle: placeholderTextStyle ?? this.placeholderTextStyle,
      placeholderForegroundColor: placeholderForegroundColor ?? this.placeholderForegroundColor,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      titleRowErrorGap: titleRowErrorGap ?? this.titleRowErrorGap,
      errorBottomPadding: errorBottomPadding ?? this.errorBottomPadding,
      borderColor: borderColor ?? this.borderColor,
      contentPadding: contentPadding ?? this.contentPadding,
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
      leadingInputGap: lerpDouble(leadingInputGap, other.leadingInputGap, t),
      trailingForegroundColor: WidgetStateProperty.lerp<Color?>(
        trailingForegroundColor,
        other.trailingForegroundColor,
        t,
        Color.lerp,
      ),
      inputTrailingGap: lerpDouble(inputTrailingGap, other.inputTrailingGap, t),
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
      floatingLabelInputGap: lerpDouble(floatingLabelInputGap, other.floatingLabelInputGap, t),
      placeholderTextStyle: TextStyle.lerp(placeholderTextStyle, other.placeholderTextStyle, t),
      placeholderForegroundColor: WidgetStateProperty.lerp<Color?>(
        placeholderForegroundColor,
        other.placeholderForegroundColor,
        t,
        Color.lerp,
      ),
      errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t),
      titleRowErrorGap: lerpDouble(titleRowErrorGap, other.titleRowErrorGap, t),
      errorBottomPadding: lerpDouble(errorBottomPadding, other.errorBottomPadding, t),
      borderColor: WidgetStateProperty.lerp<Color?>(
        borderColor,
        other.borderColor,
        t,
        Color.lerp,
      ),
      contentPadding: EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t),
    );
  }

  @override
  int get hashCode => Object.hash(
    leadingForegroundColor,
    leadingInputGap,
    trailingForegroundColor,
    inputTrailingGap,
    errorForegroundColor,
    labelTextStyle,
    labelForegroundColor,
    floatingLabelTextStyle,
    floatingLabelInputGap,
    placeholderTextStyle,
    placeholderForegroundColor,
    errorTextStyle,
    titleRowErrorGap,
    errorBottomPadding,
    borderColor,
    contentPadding,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBInputDecorationThemeData &&
        other.leadingForegroundColor == leadingForegroundColor &&
        other.leadingInputGap == leadingInputGap &&
        other.trailingForegroundColor == trailingForegroundColor &&
        other.inputTrailingGap == inputTrailingGap &&
        other.errorForegroundColor == errorForegroundColor &&
        other.labelTextStyle == labelTextStyle &&
        other.labelForegroundColor == labelForegroundColor &&
        other.floatingLabelTextStyle == floatingLabelTextStyle &&
        other.floatingLabelInputGap == floatingLabelInputGap &&
        other.placeholderTextStyle == placeholderTextStyle &&
        other.placeholderForegroundColor == placeholderForegroundColor &&
        other.errorTextStyle == errorTextStyle &&
        other.titleRowErrorGap == titleRowErrorGap &&
        other.errorBottomPadding == errorBottomPadding &&
        other.borderColor == borderColor &&
        other.contentPadding == contentPadding;
  }
}

extension SBBInputDecorationThemeDataX on SBBInputDecorationThemeData {
  SBBInputDecorationThemeData merge(SBBInputDecorationThemeData? other) {
    if (other == null) return this;
    return copyWith(
      leadingForegroundColor: other.leadingForegroundColor,
      leadingInputGap: other.leadingInputGap,
      trailingForegroundColor: other.trailingForegroundColor,
      inputTrailingGap: other.inputTrailingGap,
      errorForegroundColor: other.errorForegroundColor,
      labelTextStyle: other.labelTextStyle,
      labelForegroundColor: other.labelForegroundColor,
      floatingLabelTextStyle: other.floatingLabelTextStyle,
      floatingLabelInputGap: other.floatingLabelInputGap,
      placeholderTextStyle: other.placeholderTextStyle,
      placeholderForegroundColor: other.placeholderForegroundColor,
      errorTextStyle: other.errorTextStyle,
      titleRowErrorGap: other.titleRowErrorGap,
      errorBottomPadding: other.errorBottomPadding,
      borderColor: other.borderColor,
      contentPadding: other.contentPadding,
    );
  }
}

extension SBBInputDecorationThemeDataThemeDataX on ThemeData {
  SBBInputDecorationThemeData? get sbbInputDecorationTheme {
    return extension<SBBInputDecorationThemeData>();
  }
}
