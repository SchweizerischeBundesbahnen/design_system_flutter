import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBHeader].
///
/// TODO:
///
/// See also:
/// * [TODO], TODO
@immutable
class SBBHeaderThemeData extends ThemeExtension<SBBHeaderThemeData> with Diagnosticable {
  /// TODO:
  const SBBHeaderThemeData({this.style});

  /// TODO:
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

  // TODO: equal / hashcode
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

  /// TODO
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
  SBBHeaderThemeData? get sbbHeaderTheme {
    return extension<SBBHeaderThemeData>();
  }
}
