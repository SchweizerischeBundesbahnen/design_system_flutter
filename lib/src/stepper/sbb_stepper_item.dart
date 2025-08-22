import 'package:flutter/widgets.dart';

class SBBStepperItem {
  const SBBStepperItem({
    this.icon,
    required this.label,
  });

  final IconData? icon;
  final String label;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBStepperItem &&
        other.icon == icon &&
        other.label == label;
  }

  @override
  int get hashCode {
    return Object.hash(icon, label);
  }

  @override
  String toString() {
    return 'SBBStepperItem($label)';
  }
}
