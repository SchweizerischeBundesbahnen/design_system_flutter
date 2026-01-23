import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/checkbox/theme/sbb_checkbox_style.dart';

/// The ThemeData for the [SBBCheckbox].
///
/// Use this to set the [SBBCheckboxStyle] for all [SBBCheckbox] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbCheckboxTheme`.
@immutable
class SBBCheckboxThemeData extends ThemeExtension<SBBCheckboxThemeData> with Diagnosticable {
  /// Creates an [SBBCheckboxThemeData].
  ///
  /// The [style] may be null.
  const SBBCheckboxThemeData({this.style});

  /// Overrides for the checkbox's default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBCheckboxStyle? style;

  @override
  SBBCheckboxThemeData copyWith({SBBCheckboxStyle? style}) {
    return SBBCheckboxThemeData(style: style ?? this.style);
  }

  @override
  SBBCheckboxThemeData lerp(SBBCheckboxThemeData? other, double t) {
    if (other == null) return this;
    return SBBCheckboxThemeData(
      style: SBBCheckboxStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBCheckboxThemeData && other.style == style;
  }
}

extension SBBCheckboxThemeDataX on SBBCheckboxThemeData {
  SBBCheckboxThemeData merge(SBBCheckboxThemeData? other) {
    if (other == null) return this;
    return copyWith(style: style?.merge(other.style));
  }
}

extension SBBCheckboxThemeDataThemeDataX on ThemeData {
  SBBCheckboxThemeData? get sbbCheckboxTheme {
    return extension<SBBCheckboxThemeData>();
  }
}
