import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import '../shared/bottom_loading_indicator.dart';

/// The SBB Switch List Item.
/// Use according to [documentation](https://digital.sbb.ch/en/design-system/mobile/components/switch/)
///
/// See also:
///
/// * [SBBSwitch], which is a part of this widget.
/// * [SBBListItem], a widget with semantics similar to [SBBSwitchListItem].
/// * [SBBRadio], for selecting among a set of explicit values.
/// * [SBBSegmentedButton], for selecting among a set of explicit values.
/// * [SBBSlider], for selecting a value in a range.
///
/// Relates to a [SwitchListTile] in the Material specifications.
class SBBSwitchListItem extends StatelessWidget {
  /// Creates a combination of a [SBBListItem] and a [SBBSwitch].
  ///
  /// The [SBBSwitchListItem] itself does not maintain any state. Instead, when the
  /// state of the checkbox changes, the widget calls the [onChanged] callback.
  /// Most widgets that use a checkbox will listen for the [onChanged] callback
  /// and rebuild the checkbox tile with a new [value] to update the visual
  /// appearance of the checkbox.
  ///
  /// The following arguments are required:
  ///
  /// * [value], which determines whether the [SBBSwitch] is 'on'.
  /// * [title], the primary text written on [SBBSwitchListItem].
  /// * [onChanged], which is called when the value of the Switch should
  ///   change. It can be set to null to disable the [SBBSwitch].
  ///
  /// Set the [isLastElement] true for the last item in a list to not show any Divider.
  ///
  /// The [links] display below the [SBBSwitchListItem].
  ///
  /// If [isLoading] is true, a bottom loading indicator will be displayed.
  ///
  /// Check the [SBBSwitchListItem.custom] constructor for a complete customization.
  SBBSwitchListItem({
    Key? key,
    IconData? leadingIcon,
    required String title,
    String? subtitle,
    bool allowMultilineLabel = false,
    bool isLastElement = false,
    required bool value,
    required ValueChanged<bool>? onChanged,
    List<SBBSwitchListItemLink>? links,
    bool isLoading = false,
  }) : this.custom(
         key: key,
         leadingIcon: leadingIcon,
         title: title,
         subtitle: subtitle,
         allowMultilineLabel: allowMultilineLabel,
         isLastElement: isLastElement,
         value: value,
         onChanged: onChanged,
         isLoading: isLoading,
         linksWidgets:
             links
                 ?.map(
                   (linkItem) => SBBListItem(
                     title: linkItem.text,
                     onPressed: linkItem.onPressed,
                     isLastElement: true,
                     trailingIcon: SBBIcons.chevron_small_right_small,
                   ),
                 )
                 .toList(),
       );

  /// Use this in combination with a [SBBGroup] to create a boxed variant of the [SBBSwitchListItem].
  ///
  /// ```dart
  /// SBBGroup(
  ///   child: SBBSwitchListItem(
  ///     value: _throwShotAway,
  ///     onChanged: (bool newValue) {
  ///       setState(() {
  ///         _throwShotAway = newValue;
  ///       });
  ///     },
  ///     title: 'Example',
  ///   )
  /// )
  ///
  /// ```
  ///
  SBBSwitchListItem.boxed({
    Key? key,
    IconData? leadingIcon,
    required String title,
    String? subtitle,
    bool allowMultilineLabel = false,
    required bool value,
    required ValueChanged<bool>? onChanged,
    List<SBBSwitchListItemLink>? links,
    bool isLoading = false,
  }) : this.custom(
         key: key,
         leadingIcon: leadingIcon,
         title: title,
         subtitle: subtitle,
         allowMultilineLabel: allowMultilineLabel,
         isLastElement: true,
         value: value,
         onChanged: onChanged,
         isLoading: isLoading,
         linksWidgets:
             links
                 ?.map(
                   (linkItem) => SBBListItem(
                     title: linkItem.text,
                     onPressed: linkItem.onPressed,
                     isLastElement: true,
                     trailingIcon: SBBIcons.chevron_small_right_small,
                   ),
                 )
                 .toList(),
       );

  /// Allows complete customization of the [SBBSwitchListItem].
  const SBBSwitchListItem.custom({
    super.key,
    required this.value,
    required this.title,
    this.allowMultilineLabel = false,
    this.subtitle,
    required this.onChanged,
    this.isLastElement = true,
    this.leadingIcon,
    this.linksWidgets,
    this.isLoading = false,
  });

  /// Whether this switch is on or off.
  final bool value;

  /// Called when the user toggles the switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch with the new
  /// value.
  final ValueChanged<bool>? onChanged;

  /// The primary text displayed on the [SBBSwitchListItem].
  final String title;

  /// Whether the primary text can stretch over multiple lines.
  final bool allowMultilineLabel;

  /// The secondary text displayed below the [title].
  final String? subtitle;

  /// Whether to display a [Divider] below this Widget.
  final bool isLastElement;

  /// The icon displayed left of the [title].
  final IconData? leadingIcon;

  /// The widgets displayed below the primary [SBBSwitchListItem].
  final List<Widget>? linksWidgets;

  /// Whether to display a BottomLoadingIndicator on the [SBBSwitchListItem].
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).listItem;
    final enabled = onChanged != null;
    return Material(
      color: style?.backgroundColor,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 44.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                SBBListItem.custom(
                  leadingIcon: leadingIcon,
                  title: title,
                  titleMaxLines: allowMultilineLabel ? null : 1,
                  subtitle: subtitle,
                  subtitleMaxLines: null,
                  onPressed: enabled ? () => onChanged?.call(!value) : null,
                  isLastElement: true,
                  trailingWidget: Padding(
                    padding: const EdgeInsets.only(
                      left: sbbDefaultSpacing * 0.5,
                      right: sbbDefaultSpacing,
                    ),
                    child: SBBSwitch(
                      value: value,
                      onChanged: onChanged,
                    ),
                  ),
                ),
                if (linksWidgets != null && linksWidgets!.isNotEmpty)
                  ...linksWidgets!.expand(
                    (element) => [
                      const Divider(),
                      element,
                    ],
                  ),
              ],
            ),
            if (!isLastElement) const Divider(),
            if (isLoading) const BottomLoadingIndicator(),
          ],
        ),
      ),
    );
  }
}

class SBBSwitchListItemLink {
  SBBSwitchListItemLink({
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;
}
