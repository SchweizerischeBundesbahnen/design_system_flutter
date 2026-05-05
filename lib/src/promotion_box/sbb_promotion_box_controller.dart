import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Controller for programmatically showing and hiding a [SBBPromotionBox].
///
/// Provide an instance via [SBBPromotionBox.controller]. If no controller is
/// provided, [SBBPromotionBox] creates one internally.
class SBBPromotionBoxController {
  AnimationController? _animationController;

  /// The animation driven by this controller.
  ///
  /// Only available after the controller has been attached to an [SBBPromotionBox].
  Animation<double> get animation {
    assert(_animationController != null, 'SBBPromotionBoxController is not attached to any SBBPromotionBox.');
    return _animationController!;
  }

  /// Attaches this controller to a [TickerProvider]. Called internally by [SBBPromotionBox].
  @internal
  void attach(TickerProvider vsync) {
    _animationController?.dispose();
    _animationController = AnimationController(vsync: vsync, value: 1.0, duration: kThemeAnimationDuration);
  }

  /// Disposes the underlying [AnimationController]. Called internally by [SBBPromotionBox].
  @internal
  void detach() {
    _animationController?.dispose();
    _animationController = null;
  }

  /// Shows the promotion box with an animation.
  Future<void> show() {
    assert(_animationController != null, 'SBBPromotionBoxController is not attached to any SBBPromotionBox.');
    return _animationController!.animateTo(1.0);
  }

  /// Hides the promotion box with an animation.
  Future<void> hide() {
    assert(_animationController != null, 'SBBPromotionBoxController is not attached to any SBBPromotionBox.');
    return _animationController!.animateTo(0.0);
  }
}
