import 'package:flutter/material.dart';

class NotificationBoxTextContent extends StatelessWidget {
  const NotificationBoxTextContent({
    required this.text,
    super.key,
    this.clip = true,
    this.icon,
  });

  final String text;
  final bool clip;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            maxLines: clip ? 3 : null,
            overflow: clip ? TextOverflow.ellipsis : null,
          ),
        ),
        SizedBox(width: 8.0),
        if (icon != null) icon!,
      ],
    );
  }
}
