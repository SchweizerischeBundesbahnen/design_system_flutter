import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/popover/render_sbb_popover.dart';

// TODO: add controller for programmatic show / hide (post frame callback!)
// TODO: change targetBuilder and builder to Widget and rename to child and target
// TODO: change notch to bool
// TODO: add title, titleText, leading, leadingIconData, trailing, trailingIconData showCloseButton (same as SBBBottomSheet)
// TODO: add barrierLabel
// TODO: add reservedPadding
// TODO: check how everything works with keyboard
// TODO: add theming & styling
// TODO: docs & clean up
// TODO: check accessibility
//
// ---- RENDERING ----
//
// TODO: fix stale assert message in SBBPopoverScope ('SBBAnchoredOverlayBuilder'
//  does not exist) and decide what the scope is actually for — it duplicates
//  data the layout already receives via constructor.
//
// TODO: override computeDryLayout / intrinsics on RenderSBBPopover. Harmless
//  today (it always fills the overlay) but will surprise anyone wrapping it.

class SBBPopover extends StatefulWidget {
  const SBBPopover({
    super.key,
    required this.targetBuilder,
    required this.builder,
    this.preferredDirection = .bottom,
    this.isDismissible = true,
    this.notch = const .single(),
    this.offset = Offset.zero,
  });

  final Widget Function(BuildContext context, VoidCallback showOverlay) targetBuilder;
  final Widget Function(BuildContext context, VoidCallback hideOverlay) builder;
  final SBBPopoverDirection preferredDirection;
  final bool isDismissible;
  final SBBPopoverNotch notch;

  /// Absolute offset between the target and the popover box.
  ///
  /// The y component is defined relative to whichever edge ends up facing
  /// the target: a positive value always pushes the box further away from
  /// the target, so it's automatically inverted when a screen-edge
  /// collision flips the resolved direction. The x component is applied
  /// as-is and composes with any horizontal shift from edge clamping.
  final Offset offset;

  @override
  State<SBBPopover> createState() => _SBBPopoverState();
}

class _SBBPopoverState extends State<SBBPopover> with SingleTickerProviderStateMixin {
  final GlobalKey _targetKey = GlobalKey();

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  final OverlayPortalController _overlayController = OverlayPortalController();

  /// The target's top-left corner in the enclosing [Overlay]'s coordinate
  /// space, captured when the popover is shown.
  Offset _targetPosition = Offset.zero;
  Size _targetSize = Size.zero;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCubicEmphasized));
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCubicEmphasized));
  }

  void _showOverlay() {
    final renderBox = _targetKey.currentContext?.findRenderObject() as RenderBox?;
    // Use renderBox overlay as ancestor for multiple navigator positioning
    final RenderObject? overlay = Overlay.of(context).context.findRenderObject();
    _targetPosition = renderBox?.localToGlobal(Offset.zero, ancestor: overlay) ?? Offset.zero;
    _targetSize = renderBox?.size ?? Size.zero;
    if (!_overlayController.isShowing) {
      _overlayController.show();
    }
    _animationController.forward();
  }

  Future<void> _hideOverlay() async {
    if (!_overlayController.isShowing) return;
    await _animationController.reverse();
    if (!mounted) return;
    if (_overlayController.isShowing) {
      _overlayController.hide();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _overlayController,
      overlayChildBuilder: (BuildContext context) {
        return Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: widget.isDismissible ? _hideOverlay : null,
              child: Container(color: SBBColors.iron.withAlpha((255.0 * 0.6).round())),
            ),
            FadeTransition(
              opacity: _opacityAnimation,
              child: SBBPopoverLayout(
                preferredDirection: widget.preferredDirection,
                targetPosition: _targetPosition,
                targetSize: _targetSize,
                notch: widget.notch,
                color: Theme.of(context).sbbBaseStyle.themeValue(SBBColors.milk, SBBColors.midnight),
                offset: widget.offset,
                scaleAnimation: _scaleAnimation,
                child: Material(
                  type: MaterialType.transparency,
                  child: widget.builder(context, _hideOverlay),
                ),
              ),
            ),
          ],
        );
      },
      child: KeyedSubtree(key: _targetKey, child: widget.targetBuilder(context, _showOverlay)),
    );
  }
}
