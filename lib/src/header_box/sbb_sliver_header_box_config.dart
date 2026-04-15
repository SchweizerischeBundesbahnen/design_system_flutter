import 'package:flutter/material.dart';

/// Defines how the flap attached to a sliver header box behaves during scroll.
///
/// * [static] keeps the flap visible without changing its size.
/// * [resizable] lets the flap participate in the resize motion.
/// * [hideable] allows the flap to be hidden during contraction, i.e. slide under the header box.
enum SBBHeaderBoxFlapMode { static, resizable, hideable }

/// A config for the sliver-specific behavior of [SBBSliverHeaderBox].
@immutable
class SBBSliverHeaderBoxConfig {
  const SBBSliverHeaderBoxConfig({
    this.floating = true,
    this.resizing = true,
    this.snapMode = .scroll,
    this.snapStyle = const AnimationStyle(
      duration: Durations.short2,
      curve: Curves.linear,
      reverseDuration: Durations.short2,
      reverseCurve: Curves.linear,
    ),
    this.flapMode = .static,
  });

  /// Whether this header box should float into view when the user scrolls up.
  ///
  /// When true, the header expands immediately during upward scrolling
  /// instead of waiting until the scroll position returns to the top.
  ///
  /// This only matters when [floating] is true.
  ///
  /// Defaults to true.
  final bool floating;

  /// Whether this header box should resize while scrolling.
  ///
  /// When enabled, contractible content such as [SBBContractible] children can
  /// expand and contract between the header box's maximum and minimum heights.
  ///
  /// Defaults to true.
  final bool resizing;

  /// Controls how the header box snaps between expanded and contracted states.
  ///
  /// For example, snapping can either affect the scroll position or animate the
  /// header box independently depending on the selected mode.
  ///
  /// Defaults to [FloatingHeaderSnapMode.scroll].
  final FloatingHeaderSnapMode snapMode;

  /// Controls the animation used when the header box snaps to its expanded or
  /// contracted state.
  final AnimationStyle snapStyle;

  /// Defines how the flap behaves while the sliver header box resizes.
  ///
  /// Defaults to [SBBHeaderBoxFlapMode.static].
  final SBBHeaderBoxFlapMode flapMode;
}
