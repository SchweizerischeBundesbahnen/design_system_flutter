/// Configures whether and where the decorative notch is drawn on an
/// [SBBPopover]'s content box.
///
/// Provide one of the concrete variants: [SBBPopoverNotch.none] to suppress
/// the notch entirely, [SBBPopoverNotch.single] (the default) for a single
/// notch that always sits on the edge facing the target, or
/// [SBBPopoverNotch.both] for notches on both the top and bottom edges at
/// once.
sealed class SBBPopoverNotch {
  const SBBPopoverNotch._();

  /// No notch is drawn.
  const factory SBBPopoverNotch.none() = SBBPopoverNotchNone;

  /// Exactly one notch, always on the edge currently facing the target.
  ///
  /// Flips automatically between the top and bottom edge together with the
  /// popover's resolved layout direction (e.g. when a screen-edge collision
  /// forces the popover to the opposite side of the target). The notch can
  /// be configured to be shifted to align with the target. This behavior is
  /// enabled by default.
  const factory SBBPopoverNotch.single({bool alignWithTarget}) = SBBPopoverNotchSingle;

  /// Notches on both the top and bottom edges simultaneously.
  ///
  /// Unlike [SBBPopoverNotch.single], this does not track the target's
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
  const SBBPopoverNotchSingle({this.alignWithTarget = true}) : super._();

  /// Whether the notch shifts horizontally to stay pointed at the target's
  /// center when the popover box itself is shifted sideways to avoid a
  /// screen-edge collision.
  ///
  /// When false, the notch stays centered on the popover box instead,
  /// regardless of where the target is.
  final bool alignWithTarget;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is SBBPopoverNotchSingle && alignWithTarget == other.alignWithTarget);

  @override
  int get hashCode => Object.hash(runtimeType, alignWithTarget);
}

/// See [SBBPopoverNotch.both].
class SBBPopoverNotchBoth extends SBBPopoverNotch {
  const SBBPopoverNotchBoth() : super._();
}
