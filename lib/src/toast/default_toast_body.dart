import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/toast/toast_scope.dart';

import '../../sbb_design_system_mobile.dart';
import 'toast_action_body.dart';

class DefaultToastBody extends StatelessWidget {
  const DefaultToastBody({
    super.key,
    this.title,
    this.titleText,
    required this.duration,
    this.action,
    this.style,
  }) : assert(titleText == null || title == null, 'Cannot provide both titleText and title!'),
       assert(titleText != null || title != null, 'One of titleText or title must be set!');

  final Widget? title;
  final String? titleText;
  final Duration duration;
  final SBBToastAction? action;
  final SBBToastStyle? style;

  @override
  Widget build(BuildContext context) {
    final resolvedStyle = style.merge(SBBToastStyle.of(context));
    final toastContainer = ToastScope.of(context);

    return StreamBuilder<bool>(
      stream: toastContainer.stream,
      builder: (context, snapshot) {
        final isVisible = snapshot.data ?? false;
        return AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: kThemeAnimationDuration,
          child: Container(
            decoration: resolvedStyle.decoration,
            margin: resolvedStyle.margin,
            padding: resolvedStyle.padding,
            child: _bodyWithTextAndAction(resolvedStyle, context),
          ),
        );
      },
    );
  }

  Widget _bodyWithTextAndAction(SBBToastStyle resolvedStyle, BuildContext context) {
    if (action == null) return _bodyWithText(resolvedStyle);

    final builtAction = ToastActionBody(onPressed: action!.onPressed, title: action!.title, style: resolvedStyle);

    double actionAndMarginWidth = _actionAndMarginWidth(resolvedStyle.actionTextStyle);

    final toastWidth = MediaQuery.sizeOf(context).width - resolvedStyle.margin!.vertical;

    final bool willActionOverflow = actionAndMarginWidth / toastWidth > resolvedStyle.actionOverflowThreshold!;

    return Wrap(
      children: [
        Row(
          children: [
            Expanded(child: _bodyWithText(resolvedStyle)),
            if (!willActionOverflow) Padding(padding: resolvedStyle.actionPadding!, child: builtAction),
            if (willActionOverflow) SizedBox(width: toastWidth * 0.3),
          ],
        ),
        if (willActionOverflow) Align(alignment: .bottomRight, child: builtAction),
      ],
    );
  }

  Widget _bodyWithText(SBBToastStyle resolvedStyle) =>
      title ?? Text(titleText!, style: resolvedStyle.titleTextStyle, maxLines: resolvedStyle.titleMaxLines);

  double _actionAndMarginWidth(TextStyle? style) {
    final actionTextPainter = TextPainter(
      text: TextSpan(text: action!.title, style: style),
      maxLines: 1,
      textDirection: .ltr,
    )..layout();
    final result = actionTextPainter.size.width + SBBSpacing.medium;
    actionTextPainter.dispose();
    return result;
  }
}
