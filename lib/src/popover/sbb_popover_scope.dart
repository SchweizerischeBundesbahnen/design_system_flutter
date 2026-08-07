import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_direction.dart';

class SBBPopoverScope extends InheritedWidget {
  const SBBPopoverScope({
    super.key,
    required this.triggerPosition,
    required this.triggerSize,
    required this.preferredDirection,
    required super.child,
  });

  final Offset triggerPosition;
  final Size triggerSize;
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
    return triggerPosition != oldWidget.triggerPosition ||
        triggerSize != oldWidget.triggerSize ||
        preferredDirection != oldWidget.preferredDirection;
  }
}
