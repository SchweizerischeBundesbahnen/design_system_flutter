import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../design_system_flutter.dart';

/// SBB List Header. Use according to documentation.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/list-header>
class SBBListHeader extends StatelessWidget {
  const SBBListHeader(
    this.title, {
    Key? key,
    this.padding,
    this.icon,
    this.onCallToAction,
  })  : assert(icon != null && onCallToAction != null || icon == null && onCallToAction == null),
        super(key: key);

  final String title;
  final EdgeInsetsGeometry? padding;
  final IconData? icon;
  final VoidCallback? onCallToAction;

  static const _listHeaderHeight = 40.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _listHeaderHeight,
      padding: padding ??
          EdgeInsetsDirectional.only(
            start: sbbDefaultSpacing,
            end: onCallToAction == null ? sbbDefaultSpacing : sbbDefaultSpacing / 2,
          ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: SBBTheme.of(context).listHeaderTextStyle,
            ),
          ),
          if (onCallToAction != null)
            SBBIconButtonSmall(
              onPressed: onCallToAction,
              icon: icon!,
            ),
        ],
      ),
    );
  }
}
