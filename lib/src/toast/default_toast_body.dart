import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'sbb_toast_action_body.dart';

class DefaultToastBody extends StatelessWidget {
  const DefaultToastBody({
    super.key,
    required this.title,
    required this.duration,
    required this.stream,
    this.action,
    this.style,
  });

  final String title;
  final Duration duration;
  final Stream<bool> stream;
  final SBBToastActionBody? action;
  final SBBToastStyle? style;

  @override
  Widget build(BuildContext context) {
    final resolvedStyle = style.merge(SBBToastStyle.of(context));

    final child = _bodyWithTextAndAction(resolvedStyle, context);

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
            child: child,
          ),
        );
      },
    );
  }

  Widget _bodyWithText(SBBToastStyle resolvedStyle) =>
      Text(title, style: resolvedStyle.titleTextStyle, maxLines: resolvedStyle.titleMaxLines);

  Widget _bodyWithTextAndAction(SBBToastStyle resolvedStyle, BuildContext context) {
    if (action == null) return _bodyWithText(resolvedStyle);

    double actionAndMarginWidth = _actionAndMarginWidth(resolvedStyle.actionTextStyle);

    final snackBarWidth = MediaQuery.sizeOf(context).width - resolvedStyle.margin!.vertical;

    final bool willActionOverflow = actionAndMarginWidth / snackBarWidth > resolvedStyle.actionOverflowThreshold!;

    return Wrap(
      children: [
        Row(
          children: [
            Expanded(child: _bodyWithText(resolvedStyle)),
            if (!willActionOverflow) Padding(padding: EdgeInsets.only(left: sbbDefaultSpacing), child: action),
            if (willActionOverflow) SizedBox(width: snackBarWidth * 0.3),
          ],
        ),
        if (willActionOverflow)
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(padding: EdgeInsets.only(bottom: 6.0), child: action),
          ),
      ],
    );
  }

  double _actionAndMarginWidth(TextStyle? style) {
    final actionTextPainter = TextPainter(
      text: TextSpan(text: action!.title, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    final result = actionTextPainter.size.width + sbbDefaultSpacing;
    actionTextPainter.dispose();
    return result;
  }
}
