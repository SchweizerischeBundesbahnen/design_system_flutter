import 'dart:ui' show lerpDouble;

import 'package:material_ui/material_ui.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Defines the visual properties of an [SBBDecoration].
///
/// This is the single place where the look of the decoration around
/// [SBBTextInput], [SBBDecorated], [SBBDecoratedText] and the triggers of
/// [SBBDropdown], [SBBMultiDropdown], [SBBDateInput], [SBBTimeInput] and
/// [SBBDateTimeInput] is defined.
///
/// A style can be set on three levels. The most specific non-null value wins:
///
/// 1. per widget with [SBBDecoration.style]
/// 2. per component type with the `decorationStyle` or `triggerDecorationStyle`
///    of the component theme, e.g. [SBBTextInputThemeData.decorationStyle]
/// 3. for all components with [SBBDecorationThemeData.style]
///
/// See also:
/// * [SBBDecoration], which holds the content and this style
/// * [SBBDecorationThemeData], for applying a style to all decorated components
@immutable
class SBBDecorationStyle {
  const SBBDecorationStyle({
    this.leadingForegroundColor,
    this.leadingInputGap,
    this.labelTextStyle,
    this.labelForegroundColor,
    this.floatingLabelTextStyle,
    this.floatingLabelInputGap,
    this.floatingLabelBehavior,
    this.trailingForegroundColor,
    this.inputTrailingGap,
    this.placeholderTextStyle,
    this.placeholderForegroundColor,
    this.errorTextStyle,
    this.errorForegroundColor,
    this.titleRowErrorGap,
    this.errorBottomPadding,
    this.borderColor,
    this.borderType,
    this.contentPadding,
  });

  /// The foreground color of the leading icon.
  final WidgetStateProperty<Color?>? leadingForegroundColor;

  /// The gap between the leading widget and the input field.
  ///
  /// This is applied as right padding to the leading icon widget.
  /// Only applied when using [SBBDecoration.leadingIconData], not when using
  /// a custom [SBBDecoration.leading] widget.
  final double? leadingInputGap;

  /// The text style for the label.
  final TextStyle? labelTextStyle;

  /// The foreground color of the label text.
  final WidgetStateProperty<Color?>? labelForegroundColor;

  /// The text style for the floating label when the input is focused or has content.
  final TextStyle? floatingLabelTextStyle;

  /// The gap between the floating label and the input field.
  final double? floatingLabelInputGap;

  /// Defines the floating behavior of the label.
  ///
  /// * When set to [SBBFloatingLabelBehavior.auto], the label floats based on
  /// focus and content state.
  /// * When set to [SBBFloatingLabelBehavior.always],
  /// the label always remains in the floating position. The placeholder will always be shown unless the
  /// input is not empty.
  final SBBFloatingLabelBehavior? floatingLabelBehavior;

  /// The foreground color of the trailing icon.
  final WidgetStateProperty<Color?>? trailingForegroundColor;

  /// The gap between the input field and the trailing widget.
  ///
  /// This is applied as left padding to the trailing icon widget.
  /// Only applied when using [SBBDecoration.trailingIconData], not when using
  /// a custom [SBBDecoration.trailing] widget.
  final double? inputTrailingGap;

  /// The text style for the placeholder text.
  final TextStyle? placeholderTextStyle;

  /// The foreground color of the placeholder text.
  final WidgetStateProperty<Color?>? placeholderForegroundColor;

  /// The text style for the error text.
  final TextStyle? errorTextStyle;

  /// The foreground color of the error text.
  final WidgetStateProperty<Color?>? errorForegroundColor;

  /// The gap between the title row and the error widget.
  ///
  /// This is applied as top padding to the default error text widget.
  /// Only applied when using [SBBDecoration.errorText], not when using
  /// a custom [SBBDecoration.error] widget.
  final double? titleRowErrorGap;

  /// The padding below the error widget.
  ///
  /// This is applied as bottom padding to the default error text widget.
  /// Only applied when using [SBBDecoration.errorText], not when using
  /// a custom [SBBDecoration.error] widget.
  final double? errorBottomPadding;

