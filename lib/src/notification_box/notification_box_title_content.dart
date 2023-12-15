import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

class SBBNotificationBoxTitleContent extends StatelessWidget {
  const SBBNotificationBoxTitleContent({
    required this.icon,
    required this.title,
    required this.text,
    required this.hasDetails,
    super.key,
  });

  final Widget icon;
  final String title;
  final String text;
  final bool hasDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            icon,
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(child: Text(text)),
            SizedBox(width: 8.0),
            if (hasDetails) Icon(SBBIcons.chevron_small_right_small),
          ],
        ),
      ],
    );
  }
}
