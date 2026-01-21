import 'package:flutter/widgets.dart';

/// Defines the visual properties of an [SBBInputDecorator].
///
/// This is a simplified version of Material's [InputDecoration] that only
/// supports leading and input widgets, without borders, labels, or other
/// complex decorations.
@immutable
class SBBInputDecoration {
  const SBBInputDecoration({
    this.leading,
    this.trailing,
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

  /// Creates a copy of this decoration with the given fields replaced
  /// by the new values.
  SBBInputDecoration copyWith({
    Widget? leading,
    Widget? trailing,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return SBBInputDecoration(
      leading: leading ?? this.leading,
      trailing: trailing ?? this.trailing,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SBBInputDecoration && other.leading == leading && other.trailing == trailing;
  }

  @override
  int get hashCode => Object.hash(leading, trailing);
}
