import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBPaginator].
///
/// Use this to set the [SBBPaginatorStyle] for all [SBBPaginator] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbPaginatorTheme`.
@immutable
class SBBPaginatorThemeData extends ThemeExtension<SBBPaginatorThemeData> with Diagnosticable {
  /// Creates an [SBBPaginatorThemeData].
  ///
  /// The [style] may be null.
  const SBBPaginatorThemeData({this.style});

  /// Overrides for the paginator.dart's default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBPaginatorStyle? style;

  @override
  SBBPaginatorThemeData copyWith({SBBPaginatorStyle? style}) {
    return SBBPaginatorThemeData(style: style ?? this.style);
  }

  @override
  SBBPaginatorThemeData lerp(SBBPaginatorThemeData? other, double t) {
    if (other == null) return this;
    return SBBPaginatorThemeData(
      style: SBBPaginatorStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBPaginatorThemeData && other.style == style;
  }
}

extension SBBPaginatorThemeDataX on SBBPaginatorThemeData {
  SBBPaginatorThemeData merge(SBBPaginatorThemeData? other) {
    if (other == null) return this;
    return copyWith(style: style?.merge(other.style));
  }
}

extension SBBPaginatorThemeDataThemeDataX on ThemeData {
  SBBPaginatorThemeData? get sbbPaginatorTheme {
    return extension<SBBPaginatorThemeData>();
  }
}
