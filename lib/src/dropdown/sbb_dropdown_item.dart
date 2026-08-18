import 'package:flutter/foundation.dart';

/// An item in a menu created by a [SBBDropdown] or [SBBMultiDropdown].
///
/// The type `T` is the type of the value the entry represents. All the entries
/// in a given menu must represent values with consistent types.
class SBBDropdownItem<T> {
  const SBBDropdownItem({required this.value, required this.label, this.key});

  /// The value represented by this item.
  final T value;
  final String label;

  /// Optional key applied to the item's row in the selection sheet (the
  /// underlying `SBBRadioListItem`/`SBBCheckboxListItem`).
  ///
  /// Useful in tests to find and tap a specific item via `find.byKey(key)`.
  final Key? key;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SBBDropdownItem && runtimeType == other.runtimeType && value == other.value && label == other.label;

  @override
  int get hashCode => Object.hash(value, label);

  @override
  String toString() {
    return 'SBBDropdownItem{value: $value, label: $label}';
  }
}
