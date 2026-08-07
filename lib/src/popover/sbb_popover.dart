import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/popover/render_sbb_popover.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_notch.dart';

// TODO: add title, titleText, leading, leadingIconData, trailing, trailingIconData showCloseButton (same as SBBBottomSheet)
// TODO: add barrierLabel
// TODO: add reservedPadding
// TODO: add targetAlignment and alignment
// TODO: check how everything works with keyboard
// TODO: add theming & styling
// TODO: docs & clean up
// TODO: check accessibility

class SBBPopover extends StatefulWidget {
  const SBBPopover({
    super.key,
    required this.targetBuilder,
    required this.builder,
    this.controller,
    this.preferredDirection = .bottom,
    this.isDismissible = true,
    this.showNotch = true,
    this.alignNotchToTarget = true,
    this.offset = Offset.zero,
  });

  /// Builds the widget the popover is anchored to. Always visible; the
  /// popover positions itself relative to the built widget's on-screen
  /// geometry.
  ///
  /// Calling `showPopover` shows the popover — equivalent to calling
  /// [SBBPopoverController.show] on [controller].
  final Widget Function(BuildContext context, VoidCallback showPopover) targetBuilder;

  /// Builds the content displayed inside the popover.
  ///
  /// Calling `hidePopover` hides the popover — equivalent to calling
  /// [SBBPopoverController.hide] on [controller].
  final Widget Function(BuildContext context, VoidCallback hidePopover) builder;

  /// An optional controller to programmatically show and hide the popover.
  ///
  /// If not provided, an internal controller is created automatically.
  final SBBPopoverController? controller;

  final SBBPopoverDirection preferredDirection;
  final bool isDismissible;

  /// Whether the decorative notch pointing at the target is drawn on the
  /// edge of the popover facing the target.
  final bool showNotch;

  /// Whether the notch shifts horizontally to stay pointed at the target's
  /// center when the popover box is shifted sideways to avoid a screen-edge
  /// collision. When false, the notch stays centered on the popover box.
  ///
  /// Only has an effect when [showNotch] is true.
  final bool alignNotchToTarget;

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

  SBBPopoverController? _internalController;

  SBBPopoverController get _effectiveController =>
      widget.controller ?? (_internalController ??= SBBPopoverController());

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
    _effectiveController.addListener(_handleControllerChange);
    if (_effectiveController.value) _syncControllerAfterFrame();
  }

  @override
  void didUpdateWidget(covariant SBBPopover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      (oldWidget.controller ?? _internalController)?.removeListener(_handleControllerChange);
      _effectiveController.addListener(_handleControllerChange);
      if (_effectiveController.value != _overlayController.isShowing) _syncControllerAfterFrame();
    }
  }

  void _handleControllerChange() {
    if (_effectiveController.value) {
      _showOverlay();
    } else {
      _hideOverlay();
    }
  }

  /// Applies the controller's value at the end of the current frame.
  ///
  /// Needed when the value has to be picked up during build (initState /
  /// didUpdateWidget): OverlayPortalController.show() asserts against being
  /// called mid-build, and the target's geometry is only valid once this
  /// frame's layout has run.
  void _syncControllerAfterFrame() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _handleControllerChange();
    });
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
    _effectiveController.removeListener(_handleControllerChange);
    _animationController.dispose();
    _internalController?.dispose();
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
              onTap: widget.isDismissible ? _effectiveController.hide : null,
              child: Container(color: SBBColors.iron.withAlpha((255.0 * 0.6).round())),
            ),
            FadeTransition(
              opacity: _opacityAnimation,
              child: SBBPopoverLayout(
                preferredDirection: widget.preferredDirection,
                targetPosition: _targetPosition,
                targetSize: _targetSize,
                notch: widget.showNotch
                    ? SBBPopoverNotch.single(alignWithTarget: widget.alignNotchToTarget)
                    : const SBBPopoverNotch.none(),
                color: Theme.of(context).sbbBaseStyle.themeValue(SBBColors.milk, SBBColors.midnight),
                offset: widget.offset,
                scaleAnimation: _scaleAnimation,
                child: Material(
                  type: MaterialType.transparency,
                  child: widget.builder(context, _effectiveController.hide),
                ),
              ),
            ),
          ],
        );
      },
      child: KeyedSubtree(key: _targetKey, child: widget.targetBuilder(context, _effectiveController.show)),
    );
  }
}
