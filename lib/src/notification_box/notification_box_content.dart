import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'notification_box_text_content.dart';

class SBBNotificationBoxContent extends StatelessWidget {
  const SBBNotificationBoxContent({
    required this.text,
    required this.isCloseable,
    super.key,
    this.icon,
    this.detailsIcon,
  });

  final Widget? icon;
  final String text;
  final bool isCloseable;
  final Widget? detailsIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) ...[icon!, const SizedBox(width: 8.0)],
        Expanded(
          child: NotificationBoxTextContent(text: text, icon: detailsIcon),
        ),
        if (isCloseable) const SizedBox(width: sbbIconSizeSmall),
      ],
    );
  }
}
