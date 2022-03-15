import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// SBB Checkbox List Item. Use according to documentation.
///
/// See also:
///
/// * [SBBCheckbox], which is a part of this widget.
/// * [SBBSwitch], a widget with semantics similar to [SBBCheckbox].
/// * [SBBRadioButtonListItem] and [SBBRadioButton], for selecting among a set
/// of explicit values.
/// * [SBBSlider], for selecting a value in a range.
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/checkbox>
class SBBCheckboxListItem extends StatelessWidget {
  SBBCheckboxListItem({
    Key? key,
    required bool? value,
    required String label,
    bool allowMultilineLabel = false,
    String? secondaryLabel,
    bool tristate = false,
    required ValueChanged<bool?>? onChanged,
    bool isLastElement = false,
    IconData? leadingIcon,
    IconData? trailingIcon,
    VoidCallback? onCallToAction,
  }) : this.custom(
          key: key,
          value: value,
          label: label,
          allowMultilineLabel: allowMultilineLabel,
          secondaryLabel: secondaryLabel,
          tristate: tristate,
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

  const SBBCheckboxListItem.custom({
    Key? key,
    required this.value,
    required this.label,
    this.allowMultilineLabel = false,
    this.secondaryLabel,
    this.tristate = false,
    required this.onChanged,
    this.isLastElement = false,
    this.leadingIcon,
    this.trailingWidget,
  })  : assert(tristate || value != null),
        super(key: key);

  /// Whether this checkbox is checked.
  ///
  /// If [tristate] is false (the default), [value] must not be null.
  /// If [tristate] is true, SBBCheckbox displays a dash when [value] is null.
  final bool? value;

  /// Called when the value of the checkbox should change.
  ///
  /// The checkbox passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the checkbox with the new
  /// value.
  ///
  /// If this callback is null, the checkbox will be displayed as disabled
  /// and will not respond to input gestures.
  ///
  /// When the checkbox is tapped, if [tristate] is false (the default) then
  /// the [onChanged] callback will be applied to `!value`. If [tristate] is
  /// true this callback cycle from false to true to null.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// SBBCheckboxListItem(
  ///   value: _throwShotAway,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _throwShotAway = newValue;
  ///     });
  ///   },
  ///   label: 'Example',
  /// )
  /// ```
  final ValueChanged<bool?>? onChanged;

  /// If true the checkbox's [value] can be true, false, or null.
  ///
  /// SBBCheckbox displays a dash when its value is null.
  ///
  /// When a tri-state checkbox ([tristate] is true) is tapped, its [onChanged]
  /// callback will be applied to true if the current value is false, to null if
  /// value is true, and to false if value is null (i.e. it cycles through false
  /// => true => null => false when tapped).
  ///
  /// If tristate is false (the default), [value] must not be null.
  final bool tristate;

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
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Material(
          color: sbbTheme.checkboxListItemBackgroundColor,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48.0),
            child: InkWell(
              onTap: enabled
                  ? () {
                      switch (value) {
                        case false:
                          onChanged?.call(true);
                          break;
                        case true:
                          onChanged?.call(tristate ? null : false);
                          break;
                        default: // case null:
                          onChanged?.call(false);
                          break;
                      }
                    }
                  : null,
              splashColor: sbbTheme.checkboxListItemBackgroundColorHighlighted,
              focusColor: sbbTheme.checkboxListItemBackgroundColorHighlighted,
              highlightColor: SBBColors.transparent,
              hoverColor: SBBColors.transparent,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: sbbDefaultSpacing),
                      IgnorePointer(
                        child: FocusScope(
                          canRequestFocus: false,
                          skipTraversal: true,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                              top: sbbDefaultSpacing / 4 * 3,
                              end: sbbDefaultSpacing / 2,
                            ),
                            child: SBBCheckbox(
                              value: value,
                              tristate: tristate,
                              onChanged: onChanged,
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ),
                      if (leadingIcon != null)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: 10.0,
                            end: sbbDefaultSpacing / 2,
                          ),
                          child: Icon(
                            leadingIcon,
                            color: enabled
                                ? sbbTheme.checkboxListItemIconColor
                                : sbbTheme.checkboxListItemIconColorDisabled,
                          ),
                        ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: sbbDefaultSpacing / 4 * 3,
                            bottom: sbbDefaultSpacing / 4 * 3,
                            end: sbbDefaultSpacing,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                label,
                                style: enabled
                                    ? sbbTheme.checkboxListItemTextStyle
                                    : sbbTheme
                                        .checkboxListItemTextStyleDisabled,
                                maxLines: allowMultilineLabel ? null : 1,
                                overflow: allowMultilineLabel
                                    ? null
                                    : TextOverflow.ellipsis,
                              ),
                              if (secondaryLabel != null)
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    top: sbbDefaultSpacing / 4,
                                  ),
                                  child: Text(
                                    secondaryLabel!,
                                    style: enabled
                                        ? sbbTheme
                                            .checkboxListItemSecondaryTextStyle
                                        : sbbTheme
                                            .checkboxListItemSecondaryTextStyleDisabled,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      if (trailingWidget != null) trailingWidget!,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (!isLastElement) const Divider(indent: sbbDefaultSpacing),
      ],
    );
  }
}
