import 'package:flutter/widgets.dart';

/// Style for SBB Checkboxes. Use this in combination with [SBBCheckboxThemeData]
/// to override checkboxes within the current [SBBTheme].
///
/// See also:
/// * [SBBCheckboxThemeData], the ThemeData given to SBBTheme to override the [SBBCheckbox]
class SBBCheckboxStyle {
  const SBBCheckboxStyle({
    this.fillColor,
    this.checkColor,
    this.overlayColor,
    this.borderColor,
    this.margin,
  });

  /// The checkbox background fill color.
  final WidgetStateProperty<Color?>? fillColor;

  /// The color for the check icon or dash when this checkbox is checked.
  final WidgetStateProperty<Color?>? checkColor;

  /// The color for the checkbox's material.
  final WidgetStateProperty<Color?>? overlayColor;

  /// The color for the border of the checkbox.
  final WidgetStateProperty<Color?>? borderColor;

  /// The margin between the hit test area of the [SBBCheckbox] and the
  /// rounded shape with the visual check mark.
  ///
  /// By increasing this, the area receiving tap events for the
  /// [SBBCheckbox] increases.
  ///
  /// Defaults to [EdgeInsets.all(8.0)].
  final EdgeInsetsGeometry? margin;

  /// The width of the box surrounding the checkbox.
  static const double borderWidth = 1.0;

  /// The border radius of the box surrounding the checkbox.
  static const Radius borderRadius = Radius.circular(6.0);

  /// The width of the square surrounding the checkbox.
  ///
  /// If padding is set to [EdgeInsets.zero], this will be the total size of the checkbox.
  static const double width = 20.0;

  SBBCheckboxStyle copyWith({
    WidgetStateProperty<Color?>? fillColor,
    WidgetStateProperty<Color?>? checkColor,
    WidgetStateProperty<Color?>? overlayColor,
    WidgetStateProperty<Color?>? borderColor,
    EdgeInsetsGeometry? margin,
  }) {
    return SBBCheckboxStyle(
      fillColor: fillColor ?? this.fillColor,
      checkColor: checkColor ?? this.checkColor,
      overlayColor: overlayColor ?? this.overlayColor,
      borderColor: borderColor ?? this.borderColor,
      margin: margin ?? this.margin,
    );
  }

  SBBCheckboxStyle merge(SBBCheckboxStyle? other) {
    if (other == null) return this;

    return copyWith(
      fillColor: other.fillColor,
      checkColor: other.checkColor,
      overlayColor: other.overlayColor,
      borderColor: other.borderColor,
      margin: other.margin,
    );
  }

  static SBBCheckboxStyle? lerp(SBBCheckboxStyle? a, SBBCheckboxStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBCheckboxStyle(
      fillColor: WidgetStateProperty.lerp<Color?>(a?.fillColor, b?.fillColor, t, Color.lerp),
      checkColor: WidgetStateProperty.lerp<Color?>(a?.checkColor, b?.checkColor, t, Color.lerp),
      overlayColor: WidgetStateProperty.lerp<Color?>(a?.overlayColor, b?.overlayColor, t, Color.lerp),
      borderColor: WidgetStateProperty.lerp<Color?>(a?.borderColor, b?.borderColor, t, Color.lerp),
      margin: EdgeInsetsGeometry.lerp(a?.margin, b?.margin, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBCheckboxStyle &&
        other.fillColor == fillColor &&
        other.checkColor == checkColor &&
        other.overlayColor == overlayColor &&
        other.borderColor == borderColor &&
        other.margin == margin;
  }

  @override
  int get hashCode => Object.hash(
    fillColor,
    checkColor,
    overlayColor,
    borderColor,
    margin,
  );
}
