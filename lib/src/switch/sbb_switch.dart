import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// The SBB Switch. Use according to documentation.
///
/// The Switch itself does not maintain any state. Instead, when the state of
/// the Switch changes, the widget calls the [onChanged] callback. Most
/// widgets that use a Switch will listen for the [onChanged] callback and
/// rebuild the Switch with a new [value] to update the visual appearance of
/// the Switch.
///
/// The Switch can optionally display two values - true or false
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// See also:
///
/// * [SBBSwitchListItem], which builds this Widget as a part of a List Item
/// so that you can give the Switch a label, a subtext, a leading icon and a link
/// Widget.
/// * [SBBCheckbox], a widget with semantics similar to [SBBSwitch].
/// * [SBBRadioButton], for selecting among a set of explicit values.
/// * [SBBSegmentedButton], for selecting among a set of explicit values.
/// * <https://digital.sbb.ch/de/design-system/mobile/components/switch>
///
class SBBSwitch extends StatefulWidget {
  /// The following arguments are required:
  ///
  /// * [value], which determines whether the Switch is activated.
  /// * [onChanged], which is called when the value of the Switch should
  ///   change. It can be set to null to disable the Switch.
  ///
  const SBBSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.padding,
  }) : super(key: key);

  final bool? value;

  /// Called when the value of the Switch should change.
  ///
  /// The Switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the Switch with the new
  /// value.
  ///
  /// If this callback is null, the Switch will be displayed as disabled
  /// and will not respond to input gestures.
  ///
  /// The callback provided to [onChanged] should update the state of the parent

  final ValueChanged<bool?>? onChanged;

  final EdgeInsetsGeometry? padding;

  @override
  _SBBSwitchState createState() => _SBBSwitchState();
}

class _SBBSwitchState extends State<SBBSwitch> {
  bool? oldValue;
  bool? currentValue;

  @override
  void initState() {
    oldValue = false;
    currentValue = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(SBBSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      setState(() {
        oldValue = oldWidget.value;
        currentValue = widget.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).switchToggle;
    final enabled = widget.onChanged != null;
    var _currentValue = widget.value ?? false;
    return CupertinoSwitch(
      value: _currentValue,
      onChanged: enabled
          ? (value) {
              widget.onChanged?.call(value);
            }
          : null,
      trackColor: enabled ? style?.trackColor : style?.trackColorDisabled,
      activeColor: enabled ? style?.activeColor : style?.activeColorDisabled,
    );
  }
}
