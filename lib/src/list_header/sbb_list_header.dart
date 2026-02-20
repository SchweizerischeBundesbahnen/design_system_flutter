import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// SBB List Header. Use according to documentation.
///
/// See also:
///
/// * [SBBListItem]: generic item to be used within the list
/// * [SBBListItem.divideListItems]: to separate items in a list with the SBB specific divider
/// * [digital.sbb.ch/listView](https://digital.sbb.ch/de/design-system/mobile/components/list-view/)
class SBBListHeader extends StatelessWidget {
  const SBBListHeader(
    this.titleText, {
    super.key,
    this.style,
  });

  final String titleText;
  final SBBListHeaderStyle? style;

  @override
  Widget build(BuildContext context) {
    final themeStyle = Theme.of(context).sbbListHeaderTheme?.style;
    final effectiveStyle = themeStyle?.merge(style);

    final foregroundColor = effectiveStyle?.foregroundColor;
    final textStyle = effectiveStyle?.textStyle;
    final maxLines = effectiveStyle?.maxLines;
    final textOverflow = effectiveStyle?.textOverflow;
    final padding =
        effectiveStyle?.padding ??
        const EdgeInsets.symmetric(
          horizontal: SBBSpacing.medium,
          vertical: SBBSpacing.xSmall,
        );

    return Padding(
      padding: padding,
      child: Text(
        titleText,
        maxLines: maxLines,
        overflow: maxLines == null ? null : textOverflow,
        style: textStyle?.copyWith(color: foregroundColor) ?? TextStyle(color: foregroundColor),
      ),
    );
  }
}
