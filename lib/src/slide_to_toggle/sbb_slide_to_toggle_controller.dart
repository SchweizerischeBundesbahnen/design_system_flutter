import 'package:flutter/foundation.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Controller for programmatically changing the state of [SBBSlideToToggleState].
///
/// Provide an instance via [SBBSlideToToggle.controller]. If no controller is
/// provided, [SBBSlideToToggle] creates one internally.
class SBBSlideToToggleController extends ValueNotifier<SBBSlideToToggleState> {
  SBBSlideToToggleController({SBBSlideToToggleState initialValue = .off}) : super(initialValue);

  /// Changes the state to [state] with an bounce animation.
  void changeTo({required SBBSlideToToggleState state}) => value = state;
}
