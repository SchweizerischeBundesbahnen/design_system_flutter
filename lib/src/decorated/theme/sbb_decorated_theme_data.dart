import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The theme data for [SBBDecorated].
///
/// Defines the default visual properties for all [SBBDecorated] widgets
/// within the current theme. Individual widget instances can override these
/// defaults using [SBBDecorated.style].
///
/// Access this theme using `Theme.of(context).sbbDecoratedTheme`.
@immutable
class SBBDecoratedThemeData extends ThemeExtension<SBBDecoratedThemeData> with Diagnosticable {
  const SBBDecoratedThemeData({
    this.style,
    this.decorationStyle,
  });

  final SBBDecoratedStyle? style;

  /// Overrides for the decoration style of all [SBBDecorated] widgets.
  ///
  /// Non-null properties override the values of [SBBDecorationThemeData.style].
  ///
  /// If [decorationStyle] is null, then this theme doesn't override anything.
  final SBBDecorationStyle? decorationStyle;

  @override
  SBBDecoratedThemeData copyWith({
    SBBDecoratedStyle? style,
    SBBDecorationStyle? decorationStyle,
  }) {
    return SBBDecoratedThemeData(
      style: style ?? this.style,
      decorationStyle: decorationStyle ?? this.decorationStyle,
    );
  }

  @override
  SBBDecoratedThemeData lerp(SBBDecoratedThemeData? other, double t) {
    if (other == null) return this;
    return SBBDecoratedThemeData(
      style: SBBDecoratedStyle.lerp(style, other.style, t),
      decorationStyle: SBBDecorationStyle.lerp(decorationStyle, other.decorationStyle, t),
    );
  }

  @override
  int get hashCode => Object.hash(style, decorationStyle);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBDecoratedThemeData && other.style == style && other.decorationStyle == decorationStyle;
  }
}

extension SBBDecoratedThemeDataX on SBBDecoratedThemeData {
  SBBDecoratedThemeData merge(SBBDecoratedThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: style?.merge(other.style) ?? other.style,
      decorationStyle: decorationStyle?.merge(other.decorationStyle) ?? other.decorationStyle,
    );
  }
}

extension SBBDecoratedThemeDataThemeDataX on ThemeData {
  SBBDecoratedThemeData get sbbDecoratedTheme => extension<SBBDecoratedThemeData>()!;
}
