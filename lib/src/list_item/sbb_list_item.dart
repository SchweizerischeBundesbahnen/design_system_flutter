import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// SBB List Item. Use according to documentation.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/list-item>
class SBBListItem extends StatelessWidget {
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
  })  : assert(onCallToAction == null || trailingIcon != null),
        super(key: key);

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
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).listItem;
    return MergeSemantics(
      child: Material(
        color: style?.backgroundColor,
        child: InkWell(
          splashColor: style?.backgroundColorHighlighted,
          focusColor: style?.backgroundColorHighlighted,
          highlightColor: SBBColors.transparent,
          hoverColor: SBBColors.transparent,
          onTap: onPressed,
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
                              constraints: BoxConstraints(minHeight: sbbIconSizeSmall),
                              child: Row(
                                children: [
                                  if (leadingIcon != null)
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        end: sbbDefaultSpacing / 2,
                                      ),
                                      child: Icon(leadingIcon),
                                    ),
                                  Expanded(
                                    child: Text(
                                      title,
                                      style: style?.textStyle,
                                      maxLines: titleMaxLines,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (subtitle != null)
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  bottom: 5.0,
                                ),
                                child: Text(
                                  subtitle!,
                                  style: style?.secondaryTextStyle,
                                  maxLines: subtitleMaxLines,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    if (trailingIcon != null)
                      ExcludeFocus(
                        excluding: onCallToAction == null,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: sbbDefaultSpacing / 2,
                          ),
                          child: IgnorePointer(
                            ignoring: onCallToAction == null,
                            ignoringSemantics: onCallToAction == null,
                            child: SBBIconButtonSmall(
                              icon: trailingIcon!,
                              onPressed: onCallToAction ?? onPressed,
                            ),
                          ),
                        ),
                      )
                    else
                      SizedBox(width: sbbDefaultSpacing / 2),
                  ],
                ),
              ),
              if (!isLastElement) const Divider()
            ],
          ),
        ),
      ),
    );
  }
}
