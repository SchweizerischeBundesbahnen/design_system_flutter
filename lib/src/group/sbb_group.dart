import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';

/// SBB Group. Use according to documentation.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/module/form_group>
class SBBGroup extends StatelessWidget {
  const SBBGroup({
    Key? key,
    this.margin,
    this.padding,
    this.useShadow = false,
    required this.child,
  }) : super(key: key);

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  /// Uses shadow in light mode. Shadow will never be used in dark mode.
  final bool useShadow;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cardTheme = Theme.of(context).cardTheme;
    final shape = cardTheme.shape;
    final borderRadius = shape is RoundedRectangleBorder ? shape.borderRadius : null;
    final backgroundColor = cardTheme.color;
    return Container(
      margin: margin ?? cardTheme.margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        boxShadow: useShadow && !SBBTheme.of(context).isDark ? SBBInternal.defaultBoxShadow : null,
      ),
      child: Card(
        color: SBBColors.transparent,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }
}
