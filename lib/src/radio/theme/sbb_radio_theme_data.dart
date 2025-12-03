import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/radio/theme/sbb_radio_style.dart';

/// The ThemeData for the [SBBRadio].
///
/// Use this to set the [SBBRadioStyle] for all [SBBRadio] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbRadioTheme`.
@immutable
class SBBRadioThemeData extends ThemeExtension<SBBRadioThemeData> with Diagnosticable {
  /// Creates an [SBBRadioThemeData].
  ///
  /// The [style] may be null.
  const SBBRadioThemeData({this.style});

  /// Overrides for the radio's default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBRadioStyle? style;

  @override
  SBBRadioThemeData copyWith({SBBRadioStyle? style}) {
    return SBBRadioThemeData(style: style ?? this.style);
  }

  @override
  SBBRadioThemeData lerp(SBBRadioThemeData? other, double t) {
    if (other == null) return this;
    return SBBRadioThemeData(
      style: SBBRadioStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBRadioThemeData && other.style == style;
  }
}

extension SBBRadioThemeDataX on SBBRadioThemeData {
  SBBRadioThemeData merge(SBBRadioThemeData? other) {
    if (other == null) return this;
    return copyWith(style: style?.merge(other.style));
  }
}

extension SBBRadioThemeDataThemeDataX on ThemeData {
  SBBRadioThemeData? get sbbRadioTheme {
    return extension<SBBRadioThemeData>();
  }
}
