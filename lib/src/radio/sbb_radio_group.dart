import 'package:flutter/material.dart';

/// The SBB Radio Group.
///
/// A wrapper around Flutter's [RadioGroup] widget that manages the state for a
/// group of [SBBRadio] buttons.
///
/// This widget treats all [SBBRadio] buttons in the subtree with the same type
/// `T` as a group. When one radio button in a group is selected, the other
/// radio buttons in the group cease to be selected.
///
/// See also:
///
/// * [SBBRadio], a radio button widget for use within this group.
/// * [SBBRadioListItem], which builds [SBBRadio] as part of a List Item.
class SBBRadioGroup<T> extends StatelessWidget {
  /// Creates an SBB Radio Group.
  ///
  /// The [groupValue] sets the selection on a subtree radio with the same
  /// [SBBRadio.value].
  ///
  /// The [onChanged] is called when the selection has changed in the subtree
  /// radios.
  ///
  /// The [child] typically contains one or more [SBBRadio] buttons.
  const SBBRadioGroup({
    super.key,
    this.groupValue,
    required this.onChanged,
    required this.child,
  });

  /// The selected value under this radio group.
  ///
  /// [SBBRadio] buttons under this radio group where their [SBBRadio.value]
  /// equals to this value will be selected.
  final T? groupValue;

  /// Called when selection has changed.
  ///
  /// The value can be null when unselecting the [SBBRadio] with
  /// [SBBRadio.toggleable] set to true.
  final ValueChanged<T?> onChanged;

  /// The widget below this widget in the tree.
  ///
  /// Typically contains one or more [SBBRadio] buttons.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<T>(
      groupValue: groupValue,
      onChanged: onChanged,
      child: child,
    );
  }
}
