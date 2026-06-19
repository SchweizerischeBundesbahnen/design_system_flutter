/// Defines the behavior of the floating label in SBB input fields.
enum SBBFloatingLabelBehavior {
  /// The label floats automatically based on focus and content state.
  /// When the field is empty and unfocused, the label is centered.
  /// When the field has content or is focused, the label floats to the top.
  auto,

  /// The label always floats at the top, regardless of focus or content state.
  /// The placeholder will always be shown if input is not empty.
  always,
}
