import 'package:flutter/foundation.dart';

/// Controller for programmatically showing and hiding a [SBBPromotionBox].
///
/// Provide an instance via [SBBPromotionBox.controller]. If no controller is
/// provided, [SBBPromotionBox] creates one internally.
class SBBPromotionBoxController({bool initialValue = true}) extends ValueNotifier<bool> {
  this : super(initialValue);

  /// Shows the promotion box with an animation.
  void show() => value = true;

  /// Hides the promotion box with an animation.
  void hide() => value = false;
}
