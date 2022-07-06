import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../design_system_flutter.dart';

/// SBB List Item. Use according to documentation.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/list-item>
class SBBListItem extends StatefulWidget {
  const SBBListItem({
    Key? key,
    required this.title,
    this.subtitle,
    this.isLastElement = false,
    this.titleMaxLines,
    this.subtitleMaxLines,
    this.leadingIcon,
    this.trailingIcon,
    this.onCallToAction,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final bool isLastElement;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  final int? titleMaxLines;
  final int? subtitleMaxLines;

  /// Redirects to [onPressed] if null
  final VoidCallback? onCallToAction;
  final VoidCallback? onPressed;

  @override
  State<SBBListItem> createState() => _SBBListItemState();
}

class _SBBListItemState extends State<SBBListItem> {
  bool isHovering = false;

  Widget _buildNative(SBBThemeData sbbTheme) {
    return MergeSemantics(
      child: Material(
        color: sbbTheme.listItemBackgroundColor,
        child: InkWell(
          splashColor: sbbTheme.listItemBackgroundColorHighlighted,
          focusColor: sbbTheme.listItemBackgroundColorHighlighted,
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
                        padding: const EdgeInsetsDirectional.only(
                          top: 10,
                          bottom: 10,
                          end: sbbDefaultSpacing / 2,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(minHeight: sbbIconSizeSmall),
                              child: Row(
                                children: [
                                  if (widget.leadingIcon != null)
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        end: sbbDefaultSpacing / 2,
                                      ),
                                      child: Icon(widget.leadingIcon),
                                    ),
                                  Expanded(
                                    child: Text(
                                      widget.title,
                                      style: sbbTheme.listItemTitleTextStyle,
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
                                  style: sbbTheme.listItemSubtitleTextStyle,
                                  maxLines: widget.subtitleMaxLines,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    if (widget.trailingIcon != null)
                      ExcludeFocus(
                        excluding: widget.onCallToAction == null,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: sbbDefaultSpacing / 2,
                          ),
                          child: IgnorePointer(
                            ignoring: widget.onCallToAction == null,
                            ignoringSemantics: widget.onCallToAction == null,
                            child: SBBIconButtonSmall(
                              icon: widget.trailingIcon!,
                              onPressed:
                                  widget.onCallToAction ?? widget.onPressed,
                            ),
                          ),
                        ),
                      )
                    else
                      SizedBox(width: sbbDefaultSpacing / 2),
                  ],
                ),
              ),
              if (!widget.isLastElement) const Divider()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeb(SBBThemeData sbbTheme) {
    return MergeSemantics(
      child: Material(
        color: sbbTheme.listItemBackgroundColor,
        child: InkWell(
          splashColor: sbbTheme.listItemBackgroundColorHighlighted,
          focusColor: sbbTheme.listItemBackgroundColorHighlighted,
          highlightColor: SBBColors.transparent,
          hoverColor: SBBColors.milk,
          onTap: widget.onPressed,
          onHover: (hovering) {
            setState(() => this.isHovering = hovering);
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                        color: isHovering
                            ? SBBColors.red125
                            : SBBColors.transparent))),
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
                          padding: const EdgeInsetsDirectional.only(
                            top: 2,
                            bottom: 2,
                            end: sbbDefaultSpacing / 2,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ConstrainedBox(
                                constraints:
                                    BoxConstraints(minHeight: sbbIconSizeSmall),
                                child: Row(
                                  children: [
                                    if (widget.leadingIcon != null)
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                          end: sbbDefaultSpacing / 2,
                                        ),
                                        child: Icon(widget.leadingIcon,
                                            color: isHovering
                                                ? SBBColors.red125
                                                : SBBColors.black),
                                      ),
                                    Expanded(
                                      child: Text(
                                        widget.title,
                                        style: isHovering
                                            ? sbbTheme.listItemTitleTextStyle
                                                .copyWith(
                                                    color: SBBColors.red125)
                                            : sbbTheme.listItemTitleTextStyle,
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
                                    style: isHovering
                                        ? sbbTheme.listItemSubtitleTextStyle
                                            .copyWith(color: SBBColors.red125)
                                        : sbbTheme.listItemSubtitleTextStyle,
                                    maxLines: widget.subtitleMaxLines,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                      if (widget.trailingIcon != null)
                        ExcludeFocus(
                          excluding: widget.onCallToAction == null,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                              end: sbbDefaultSpacing / 2,
                            ),
                            child: IgnorePointer(
                              ignoring: widget.onCallToAction == null,
                              ignoringSemantics: widget.onCallToAction == null,
                              child: SBBIconButtonSmall(
                                icon: widget.trailingIcon!,
                                onPressed:
                                    widget.onCallToAction ?? widget.onPressed,
                              ),
                            ),
                          ),
                        )
                      else
                        SizedBox(width: sbbDefaultSpacing / 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sbbTheme = SBBTheme.of(context);
    final bool isWeb = sbbTheme.hostPlatform == HostPlatform.web;
    if (isWeb) return _buildWeb(sbbTheme);
    return _buildNative(sbbTheme);
  }
}
