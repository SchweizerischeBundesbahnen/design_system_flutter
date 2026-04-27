import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBHeader].
///
/// Use this to set the [SBBHeaderStyle] for all [SBBHeader] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbHeaderTheme`.
@immutable
class SBBHeaderThemeData extends ThemeExtension<SBBHeaderThemeData> with Diagnosticable {
  const SBBHeaderThemeData({this.style});

  /// Overrides for the header's default style.
  ///
  /// Non-null values override the default values.
  ///
  /// If [style] is null, then this theme doesn't override the style.
  final SBBHeaderStyle? style;

  @override
  SBBHeaderThemeData copyWith({
    SBBHeaderStyle? style,
  }) {
    return SBBHeaderThemeData(
      style: style ?? this.style,
    );
  }

  @override
  SBBHeaderThemeData lerp(SBBHeaderThemeData? other, double t) {
    if (other == null) return this;
    return SBBHeaderThemeData(
      style: SBBHeaderStyle.lerp(style, other.style, t),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SBBHeaderThemeData && runtimeType == other.runtimeType && style == other.style;

  @override
  int get hashCode => style.hashCode;
}

extension SBBHeaderThemeDataX on SBBHeaderThemeData {
  /// Merges this theme with another [SBBHeaderThemeData].
  ///
  /// Properties from [other] override properties from this theme.
  /// If [other] is null, returns this theme unchanged.
  SBBHeaderThemeData merge(SBBHeaderThemeData? other) {
    if (other == null) return this;
    return copyWith(
      style: style?.merge(other.style) ?? other.style,
    );
  }

  /// Converts the [SBBHeaderThemeData] to [AppBarTheme] used for default [ThemeData.appBarTheme].
  AppBarTheme get appBarTheme => AppBarTheme(
    foregroundColor: style?.foregroundColor,
    backgroundColor: style?.backgroundColor,
    iconTheme: IconThemeData(color: style?.foregroundColor),
    actionsIconTheme: IconThemeData(color: style?.foregroundColor),
    elevation: style?.elevation,
    centerTitle: style?.centerTitle,
    titleSpacing: style?.titleSpacing,
    titleTextStyle: style?.titleTextStyle,
    actionsPadding: style?.actionsPadding,
    systemOverlayStyle: style?.systemOverlayStyle,
    toolbarTextStyle: style?.toolbarTextStyle,
  );
}

extension SBBHeaderThemeDataThemeDataX on ThemeData {
  /// Access the [SBBHeaderThemeData] from the current theme.
  SBBHeaderThemeData? get sbbHeaderTheme => extension<SBBHeaderThemeData>();
}
