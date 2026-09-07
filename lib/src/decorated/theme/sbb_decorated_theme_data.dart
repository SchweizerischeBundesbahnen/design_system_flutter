import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  });

  final SBBDecoratedStyle? style;

  @override
  SBBDecoratedThemeData copyWith({
    SBBDecoratedStyle? style,
  }) {
    return SBBDecoratedThemeData(
      style: style ?? this.style,
    );
  }

  @override
  SBBDecoratedThemeData lerp(SBBDecoratedThemeData? other, double t) {
    if (other == null) return this;
    return SBBDecoratedThemeData(
      style: SBBDecoratedStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBDecoratedThemeData && other.style == style;
  }
}

extension SBBDecoratedThemeDataX on SBBDecoratedThemeData {
  SBBDecoratedThemeData merge(SBBDecoratedThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: style?.merge(other.style) ?? other.style,
    );
  }
}

extension SBBDecoratedThemeDataThemeDataX on ThemeData {
  SBBDecoratedThemeData get sbbDecoratedTheme => extension<SBBDecoratedThemeData>()!;
}
