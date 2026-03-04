import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/shared/divider/divider_painter.dart';

/// A one-pixel divider line using the SBB design system styling.
///
/// See also:
///  * [SBBListItem.divideListItems], for automatically adding dividers between list items.
class SBBDivider extends StatelessWidget {
  const SBBDivider({super.key, this.color});

  /// The color of the divider line.
  ///
  /// If null, defaults to [ThemeData.dividerColor].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Color resolvedColor = color ?? Theme.of(context).dividerColor;
    return CustomPaint(
      foregroundPainter: DividerPainter(
        color: resolvedColor,
        indent: 0.0,
        paintAtTop: false,
      ),
    );
  }
}
