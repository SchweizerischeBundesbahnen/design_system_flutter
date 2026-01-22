import 'package:flutter/widgets.dart';

/// Defines the visual properties of an [_SBBDecorator].
///
/// Analog to [SBBInputDecoration] for the [_SBBDecorator].
@immutable
class SBBDecoration {
  const SBBDecoration({
    this.leading,
    this.trailing,
    this.placeholder,
    this.label,
    this.error,
    this.container,
  });

  /// An optional widget to display before the input field.
  ///
  /// The leading widget will be vertically centered on the first baseline
  /// of the input field.
  final Widget? leading;

  /// An optional widget to display after the input field.
  ///
  /// The trailing widget will be vertically aligned with the baseline
  /// of the input field.
  final Widget? trailing;

  /// An optional widget to display in place of the input when the field
  /// is focused and empty.
  ///
  /// The placeholder widget is baseline-aligned with where the input would be.
  final Widget? placeholder;

  /// An optional widget to display above the input field.
  ///
  /// The label widget is displayed at the top of the decorator box,
  /// with the same width constraints and x offset as the input field.
  final Widget? label;

  /// An optional error widget to display below the input field.
  ///
  /// The error widget is displayed at the left edge of the decorator box,
  /// below the main content (input, leading, trailing).
  final Widget? error;

  /// The container surrounding the decoration.
  final Widget? container;

  /// Creates a copy of this decoration with the given fields replaced
  /// by the new values.
  SBBDecoration copyWith({
    Widget? leading,
    Widget? trailing,
    Widget? placeholder,
    Widget? label,
    Widget? error,
    Widget? container,
  }) {
    return SBBDecoration(
      leading: leading ?? this.leading,
      trailing: trailing ?? this.trailing,
      placeholder: placeholder ?? this.placeholder,
      label: label ?? this.label,
      error: error ?? this.error,
      container: container ?? this.container,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBDecoration &&
        other.leading == leading &&
        other.trailing == trailing &&
        other.placeholder == placeholder &&
        other.label == label &&
        other.error == error &&
        other.container == container;
  }

  @override
  int get hashCode => Object.hash(leading, trailing, placeholder, label, error, container);
}
