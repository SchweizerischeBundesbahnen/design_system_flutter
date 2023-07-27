import 'package:flutter/material.dart';
import '../../design_system_flutter.dart';

/// SBB switch Link. Use according to documentation.
///
/// See also:
///
/// * [SBBSwitch], which is a part of this widget.
/// * [SBBSwitchLink], a default widget for a linkWidget in [SBBSwitchListItem].
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/switch>
///

class SBBSwitchLink extends StatelessWidget {
  const SBBSwitchLink({
    this.text,
    this.child,
    this.trailingIcon,
    this.isLastElement = false,
    this.enabled = false,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final String? text;
  final Widget? child;
  final IconData? trailingIcon;
  final bool isLastElement;
  final bool enabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).listItem;
    return MergeSemantics(
      child: Semantics(
        button: onPressed != null,
        child: Material(
          color: style?.backgroundColor,
          child: InkWell(
            splashColor: style?.backgroundColorHighlighted,
            focusColor: style?.backgroundColorHighlighted,
            highlightColor: SBBColors.transparent,
            hoverColor: SBBColors.transparent,
            onTap: enabled ? onPressed : null,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48.0),
              child: Column(
                children: [
                  Container(
                    constraints:
                        const BoxConstraints(minHeight: sbbIconSizeSmall * 2),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: sbbDefaultSpacing, end: sbbDefaultSpacing),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (text != null)
                                  Text(
                                    text!,
                                    style: enabled
                                        ? style?.textStyle
                                        : style?.textStyleDisabled,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                if (child != null) child!,
                              ],
                            ),
                          ),
                          if (trailingIcon != null)
                            Padding(
                              padding: const EdgeInsetsDirectional.all(
                                  sbbDefaultSpacing / 2),
                              child: Icon(
                                trailingIcon!,
                                size: sbbIconSizeSmall / 2,
                                color: enabled
                                    ? style?.iconColor
                                    : style?.iconColorDisabled,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (!isLastElement) const Divider()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
