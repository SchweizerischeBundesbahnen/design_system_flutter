import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_direction.dart';

class SBBPopoverScope extends InheritedWidget {
  const SBBPopoverScope({
    super.key,
    required this.triggerKey,
    required this.preferredDirection,
    required this.safeAreaInsets,
    required super.child,
  });

  final GlobalKey triggerKey;
  final SBBPopoverDirection preferredDirection;
  final EdgeInsets safeAreaInsets;

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
    return triggerKey != oldWidget.triggerKey ||
        preferredDirection != oldWidget.preferredDirection ||
        safeAreaInsets != oldWidget.safeAreaInsets;
  }
}
