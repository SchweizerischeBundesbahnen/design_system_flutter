import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

class SBBNotificationBoxContent extends StatelessWidget {
  const SBBNotificationBoxContent({
    required this.icon,
    required this.text,
    required this.isCloseable,
    super.key,
  });

  final Widget icon;
  final String text;
  final bool isCloseable;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        SizedBox(width: 8.0),
        Expanded(child: Text(text)),
        if (isCloseable) const SizedBox(width: sbbIconSizeSmall),
      ],
    );
  }
}
