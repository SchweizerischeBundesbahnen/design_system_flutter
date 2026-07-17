import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_direction.dart';

class SBBPopoverScope extends InheritedWidget {
  const SBBPopoverScope({
    super.key,
    required this.triggerGlobalPosition,
    required this.triggerSize,
    required this.preferredDirection,
    required super.child,
  });

  final Offset triggerGlobalPosition;
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
    return triggerGlobalPosition != oldWidget.triggerGlobalPosition ||
        triggerSize != oldWidget.triggerSize ||
        preferredDirection != oldWidget.preferredDirection;
  }
}
