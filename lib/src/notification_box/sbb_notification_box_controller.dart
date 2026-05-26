import 'package:flutter/foundation.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Controller for programmatically showing and hiding a [SBBNotificationBox].
///
/// Provide an instance via [SBBNotificationBox.controller]. If no controller is
/// provided, [SBBNotificationBox] creates one internally.
class SBBNotificationBoxController extends ValueNotifier<bool> {
  SBBNotificationBoxController({bool initialValue = true}) : super(initialValue);

  /// Shows the notification box with an animation.
  void show() => value = true;

  /// Hides the notification box with an animation.
  void hide() => value = false;
}
