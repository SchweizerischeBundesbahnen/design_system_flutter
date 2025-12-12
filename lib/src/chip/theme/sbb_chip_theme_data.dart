import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'sbb_chip_style.dart';

/// The ThemeData for the [SBBChip].
///
/// Use this to set the [SBBChipStyle] for all [SBBChip] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbChipTheme`.
@immutable
class SBBChipThemeData extends ThemeExtension<SBBChipThemeData> with Diagnosticable {
  /// Creates an [SBBChipThemeData].
  ///
  /// The [style] may be null.
  const SBBChipThemeData({this.style});

  /// Overrides for the chip's default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBChipStyle? style;

  @override
  SBBChipThemeData copyWith({SBBChipStyle? style}) {
    return SBBChipThemeData(style: style ?? this.style);
  }

  @override
  SBBChipThemeData lerp(SBBChipThemeData? other, double t) {
    if (other == null) return this;
    return SBBChipThemeData(
      style: SBBChipStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBChipThemeData && other.style == style;
  }
}

extension SBBChipThemeDataX on SBBChipThemeData {
  SBBChipThemeData merge(SBBChipThemeData? other) {
    if (other == null) return this;
    return copyWith(style: style?.merge(other.style));
  }
}

extension SBBChipThemeDataThemeDataX on ThemeData {
  SBBChipThemeData? get sbbChipTheme {
    return extension<SBBChipThemeData>();
  }
}
