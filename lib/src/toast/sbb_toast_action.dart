import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/toast/toast_action_body.dart';

import '../../sbb_design_system_mobile.dart';

class SBBToastAction extends StatelessWidget {
  const SBBToastAction({required this.onPressed, required this.title, this.style, super.key});

  final VoidCallback onPressed;
  final String title;
  final SBBToastStyle? style;

  @override
  Widget build(BuildContext context) {
    final resolvedStyle = style ?? SBBToastStyle.of(context);
    return ToastActionBody(onPressed: onPressed, title: title, style: resolvedStyle);
  }
}
