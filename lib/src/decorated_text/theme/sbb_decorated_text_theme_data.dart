import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBDecoratedText].
///
/// Use this to customize the appearance of all [SBBDecoratedText] widgets
/// within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbDecoratedTextTheme`.
@immutable
class SBBDecoratedTextThemeData extends ThemeExtension<SBBDecoratedTextThemeData> with Diagnosticable {
  const SBBDecoratedTextThemeData({
    this.style,
  });

  /// Defines the visual properties of [SBBDecoratedText].
  ///
  /// Non-null properties of [SBBDecoratedText.style] override the corresponding
  /// properties in this style.
  final SBBDecoratedTextStyle? style;

  @override
  SBBDecoratedTextThemeData copyWith({
    SBBDecoratedTextStyle? style,
  }) {
    return SBBDecoratedTextThemeData(
      style: style ?? this.style,
    );
  }

  @override
  SBBDecoratedTextThemeData lerp(SBBDecoratedTextThemeData? other, double t) {
    if (other == null) return this;
    return SBBDecoratedTextThemeData(
      style: SBBDecoratedTextStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBDecoratedTextThemeData && other.style == style;
  }
}

extension SBBDecoratedTextThemeDataX on SBBDecoratedTextThemeData {
  SBBDecoratedTextThemeData merge(SBBDecoratedTextThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: style?.merge(other.style) ?? other.style,
    );
  }
}

extension SBBDecoratedTextThemeDataThemeDataX on ThemeData {
  SBBDecoratedTextThemeData? get sbbDecoratedTextTheme {
    return extension<SBBDecoratedTextThemeData>();
  }
}
