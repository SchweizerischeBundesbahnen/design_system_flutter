import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../design_system_flutter.dart';

/// SBB Radio Button List Item. Use according to documentation.
///
/// See also:
///
/// * [SBBRadioButton], which is a part of this widget.
/// * [SBBSegmentedButton], a widget with semantics similar to [SBBRadioButton].
/// * [SBBSlider], for selecting a value in a range.
/// * [SBBCheckboxListItem], [SBBCheckbox] and [SBBSwitch], for toggling a
/// particular value on or off.
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/radiobutton>
class SBBRadioButtonListItem<T> extends StatelessWidget {
  SBBRadioButtonListItem({
    Key? key,
    required T value,
    required T? groupValue,
    required String label,
    bool allowMultilineLabel = false,
    String? secondaryLabel,
    required ValueChanged<T?>? onChanged,
    bool isLastElement = false,
    IconData? leadingIcon,
    IconData? trailingIcon,
    VoidCallback? onCallToAction,
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
          trailingWidget: trailingIcon != null && onChanged != null
              ? SBBIconButtonSmall(
                  icon: trailingIcon,
                  onPressed: onCallToAction ?? () => onChanged(value),
                )
              : null,
        );

  const SBBRadioButtonListItem.custom({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.label,
    this.allowMultilineLabel = false,
    this.secondaryLabel,
    required this.onChanged,
    this.isLastElement = false,
    this.leadingIcon,
    this.trailingWidget,
  }) : super(key: key);

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

  final String label;
  final bool allowMultilineLabel;
  final String? secondaryLabel;
  final bool isLastElement;
  final IconData? leadingIcon;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    final sbbTheme = SBBTheme.of(context);
    final enabled = onChanged != null;
    final paddingTop = secondaryLabel != null && trailingWidget == null ? sbbDefaultSpacing * (3 / 4) : 0.0;
    final spacingBetweenLabels = secondaryLabel != null && trailingWidget == null ? sbbDefaultSpacing / 4 : 0.0;
    final paddingBottom = secondaryLabel != null ? sbbDefaultSpacing * (3 / 4) : 0.0;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Material(
          color: sbbTheme.radioButtonListItemBackgroundColor,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48.0),
            child: InkWell(
              onTap: enabled ? () => onChanged!(value) : null,
              splashColor: sbbTheme.radioButtonListItemBackgroundColorHighlighted,
              focusColor: sbbTheme.radioButtonListItemBackgroundColorHighlighted,
              highlightColor: SBBColors.transparent,
              hoverColor: SBBColors.transparent,
              child: Padding(
                padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: sbbDefaultSpacing),
                        IgnorePointer(
                          child: FocusScope(
                            canRequestFocus: false,
                            skipTraversal: true,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                end: sbbDefaultSpacing / 2,
                              ),
                              child: SBBRadioButton(
                                value: value,
                                groupValue: groupValue,
                                onChanged: onChanged,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                        if (leadingIcon != null)
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              end: sbbDefaultSpacing / 2,
                            ),
                            child: Icon(
                              leadingIcon,
                              color: enabled ? sbbTheme.radioButtonListItemIconColor : sbbTheme.radioButtonListItemIconColorDisabled,
                            ),
                          ),
                        Expanded(
                          child: Text(
                            label,
                            style: enabled ? sbbTheme.checkboxListItemTextStyle : sbbTheme.checkboxListItemTextStyleDisabled,
                            maxLines: allowMultilineLabel ? null : 1,
                            overflow: allowMultilineLabel ? null : TextOverflow.ellipsis,
                          ),
                        ),
                        if (trailingWidget != null) trailingWidget!,
                      ],
                    ),
                    if (secondaryLabel != null) ...[
                      SizedBox(height: spacingBetweenLabels),
                      Padding(
                        padding: const EdgeInsets.only(right: sbbDefaultSpacing / 2),
                        child: Row(
                          children: [
                            const SizedBox(width: sbbDefaultSpacing + (Checkbox.width + sbbDefaultSpacing / 4) + sbbDefaultSpacing / 2),
                            Expanded(
                              child: Text(
                                secondaryLabel!,
                                style: enabled ? sbbTheme.radioButtonListItemSecondaryTextStyle : sbbTheme.radioButtonListItemSecondaryTextStyleDisabled,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        if (!isLastElement) const Divider(indent: sbbDefaultSpacing),
      ],
    );
  }
}
