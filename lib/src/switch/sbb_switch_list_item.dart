import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// SBB switch List Item. Use according to documentation.
///
/// See also:
///
/// * [SBBSwitch], which is a part of this widget.
/// * [SBBSwitchListItem], a widget with semantics similar to [SBBListItem].
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/switch>
class SBBSwitchListItem extends StatelessWidget {
  const SBBSwitchListItem({
    Key? key,
    required bool value,
    required String label,
    bool allowMultilineLabel = false,
    String? subText,
    bool tristate = false,
    required ValueChanged<bool>? onChanged,
    bool isLastElement = false,
    IconData? leadingIcon,
    IconData? trailingIcon,
    List<SBBSwitchLink>? links,
  }) : this.custom(
          key: key,
          value: value,
          label: label,
          allowMultilineLabel: allowMultilineLabel,
          subText: subText,
          onChanged: onChanged,
          isLastElement: isLastElement,
          leadingIcon: leadingIcon,
          linksWidgets: links,
        );

  const SBBSwitchListItem.custom({
    Key? key,
    required this.value,
    required this.label,
    this.allowMultilineLabel = false,
    this.subText,
    required this.onChanged,
    this.isLastElement = true,
    this.leadingIcon,
    this.linksWidgets,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool>? onChanged;

  /// [value] and [onChanged] will work same like [SBBSwitch]

  final String label;
  final bool allowMultilineLabel;
  final String? subText;
  final bool isLastElement;
  final IconData? leadingIcon;

  /// [label], [allowMultilineLabel], [subText], [isLastElement], [leadingIcon]
  /// Will work same like [SBBListItem]

  final List<Widget>? linksWidgets;

  /// When [linkText] is not null and [value] is true,
  /// [SBBSwitchLink] will be shown.
  ///
  /// [linksWidgets] can be customized, but the widget must have been created
  /// by following SBB Design System Principles.
  ///

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).listItem;
    final enabled = onChanged != null;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Material(
          color: style?.backgroundColor,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 44.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: sbbDefaultSpacing, end: sbbDefaultSpacing),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (leadingIcon != null)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: sbbDefaultSpacing / 2,
                          ),
                          child: Icon(
                            leadingIcon,
                            color: enabled
                                ? style?.iconColor
                                : style?.iconColorDisabled,
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
                                    ? style?.textStyle
                                    : style?.textStyleDisabled,
                                maxLines: allowMultilineLabel ? null : 1,
                                overflow: allowMultilineLabel
                                    ? null
                                    : TextOverflow.ellipsis,
                              ),
                              if (subText != null)
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    top: sbbDefaultSpacing / 4,
                                  ),
                                  child: Text(
                                    subText!,
                                    style: enabled
                                        ? style?.secondaryTextStyle
                                        : style?.secondaryTextStyleDisabled,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: sbbDefaultSpacing),
                      SBBSwitch(
                        value: value,
                        onChanged: onChanged,
                      ),
                    ],
                  ),
                ),
                if (linksWidgets != null && linksWidgets!.isNotEmpty)
                  const Divider(
                    indent: sbbDefaultSpacing,
                  ),
                if (linksWidgets != null && linksWidgets!.isNotEmpty) linksWidgets!.first,
              ],
            ),
          ),
        ),
        if (!isLastElement) const Divider(),
      ],
    );
  }
}

class SBBSwitchListItemLink {

}