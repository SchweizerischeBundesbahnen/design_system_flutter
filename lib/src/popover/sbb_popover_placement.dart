import 'package:flutter/widgets.dart';

/// The edge of the target an [SBBPopover] is placed on.
enum SBBPopoverEdge {
  top,
  bottom,
  left,
  right;

  /// The edge on the opposite side of the target — where the popover moves
  /// when a viewport collision flips it.
  SBBPopoverEdge get opposite => switch (this) {
    top => bottom,
    bottom => top,
    left => right,
    right => left,
  };

  /// The main layout axis for this edge: the axis along which the popover is
  /// pushed away from the target (and flipped on collision).
  Axis get mainAxis => switch (this) {
    top || bottom => .vertical,
    left || right => .horizontal,
  };
}

/// How an [SBBPopover] aligns with its target along the chosen edge.
///
/// This can be interpreted as the cross axis alignment.
enum SBBPopoverAlignment { start, center, end }

/// Where an [SBBPopover] is placed relative to its target: an edge (the main
/// axis, subject to flip-on-collision) plus a cross-axis alignment along that edge
/// (subject to clamping at the viewport edges).
///
/// This is the placement model used by Floating UI and Radix; see their live
/// demos of the collision behavior this component follows:
/// flipping (<https://floating-ui.com/docs/flip>) and edge shifting
/// (<https://floating-ui.com/docs/shift>).
///
/// Usually used through one of the 12 predefined constants:
///
/// ```dart
/// SBBPopover(placement: .bottomStart, ...)
/// ```
@immutable
class SBBPopoverPlacement {
  const SBBPopoverPlacement(this.edge, [this.crossAxisAlignment = .center]);

  /// The target edge the popover is placed on. This is a preference: a
  /// viewport collision can flip the popover to [SBBPopoverEdge.opposite].
  final SBBPopoverEdge edge;

  /// How the popover aligns with the target along [edge].
  final SBBPopoverAlignment crossAxisAlignment;

  static const top = SBBPopoverPlacement(.top);
  static const topStart = SBBPopoverPlacement(.top, .start);
  static const topEnd = SBBPopoverPlacement(.top, .end);
  static const bottom = SBBPopoverPlacement(.bottom);
  static const bottomStart = SBBPopoverPlacement(.bottom, .start);
  static const bottomEnd = SBBPopoverPlacement(.bottom, .end);
  static const left = SBBPopoverPlacement(.left);
  static const leftStart = SBBPopoverPlacement(.left, .start);
  static const leftEnd = SBBPopoverPlacement(.left, .end);
  static const right = SBBPopoverPlacement(.right);
  static const rightStart = SBBPopoverPlacement(.right, .start);
  static const rightEnd = SBBPopoverPlacement(.right, .end);

  /// The main layout axis, see [SBBPopoverEdge.mainAxis].
  Axis get mainAxis => edge.mainAxis;

  /// The same alignment on the opposite edge — the placement a viewport
  /// collision flips to.
  SBBPopoverPlacement get flipped => SBBPopoverPlacement(edge.opposite, crossAxisAlignment);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SBBPopoverPlacement && edge == other.edge && crossAxisAlignment == other.crossAxisAlignment);

  @override
  int get hashCode => Object.hash(edge, crossAxisAlignment);

  @override
  String toString() => 'SBBPopoverPlacement(${edge.name}, ${crossAxisAlignment.name})';
}
