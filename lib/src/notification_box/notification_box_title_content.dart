import 'package:flutter/material.dart';

import 'notification_box_text_content.dart';

class SBBNotificationBoxTitleContent extends StatelessWidget {
  const SBBNotificationBoxTitleContent({
    required this.title,
    required this.text,
    super.key,
    this.icon,
    this.detailsIcon,
  });

  final Widget? icon;
  final String title;
  final String text;
  final Widget? detailsIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 8.0),
            ],
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        NotificationBoxTextContent(text: text, icon: detailsIcon),
      ],
    );
  }
}
