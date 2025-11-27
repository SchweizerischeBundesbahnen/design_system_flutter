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
  });

  /// The checkbox background fill color.
  final WidgetStateProperty<Color?>? fillColor;

  /// The color for the check icon or dash when this checkbox is checked.
  final WidgetStateProperty<Color?>? checkColor;

  /// The color for the checkbox's material.
  final WidgetStateProperty<Color?>? overlayColor;

  /// The color for the border of the checkbox.
  final WidgetStateProperty<Color?>? borderColor;

  SBBCheckboxStyle copyWith({
    WidgetStateProperty<Color?>? fillColor,
    WidgetStateProperty<Color?>? checkColor,
    WidgetStateProperty<Color?>? overlayColor,
    WidgetStateProperty<Color?>? borderColor,
  }) {
    return SBBCheckboxStyle(
      fillColor: fillColor ?? this.fillColor,
      checkColor: checkColor ?? this.checkColor,
      overlayColor: overlayColor ?? this.overlayColor,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  SBBCheckboxStyle merge(SBBCheckboxStyle? other) {
    if (other == null) return this;

    return copyWith(
      fillColor: other.fillColor,
      checkColor: other.checkColor,
      overlayColor: other.overlayColor,
      borderColor: other.borderColor,
    );
  }

  static SBBCheckboxStyle? lerp(SBBCheckboxStyle? a, SBBCheckboxStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBCheckboxStyle(
      fillColor: WidgetStateProperty.lerp<Color?>(a?.fillColor, b?.fillColor, t, Color.lerp),
      checkColor: WidgetStateProperty.lerp<Color?>(a?.checkColor, b?.checkColor, t, Color.lerp),
      overlayColor: WidgetStateProperty.lerp<Color?>(a?.overlayColor, b?.overlayColor, t, Color.lerp),
      borderColor: WidgetStateProperty.lerp<Color?>(a?.borderColor, b?.borderColor, t, Color.lerp),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBCheckboxStyle &&
        other.fillColor == fillColor &&
        other.checkColor == checkColor &&
        other.overlayColor == overlayColor &&
        other.borderColor == borderColor;
  }

  @override
  int get hashCode => Object.hash(
    fillColor,
    checkColor,
    overlayColor,
    borderColor,
  );
}
