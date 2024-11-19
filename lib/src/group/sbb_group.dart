import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';

/// SBB Group. Use according to documentation.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/module/form_group>
class SBBGroup extends StatelessWidget {
  const SBBGroup({
    super.key,
    this.margin,
    this.padding,
    this.useShadow = false,
    required this.child,
  });

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
    final style = SBBBaseStyle.of(context);
    return Container(
      margin: margin ?? cardTheme.margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        boxShadow: SBBBaseStyle.resolve(
          useShadow && style.brightness == Brightness.light,
          SBBInternal.defaultBoxShadow,
          null,
        ),
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
