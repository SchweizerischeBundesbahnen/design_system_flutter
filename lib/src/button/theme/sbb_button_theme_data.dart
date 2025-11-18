import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// The [SBBButtonThemeData] used to style the SBB Button variants within the current [SBBTheme].
///
/// This is a wrapper for passing the underlying [ThemeData] variants of [FilledButtonThemeData],
/// [OutlinedButtonThemeData] and [TextButtonThemeData].
@immutable
sealed class SBBButtonThemeData with Diagnosticable {
  /// Creates an [SBBButtonThemeData].
  ///
  /// The [style] may be null.
  const SBBButtonThemeData({this.style});

  /// Overrides for the button's default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBButtonStyle? style;

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is SBBButtonThemeData && other.style == style;
  }

  SBBButtonThemeData copyWith({SBBButtonStyle? style}) {
    return switch (this) {
      SBBPrimaryButtonThemeData() => SBBPrimaryButtonThemeData(style: style ?? this.style),
      SBBSecondaryButtonThemeData() => SBBSecondaryButtonThemeData(style: style ?? this.style),
      SBBTertiaryButtonThemeData() => SBBTertiaryButtonThemeData(style: style ?? this.style),
    };
  }
}

/// The ThemeData for the [SBBPrimaryButton].
///
/// Use this to set the [SBBButtonStyle] for all [SBBPrimaryButton] within the current [SBBTheme].
///
/// This will effectively replace the [FilledButtonThemeData] within the current Theme.
@immutable
class SBBPrimaryButtonThemeData extends SBBButtonThemeData {
  /// Creates an [SBBPrimaryButtonThemeData].
  ///
  /// The [style] may be null.
  const SBBPrimaryButtonThemeData({super.style});
}

/// The ThemeData for the [SBBSecondaryButton].
///
/// Use this to set the [SBBButtonStyle] for all [SBBSecondaryButton] within the current [SBBTheme].
///
/// This will effectively replace the [OutlinedButtonThemeData] within the current Theme.
@immutable
class SBBSecondaryButtonThemeData extends SBBButtonThemeData {
  /// Creates an [SBBSecondaryButtonThemeData].
  ///
  /// The [style] may be null.
  const SBBSecondaryButtonThemeData({super.style});
}

/// The ThemeData for the [SBBTertiaryButton] and [SBBTertiaryButtonSmall].
///
/// Use this to set the [SBBButtonStyle] for all [SBBTertiaryButton] and [SBBTertiaryButtonSmall]
/// within the current [SBBTheme].
///
/// This will effectively replace the [TextButtonThemeData] within the current Theme.
@immutable
class SBBTertiaryButtonThemeData extends SBBButtonThemeData {
  /// Creates an [SBBTertiaryButtonThemeData].
  ///
  /// The [style] may be null.
  const SBBTertiaryButtonThemeData({super.style});
}

extension SBBButtonThemeDataX on SBBButtonThemeData {
  SBBButtonThemeData merge(SBBButtonThemeData? other) {
    if (other == null) return this;
    return copyWith(style: style?.merge(other.style));
  }
}
