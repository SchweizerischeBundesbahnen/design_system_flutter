import 'package:flutter/foundation.dart';

/// Controller for programmatically showing and hiding an [SBBPopover].
///
/// Provide an instance via [SBBPopover.controller]. If no controller is
/// provided, [SBBPopover] creates one internally.
class SBBPopoverController extends ValueNotifier<bool> {
  SBBPopoverController({bool initialValue = false}) : super(initialValue);

  /// Shows the popover with an animation.
  void show() => value = true;

  /// Hides the popover with an animation.
  void hide() => value = false;
}
