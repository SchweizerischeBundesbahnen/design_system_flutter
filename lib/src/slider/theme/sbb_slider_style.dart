import 'package:flutter/widgets.dart';

/// Defines the visual properties of [SBBSlider].
///
/// Use this class in combination with [SBBSliderThemeData] to customize
/// the appearance of sliders throughout your app or for specific widget subtrees.
///
/// See also:
/// * [SBBSlider], the widget that uses this style.
/// * [SBBSliderThemeData], which applies this style theme-wide.
class SBBSliderStyle {
  const SBBSliderStyle({
    this.trackColor,
    this.activeTrackColor,
    this.thumbBackgroundColor,
    this.thumbBorderColor,
    this.leadingForegroundColor,
    this.trailingForegroundColor,
    this.padding,
  });

  /// The color of the inactive track.
  ///
  /// This is the portion of the track that is not filled by the active track.
  final WidgetStateProperty<Color?>? trackColor;

  /// The color of the active track.
  ///
  /// This is the portion of the track from the minimum value to the current value.
  final WidgetStateProperty<Color?>? activeTrackColor;

  /// The background color of the thumb.
  final WidgetStateProperty<Color?>? thumbBackgroundColor;

  /// The border color of the thumb.
  final WidgetStateProperty<Color?>? thumbBorderColor;

  /// The color of the leading Widget.
  final WidgetStateProperty<Color?>? leadingForegroundColor;

  /// The color of the trailing Widget.
  final WidgetStateProperty<Color?>? trailingForegroundColor;

  /// The padding around the slider track.
  ///
  /// Defaults to [EdgeInsets.symmetric(horizontal: SBBSpacing.small)].
  final EdgeInsetsGeometry? padding;

  /// The height of the slider track in logical pixels.
  ///
  /// Default value is 4.0 logical pixels.
  static double get trackHeight => 4.0;

  /// The radius of the slider thumb in logical pixels.
  ///
  /// Default value is 11.0 logical pixels.
  static double get thumbRadius => 11.0;

  /// The width of the border around the slider thumb in logical pixels.
  ///
  /// Default value is 2.0 logical pixels.
  static double get thumbBorderWidth => 2.0;

  SBBSliderStyle copyWith({
    WidgetStateProperty<Color?>? trackColor,
    WidgetStateProperty<Color?>? activeTrackColor,
    WidgetStateProperty<Color?>? thumbBackgroundColor,
    WidgetStateProperty<Color?>? thumbBorderColor,
    WidgetStateProperty<Color?>? leadingForegroundColor,
    WidgetStateProperty<Color?>? trailingForegroundColor,
    EdgeInsetsGeometry? padding,
  }) {
    return SBBSliderStyle(
      trackColor: trackColor ?? this.trackColor,
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      thumbBackgroundColor: thumbBackgroundColor ?? this.thumbBackgroundColor,
      thumbBorderColor: thumbBorderColor ?? this.thumbBorderColor,
      leadingForegroundColor: leadingForegroundColor ?? this.leadingForegroundColor,
      trailingForegroundColor: trailingForegroundColor ?? this.trailingForegroundColor,
      padding: padding ?? this.padding,
    );
  }

  SBBSliderStyle merge(SBBSliderStyle? other) {
    if (other == null) return this;

    return copyWith(
      trackColor: other.trackColor,
      activeTrackColor: other.activeTrackColor,
      thumbBackgroundColor: other.thumbBackgroundColor,
      thumbBorderColor: other.thumbBorderColor,
      leadingForegroundColor: other.leadingForegroundColor,
      trailingForegroundColor: other.trailingForegroundColor,
      padding: other.padding,
    );
  }

  static SBBSliderStyle? lerp(SBBSliderStyle? a, SBBSliderStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBSliderStyle(
      trackColor: WidgetStateProperty.lerp<Color?>(a?.trackColor, b?.trackColor, t, Color.lerp),
      activeTrackColor: WidgetStateProperty.lerp<Color?>(a?.activeTrackColor, b?.activeTrackColor, t, Color.lerp),
      thumbBackgroundColor: WidgetStateProperty.lerp<Color?>(
        a?.thumbBackgroundColor,
        b?.thumbBackgroundColor,
        t,
        Color.lerp,
      ),
      thumbBorderColor: WidgetStateProperty.lerp<Color?>(a?.thumbBorderColor, b?.thumbBorderColor, t, Color.lerp),
      leadingForegroundColor: WidgetStateProperty.lerp<Color?>(
        a?.leadingForegroundColor,
        b?.leadingForegroundColor,
        t,
        Color.lerp,
      ),
      trailingForegroundColor: WidgetStateProperty.lerp<Color?>(
        a?.trailingForegroundColor,
        b?.trailingForegroundColor,
        t,
        Color.lerp,
      ),
      padding: EdgeInsetsGeometry.lerp(a?.padding, b?.padding, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBSliderStyle &&
        other.trackColor == trackColor &&
        other.activeTrackColor == activeTrackColor &&
        other.thumbBackgroundColor == thumbBackgroundColor &&
        other.thumbBorderColor == thumbBorderColor &&
        other.leadingForegroundColor == leadingForegroundColor &&
        other.trailingForegroundColor == trailingForegroundColor &&
        other.padding == padding;
  }

  @override
  int get hashCode => Object.hash(
    trackColor,
    activeTrackColor,
    thumbBackgroundColor,
    thumbBorderColor,
    leadingForegroundColor,
    trailingForegroundColor,
    padding,
  );
}
