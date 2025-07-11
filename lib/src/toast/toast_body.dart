import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

class ToastBody extends StatelessWidget {
  const ToastBody({
    super.key,
    required this.title,
    required this.duration,
    required this.stream,
  });

  final String title;
  final Duration duration;
  final Stream<bool> stream;

  @override
  Widget build(BuildContext context) {
    final toastStyle = SBBToastStyle.of(context);

    return StreamBuilder<bool>(
      stream: stream,
      builder: (context, snapshot) {
        final isVisible = snapshot.data ?? false;
        return AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: kThemeAnimationDuration,
          child: Container(
            decoration: toastStyle.decoration,
            margin: toastStyle.margin,
            padding: toastStyle.padding,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(title, style: toastStyle.titleTextStyle),
              ],
            ),
          ),
        );
      },
    );
  }
}
