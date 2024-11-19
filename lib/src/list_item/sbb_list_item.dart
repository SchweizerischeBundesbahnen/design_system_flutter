import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// SBB List Item.
/// Use according to [documentation](https://digital.sbb.ch/en/design-system/mobile/components/list-item/).
class SBBListItem extends StatefulWidget {
  SBBListItem({
    Key? key,
    IconData? leadingIcon,
    required String title,
    String? subtitle,
    IconData? trailingIcon,
    int? titleMaxLines,
    int? subtitleMaxLines,
    bool isLastElement = false,
    required VoidCallback? onPressed,
  }) : this.custom(
          key: key,
          leadingIcon: leadingIcon,
          title: title,
          subtitle: subtitle,
          titleMaxLines: titleMaxLines,
          subtitleMaxLines: subtitleMaxLines,
          isLastElement: isLastElement,
          trailingWidget: trailingIcon != null
              ? Builder(
                  builder: (BuildContext context) {
                    final style = SBBControlStyles.of(context).listItem!;
                    final isEnabled = onPressed != null;
                    return Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: sbbDefaultSpacing,
                      ),
                      child: Icon(
                        trailingIcon,
                        color: isEnabled
                            ? style.iconColor
                            : style.iconColorDisabled,
                      ),
                    );
                  },
                )
              : null,
          onPressed: onPressed,
        );

  SBBListItem.button({
    Key? key,
    IconData? leadingIcon,
    required String title,
    String? subtitle,
    int? titleMaxLines,
    int? subtitleMaxLines,
    bool isLastElement = false,
    required VoidCallback? onPressed,
    required IconData buttonIcon,
    required VoidCallback? onPressedButton,
  }) : this.custom(
          key: key,
          leadingIcon: leadingIcon,
          title: title,
          subtitle: subtitle,
          titleMaxLines: titleMaxLines,
          subtitleMaxLines: subtitleMaxLines,
          isLastElement: isLastElement,
          onPressed: onPressed,
          trailingWidget: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: sbbDefaultSpacing * 0.5,
            ),
            child: SBBIconButtonSmall(
              icon: buttonIcon,
              onPressed: onPressed != null ? onPressedButton : null,
            ),
          ),
        );

  const SBBListItem.custom({
    super.key,
    this.leadingIcon,
    required this.title,
    this.subtitle,
    this.titleMaxLines,
    this.subtitleMaxLines,
    this.enabled,
    this.isLastElement = false,
    required this.onPressed,
    required this.trailingWidget,
  });

  final IconData? leadingIcon;
  final String title;
  final String? subtitle;
  final int? titleMaxLines;
  final int? subtitleMaxLines;
  final bool? enabled;
  final bool isLastElement;
  final VoidCallback? onPressed;
  final Widget? trailingWidget;

  @override
  State<SBBListItem> createState() => _SBBListItemState();
}

class _SBBListItemState extends State<SBBListItem> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).listItem!;
    final isEnabled = widget.enabled ?? widget.onPressed != null;
    return MergeSemantics(
      child: Semantics(
        button: isEnabled,
        child: Material(
          color:
              isEnabled ? style.backgroundColor : style.backgroundColorDisabled,
          child: InkWell(
            splashColor: style.backgroundColorHighlighted,
            focusColor: style.backgroundColorHighlighted,
            highlightColor: SBBColors.transparent,
            hoverColor: SBBColors.transparent,
            onTap: widget.onPressed,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: sbbDefaultSpacing,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minHeight: sbbIconSizeSmall,
                                ),
                                child: Row(
                                  children: [
                                    if (widget.leadingIcon != null)
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                          end: sbbDefaultSpacing * 0.5,
                                        ),
                                        child: Icon(
                                          widget.leadingIcon,
                                          color: isEnabled
                                              ? style.iconColor
                                              : style.iconColorDisabled,
                                        ),
                                      ),
                                    Expanded(
                                      child: Text(
                                        widget.title,
                                        style: isEnabled
                                            ? style.textStyle
                                            : style.textStyleDisabled,
                                        maxLines: widget.titleMaxLines,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (widget.subtitle != null)
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    bottom: 5.0,
                                  ),
                                  child: Text(
                                    widget.subtitle!,
                                    style: isEnabled
                                        ? style.secondaryTextStyle
                                        : style.secondaryTextStyleDisabled,
                                    maxLines: widget.subtitleMaxLines,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                      if (widget.trailingWidget != null)
                        widget.trailingWidget!
                      else
                        const SizedBox(
                          width: sbbDefaultSpacing,
                        ),
                    ],
                  ),
                ),
                if (!widget.isLastElement) const Divider()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
