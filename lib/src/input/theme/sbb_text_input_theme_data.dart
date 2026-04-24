import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The ThemeData for the [SBBTextInput].
///
/// Use this to set the default text input properties for all [SBBTextInput] within the current [SBBTheme].
///
/// To access this in your application, use `Theme.of(context).sbbTextInputTheme`.
@immutable
class SBBTextInputThemeData extends ThemeExtension<SBBTextInputThemeData> with Diagnosticable {
  /// Creates an [SBBTextInputThemeData].
  const SBBTextInputThemeData({
    this.inputTextStyle,
    this.inputForegroundColor,
    this.enableClearButton,
  });

  /// The text style for the input text.
  ///
  /// This applies to the text entered by the user in the text field.
  final TextStyle? inputTextStyle;

  /// The color of the input text.
  ///
  /// This affects the color of the text entered by the user.
  final WidgetStateProperty<Color?>? inputForegroundColor;

  /// Whether to replace the trailingIconData with a clear button when the input is focused and has content.
  ///
  /// Defaults to `true`.
  final bool? enableClearButton;

  @override
  SBBTextInputThemeData copyWith({
    TextStyle? inputTextStyle,
    WidgetStateProperty<Color?>? inputForegroundColor,
    bool? enableClearButton,
  }) {
    return SBBTextInputThemeData(
      inputTextStyle: inputTextStyle ?? this.inputTextStyle,
      inputForegroundColor: inputForegroundColor ?? this.inputForegroundColor,
      enableClearButton: enableClearButton ?? this.enableClearButton,
    );
  }

  @override
  SBBTextInputThemeData lerp(SBBTextInputThemeData? other, double t) {
    if (other == null) return this;
    return SBBTextInputThemeData(
      inputTextStyle: TextStyle.lerp(
        inputTextStyle,
        other.inputTextStyle,
        t,
      ),
      inputForegroundColor: WidgetStateProperty.lerp<Color?>(
        inputForegroundColor,
        other.inputForegroundColor,
        t,
        Color.lerp,
      ),
      enableClearButton: t < 0.5 ? enableClearButton : other.enableClearButton,
    );
  }

  @override
  int get hashCode => Object.hash(inputTextStyle, inputForegroundColor, enableClearButton);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBTextInputThemeData &&
        other.inputTextStyle == inputTextStyle &&
        other.inputForegroundColor == inputForegroundColor &&
        other.enableClearButton == enableClearButton;
  }
}

extension SBBTextInputThemeDataX on SBBTextInputThemeData {
  SBBTextInputThemeData merge(SBBTextInputThemeData? other) {
    if (other == null) return this;
    return copyWith(
      inputTextStyle: other.inputTextStyle,
      inputForegroundColor: other.inputForegroundColor,
      enableClearButton: other.enableClearButton,
    );
  }
}

extension SBBTextInputThemeDataThemeDataX on ThemeData {
  SBBTextInputThemeData? get sbbTextInputTheme {
    return extension<SBBTextInputThemeData>();
  }
}
