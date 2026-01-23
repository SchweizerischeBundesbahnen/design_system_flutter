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
    this.leadingInputGap,
    this.label,
    this.labelText,
    this.labelTextStyle,
    this.labelForegroundColor,
    this.floatingLabelTextStyle,
    this.floatingLabelInputGap,
    this.trailing,
    this.trailingIconData,
    this.trailingForegroundColor,
    this.inputTrailingGap,
    this.placeholder,
    this.placeholderText,
    this.placeholderTextStyle,
    this.placeholderForegroundColor,
    this.error,
    this.errorText,
    this.errorTextStyle,
    this.errorForegroundColor,
    this.titleRowErrorGap,
    this.errorBottomPadding,
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

  /// The gap between the leading widget and the input field.
  ///
  /// This is applied as right padding to the leading icon widget.
  /// Only applied when using [leadingIconData], not when using custom [leading] widget.
  final double? leadingInputGap;

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

  /// The gap between the floating label and the input field.
  final double? floatingLabelInputGap;

  /// An optional widget to display after the input field.
  final Widget? trailing;

  /// An optional icon to display after the input field.
  ///
  /// If both [trailing] and [trailingIconData] are provided, [trailing] takes precedence.
  final IconData? trailingIconData;

  /// The foreground color of the trailing icon.
  final WidgetStateProperty<Color?>? trailingForegroundColor;

  /// The gap between the input field and the trailing widget.
  ///
  /// This is applied as left padding to the trailing icon widget.
  /// Only applied when using [trailingIconData], not when using custom [trailing] widget.
  final double? inputTrailingGap;

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

  /// The gap between the title row and the error widget.
  ///
  /// This is applied as top padding to the default error text widget.
  /// Only applied when using [errorText], not when using custom [error] widget.
  final double? titleRowErrorGap;

  /// The padding below the error widget.
  ///
  /// This is applied as bottom padding to the default error text widget.
  /// Only applied when using [errorText], not when using custom [error] widget.
  final double? errorBottomPadding;

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
    double? leadingInputGap,
    Widget? label,
    String? labelText,
    TextStyle? labelTextStyle,
    WidgetStateProperty<Color?>? labelForegroundColor,
    TextStyle? floatingLabelTextStyle,
    double? floatingLabelInputGap,
    Widget? trailing,
    IconData? trailingIconData,
    WidgetStateProperty<Color?>? trailingForegroundColor,
    double? inputTrailingGap,
    Widget? placeholder,
    String? placeholderText,
    TextStyle? placeholderTextStyle,
    WidgetStateProperty<Color?>? placeholderForegroundColor,
    Widget? error,
    String? errorText,
    TextStyle? errorTextStyle,
    WidgetStateProperty<Color?>? errorForegroundColor,
    double? titleRowErrorGap,
    double? errorBottomPadding,
    WidgetStateProperty<Color?>? borderColor,
  }) {
    return SBBInputDecoration(
      leading: leading ?? this.leading,
      leadingIconData: leadingIconData ?? this.leadingIconData,
      leadingForegroundColor: leadingForegroundColor ?? this.leadingForegroundColor,
      leadingInputGap: leadingInputGap ?? this.leadingInputGap,
      label: label ?? this.label,
      labelText: labelText ?? this.labelText,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      labelForegroundColor: labelForegroundColor ?? this.labelForegroundColor,
      floatingLabelTextStyle: floatingLabelTextStyle ?? this.floatingLabelTextStyle,
      floatingLabelInputGap: floatingLabelInputGap ?? this.floatingLabelInputGap,
      trailing: trailing ?? this.trailing,
      trailingIconData: trailingIconData ?? this.trailingIconData,
      trailingForegroundColor: trailingForegroundColor ?? this.trailingForegroundColor,
      inputTrailingGap: inputTrailingGap ?? this.inputTrailingGap,
      placeholder: placeholder ?? this.placeholder,
      placeholderText: placeholderText ?? this.placeholderText,
      placeholderTextStyle: placeholderTextStyle ?? this.placeholderTextStyle,
      placeholderForegroundColor: placeholderForegroundColor ?? this.placeholderForegroundColor,
      error: error ?? this.error,
      errorText: errorText ?? this.errorText,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      errorForegroundColor: errorForegroundColor ?? this.errorForegroundColor,
      titleRowErrorGap: titleRowErrorGap ?? this.titleRowErrorGap,
      errorBottomPadding: errorBottomPadding ?? this.errorBottomPadding,
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
        other.leadingInputGap == leadingInputGap &&
        other.label == label &&
        other.labelText == labelText &&
        other.labelTextStyle == labelTextStyle &&
        other.labelForegroundColor == labelForegroundColor &&
        other.floatingLabelTextStyle == floatingLabelTextStyle &&
        other.floatingLabelInputGap == floatingLabelInputGap &&
        other.trailing == trailing &&
        other.trailingIconData == trailingIconData &&
        other.trailingForegroundColor == trailingForegroundColor &&
        other.inputTrailingGap == inputTrailingGap &&
        other.placeholder == placeholder &&
        other.placeholderText == placeholderText &&
        other.placeholderTextStyle == placeholderTextStyle &&
        other.placeholderForegroundColor == placeholderForegroundColor &&
        other.error == error &&
        other.errorText == errorText &&
        other.errorTextStyle == errorTextStyle &&
        other.errorForegroundColor == errorForegroundColor &&
        other.titleRowErrorGap == titleRowErrorGap &&
        other.errorBottomPadding == errorBottomPadding &&
        other.borderColor == borderColor;
  }

  @override
  int get hashCode => Object.hashAll([
    leading,
    leadingIconData,
    leadingForegroundColor,
    leadingInputGap,
    label,
    labelText,
    labelTextStyle,
    labelForegroundColor,
    floatingLabelTextStyle,
    floatingLabelInputGap,
    trailing,
    trailingIconData,
    trailingForegroundColor,
    inputTrailingGap,
    placeholder,
    placeholderText,
    placeholderTextStyle,
    placeholderForegroundColor,
    error,
    errorText,
    errorTextStyle,
    errorForegroundColor,
    titleRowErrorGap,
    errorBottomPadding,
    borderColor,
  ]);
}
