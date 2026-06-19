/// An item in a menu created by a [SBBDropdown] or [SBBMultiDropdown].
///
/// The type `T` is the type of the value the entry represents. All the entries
/// in a given menu must represent values with consistent types.
class SBBDropdownItem<T> {
  const SBBDropdownItem({required this.value, required this.label});

  final T value;
  final String label;

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
