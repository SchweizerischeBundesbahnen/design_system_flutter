import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/divider/divider_painter.dart';
import 'package:sbb_design_system_mobile/src/shared/debug.dart';

/// A one-pixel divider line using the SBB design system styling.
///
/// ## Sample code for standard use
///
/// ```dart
/// Column(
///   children: SBBDivider.divideItems(
///     context: context,
///     items: [
///       SBBListItem(titleText: 'Item 1'),
///       SBBListItem(titleText: 'Item 2'),
///       SBBListItem(titleText: 'Item 3'),
///     ],
///   )
/// )
/// ```
///
///
/// {@template sbb_design_system.divider.sample_builder}
/// ## Sample code for item builders
///
/// ```dart
/// SliverList.separated(
///   itemBuilder: (context, index) => SBBListItem(
///     titleText: 'Item $index',
///   ),
///   separatorBuilder: SBBDivider.separatorBuilder,
/// ),
/// ```
/// {@endtemplate}
///
/// See also:
///  * [SBBDivider.divideItems], for automatically adding dividers between list items.
///  * [SBBDivider.separatorBuilder], for a convenience function when using separated item builders.
class SBBDivider extends StatelessWidget {
  const SBBDivider({super.key, this.color});

  /// The color of the divider line.
  ///
  /// If null, defaults to [ThemeData.dividerTheme.color].
  final Color? color;

  /// Add a one pixel border in between each item. If color isn't specified the
  /// [ThemeData.dividerColor] of the context's [Theme] is used, which defaults to
  /// [SBBBaseStyle.dividerColor].
  ///
  /// When working with an item builder, consider using [separatorBuilder].
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

  /// A convenience function for use in separated item builders.
  ///
  /// {@macro sbb_design_system.divider.sample_builder}
  static Widget separatorBuilder(BuildContext _, int _) {
    return SBBDivider();
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
