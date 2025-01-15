import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

const double _iconTopPadding = 10.0;

/// SBB Radio Button List Item. Use according to documentation.
///
/// Use [SBBControlStyle].listItem to manipulate the style of this Widget.
///
/// See also:
///
/// * [SBBRadio], which is a part of this widget.
/// * [SBBSegmentedButton], a widget with semantics similar to [SBBRadio].
/// * [SBBSlider], for selecting a value in a range.
/// * [SBBCheckboxListItem], [SBBCheckbox] and [SBBSwitch], for toggling a
/// particular value on or off.
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/radiobutton>
@Deprecated('Use SBBRadioListItem instead')
class SBBRadioButtonListItem<T> extends StatelessWidget {
  /// Creates a combination of a tile and a [SBBRadio].
  ///
  /// The [SBBRadioButtonListItem] itself does not maintain any state. Instead, when the
  /// state of the checkbox changes, the widget calls the [onChanged] callback.
  /// Most widgets that use a checkbox will listen for the [onChanged] callback
  /// and rebuild the checkbox tile with a new [value] to update the visual
  /// appearance of the checkbox.
  ///
  /// The following arguments are required:
  ///
  /// * [value] and [groupValue] together determine whether the radio button is
  ///   selected.
  /// * [label], the primary text written on [SBBCheckboxListItem].
  /// * [onChanged] is called when the user selects this radio button.
  ///
  /// Set the [isLastElement] true for the last item in a list to not show any Divider.
  ///
  /// The trailing widget of this widget is determined in the following way:
  ///
  /// * if no [trailingIcon] is given, no trailing Widget will be shown.
  /// * if [onCallToAction] is not given, the trailingIcon will be shown as 24px sized [Icon].
  /// * if [onCallToAction] is given, the trailingIcon will be wrapped in a [SBBIconButtonSmall].
  ///
  /// If [isLoading] is true, a bottom loading indicator will be displayed.
  ///
  /// Check the [SBBRadioButtonListItem.custom] constructor for a complete customization.
  @Deprecated('Use SBBRadioListItem instead.')
  SBBRadioButtonListItem({
    Key? key,
    required T value,
    required T? groupValue,
    required String label,
    required ValueChanged<T?>? onChanged,
    bool allowMultilineLabel = false,
    String? secondaryLabel,
    bool isLastElement = false,
    IconData? leadingIcon,
    IconData? trailingIcon,
    VoidCallback? onCallToAction,
    bool isLoading = false,
    String? radioSemanticLabel,
  }) : this.custom(
          key: key,
          value: value,
          groupValue: groupValue,
          label: label,
          allowMultilineLabel: allowMultilineLabel,
          secondaryLabel: secondaryLabel,
          onChanged: onChanged,
          isLastElement: isLastElement,
          leadingIcon: leadingIcon,
          trailingWidget: _optionallyButtonedTrailingIcon(trailingIcon, onCallToAction, onChanged),
          isLoading: isLoading,
          radioSemanticLabel: radioSemanticLabel,
        );

  /// Use this in combination with a [SBBGroup] to create a boxed variant of the [SBBRadioButtonListItem].
  ///
  /// ```dart
  /// SBBGroup(
  ///   child: SBBRadioButtonListItem<SingingCharacter>(
  ///   value: SingingCharacter.lafayette,
  ///   groupValue: _character,
  ///   onChanged: (SingingCharacter newValue) {
  ///     setState(() {
  ///       _character = newValue;
  ///     });
  ///   },
  ///   )
  /// )
  ///
  /// ```
  @Deprecated('Use SBBRadioListItem instead.')
  SBBRadioButtonListItem.boxed({
    Key? key,
    required T value,
    required T? groupValue,
    required String label,
    required ValueChanged<T?>? onChanged,
    bool allowMultilineLabel = false,
    String? secondaryLabel,
    IconData? leadingIcon,
    IconData? trailingIcon,
    VoidCallback? onCallToAction,
    bool isLoading = false,
    String? radioSemanticLabel,
  }) : this.custom(
          key: key,
          value: value,
          groupValue: groupValue,
          label: label,
          allowMultilineLabel: allowMultilineLabel,
          secondaryLabel: secondaryLabel,
          onChanged: onChanged,
          isLastElement: true,
          leadingIcon: leadingIcon,
          trailingWidget: _optionallyButtonedTrailingIcon(trailingIcon, onCallToAction, onChanged),
          isLoading: isLoading,
          radioSemanticLabel: radioSemanticLabel,
        );

  @Deprecated('Use SBBRadioListItem instead.')
  const SBBRadioButtonListItem.custom({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
    this.allowMultilineLabel = false,
    this.secondaryLabel,
    this.isLastElement = false,
    this.leadingIcon,
    this.trailingWidget,
    this.isLoading = false,
    this.radioSemanticLabel,
  });

  /// The value represented by this radio button.
  final T value;

  /// The currently selected value for a group of radio buttons.
  ///
  /// This radio button is considered selected if its [value] matches the
  /// [groupValue].
  final T? groupValue;

  /// Called when the user selects this [SBBRadioButtonListItem].
  ///
  /// The [SBBRadioButtonListItem] passes [value] as a parameter to this callback. The list item
  /// does not actually change state until the parent widget rebuilds the
  /// list item with the new [groupValue].
  ///
  /// If null, the list item will be displayed as disabled.
  ///
  /// The provided callback will not be invoked if this list item is already
  /// selected.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// SBBRadioButtonListItem<SingingCharacter>(
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

  /// The primary label on the tile.
  final String label;

  /// Whether the [label] can wrap to a second line.
  final bool allowMultilineLabel;

  /// The subtext displayed below the [label] over multiple lines.
  final String? secondaryLabel;

  /// Whether to draw a [Divider] below the [SBBCheckboxListItem].
  final bool isLastElement;

  /// The icon displayed in between the [SBBCheckbox] and the [label].
  final IconData? leadingIcon;

  /// The widget displayed at the end of the tile.
  final Widget? trailingWidget;

  /// Whether to display a BottomLoadingIndicator on the [SBBCheckboxListItem].
  final bool isLoading;

  /// The semantic label for the RadioButton that will be announced by screen readers.
  ///
  /// This is announced by assistive technologies (e.g TalkBack/VoiceOver).
  ///
  /// This label does not show in the UI.
  final String? radioSemanticLabel;

  @override
  Widget build(BuildContext context) {
    return SBBRadioListItem.custom(
      key: key,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      label: label,
      allowMultilineLabel: allowMultilineLabel,
      secondaryLabel: secondaryLabel,
      isLastElement: isLastElement,
      leadingIcon: leadingIcon,
      trailingWidget: trailingWidget,
      isLoading: isLoading,
      radioSemanticLabel: radioSemanticLabel,
    );
  }

  static Widget? _optionallyButtonedTrailingIcon<T>(
    IconData? trailingIcon,
    VoidCallback? onCallToAction,
    ValueChanged<T?>? onChanged,
  ) {
    if (trailingIcon == null) return null;

    if (onCallToAction == null) {
      return Padding(
        padding: const EdgeInsets.only(top: _iconTopPadding, right: sbbDefaultSpacing),
        child: Icon(trailingIcon, size: 24.0),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(right: sbbDefaultSpacing * .5),
        child: SBBIconButtonSmall(
          icon: trailingIcon,
          onPressed: onChanged != null ? onCallToAction : null,
        ),
      );
    }
  }
}
