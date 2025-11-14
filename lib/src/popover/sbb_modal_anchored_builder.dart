import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/popover/popover_shifted_positioned.dart';

import '../../sbb_design_system_mobile.dart';

final _fullPageBackgroundColor = SBBColors.iron.withAlpha((255.0 * 0.6).round());

/// SBBModalAnchoredBuilder. Used to build the effect of showing a full screen overlay anchored on a collapsed Widget.
///
/// This is typically used to show more content on tablet screen sizes in combination with [SBBPopover].
///
/// This widget has two states:
/// 1. "collapsed": a Widget, that can be interacted with to transition to the expanded state using the callback
/// 2. "overlay": an anchored overlay with a full screen modal barrier
///
/// Implemented using an [OverlayPortal] and a [CompositedTransformTarget]. Control the relative positioning of the
/// collapsed Widget and the Widget in the overlay with [targetAnchor], [followerAnchor] and [offset].
///
/// See also [SBBPopover].
class SBBModalAnchoredBuilder extends StatefulWidget {
  const SBBModalAnchoredBuilder({
    super.key,
    required this.collapsedBuilder,
    required this.overlayBuilder,
    this.openAnimationDuration = kThemeAnimationDuration,
    this.closeAnimationDuration = kThemeAnimationDuration,
    this.targetAnchor = Alignment.bottomCenter,
    this.followerAnchor = Alignment.topCenter,
    this.offset = const Offset(0, sbbDefaultSpacing / 2),
    this.barrierDismissable = true,
  });

  /// The builder that will display the collapsed widget.
  ///
  /// This is usually some form of a button.
  final Widget Function(BuildContext context, VoidCallback showOverlay) collapsedBuilder;

  /// The content to display in the overlay.
  ///
  /// Typically, a [SBBPopover] is used.
  final Widget Function(BuildContext context, VoidCallback closeOverlay) overlayBuilder;

  /// The duration of the opening animation.
  final Duration openAnimationDuration;

  /// The duration of the collapsing animation.
  final Duration closeAnimationDuration;

  /// Alignment of the collapsed anchor.
  ///
  /// This determines where the overlay will point to.
  ///
  /// Defaults to [Alignment.bottomCenter]
  final Alignment targetAnchor;

  /// Alignment of the overlay.
  ///
  /// This determines where the overlay Widget will be positioned relative to the collapsed Widget.
  ///
  /// Defaults to [Alignment.topCenter]
  final Alignment followerAnchor;

  /// Offset between the collapsed Widget and the overlay Widget.
  ///
  /// Defaults to [Offset(0, sbbDefaultSpacing / 2))]
  final Offset offset;

  /// Whether the modal barrier underneath the overlay is dismissable by user tap.
  ///
  /// Defaults to true.
  final bool barrierDismissable;

  @override
  State<SBBModalAnchoredBuilder> createState() => _SBBModalAnchoredBuilderState();
}

class _SBBModalAnchoredBuilderState extends State<SBBModalAnchoredBuilder> with SingleTickerProviderStateMixin {
  final _overlayController = OverlayPortalController();
  final _layerLink = LayerLink();
  GlobalKey key = GlobalKey();

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.openAnimationDuration,
      reverseDuration: widget.closeAnimationDuration,
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: OverlayPortal.overlayChildLayoutBuilder(
        controller: _overlayController,
        overlayChildBuilder: (context, info) {
          return Stack(
            children: [
              _fullscreenBarrier(),
              PopoverShiftedPositioned(overlayInfo: info, child: _animatedContent(context)),

              /// TODO: Two RenderObjects
              ///  * one above popover, one for the actual popover
              ///  * above does layout with information from OverlayChildLayoutBuilderInfo (info)
              ///  * above sets parentData (StackParentData) with position calculated from size of child and
              ///    screen dimensions
              ///  * above sets child position and anchor point (for notch painting) in parentData of child
              ///  * renderBox for popover clips path with notch at the anchor point and sizes itself as big as the popover wants (RenderProxyBox)
              ///
              ///  above should probably extend RenderShiftedBox and popover should extend RenderProxyBox
              // CompositedTransformFollower(
              //   link: _layerLink,
              //   offset: widget.offset,
              //   targetAnchor: widget.targetAnchor,
              //   followerAnchor: widget.followerAnchor,
              //   child: _animatedContent(context),
              // ),
            ],
          );
        },
        child: widget.collapsedBuilder(context, _showOverlay),
        // child: CompositedTransformTarget(
        //   link: _layerLink,
        //   child: widget.collapsedBuilder(context, _showOverlay),
        // ),
      ),
    );
  }

  GestureDetector _fullscreenBarrier() {
    return GestureDetector(
      onTap: widget.barrierDismissable ? () => _removeOverlay() : null,
      child: Container(color: _fullPageBackgroundColor),
    );
  }

  Future<void> _showOverlay() async {
    _overlayController.show();
    _animationController.forward();
  }

  Future<void> _removeOverlay() async {
    await _animationController.reverse();
    _overlayController.hide();
  }

  Widget _animatedContent(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: Colors.transparent,
              child: widget.overlayBuilder(context, _removeOverlay),
            ),
          ],
        ),
      ),
    );
  }
}
