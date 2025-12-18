import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/container/theme/default_sbb_content_box_theme_data.dart';

import '../../../sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBContentBox].
///
/// Use this to set the [SBBContentBoxStyle] for all [SBBContentBox] widgets within the current
/// [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbContentBoxTheme`.
@immutable
class SBBContentBoxThemeData extends ThemeExtension<SBBContentBoxThemeData> with Diagnosticable {
  /// Creates an [SBBContentBoxThemeData].
  ///
  /// The [style] may be null. If null, the theme won't override the default [SBBContentBoxStyle].
  const SBBContentBoxThemeData({this.style});

  /// Overrides for the content box's default style.
  ///
  /// Non-null properties of this [SBBContentBoxStyle] will override the default values used by
  /// [SBBContentBox] widgets.
  ///
  /// If [style] is null, then this theme doesn't override anything and the default
  /// [DefaultSBBContentBoxTheme] will be used.
  final SBBContentBoxStyle? style;

  @override
  SBBContentBoxThemeData copyWith({SBBContentBoxStyle? style}) {
    return SBBContentBoxThemeData(style: style ?? this.style);
  }

  @override
  SBBContentBoxThemeData lerp(SBBContentBoxThemeData? other, double t) {
    if (other == null) return this;
    return SBBContentBoxThemeData(style: style?.lerp(other.style, t));
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBContentBoxThemeData && other.style == style;
  }
}

extension SBBContentBoxThemeDataX on SBBContentBoxThemeData {
  SBBContentBoxThemeData merge(SBBContentBoxThemeData? other) {
    if (other == null) return this;
    return copyWith(style: style?.merge(other.style));
  }
}

extension SBBContentBoxThemeDataThemeDataX on ThemeData {
  SBBContentBoxThemeData? get sbbContentBoxTheme {
    return extension<SBBContentBoxThemeData>();
  }
}
