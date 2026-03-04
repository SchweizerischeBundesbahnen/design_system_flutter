import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/shared/divider/divider_painter.dart';

class SBBDivider extends StatelessWidget {
  const SBBDivider({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Color resolvedColor = color ?? Theme.of(context).dividerColor;
    return CustomPaint(
      foregroundPainter: SBBDividerPainter(
        color: resolvedColor,
        indent: 0.0,
        paintAtTop: false,
      ),
    );
  }
}
