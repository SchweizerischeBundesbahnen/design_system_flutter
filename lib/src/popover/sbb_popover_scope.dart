import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_direction.dart';

class SBBPopoverScope extends InheritedWidget {
  const SBBPopoverScope({
    super.key,
    required this.targetPosition,
    required this.targetSize,
    required this.preferredDirection,
    required super.child,
  });

  final Offset targetPosition;
  final Size targetSize;
  final SBBPopoverDirection preferredDirection;

  static SBBPopoverScope of(BuildContext context) {
    final SBBPopoverScope? result = context.dependOnInheritedWidgetOfExactType<SBBPopoverScope>();
    assert(
      result != null,
      'No SBBPopoverScope found in context. Ensure SBBPopover is wrapped in an SBBAnchoredOverlayBuilder.',
    );
    return result!;
  }

  @override
  bool updateShouldNotify(SBBPopoverScope oldWidget) {
    return targetPosition != oldWidget.targetPosition ||
        targetSize != oldWidget.targetSize ||
        preferredDirection != oldWidget.preferredDirection;
  }
}
