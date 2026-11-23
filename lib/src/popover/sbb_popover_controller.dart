import 'package:flutter/foundation.dart';

/// Controller for programmatically showing and hiding an [SBBPopover].
///
/// Provide an instance via [SBBPopover.controller]. If no controller is
/// provided, [SBBPopover] creates one internally.
class SBBPopoverController({bool initialValue = false}) extends ValueNotifier<bool> {
  this : super(initialValue);

  /// Shows the popover with an animation.
  void show() => value = true;

  /// Hides the popover with an animation.
  void hide() => value = false;
}
