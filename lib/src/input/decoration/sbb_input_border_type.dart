/// Defines if the input widget is standalone or listed/boxed to handle input border.
enum SBBInputBorderType {
  /// Default bottom border is handled by surrounding widgets like boxed variants or by [SBBDivider.divideItems].
  boxedOrListed,

  /// Default bottom border is handled by widget itself.
  standalone,
}
