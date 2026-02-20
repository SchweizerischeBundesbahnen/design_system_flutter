import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// The SBB List Header.
///
/// A header widget used to label and organize list content within a list view.
/// It displays a text label with configurable styling, overflow behavior, and padding.
///
/// See also:
///
/// * [SBBListItem]: generic item to be used within the list
/// * [SBBListItem.divideListItems]: to separate items in a list with the SBB specific divider
/// * [digital.sbb.ch/listView](https://digital.sbb.ch/de/design-system/mobile/components/list-view/)
class SBBListHeader extends StatelessWidget {
  /// Creates an SBB List Header.
  ///
  /// The [titleText] parameter is required.
  ///
  /// The [style] parameter can be used to customize the appearance of the header.
  /// Non-null properties of [style] will override the corresponding properties
  /// in [SBBListHeaderThemeData.style] of the theme found in [context].
  const SBBListHeader(
    this.titleText, {
    super.key,
    this.style,
  });

  /// The text to display as the header label.
  final String titleText;

  /// Customizes this list header appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBListHeaderThemeData.style] of the theme found in [context].
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
