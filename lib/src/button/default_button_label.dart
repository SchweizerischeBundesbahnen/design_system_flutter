import 'package:flutter/material.dart';

class DefaultButtonLabel extends StatelessWidget {
  const DefaultButtonLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(label, overflow: TextOverflow.ellipsis, maxLines: 1);
  }
}
