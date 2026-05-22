import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/shared/debug.dart';
import 'package:sbb_design_system_mobile/src/shared/divider/divider_painter.dart';

/// A one-pixel divider line using the SBB design system styling.
///
/// See also:
///  * [SBBDivider.divideItems], for automatically adding dividers between list items.
class SBBDivider extends StatelessWidget {
  const SBBDivider({super.key, this.color});

  /// The color of the divider line.
  ///
  /// If null, defaults to [ThemeData.dividerTheme.color].
  final Color? color;

  /// Add a one pixel border in between each item. If color isn't specified the
  /// [ThemeData.dividerColor] of the context's [Theme] is used, which defaults to
  /// [SBBBaseStyle.dividerColor].
  static List<Widget> divideItems({
    required BuildContext context,
    required Iterable<Widget> items,
    Color? color,
  }) {
    final itemList = items.toList();

    if (itemList.isEmpty || itemList.length == 1) {
      return itemList;
    }

    final resolvedColor = color ?? Theme.of(context).dividerColor;

    Widget wrapListItem(Widget link) {
      return CustomPaint(
        foregroundPainter: DividerPainter(
          paintAtTop: false,
          color: resolvedColor,
          indent: 0.0,
        ),
        child: link,
      );
    }

    return <Widget>[...itemList.take(itemList.length - 1).map(wrapListItem), itemList.last];
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasSBBBaseStyle(context));

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
