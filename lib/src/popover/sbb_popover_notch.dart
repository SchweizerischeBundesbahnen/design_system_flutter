/// Configures whether and where the decorative notch (the small triangular
/// tail pointing at the trigger) is drawn on an [SBBPopover]'s content box.
///
/// Provide one of the concrete variants: [SBBPopoverNotch.none] to suppress
/// the notch entirely, [SBBPopoverNotch.single] (the default) for a single
/// notch that always sits on the edge facing the trigger, or
/// [SBBPopoverNotch.both] for notches on both the top and bottom edges at
/// once.
sealed class SBBPopoverNotch {
  const SBBPopoverNotch._();

  /// No notch is drawn.
  const factory SBBPopoverNotch.none() = SBBPopoverNotchNone;

  /// Exactly one notch, always on the edge currently facing the trigger.
  ///
  /// Flips automatically between the top and bottom edge together with the
  /// popover's resolved layout direction (e.g. when a screen-edge collision
  /// forces the popover to the opposite side of the trigger). This is the
  /// default.
  const factory SBBPopoverNotch.single() = SBBPopoverNotchSingle;

  /// Notches on both the top and bottom edges simultaneously.
  ///
  /// Unlike [SBBPopoverNotch.single], this does not track the trigger's
  /// position — both notches are always drawn, regardless of which edge
  /// the popover's resolved layout direction faces.
  const factory SBBPopoverNotch.both() = SBBPopoverNotchBoth;

  @override
  bool operator ==(Object other) => identical(this, other) || runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// See [SBBPopoverNotch.none].
class SBBPopoverNotchNone extends SBBPopoverNotch {
  const SBBPopoverNotchNone() : super._();
}

/// See [SBBPopoverNotch.single].
class SBBPopoverNotchSingle extends SBBPopoverNotch {
  const SBBPopoverNotchSingle() : super._();
}

/// See [SBBPopoverNotch.both].
class SBBPopoverNotchBoth extends SBBPopoverNotch {
  const SBBPopoverNotchBoth() : super._();
}
