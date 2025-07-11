import 'package:flutter/material.dart';

class SBBToastAction {
  const SBBToastAction({
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;
}
