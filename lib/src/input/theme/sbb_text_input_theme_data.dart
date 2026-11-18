import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBTextInput].
///
/// Use this to set the default text input properties for all [SBBTextInput] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbTextInputTheme`.
@immutable
class SBBTextInputThemeData extends ThemeExtension<SBBTextInputThemeData> with Diagnosticable {
  /// Creates an [SBBTextInputThemeData].
  const SBBTextInputThemeData({
    this.style,
    this.decorationStyle,
  });

  /// Overrides for the default style of the text input.
  ///
  /// Non-null properties override the default values.
  final SBBTextInputStyle? style;

  /// Overrides for the decoration style of all text inputs.
  ///
  /// Non-null properties override the values of [SBBDecorationThemeData.style].
  ///
  /// If [decorationStyle] is null, then this theme doesn't override anything.
  final SBBDecorationStyle? decorationStyle;

  @override
  SBBTextInputThemeData copyWith({
    SBBTextInputStyle? style,
    SBBDecorationStyle? decorationStyle,
  }) {
    return SBBTextInputThemeData(
      style: style ?? this.style,
      decorationStyle: decorationStyle ?? this.decorationStyle,
    );
  }

  @override
  SBBTextInputThemeData lerp(SBBTextInputThemeData? other, double t) {
    if (other == null) return this;
    return SBBTextInputThemeData(
      style: SBBTextInputStyle.lerp(style, other.style, t),
      decorationStyle: SBBDecorationStyle.lerp(decorationStyle, other.decorationStyle, t),
    );
  }

  @override
  int get hashCode => Object.hash(style, decorationStyle);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBTextInputThemeData && other.style == style && other.decorationStyle == decorationStyle;
  }
}

extension SBBTextInputThemeDataX on SBBTextInputThemeData {
  SBBTextInputThemeData merge(SBBTextInputThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: style?.merge(other.style) ?? other.style,
      decorationStyle: decorationStyle?.merge(other.decorationStyle) ?? other.decorationStyle,
    );
  }
}

extension SBBTextInputThemeDataThemeDataX on ThemeData {
  /// Access the [SBBTextInputThemeData] from the current theme.
  SBBTextInputThemeData get sbbTextInputTheme => extension<SBBTextInputThemeData>()!;
}
