import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBPrimaryButton].
///
/// Use this to set the [SBBButtonStyle] for all [SBBPrimaryButton] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbPrimaryButtonTheme`.
///
/// This will effectively replace the [FilledButtonThemeData] within the current Theme.
@immutable
class SBBPrimaryButtonThemeData extends ThemeExtension<SBBPrimaryButtonThemeData> with Diagnosticable {
  /// Creates an [SBBPrimaryButtonThemeData].
  ///
  /// The [style] may be null.
  const SBBPrimaryButtonThemeData({this.style});

  /// Overrides for the button's default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBButtonStyle? style;

  @override
  SBBPrimaryButtonThemeData copyWith({SBBButtonStyle? style}) {
    return SBBPrimaryButtonThemeData(style: style ?? this.style);
  }

  @override
  SBBPrimaryButtonThemeData lerp(SBBPrimaryButtonThemeData? other, double t) {
    if (other == null) return this;
    return SBBPrimaryButtonThemeData(
      style: SBBButtonStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBPrimaryButtonThemeData && other.style == style;
  }
}

/// The ThemeData for the [SBBSecondaryButton].
///
/// Use this to set the [SBBButtonStyle] for all [SBBSecondaryButton] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbSecondaryButtonTheme`.
///
/// This will effectively replace the [OutlinedButtonThemeData] within the current Theme.
@immutable
class SBBSecondaryButtonThemeData extends ThemeExtension<SBBSecondaryButtonThemeData> with Diagnosticable {
  /// Creates an [SBBSecondaryButtonThemeData].
  ///
  /// The [style] may be null.
  const SBBSecondaryButtonThemeData({this.style});

  /// Overrides for the button's default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBButtonStyle? style;

  @override
  SBBSecondaryButtonThemeData copyWith({SBBButtonStyle? style}) {
    return SBBSecondaryButtonThemeData(style: style ?? this.style);
  }

  @override
  SBBSecondaryButtonThemeData lerp(SBBSecondaryButtonThemeData? other, double t) {
    if (other == null) return this;
    return SBBSecondaryButtonThemeData(
      style: SBBButtonStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBSecondaryButtonThemeData && other.style == style;
  }
}

/// The ThemeData for the [SBBTertiaryButton] and [SBBTertiaryButtonSmall].
///
/// Use this to set the [SBBButtonStyle] for all [SBBTertiaryButton] and [SBBTertiaryButtonSmall]
/// within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbTertiaryButtonTheme`.
///
/// This will effectively replace the [TextButtonThemeData] within the current Theme.
@immutable
class SBBTertiaryButtonThemeData extends ThemeExtension<SBBTertiaryButtonThemeData> with Diagnosticable {
  /// Creates an [SBBTertiaryButtonThemeData].
  ///
  /// The [style] may be null.
  const SBBTertiaryButtonThemeData({this.style});

  /// Overrides for the button's default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final SBBButtonStyle? style;

  @override
  SBBTertiaryButtonThemeData copyWith({SBBButtonStyle? style}) {
    return SBBTertiaryButtonThemeData(style: style ?? this.style);
  }

  @override
  SBBTertiaryButtonThemeData lerp(SBBTertiaryButtonThemeData? other, double t) {
    if (other == null) return this;
    return SBBTertiaryButtonThemeData(
      style: SBBButtonStyle.lerp(style, other.style, t),
    );
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBTertiaryButtonThemeData && other.style == style;
  }
}

extension SBBPrimaryButtonThemeDataX on SBBPrimaryButtonThemeData {
  SBBPrimaryButtonThemeData merge(SBBPrimaryButtonThemeData? other) {
    if (other == null) return this;
    return copyWith(style: style?.merge(other.style));
  }
}

extension SBBSecondaryButtonThemeDataX on SBBSecondaryButtonThemeData {
  SBBSecondaryButtonThemeData merge(SBBSecondaryButtonThemeData? other) {
    if (other == null) return this;
    return copyWith(style: style?.merge(other.style));
  }
}

extension SBBTertiaryButtonThemeDataX on SBBTertiaryButtonThemeData {
  SBBTertiaryButtonThemeData merge(SBBTertiaryButtonThemeData? other) {
    if (other == null) return this;
    return copyWith(style: style?.merge(other.style));
  }
}

extension SBBButtonThemeDataThemeDataX on ThemeData {
  SBBPrimaryButtonThemeData? get sbbPrimaryButtonTheme {
    return extension<SBBPrimaryButtonThemeData>();
  }

  SBBSecondaryButtonThemeData? get sbbSecondaryButtonTheme {
    return extension<SBBSecondaryButtonThemeData>();
  }

  SBBTertiaryButtonThemeData? get sbbTertiaryButtonTheme {
    return extension<SBBTertiaryButtonThemeData>();
  }
}
