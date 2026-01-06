import 'package:flutter/widgets.dart';

/// Defines the visual properties of [SBBSwitch].
///
/// Use this class in combination with [SBBSwitchThemeData] to customize
/// the appearance of switches throughout your app or for specific widget subtrees.
///
/// See also:
/// * [SBBSwitch], the switch widget that uses this style.
/// * [SBBSwitchThemeData], which applies this style theme-wide.
class SBBSwitchStyle {
  const SBBSwitchStyle({
    this.trackColor,
    this.knobBackgroundColor,
    this.knobBorderColor,
    this.knobForegroundColor,
    this.tapTargetPadding,
  });

  /// The color of the switch track.
  final WidgetStateProperty<Color?>? trackColor;

  /// The background color of the switch knob.
  final WidgetStateProperty<Color?>? knobBackgroundColor;

  /// The border color of the switch knob.
  final WidgetStateProperty<Color?>? knobBorderColor;

  /// The color for the icon (tick mark) on the knob.
  final WidgetStateProperty<Color?>? knobForegroundColor;

  /// The space between the switch's tap target and its visual appearance.
  ///
  /// This padding increases the interactive area of the switch beyond the
  /// visible [switchSize]. A larger padding makes the switch easier to tap
  /// while keeping the visual size constant.
  ///
  /// Defaults to `EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0)` to ensure
  /// a minimum tap target height of 36.
  final EdgeInsetsGeometry? tapTargetPadding;

  static const double trackWidth = 52.0;

  static const double trackHeight = 20.0;

  static const Size trackSize = Size(trackWidth, trackHeight);

  static const Size switchSize = Size(trackWidth, (knobRadius + knobBorderWidth) * 2);

  static const double trackInnerStart = knobRadius + knobBorderWidth * .5;

  static const double trackInnerEnd = trackWidth - trackInnerStart;

  static const double trackInnerLength = trackInnerEnd - trackInnerStart;

  static const double knobRadius = 13.0;

  static const double knobBorderWidth = 1.0;

  /// The horizontal extension of the knob when pressed.
  static const double knobPressedExtension = 7.0;

  static const List<BoxShadow> knobBoxShadows = [
    BoxShadow(color: Color(0x4D000000), offset: Offset(0, 1), blurRadius: 2.0),
  ];

  SBBSwitchStyle copyWith({
    WidgetStateProperty<Color?>? trackColor,
    WidgetStateProperty<Color?>? knobBackgroundColor,
    WidgetStateProperty<Color?>? knobBorderColor,
    WidgetStateProperty<Color?>? knobForegroundColor,
    EdgeInsetsGeometry? tapTargetPadding,
  }) {
    return SBBSwitchStyle(
      trackColor: trackColor ?? this.trackColor,
      knobBackgroundColor: knobBackgroundColor ?? this.knobBackgroundColor,
      knobBorderColor: knobBorderColor ?? this.knobBorderColor,
      knobForegroundColor: knobForegroundColor ?? this.knobForegroundColor,
      tapTargetPadding: tapTargetPadding ?? this.tapTargetPadding,
    );
  }

  SBBSwitchStyle merge(SBBSwitchStyle? other) {
    if (other == null) return this;

    return copyWith(
      trackColor: other.trackColor,
      knobBackgroundColor: other.knobBackgroundColor,
      knobBorderColor: other.knobBorderColor,
      knobForegroundColor: other.knobForegroundColor,
      tapTargetPadding: other.tapTargetPadding,
    );
  }

  static SBBSwitchStyle? lerp(SBBSwitchStyle? a, SBBSwitchStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBSwitchStyle(
      trackColor: WidgetStateProperty.lerp<Color?>(a?.trackColor, b?.trackColor, t, Color.lerp),
      knobBackgroundColor: WidgetStateProperty.lerp<Color?>(
        a?.knobBackgroundColor,
        b?.knobBackgroundColor,
        t,
        Color.lerp,
      ),
      knobBorderColor: WidgetStateProperty.lerp<Color?>(a?.knobBorderColor, b?.knobBorderColor, t, Color.lerp),
      knobForegroundColor: WidgetStateProperty.lerp<Color?>(
        a?.knobForegroundColor,
        b?.knobForegroundColor,
        t,
        Color.lerp,
      ),
      tapTargetPadding: EdgeInsetsGeometry.lerp(a?.tapTargetPadding, b?.tapTargetPadding, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBSwitchStyle &&
        other.trackColor == trackColor &&
        other.knobBackgroundColor == knobBackgroundColor &&
        other.knobBorderColor == knobBorderColor &&
        other.knobForegroundColor == knobForegroundColor &&
        other.tapTargetPadding == tapTargetPadding;
  }

  @override
  int get hashCode => Object.hash(
    trackColor,
    knobBackgroundColor,
    knobBorderColor,
    knobForegroundColor,
    tapTargetPadding,
  );
}
