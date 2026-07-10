import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_direction.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_layout_result.dart';

class SBBPopoverLayoutDelegate extends SingleChildLayoutDelegate {
  SBBPopoverLayoutDelegate({
    required this.preferredDirection,
    required this.safeAreaInsets,
    required this.triggerSize,
    required this.triggerGlobalPosition,
    required this.screenSize,
    required this.layoutState,
  });

  final SBBPopoverDirection preferredDirection;
  final EdgeInsets safeAreaInsets;
  final Size triggerSize;
  final Offset triggerGlobalPosition;
  final Size screenSize;
  final ValueNotifier<SBBLayoutResult> layoutState;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // Restrict max size to screen bounds minus safe areas
    return BoxConstraints(
      maxWidth: screenSize.width - safeAreaInsets.horizontal,
      maxHeight: screenSize.height - safeAreaInsets.vertical,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // CompositedTransformFollower origin (0,0) is at the target's top-left.
    double x = 0.0;
    double y = 0.0;
    SBBPopoverDirection finalDirection = preferredDirection;

    // Helper to calculate ideal centered X
    double getCenteredX() {
      double idealX = (triggerSize.width / 2) - (childSize.width / 2);
      final double globalIdealX = triggerGlobalPosition.dx + idealX;

      // Shifting algorithm (horizontal bounds check)
      if (globalIdealX < safeAreaInsets.left) {
        idealX += (safeAreaInsets.left - globalIdealX); // Shift right
      } else if (globalIdealX + childSize.width > screenSize.width - safeAreaInsets.right) {
        idealX -= (globalIdealX + childSize.width) - (screenSize.width - safeAreaInsets.right); // Shift left
      }
      return idealX;
    }

    // Flipping algorithm (vertical/horizontal bounds check)
    if (preferredDirection == SBBPopoverDirection.bottom) {
      if (triggerGlobalPosition.dy + triggerSize.height + childSize.height >
          screenSize.height - safeAreaInsets.bottom) {
        finalDirection = SBBPopoverDirection.top; // Flip top
      }
    } else if (preferredDirection == SBBPopoverDirection.top) {
      if (triggerGlobalPosition.dy - childSize.height < safeAreaInsets.top) {
        finalDirection = SBBPopoverDirection.bottom; // Flip bottom
      }
    }

    // Apply positioning based on calculated final direction
    if (finalDirection == SBBPopoverDirection.bottom) {
      x = getCenteredX();
      y = triggerSize.height; // Below trigger
    } else {
      x = getCenteredX();
      y = -childSize.height; // Above trigger
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newResult = SBBLayoutResult(direction: finalDirection);
      if (layoutState.value != newResult) {
        layoutState.value = newResult;
      }
    });

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(covariant SBBPopoverLayoutDelegate oldDelegate) {
    return oldDelegate.preferredDirection != preferredDirection ||
        oldDelegate.triggerGlobalPosition != triggerGlobalPosition ||
        oldDelegate.triggerSize != triggerSize ||
        oldDelegate.screenSize != screenSize ||
        oldDelegate.safeAreaInsets != safeAreaInsets;
  }
}
