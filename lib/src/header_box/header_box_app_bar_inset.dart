import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Embeds the header box into the app bar by drawing part of the app bar underneath the top edge.
class HeaderBoxAppBarInset extends StatelessWidget {
  const HeaderBoxAppBarInset({
    super.key,
    required this.style,
    required this.child,
  });

  final SBBHeaderBoxStyle style;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Align(
          alignment: .topCenter,
          child: Container(
            color: theme.appBarTheme.backgroundColor,
            height: style.appBarOverlap,
          ),
        ),
        Padding(
          padding: style.margin ?? EdgeInsets.zero,
          child: child,
        ),
      ],
    );
  }
}
