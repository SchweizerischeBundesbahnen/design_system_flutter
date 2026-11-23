import 'package:material_ui/material_ui.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Defines the content and the visual properties of the decoration around a decorated component.
///
/// The decoration consists of a label, a leading and a trailing widget, a placeholder,
/// an error and a border. It is drawn by the following components:
///
/// * [SBBTextInput] and its variants, to enter text
/// * [SBBDecoratedText], to display a read-only text value
/// * [SBBDecorated], to decorate an arbitrary widget
/// * [SBBDropdown] and [SBBMultiDropdown], whose trigger is an [SBBDecoratedText]
/// * [SBBDateInput], [SBBTimeInput] and [SBBDateTimeInput], whose trigger is an [SBBDecoratedText]
///
/// The content is set on this class. The look is set with [style], see
/// [SBBDecorationStyle] for the order in which widget, component theme and
/// [SBBDecorationThemeData] values are applied.
@immutable
class SBBDecoration {
  const SBBDecoration({
    this.leading,
    this.leadingIconData,
    this.label,
    this.labelText,
    this.trailing,
    this.trailingIconData,
    this.placeholder,
    this.placeholderText,
    this.error,
    this.errorText,
    this.style,
  }) : assert(
         leading == null || leadingIconData == null,
         'leading and leadingIconData are mutually exclusive. Provide only one.',
       ),
       assert(
         label == null || labelText == null,
         'label and labelText are mutually exclusive. Provide only one.',
       ),
       assert(
         placeholder == null || placeholderText == null,
         'placeholder and placeholderText are mutually exclusive. Provide only one.',
       ),
       assert(
         error == null || errorText == null,
         'error and errorText are mutually exclusive. Provide only one.',
       );

  /// An optional widget to display before the input field.
  ///
  /// Mutually exclusive with [leadingIconData]. Only one of the two can be provided.
  final Widget? leading;

  /// An optional icon to display before the input field.
  ///
  /// Mutually exclusive with [leading]. Only one of the two can be provided.
  final IconData? leadingIconData;

  /// An optional widget to display as the label above the input field.
  ///
  /// Mutually exclusive with [labelText]. Only one of the two can be provided.
  final Widget? label;

  /// Text to display as the label above the input field.
  ///
  /// Mutually exclusive with [label]. Only one of the two can be provided.
  final String? labelText;

  /// An optional widget to display after the input field.
  ///
  /// Mutually exclusive with [trailingIconData]. If both are provided, trailing takes precedence.
  final Widget? trailing;

  /// An optional icon to display after the input field.
  ///
  /// Mutually exclusive with [trailing]. If both are provided, trailing takes precedence.
  final IconData? trailingIconData;

  /// An optional widget to display as a hint/placeholder in the input field.
  ///
  /// Mutually exclusive with [placeholderText]. Only one of the two can be provided.
  final Widget? placeholder;

  /// Text to display as a hint/placeholder in the input field.
  ///
  /// Mutually exclusive with [placeholder]. Only one of the two can be provided.
  final String? placeholderText;

  /// An optional widget to display as an error message below the input field.
  ///
  /// Mutually exclusive with [errorText]. Only one of the two can be provided.
  final Widget? error;

  /// Text to display as an error message below the input field.
  ///
  /// Mutually exclusive with [error]. Only one of the two can be provided.
  final String? errorText;

  /// Customizes the visual appearance of this decoration.
  ///
  /// Non-null properties override the corresponding properties of the
  /// component theme and of [SBBDecorationThemeData.style].
  final SBBDecorationStyle? style;

  /// The minimum height for input fields.
  ///
  /// This value will scale when text scaling is applied.
  static const double minInputFieldHeight = 48.0;

  SBBDecoration copyWith({
    Widget? leading,
    IconData? leadingIconData,
    Widget? label,
    String? labelText,
    Widget? trailing,
    IconData? trailingIconData,
    Widget? placeholder,
    String? placeholderText,
    Widget? error,
    String? errorText,
    SBBDecorationStyle? style,
  }) {
    return SBBDecoration(
      leading: leading ?? this.leading,
      leadingIconData: leadingIconData ?? this.leadingIconData,
      label: label ?? this.label,
      labelText: labelText ?? this.labelText,
      trailing: trailing ?? this.trailing,
      trailingIconData: trailingIconData ?? this.trailingIconData,
      placeholder: placeholder ?? this.placeholder,
      placeholderText: placeholderText ?? this.placeholderText,
      error: error ?? this.error,
      errorText: errorText ?? this.errorText,
      style: style ?? this.style,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBDecoration &&
        other.leading == leading &&
        other.leadingIconData == leadingIconData &&
        other.label == label &&
        other.labelText == labelText &&
        other.trailing == trailing &&
        other.trailingIconData == trailingIconData &&
        other.placeholder == placeholder &&
        other.placeholderText == placeholderText &&
        other.error == error &&
        other.errorText == errorText &&
        other.style == style;
  }

  @override
  int get hashCode => Object.hash(
    leading,
    leadingIconData,
    label,
    labelText,
    trailing,
    trailingIconData,
    placeholder,
    placeholderText,
    error,
    errorText,
    style,
  );
}
