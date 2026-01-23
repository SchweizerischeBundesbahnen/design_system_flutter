import 'package:flutter/widgets.dart';

/// Defines the visual properties of [SBBCheckbox].
///
/// Use this class in combination with [SBBCheckboxThemeData] to customize
/// the appearance of checkboxes throughout your app or for specific widget subtrees.
///
/// ## Sample code
///
/// ```dart
/// SBBCheckbox(
///   value: true,
///   onChanged: (value) {},
///   style: SBBCheckboxStyle(
///     fillColor: WidgetStateProperty.all(Colors.blue),
///     checkColor: WidgetStateProperty.all(Colors.white),
///   ),
/// )
/// ```
///
/// See also:
/// * [SBBCheckbox], the checkbox widget that uses this style.
/// * [SBBCheckboxThemeData], which applies this style theme-wide.
class SBBCheckboxStyle {
  const SBBCheckboxStyle({
    this.fillColor,
    this.checkColor,
    this.borderColor,
    this.tapTargetPadding,
  });

  /// The background color of the checkbox.
  ///
  /// This color fills the rounded square that contains the check mark.
  /// It does not affect the tap target area, which is controlled by [tapTargetPadding].
  ///
  /// The color can change based on the checkbox state (selected, disabled, etc.)
  /// by using [WidgetStateProperty].
  final WidgetStateProperty<Color?>? fillColor;

  /// The color of the check mark or dash icon.
  ///
  /// This color is used for:
  /// * The check mark when [SBBCheckbox.value] is `true`
  /// * The dash icon when [SBBCheckbox.value] is `null` (in tristate mode)
  ///
  /// The color can change based on the checkbox state by using [WidgetStateProperty].
  final WidgetStateProperty<Color?>? checkColor;

  /// The color of the checkbox border.
  ///
  /// This is the outline color of the rounded square surrounding the check mark.
  /// The border width is defined by [SBBCheckboxStyle.borderWidth].
  ///
  /// The color can change based on the checkbox state by using [WidgetStateProperty].
  final WidgetStateProperty<Color?>? borderColor;

  /// The space between the checkbox's tap target and its visual appearance.
  ///
  /// This padding increases the interactive area of the checkbox beyond the
  /// visible [SBBCheckboxStyle.width] × [SBBCheckboxStyle.width] square. A larger padding makes the checkbox
  /// easier to tap while keeping the visual size constant.
  ///
  /// Defaults to `EdgeInsets.all(8.0)`.
  final EdgeInsetsGeometry? tapTargetPadding;

  /// The thickness of the checkbox border.
  ///
  /// This value determines how wide the border line around the checkbox appears.
  static const double borderWidth = 1.0;

  /// The corner radius of the checkbox.
  ///
  /// This creates rounded corners for the checkbox square.
  static const Radius borderRadius = Radius.circular(6.0);

  /// The size of the checkbox's visible square.
  ///
  /// This is the width and height of the rounded square containing the check mark,
  /// not including the [tapTargetPadding]. The total interactive area is larger when margin
  /// is applied.
  static const double width = 20.0;

  SBBCheckboxStyle copyWith({
    WidgetStateProperty<Color?>? fillColor,
    WidgetStateProperty<Color?>? checkColor,
    WidgetStateProperty<Color?>? borderColor,
    EdgeInsetsGeometry? tapTargetPadding,
  }) {
    return SBBCheckboxStyle(
      fillColor: fillColor ?? this.fillColor,
      checkColor: checkColor ?? this.checkColor,
      borderColor: borderColor ?? this.borderColor,
      tapTargetPadding: tapTargetPadding ?? this.tapTargetPadding,
    );
  }

  SBBCheckboxStyle merge(SBBCheckboxStyle? other) {
    if (other == null) return this;

    return copyWith(
      fillColor: other.fillColor,
      checkColor: other.checkColor,
      borderColor: other.borderColor,
      tapTargetPadding: other.tapTargetPadding,
    );
  }

  static SBBCheckboxStyle? lerp(SBBCheckboxStyle? a, SBBCheckboxStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBCheckboxStyle(
      fillColor: WidgetStateProperty.lerp<Color?>(a?.fillColor, b?.fillColor, t, Color.lerp),
      checkColor: WidgetStateProperty.lerp<Color?>(a?.checkColor, b?.checkColor, t, Color.lerp),
      borderColor: WidgetStateProperty.lerp<Color?>(a?.borderColor, b?.borderColor, t, Color.lerp),
      tapTargetPadding: EdgeInsetsGeometry.lerp(a?.tapTargetPadding, b?.tapTargetPadding, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBCheckboxStyle &&
        other.fillColor == fillColor &&
        other.checkColor == checkColor &&
        other.borderColor == borderColor &&
        other.tapTargetPadding == tapTargetPadding;
  }

  @override
  int get hashCode => Object.hash(
    fillColor,
    checkColor,
    borderColor,
    tapTargetPadding,
  );
}
