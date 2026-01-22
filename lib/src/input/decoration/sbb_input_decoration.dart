import 'package:flutter/material.dart';

/// Defines the visual properties and content for SBB inputs.
///
/// This class provides a way to configure the appearance and content of
/// text input decorations including leading/trailing widgets, labels,
/// hints, errors, and colors.
@immutable
class SBBInputDecoration {
  const SBBInputDecoration({
    this.leading,
    this.leadingIconData,
    this.leadingForegroundColor,
    this.label,
    this.labelText,
    this.labelTextStyle,
    this.labelForegroundColor,
    this.floatingLabelTextStyle,
    this.trailing,
    this.trailingIconData,
    this.trailingForegroundColor,
    this.placeholder,
    this.placeholderText,
    this.placeholderTextStyle,
    this.placeholderForegroundColor,
    this.error,
    this.errorText,
    this.errorTextStyle,
    this.errorForegroundColor,
    this.borderColor,
  });

  /// An optional widget to display before the input field.
  final Widget? leading;

  /// An optional icon to display before the input field.
  ///
  /// If both [leading] and [leadingIconData] are provided, [leading] takes precedence.
  final IconData? leadingIconData;

  /// The foreground color of the leading icon.
  final WidgetStateProperty<Color?>? leadingForegroundColor;

  /// An optional widget to display as the label above the input field.
  final Widget? label;

  /// Text to display as the label above the input field.
  ///
  /// If both [label] and [labelText] are provided, [label] takes precedence.
  final String? labelText;

  /// The text style for the label.
  final TextStyle? labelTextStyle;

  /// The foreground color of the label text.
  final WidgetStateProperty<Color?>? labelForegroundColor;

  /// The text style for the floating label when the input is focused or has content.
  final TextStyle? floatingLabelTextStyle;

  /// An optional widget to display after the input field.
  final Widget? trailing;

  /// An optional icon to display after the input field.
  ///
  /// If both [trailing] and [trailingIconData] are provided, [trailing] takes precedence.
  final IconData? trailingIconData;

  /// The foreground color of the trailing icon.
  final WidgetStateProperty<Color?>? trailingForegroundColor;

  /// An optional widget to display as a hint/placeholder in the input field.
  final Widget? placeholder;

  /// Text to display as a hint/placeholder in the input field.
  ///
  /// If both [placeholder] and [placeholderText] are provided, [placeholder] takes precedence.
  final String? placeholderText;

  /// The text style for the hint text.
  final TextStyle? placeholderTextStyle;

  /// The foreground color of the hint text.
  final WidgetStateProperty<Color?>? placeholderForegroundColor;

  /// An optional widget to display as an error message below the input field.
  final Widget? error;

  /// Text to display as an error message below the input field.
  ///
  /// If both [error] and [errorText] are provided, [error] takes precedence.
  final String? errorText;

  /// The text style for the error text.
  final TextStyle? errorTextStyle;

  /// The foreground color of the error text.
  final WidgetStateProperty<Color?>? errorForegroundColor;

  /// The color of the border around the input field.
  ///
  /// This will be applied to a bottom border for e.g. a simple input field
  /// and to a surrounding border for a boxed input field.
  final WidgetStateProperty<Color?>? borderColor;

  /// Creates a copy of this decoration with the given fields replaced
  /// by the new values.
  SBBInputDecoration copyWith({
    Widget? leading,
    IconData? leadingIconData,
    WidgetStateProperty<Color?>? leadingForegroundColor,
    Widget? label,
    String? labelText,
    TextStyle? labelTextStyle,
    WidgetStateProperty<Color?>? labelForegroundColor,
    TextStyle? floatingLabelTextStyle,
    Widget? trailing,
    IconData? trailingIconData,
    WidgetStateProperty<Color?>? trailingForegroundColor,
    Widget? placeholder,
    String? placeholderText,
    TextStyle? placeholderTextStyle,
    WidgetStateProperty<Color?>? placeholderForegroundColor,
    Widget? error,
    String? errorText,
    TextStyle? errorTextStyle,
    WidgetStateProperty<Color?>? errorForegroundColor,
    WidgetStateProperty<Color?>? borderColor,
  }) {
    return SBBInputDecoration(
      leading: leading ?? this.leading,
      leadingIconData: leadingIconData ?? this.leadingIconData,
      leadingForegroundColor: leadingForegroundColor ?? this.leadingForegroundColor,
      label: label ?? this.label,
      labelText: labelText ?? this.labelText,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      labelForegroundColor: labelForegroundColor ?? this.labelForegroundColor,
      floatingLabelTextStyle: floatingLabelTextStyle ?? this.floatingLabelTextStyle,
      trailing: trailing ?? this.trailing,
      trailingIconData: trailingIconData ?? this.trailingIconData,
      trailingForegroundColor: trailingForegroundColor ?? this.trailingForegroundColor,
      placeholder: placeholder ?? this.placeholder,
      placeholderText: placeholderText ?? this.placeholderText,
      placeholderTextStyle: placeholderTextStyle ?? this.placeholderTextStyle,
      placeholderForegroundColor: placeholderForegroundColor ?? this.placeholderForegroundColor,
      error: error ?? this.error,
      errorText: errorText ?? this.errorText,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      errorForegroundColor: errorForegroundColor ?? this.errorForegroundColor,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBInputDecoration &&
        other.leading == leading &&
        other.leadingIconData == leadingIconData &&
        other.leadingForegroundColor == leadingForegroundColor &&
        other.label == label &&
        other.labelText == labelText &&
        other.labelTextStyle == labelTextStyle &&
        other.labelForegroundColor == labelForegroundColor &&
        other.floatingLabelTextStyle == floatingLabelTextStyle &&
        other.trailing == trailing &&
        other.trailingIconData == trailingIconData &&
        other.trailingForegroundColor == trailingForegroundColor &&
        other.placeholder == placeholder &&
        other.placeholderText == placeholderText &&
        other.placeholderTextStyle == placeholderTextStyle &&
        other.placeholderForegroundColor == placeholderForegroundColor &&
        other.error == error &&
        other.errorText == errorText &&
        other.errorTextStyle == errorTextStyle &&
        other.errorForegroundColor == errorForegroundColor &&
        other.borderColor == borderColor;
  }

  @override
  int get hashCode => Object.hashAll([
    leading,
    leadingIconData,
    leadingForegroundColor,
    label,
    labelText,
    labelTextStyle,
    labelForegroundColor,
    floatingLabelTextStyle,
    trailing,
    trailingIconData,
    trailingForegroundColor,
    placeholder,
    placeholderText,
    placeholderTextStyle,
    placeholderForegroundColor,
    error,
    errorText,
    errorTextStyle,
    errorForegroundColor,
    borderColor,
  ]);
}
