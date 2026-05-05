import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Controller for programmatically showing and hiding a [SBBPromotionBox].
///
/// Provide an instance via [SBBPromotionBox.controller]. If no controller is
/// provided, [SBBPromotionBox] creates one internally.
class SBBPromotionBoxController extends ValueNotifier<bool> {
  SBBPromotionBoxController({bool initialValue = true}) : super(initialValue);

  /// Shows the promotion box with an animation.
  void show() async => value = true;

  /// Hides the promotion box with an animation.
  void hide() => value = false;
}