  /// The color of the border around the input field.
  ///
  /// This will be applied to a bottom border for e.g. a simple input field
  /// and to a surrounding border for a boxed input field.
  ///
  /// If [borderType] is [SBBDecorationBorderType.standalone], [SBBColorScheme.strokeSeparator]
  /// is used as default color when color is null or transparent.
  final WidgetStateProperty<Color?>? borderColor;

  /// The type of border handling for the decoration.
  ///
  /// The default border type is [SBBDecorationBorderType.boxedOrListed], where part
  /// of the border decoration is handled from outside i.e [SBBDivider.divideItems]
  /// or boxed variants like [SBBTextInputBoxed]. If the widget is standalone and
  /// expects a default border, use [SBBDecorationBorderType.standalone].
  final SBBDecorationBorderType? borderType;

  /// The padding around all decoration content.
  final EdgeInsetsGeometry? contentPadding;

  SBBDecorationStyle copyWith({
    WidgetStateProperty<Color?>? leadingForegroundColor,
    double? leadingInputGap,
    TextStyle? labelTextStyle,
    WidgetStateProperty<Color?>? labelForegroundColor,
    TextStyle? floatingLabelTextStyle,
    double? floatingLabelInputGap,
    SBBFloatingLabelBehavior? floatingLabelBehavior,
    WidgetStateProperty<Color?>? trailingForegroundColor,
    double? inputTrailingGap,
    TextStyle? placeholderTextStyle,
    WidgetStateProperty<Color?>? placeholderForegroundColor,
    TextStyle? errorTextStyle,
    WidgetStateProperty<Color?>? errorForegroundColor,
    double? titleRowErrorGap,
    double? errorBottomPadding,
    WidgetStateProperty<Color?>? borderColor,
    SBBDecorationBorderType? borderType,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return SBBDecorationStyle(
      leadingForegroundColor: leadingForegroundColor ?? this.leadingForegroundColor,
      leadingInputGap: leadingInputGap ?? this.leadingInputGap,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      labelForegroundColor: labelForegroundColor ?? this.labelForegroundColor,
      floatingLabelTextStyle: floatingLabelTextStyle ?? this.floatingLabelTextStyle,
      floatingLabelInputGap: floatingLabelInputGap ?? this.floatingLabelInputGap,
      floatingLabelBehavior: floatingLabelBehavior ?? this.floatingLabelBehavior,
      trailingForegroundColor: trailingForegroundColor ?? this.trailingForegroundColor,
      inputTrailingGap: inputTrailingGap ?? this.inputTrailingGap,
      placeholderTextStyle: placeholderTextStyle ?? this.placeholderTextStyle,
      placeholderForegroundColor: placeholderForegroundColor ?? this.placeholderForegroundColor,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      errorForegroundColor: errorForegroundColor ?? this.errorForegroundColor,
      titleRowErrorGap: titleRowErrorGap ?? this.titleRowErrorGap,
      errorBottomPadding: errorBottomPadding ?? this.errorBottomPadding,
      borderColor: borderColor ?? this.borderColor,
      borderType: borderType ?? this.borderType,
      contentPadding: contentPadding ?? this.contentPadding,
    );
  }

  /// Returns a copy of this style where every non-null value of [other] replaces the value of this style.
  SBBDecorationStyle merge(SBBDecorationStyle? other) {
    if (other == null) return this;

    return copyWith(
      leadingForegroundColor: other.leadingForegroundColor,
      leadingInputGap: other.leadingInputGap,
      labelTextStyle: other.labelTextStyle,
      labelForegroundColor: other.labelForegroundColor,
      floatingLabelTextStyle: other.floatingLabelTextStyle,
      floatingLabelInputGap: other.floatingLabelInputGap,
      floatingLabelBehavior: other.floatingLabelBehavior,
      trailingForegroundColor: other.trailingForegroundColor,
      inputTrailingGap: other.inputTrailingGap,
      placeholderTextStyle: other.placeholderTextStyle,
      placeholderForegroundColor: other.placeholderForegroundColor,
      errorTextStyle: other.errorTextStyle,
      errorForegroundColor: other.errorForegroundColor,
      titleRowErrorGap: other.titleRowErrorGap,
      errorBottomPadding: other.errorBottomPadding,
      borderColor: other.borderColor,
      borderType: other.borderType,
      contentPadding: other.contentPadding,
    );
  }

  static SBBDecorationStyle? lerp(SBBDecorationStyle? a, SBBDecorationStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBDecorationStyle(
      leadingForegroundColor: WidgetStateProperty.lerp<Color?>(
        a?.leadingForegroundColor,
        b?.leadingForegroundColor,
        t,
        Color.lerp,
      ),
      leadingInputGap: lerpDouble(a?.leadingInputGap, b?.leadingInputGap, t),
      labelTextStyle: TextStyle.lerp(a?.labelTextStyle, b?.labelTextStyle, t),
      labelForegroundColor: WidgetStateProperty.lerp<Color?>(
        a?.labelForegroundColor,
        b?.labelForegroundColor,
        t,
        Color.lerp,
      ),
      floatingLabelTextStyle: TextStyle.lerp(a?.floatingLabelTextStyle, b?.floatingLabelTextStyle, t),
      floatingLabelInputGap: lerpDouble(a?.floatingLabelInputGap, b?.floatingLabelInputGap, t),
      floatingLabelBehavior: t < 0.5 ? a?.floatingLabelBehavior : b?.floatingLabelBehavior,
      trailingForegroundColor: WidgetStateProperty.lerp<Color?>(
        a?.trailingForegroundColor,
        b?.trailingForegroundColor,
        t,
        Color.lerp,
      ),
      inputTrailingGap: lerpDouble(a?.inputTrailingGap, b?.inputTrailingGap, t),
      placeholderTextStyle: TextStyle.lerp(a?.placeholderTextStyle, b?.placeholderTextStyle, t),
      placeholderForegroundColor: WidgetStateProperty.lerp<Color?>(
        a?.placeholderForegroundColor,
        b?.placeholderForegroundColor,
        t,
        Color.lerp,
      ),
      errorTextStyle: TextStyle.lerp(a?.errorTextStyle, b?.errorTextStyle, t),
      errorForegroundColor: WidgetStateProperty.lerp<Color?>(
        a?.errorForegroundColor,
        b?.errorForegroundColor,
        t,
        Color.lerp,
      ),
      titleRowErrorGap: lerpDouble(a?.titleRowErrorGap, b?.titleRowErrorGap, t),
      errorBottomPadding: lerpDouble(a?.errorBottomPadding, b?.errorBottomPadding, t),
      borderColor: WidgetStateProperty.lerp<Color?>(a?.borderColor, b?.borderColor, t, Color.lerp),
      borderType: t < 0.5 ? a?.borderType : b?.borderType,
      contentPadding: EdgeInsetsGeometry.lerp(a?.contentPadding, b?.contentPadding, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBDecorationStyle &&
        other.leadingForegroundColor == leadingForegroundColor &&
        other.leadingInputGap == leadingInputGap &&
        other.labelTextStyle == labelTextStyle &&
        other.labelForegroundColor == labelForegroundColor &&
        other.floatingLabelTextStyle == floatingLabelTextStyle &&
        other.floatingLabelInputGap == floatingLabelInputGap &&
        other.floatingLabelBehavior == floatingLabelBehavior &&
        other.trailingForegroundColor == trailingForegroundColor &&
        other.inputTrailingGap == inputTrailingGap &&
        other.placeholderTextStyle == placeholderTextStyle &&
        other.placeholderForegroundColor == placeholderForegroundColor &&
        other.errorTextStyle == errorTextStyle &&
        other.errorForegroundColor == errorForegroundColor &&
        other.titleRowErrorGap == titleRowErrorGap &&
        other.errorBottomPadding == errorBottomPadding &&
        other.borderColor == borderColor &&
        other.borderType == borderType &&
        other.contentPadding == contentPadding;
  }

  @override
  int get hashCode => Object.hash(
    leadingForegroundColor,
    leadingInputGap,
    labelTextStyle,
    labelForegroundColor,
    floatingLabelTextStyle,
    floatingLabelInputGap,
    floatingLabelBehavior,
    trailingForegroundColor,
    inputTrailingGap,
    placeholderTextStyle,
    placeholderForegroundColor,
    errorTextStyle,
    errorForegroundColor,
    titleRowErrorGap,
    errorBottomPadding,
    borderColor,
    borderType,
    contentPadding,
  );
}
