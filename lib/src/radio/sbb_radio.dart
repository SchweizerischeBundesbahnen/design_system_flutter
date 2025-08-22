import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// The SBB Radio Button.
/// Use according to [documentation](https://digital.sbb.ch/de/design-system/mobile/components/radiobutton/).
///
/// Consider using [SBBRadioListItem] instead of this Widget.
///
/// Used to select between a number of mutually exclusive values. When one radio
/// button in a group is selected, the other radio buttons in the group cease to
/// be selected. The values are of type `T`, the type parameter of the
/// [SBBRadio] class. Enums are commonly used for this purpose.
///
/// The radio button itself does not maintain any state. Instead, selecting the
/// radio invokes the [onChanged] callback, passing [value] as a parameter. If
/// [groupValue] and [value] match, this radio will be selected. Most widgets
/// will respond to [onChanged] by calling [State.setState] to update the
/// radio button's [groupValue].
///
/// See also:
///
/// * [SBBRadioListItem], which builds this widget as a part of a List
/// Item so that you can give the checkbox a label, a leading icon and a
/// trailing Widget.
/// * [SBBSegmentedButton], a widget with semantics similar to [SBBRadio].
/// * [SBBSlider], for selecting a value in a range.
/// * [SBBCheckbox] and [SBBSwitch], for toggling a particular value on or off.
class SBBRadio<T> extends StatelessWidget {
  /// Creates a SBB Radio Button.
  ///
  /// The radio button itself does not maintain any state. Instead, when the
  /// radio button is selected, the widget calls the [onChanged] callback. Most
  /// widgets that use a radio button will listen for the [onChanged] callback
  /// and rebuild the radio button with a new [groupValue] to update the visual
  /// appearance of the radio button.
  ///
  /// The following arguments are required:
  ///
  /// * [value] and [groupValue] together determine whether the radio button is
  ///   selected.
  /// * [onChanged] is called when the user selects this radio button.
  ///
  ///
  /// The [padding] enlarges the hittable area for the radio button.
  const SBBRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.padding,
    this.semanticLabel,
  });

  /// The value represented by this radio button.
  final T value;

  /// The currently selected value for a group of radio buttons.
  ///
  /// This radio button is considered selected if its [value] matches the
  /// [groupValue].
  final T? groupValue;

  /// Called when the user selects this radio button.
  ///
  /// The radio button passes [value] as a parameter to this callback. The radio
  /// button does not actually change state until the parent widget rebuilds the
  /// radio button with the new [groupValue].
  ///
  /// If null, the radio button will be displayed as disabled.
  ///
  /// The provided callback will not be invoked if this radio button is already
  /// selected.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// SBBRadioButton<SingingCharacter>(
  ///   value: SingingCharacter.lafayette,
  ///   groupValue: _character,
  ///   onChanged: (SingingCharacter newValue) {
  ///     setState(() {
  ///       _character = newValue;
  ///     });
  ///   },
  /// )
  /// ```
  final ValueChanged<T?>? onChanged;

  /// Enlarges the hittable area around the [SBBRadio].
  final EdgeInsetsGeometry? padding;

  /// The semantic label for the [SBBRadio] that will be announced by screen readers.
  ///
  /// This is announced by assistive technologies (e.g TalkBack/VoiceOver).
  ///
  /// This label does not show in the UI.
  final String? semanticLabel;

  bool get _selected => value == groupValue;

  static const _outerCircleSize = 20.0;
  static const _innerCircleSize = 8.0;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).radioButton;
    final enabled = onChanged != null;
    return Material(
      color: SBBColors.transparent,
      child: Semantics(
        label: semanticLabel,
        selected: _selected,
        child: InkWell(
          splashFactory: InkRipple.splashFactory,
          customBorder: const CircleBorder(),
          splashColor: style?.basic?.backgroundColorHighlighted,
          focusColor: style?.basic?.backgroundColorHighlighted,
          highlightColor: SBBColors.transparent,
          hoverColor: SBBColors.transparent,
          onTap: enabled ? () => onChanged?.call(value) : null,
          child: Center(
            child: Container(
              height: _outerCircleSize,
              width: _outerCircleSize,
              margin: padding ?? const EdgeInsets.all(sbbDefaultSpacing / 2),
              decoration: BoxDecoration(
                color:
                    enabled ? style?.basic?.backgroundColor : style?.basic?.backgroundColorDisabled,
                shape: BoxShape.circle,
                border: Border.fromBorderSide(
                  BorderSide(
                    color:
                        (enabled ? style?.basic?.borderColor : style?.basic?.borderColorDisabled)!,
                  ),
                ),
              ),
              child: Center(
                child: AnimatedContainer(
                  duration: kThemeAnimationDuration,
                  curve: Curves.easeInOut,
                  height: _selected ? _innerCircleSize : 0,
                  width: _selected ? _innerCircleSize : 0,
                  decoration: BoxDecoration(
                    color: enabled ? style?.color : style?.colorDisabled,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
