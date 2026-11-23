import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The theme data for the [SBBDecoration].
///
/// Use this to set the default decoration style of all decorated components
/// within the current [SBBTheme]: [SBBTextInput], [SBBDecorated], [SBBDecoratedText]
/// and the triggers of dropdowns and date and time inputs.
///
/// A single component type can deviate from this with the `decorationStyle` or
/// `triggerDecorationStyle` of its own theme, a single widget with [SBBDecoration.style].
///
/// To access this in your application, use `Theme.of(context).sbbDecorationTheme`.
@immutable
class SBBDecorationThemeData extends ThemeExtension<SBBDecorationThemeData> with Diagnosticable {
  const SBBDecorationThemeData({
    this.style,
  });

  /// Overrides for the default decoration style.
  ///
  /// Non-null properties override the default values.
  final SBBDecorationStyle? style;

  @override
  SBBDecorationThemeData copyWith({
    SBBDecorationStyle? style,
  }) {
    return SBBDecorationThemeData(
      style: style ?? this.style,
    );
  }

  @override
  SBBDecorationThemeData lerp(SBBDecorationThemeData? other, double t) {
    if (other == null) return this;
    return SBBDecorationThemeData(
      style: SBBDecorationStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBDecorationThemeData && other.style == style;
  }
}

extension SBBDecorationThemeDataX on SBBDecorationThemeData {
  SBBDecorationThemeData merge(SBBDecorationThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: style?.merge(other.style) ?? other.style,
    );
  }
}

extension SBBDecorationThemeDataThemeDataX on ThemeData {
  /// Access the [SBBDecorationThemeData] from the current theme.
  SBBDecorationThemeData get sbbDecorationTheme => extension<SBBDecorationThemeData>()!;
}
