import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Defines the visual properties of [SBBTextInput].
///
/// Use this class to customize the text entered by the user and the clear button.
/// The label, placeholder, error, affixes and border are customized with
/// [SBBDecorationStyle] instead.
///
/// Typically applied theme-wide via [SBBTextInputThemeData], but can be overridden
/// per-widget using [SBBTextInput.style].
///
/// See also:
/// * [SBBTextInput], the widget that uses this style
/// * [SBBTextInputThemeData], for applying styles theme-wide
@immutable
class SBBTextInputStyle {
  const SBBTextInputStyle({
    this.inputTextStyle,
    this.inputForegroundColor,
    this.enableClearButton,
  });

  /// The text style for the input text.
  ///
  /// This applies to the text entered by the user in the text field.
  /// The text color is overridden by [inputForegroundColor].
  final TextStyle? inputTextStyle;

  /// The color of the input text, resolved based on widget state.
  final WidgetStateProperty<Color?>? inputForegroundColor;

  /// Whether to replace the trailingIconData with a clear button when the input is focused and has content.
  ///
  /// Defaults to `true`.
  final bool? enableClearButton;

  SBBTextInputStyle copyWith({
    TextStyle? inputTextStyle,
    WidgetStateProperty<Color?>? inputForegroundColor,
    bool? enableClearButton,
  }) {
    return SBBTextInputStyle(
      inputTextStyle: inputTextStyle ?? this.inputTextStyle,
      inputForegroundColor: inputForegroundColor ?? this.inputForegroundColor,
      enableClearButton: enableClearButton ?? this.enableClearButton,
    );
  }

  SBBTextInputStyle merge(SBBTextInputStyle? other) {
    if (other == null) return this;

    return copyWith(
      inputTextStyle: other.inputTextStyle,
      inputForegroundColor: other.inputForegroundColor,
      enableClearButton: other.enableClearButton,
    );
  }

  static SBBTextInputStyle? lerp(SBBTextInputStyle? a, SBBTextInputStyle? b, double t) {
    if (identical(a, b)) return a;

    return SBBTextInputStyle(
      inputTextStyle: TextStyle.lerp(a?.inputTextStyle, b?.inputTextStyle, t),
      inputForegroundColor: WidgetStateProperty.lerp<Color?>(
        a?.inputForegroundColor,
        b?.inputForegroundColor,
        t,
        Color.lerp,
      ),
      enableClearButton: t < 0.5 ? a?.enableClearButton : b?.enableClearButton,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBTextInputStyle &&
        other.inputTextStyle == inputTextStyle &&
        other.inputForegroundColor == inputForegroundColor &&
        other.enableClearButton == enableClearButton;
  }

  @override
  int get hashCode => Object.hash(inputTextStyle, inputForegroundColor, enableClearButton);
}
