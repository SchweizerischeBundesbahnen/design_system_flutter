import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

class DefaultToastBody extends StatelessWidget {
  const DefaultToastBody({
    super.key,
    required this.title,
    required this.duration,
    required this.stream,
    this.style,
  });

  final String title;
  final Duration duration;
  final Stream<bool> stream;
  final SBBToastStyle? style;

  @override
  Widget build(BuildContext context) {
    final resolvedStyle = style.merge(SBBToastStyle.of(context));

    return StreamBuilder<bool>(
      stream: stream,
      builder: (context, snapshot) {
        final isVisible = snapshot.data ?? false;
        return AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: kThemeAnimationDuration,
          child: Container(
            decoration: resolvedStyle.decoration,
            margin: resolvedStyle.margin,
            padding: resolvedStyle.padding,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(title, style: resolvedStyle.titleTextStyle),
              ],
            ),
          ),
        );
      },
    );
  }
}
