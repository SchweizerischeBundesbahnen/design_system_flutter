import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBListHeader].
///
/// Use this to set the [SBBListHeaderStyle] for all [SBBListHeader] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbListHeaderTheme`.
@immutable
class SBBListHeaderThemeData extends ThemeExtension<SBBListHeaderThemeData> with Diagnosticable {
  /// Creates an [SBBListHeaderThemeData].
  ///
  /// The [style] may be null.
  const SBBListHeaderThemeData({this.style});

  /// Overrides for the list header's default style.
  ///
  /// Non-null properties override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBListHeaderStyle? style;

  @override
  SBBListHeaderThemeData copyWith({SBBListHeaderStyle? style}) {
    return SBBListHeaderThemeData(style: style ?? this.style);
  }

  @override
  SBBListHeaderThemeData lerp(SBBListHeaderThemeData? other, double t) {
    if (other == null) return this;
    return SBBListHeaderThemeData(
      style: SBBListHeaderStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBListHeaderThemeData && other.style == style;
  }
}

extension SBBListHeaderThemeDataX on SBBListHeaderThemeData {
  SBBListHeaderThemeData merge(SBBListHeaderThemeData? other) {
    if (other == null) return this;
    return copyWith(style: style?.merge(other.style));
  }
}

extension SBBListHeaderThemeDataThemeDataX on ThemeData {
  /// Access the [SBBListHeaderThemeData] from the current theme.
  SBBListHeaderThemeData? get sbbListHeaderTheme => extension<SBBListHeaderThemeData>();
}
