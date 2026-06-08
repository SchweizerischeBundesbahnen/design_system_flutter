/// Defines the mode when [SBBSlideToToggle] triggers the toggle callback.
enum SBBSlideToToggleTriggerMode {
  /// Triggers automatically when [SBBSlideToToggle.threshold] is reached.
  onThresholdReached,

  /// Triggers when the user is over the [SBBSlideToToggle.threshold] and releases the toggle.
  onTapReleased,
}
