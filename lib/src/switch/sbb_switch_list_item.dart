import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// The SBB Switch List Item.
/// Use according to [documentation](https://digital.sbb.ch/en/design-system/mobile/components/switch/)
///
/// See also:
///
/// * [SBBSwitch], which is a part of this widget.
/// * [SBBListItem], a widget with semantics similar to [SBBSwitchListItem].
class SBBSwitchListItem extends StatelessWidget {
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
  }) : this.custom(
          key: key,
          leadingIcon: leadingIcon,
          title: title,
          subtitle: subtitle,
          allowMultilineLabel: allowMultilineLabel,
          isLastElement: isLastElement,
          value: value,
          onChanged: onChanged,
          linksWidgets: links
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

  const SBBSwitchListItem.custom({
    Key? key,
    required this.value,
    required this.title,
    this.allowMultilineLabel = false,
    this.subtitle,
    required this.onChanged,
    this.isLastElement = true,
    this.leadingIcon,
    this.linksWidgets,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String title;
  final bool allowMultilineLabel;
  final String? subtitle;
  final bool isLastElement;
  final IconData? leadingIcon;
  final List<Widget>? linksWidgets;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).listItem;
    final enabled = onChanged != null;
    return Material(
      color: style?.backgroundColor,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 44.0),
        child: Column(
          children: [
            SBBListItem.custom(
              leadingIcon: leadingIcon,
              title: title,
              subtitle: subtitle,
              onPressed: enabled ? () => onChanged?.call(!value) : null,
              isLastElement: true,
              trailingWidget: Padding(
                padding: EdgeInsets.only(
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
              ...linksWidgets!.expand((element) => [
                    const Divider(
                      indent: sbbDefaultSpacing,
                    ),
                    element,
                  ]),
            if (!isLastElement) const Divider(),
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
