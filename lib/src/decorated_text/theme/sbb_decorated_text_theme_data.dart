import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The theme data for [SBBDecoratedText].
///
/// Defines the default visual properties for all [SBBDecoratedText] widgets
/// within the current theme. Individual widget instances can override these
/// defaults using [SBBDecoratedText.style].
///
/// Access this theme using `Theme.of(context).sbbDecoratedTextTheme`.
@immutable
class SBBDecoratedTextThemeData extends ThemeExtension<SBBDecoratedTextThemeData> with Diagnosticable {
  const SBBDecoratedTextThemeData({
    this.style,
    this.decorationStyle,
  });

  /// Defines the visual properties of [SBBDecoratedText].
  final SBBDecoratedTextStyle? style;

  /// Overrides for the decoration style of all [SBBDecoratedText] widgets.
  ///
  /// Non-null properties override the values of [SBBDecorationThemeData.style].
  ///
  /// If [decorationStyle] is null, then this theme doesn't override anything.
  final SBBDecorationStyle? decorationStyle;

  @override
  SBBDecoratedTextThemeData copyWith({
    SBBDecoratedTextStyle? style,
    SBBDecorationStyle? decorationStyle,
  }) {
    return SBBDecoratedTextThemeData(
      style: style ?? this.style,
      decorationStyle: decorationStyle ?? this.decorationStyle,
    );
  }

  @override
  SBBDecoratedTextThemeData lerp(SBBDecoratedTextThemeData? other, double t) {
    if (other == null) return this;
    return SBBDecoratedTextThemeData(
      style: SBBDecoratedTextStyle.lerp(style, other.style, t),
      decorationStyle: SBBDecorationStyle.lerp(decorationStyle, other.decorationStyle, t),
    );
  }

  @override
  int get hashCode => Object.hash(style, decorationStyle);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBDecoratedTextThemeData && other.style == style && other.decorationStyle == decorationStyle;
  }
}

extension SBBDecoratedTextThemeDataX on SBBDecoratedTextThemeData {
  SBBDecoratedTextThemeData merge(SBBDecoratedTextThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: style?.merge(other.style) ?? other.style,
      decorationStyle: decorationStyle?.merge(other.decorationStyle) ?? other.decorationStyle,
    );
  }
}

extension SBBDecoratedTextThemeDataThemeDataX on ThemeData {
  /// Access the [SBBDecoratedTextThemeData] from the current theme.
  SBBDecoratedTextThemeData get sbbDecoratedTextTheme => extension<SBBDecoratedTextThemeData>()!;
}
