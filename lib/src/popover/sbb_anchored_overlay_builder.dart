import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_scope.dart';

// TODO: make notch configurable in SBBPopover
// TODO: clean up layout delegate / simplify with custom SingleChildRenderObject
// TODO: add theming & styling
// TODO: offset inversion with preferred direction / move offset further down and do not handle in composition
// TODO: check safeAreaInsets & keyboard functionality
// TODO: docs & clean up
// TODO: check accessibility

class SBBAnchoredOverlayBuilder extends StatefulWidget {
  const SBBAnchoredOverlayBuilder({
    super.key,
    required this.targetBuilder,
    required this.followerBuilder,
    this.preferredDirection = .bottom,
    this.safeAreaInsets = EdgeInsets.zero,
    this.isDismissible = true,
    this.offset = Offset.zero,
  });

  final Widget Function(BuildContext context, VoidCallback showOverlay) targetBuilder;
  final Widget Function(BuildContext context, VoidCallback hideOverlay) followerBuilder;
  final SBBPopoverDirection preferredDirection;
  final EdgeInsets safeAreaInsets;
  final bool isDismissible;
  final Offset offset;

  @override
  State<SBBAnchoredOverlayBuilder> createState() => _SBBAnchoredOverlayBuilderState();
}

class _SBBAnchoredOverlayBuilderState extends State<SBBAnchoredOverlayBuilder> with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _triggerKey = GlobalKey();

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  final OverlayPortalController _overlayController = OverlayPortalController();

  Offset _triggerGlobalPosition = Offset.zero;
  Size _triggerSize = Size.zero;

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
    if (!_overlayController.isShowing) {
      final renderBox = _triggerKey.currentContext?.findRenderObject() as RenderBox?;
      _triggerGlobalPosition = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
      _triggerSize = renderBox?.size ?? Size.zero;
      _overlayController.show();
      _animationController.forward();
    }
  }

  Future<void> _hideOverlay() async {
    if (_overlayController.isShowing) {
      await _animationController.reverse();
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
        return SBBPopoverScope(
          triggerGlobalPosition: _triggerGlobalPosition,
          triggerSize: _triggerSize,
          preferredDirection: widget.preferredDirection,
          safeAreaInsets: widget.safeAreaInsets,
          child: Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: widget.isDismissible ? _hideOverlay : null,
                child: Container(color: SBBColors.iron.withAlpha((255.0 * 0.6).round())),
              ),
              FadeTransition(
                opacity: _opacityAnimation,
                child: ScaleTransition(
                  alignment: .topCenter,
                  scale: _scaleAnimation,
                  child: widget.followerBuilder(context, _hideOverlay),
                ),
              ),
            ],
          ),
        );
      },
      child: KeyedSubtree(key: _triggerKey, child: widget.targetBuilder(context, _showOverlay)),
    );
  }
}
