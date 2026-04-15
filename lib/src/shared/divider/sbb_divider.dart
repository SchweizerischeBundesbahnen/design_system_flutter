import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/shared/divider/divider_painter.dart';

/// A one-pixel divider line using the SBB design system styling.
///
/// See also:
///  * [SBBListItem.divideListItems], for automatically adding dividers between list items.
class SBBDivider extends StatelessWidget {
  const SBBDivider({super.key, this.color});

  /// The color of the divider line.
  ///
  /// If null, defaults to [ThemeData.dividerTheme.color].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final resolvedColor = color ?? Theme.of(context).dividerTheme.color;
    if (resolvedColor == null) return SizedBox.shrink();
    return CustomPaint(
      foregroundPainter: DividerPainter(
        color: resolvedColor,
        indent: 0.0,
        paintAtTop: false,
      ),
    );
  }
}
