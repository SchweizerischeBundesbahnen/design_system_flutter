import 'package:flutter/material.dart';

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
    this.maxLines,
    this.padding,
    this.textStyle,
  }) : super(key: key);

  final String title;
  final int? maxLines;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context);
    return Padding(
      padding: padding ??
          EdgeInsets.symmetric(
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
