import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// SBB List Header. Use according to documentation.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/list-header>
class SBBListHeader extends StatelessWidget {
  const SBBListHeader(
    this.title, {
    super.key,
    this.maxLines,
    this.padding,
    this.textStyle,
  });

  final String title;
  final int? maxLines;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context);
    return Padding(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: sbbDefaultSpacing,
            vertical: sbbDefaultSpacing / 2,
          ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: maxLines,
              overflow: maxLines == null ? null : TextOverflow.ellipsis,
              style: textStyle ?? style.listHeaderTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
