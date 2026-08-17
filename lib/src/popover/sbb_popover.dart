import 'dart:math' as math;
import 'dart:ui' show FlutterView;

import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/popover/render_sbb_popover.dart';
import 'package:sbb_design_system_mobile/src/shared/utils.dart';

/// A popover anchored to a target widget, displayed in the enclosing
/// [Overlay] above a modal barrier.
///
/// This should be used primarily in tablet screen contexts when using a
/// [SBBBottomSheet] is undesirable.
///
/// The popover positions itself on the [placement]'s edge of the target and
/// handles viewport collisions the same way Floating UI does: if the popover
/// doesn't fit on the preferred edge (and the opposite side offers more
/// room), it flips to the other side (<https://floating-ui.com/docs/flip>);
/// along the edge it shifts as far as needed to stay inside the viewport
/// (<https://floating-ui.com/docs/shift>), with the notch shifting toward
/// the target if the center of the popover ends up beside it.
///
/// The popover is shown via the `showPopover` callback passed to
/// [targetBuilder], or programmatically through a [controller]. It is
/// dismissed by tapping the barrier or the close button
/// (only if [isDismissible] allows), or through the controller.
///
/// While open, the popover keeps clear of the safe area and the on-screen
/// keyboard — re-anchoring to the target when a keyboard-driven resize
/// (e.g. a Scaffold avoiding the keyboard) moves it — and hides itself when
/// the screen geometry changes (rotation, window resize) since its captured
/// target position would be stale.
///
/// See also:
/// * [SBBBottomSheet] for displaying content in mobile screen contexts
/// * [SBBPopoverStyle], the style used to change the appearance of this
/// * [SBBPopoverThemeData], for setting the [SBBPopoverStyle] for all popovers within the current Theme
class SBBPopover extends StatefulWidget {
  const SBBPopover({
    super.key,
    required this.targetBuilder,
    required this.builder,
    this.controller,
    this.title,
    this.titleText,
    this.leading,
    this.leadingIconData,
    this.trailing,
    this.trailingIconData,
    this.showCloseButton = true,
    this.placement = .bottom,
    this.isDismissible = true,
    this.barrierLabel,
    this.showNotch = true,
    this.alignNotchToTarget = true,
    this.offset = Offset.zero,
    this.viewportMargin = const .all(SBBSpacing.xSmall),
    this.style,
  }) : assert(title == null || titleText == null, 'Only title or titleText can be set!'),
       assert(leading == null || leadingIconData == null, 'Only leading or leadingIconData can be set!'),
       assert(trailing == null || trailingIconData == null, 'Only trailing or trailingIconData can be set!');

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

  /// A custom widget displayed as the popover's title.
  ///
  /// For simple text titles, use [titleText] instead.
  ///
  /// Cannot be used together with [titleText].
  final Widget? title;

  /// Text string to display as the popover's title.
  ///
  /// Cannot be used together with [title].
  final String? titleText;

  /// A custom widget displayed at the leading edge of the header.
  ///
  /// For icon-only leading content, use [leadingIconData] instead.
  ///
  /// Cannot be used together with [leadingIconData].
  final Widget? leading;

  /// Icon data for an icon displayed at the leading edge of the header.
  ///
  /// Cannot be used together with [leading].
  final IconData? leadingIconData;

  /// A custom widget displayed at the trailing edge of the header.
  ///
  /// For icon-only trailing content, use [trailingIconData] instead.
  ///
  /// Cannot be used together with [trailingIconData].
  final Widget? trailing;

  /// Icon data for an icon displayed at the trailing edge of the header.
  ///
  /// Cannot be used together with [trailing].
  final IconData? trailingIconData;

  /// Whether to show a close button in the header that hides the popover.
  ///
  /// Only shown if [isDismissible] is also true.
  ///
  /// Defaults to true.
  final bool showCloseButton;

  /// The preferred placement of the popover relative to the target: an edge
  /// plus an alignment along that edge, e.g. [SBBPopoverPlacement.bottomStart].
  ///
  /// The edge is a preference — when the popover doesn't fit there and the
  /// opposite side of the target offers more room, it flips
  /// (<https://floating-ui.com/docs/flip> demonstrates the behavior live).
  /// The alignment is kept as well as possible: the popover shifts along the
  /// edge only as far as viewport collisions require
  /// (<https://floating-ui.com/docs/shift>).
  ///
  /// Defaults to [SBBPopoverPlacement.bottom].
  final SBBPopoverPlacement placement;

  /// Whether the popover can be dismissed by the user — by tapping the
  /// barrier or through the close button.
  ///
  /// Defaults to true.
  final bool isDismissible;

  /// The semantic label announced by screen readers for the barrier behind
  /// the popover (read when the barrier receives accessibility focus, with
  /// a tap dismissing the popover if [isDismissible] is true).
  ///
  /// If null, defaults to [MaterialLocalizations.modalBarrierDismissLabel].
  final String? barrierLabel;

  /// Whether the decorative notch pointing at the target is drawn on the
  /// edge of the popover facing the target.
  final bool showNotch;

  /// Whether the notch shifts along its edge to stay pointed at the target
  /// when the popover center ends up beside the target rect. As long as the
  /// center stays within the target extent, the notch will not shift.
  ///
  /// When false, the notch always stays centered on the popover.
  ///
  /// Only has an effect when [showNotch] is true.
  final bool alignNotchToTarget;

  /// Nudges the popover away from its default position, in logical pixels.
  ///
  /// [Offset.dy] is the main-axis gap between the target and the popover:
  /// a positive value always pushes the popover further away from the
  /// target, on whichever edge it ends up — so it's automatically inverted
  /// when a viewport collision flips the resolved edge.
  ///
  /// [Offset.dx] is the cross-axis nudge along the aligned edge, applied on
  /// top of [placement]'s alignment. Composes with any shift from viewport
  /// clamping. Positive values move toward the cross axis's end: to the
  /// right for top/bottom placements, downward for left/right ones.
  final Offset offset;

  /// Minimum empty space to keep between the popover and the enclosing
  /// viewport's edges, so the popover never sits flush against them.
  ///
  /// Edge clamping (and the per-side space budgets driving the flip
  /// decision) treat the viewport shrunk by this margin as the usable area.
  /// Where the safe area or the on-screen keyboard inset an edge further
  /// than this margin, the larger of the two applies.
  ///
  /// Defaults to [SBBSpacing.xSmall] on all sides.
  final EdgeInsets viewportMargin;

  /// Per-instance style overrides.
  ///
  /// Non-null properties override the ambient [SBBPopoverThemeData.style].
  final SBBPopoverStyle? style;

  @override
  State<SBBPopover> createState() => _SBBPopoverState();
}

class _SBBPopoverState extends State<SBBPopover> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
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
  Offset _targetPosition = .zero;
  Size _targetSize = .zero;

  /// The view (and its size) the popover was shown in — when the view's size
  /// changes while the popover is open (rotation, window resize), the
  /// captured target geometry is stale and the popover dismisses itself.
  FlutterView? _viewAtShow;
  Size _viewSizeAtShow = .zero;

  /// The node focused before the popover opened; focus returns to it when
  /// the popover closes.
  FocusNode? _previousFocus;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
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

  @override
  void didChangeMetrics() {
    final view = _viewAtShow;
    if (view == null || !_overlayController.isShowing) return;
    if (view.physicalSize != _viewSizeAtShow) {
      _effectiveController.hide();
      return;
    }
    _scheduleReanchor();
  }

  bool _reanchorScheduled = false;

  void _scheduleReanchor() {
    if (_reanchorScheduled) return;
    _reanchorScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _reanchorScheduled = false;
      if (!mounted || !_overlayController.isShowing) return;
      setState(_captureTargetGeometry);
    });
  }

  /// Captures the target's geometry in the enclosing [Overlay]'s coordinate
  /// space. Keeps the previous values if the target has no laid-out render
  /// box right now.
  void _captureTargetGeometry() {
    final renderBox = _targetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.attached || !renderBox.hasSize) return;
    // Use renderBox overlay as ancestor for multiple navigator positioning
    final RenderObject? overlay = Overlay.of(context).context.findRenderObject();
    _targetPosition = renderBox.localToGlobal(.zero, ancestor: overlay);
    _targetSize = renderBox.size;
  }

  void _handleControllerChange() => _effectiveController.value ? _showOverlay() : _hideOverlay();

  void _syncControllerAfterFrame() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _handleControllerChange();
    });
  }

  void _showOverlay() {
    _captureTargetGeometry();
    final view = View.of(context);
    _viewAtShow = view;
    _viewSizeAtShow = view.physicalSize;
    _previousFocus = FocusManager.instance.primaryFocus;
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
    _restorePreviousFocus();
  }

  void _restorePreviousFocus() {
    final previousFocus = _previousFocus;
    _previousFocus = null;
    if (previousFocus != null && previousFocus.context?.mounted == true && previousFocus.canRequestFocus) {
      previousFocus.requestFocus();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _effectiveController.removeListener(_handleControllerChange);
    _animationController.dispose();
    _internalController?.dispose();
    super.dispose();
  }

  /// Assembles the popover content: an optional header row (mirroring
  /// [SBBBottomSheet]'s contract) above the [SBBPopover.builder] body.
  Widget _buildContent(BuildContext context, SBBPopoverStyle style) {
    final EdgeInsets padding = style.padding ?? .zero;

    final body = widget.builder(context, _effectiveController.hide);

    final titleWidget = addDefaultAncestorWithResolved(
      child: widget.title ?? (widget.titleText != null ? Text(widget.titleText!) : null),
      foregroundColor: style.titleForegroundColor,
      textStyle: style.titleTextStyle,
    );
    final leadingWidget = addDefaultAncestorWithResolved(
      child: widget.leading ?? (widget.leadingIconData != null ? Icon(widget.leadingIconData) : null),
      foregroundColor: style.leadingForegroundColor,
      textStyle: style.leadingTextStyle,
    );
    final trailingWidget = addDefaultAncestorWithResolved(
      child: widget.trailing ?? (widget.trailingIconData != null ? Icon(widget.trailingIconData) : null),
      foregroundColor: style.trailingForegroundColor,
      textStyle: style.trailingTextStyle,
    );
    final closeButton = widget.isDismissible && widget.showCloseButton ? _closeButton(context) : null;

    final hasHeader = titleWidget != null || leadingWidget != null || trailingWidget != null || closeButton != null;
    if (!hasHeader) return Padding(padding: padding, child: body);

    // Adjust for the close button, same as SBBBottomSheet.
    final titlePadding = padding.copyWith(right: closeButton != null ? SBBSpacing.xSmall : padding.right, bottom: 0);
    final bodyPadding = padding.copyWith(top: SBBSpacing.small);

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: titlePadding,
          child: _PopoverHeaderRow(
            title: titleWidget,
            leading: leadingWidget,
            trailing: trailingWidget,
            closeButton: closeButton,
          ),
        ),
        Flexible(
          child: Padding(padding: bodyPadding, child: body),
        ),
      ],
    );
  }

  Widget _closeButton(BuildContext context) => Semantics(
    label: MaterialLocalizations.of(context).closeButtonTooltip,
    excludeSemantics: true,
    button: true,
    child: SBBTertiaryButtonSmall(
      onPressed: _effectiveController.hide,
      iconData: SBBIcons.cross_small,
    ),
  );

  /// The usable-viewport margin: the configured [SBBPopover.viewportMargin],
  /// widened per edge wherever the safe area or the on-screen keyboard
  /// insets further (max per edge, so the two never stack up).
  ///
  /// Insets are read from the raw [FlutterView] instead of the inherited
  /// [MediaQuery]: an ancestor may have consumed them before they reach this
  /// subtree — most notably a Scaffold with `resizeToAvoidBottomInset`
  /// removes the keyboard's bottom inset for its body — but the popover lays
  /// out in the enclosing full-view [Overlay], which the keyboard still
  /// overlaps. Rebuilds on inset changes are driven by [didChangeMetrics].
  EdgeInsets _effectiveViewportMargin(BuildContext context) {
    final view = View.of(context);
    final padding = EdgeInsets.fromViewPadding(view.padding, view.devicePixelRatio);
    final viewInsets = EdgeInsets.fromViewPadding(view.viewInsets, view.devicePixelRatio);
    final margin = widget.viewportMargin;
    return EdgeInsets.fromLTRB(
      math.max(margin.left, math.max(padding.left, viewInsets.left)),
      math.max(margin.top, math.max(padding.top, viewInsets.top)),
      math.max(margin.right, math.max(padding.right, viewInsets.right)),
      math.max(margin.bottom, math.max(padding.bottom, viewInsets.bottom)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _overlayController,
      overlayChildBuilder: (BuildContext context) {
        final style = Theme.of(context).sbbPopoverTheme.style!.merge(widget.style);
        return Stack(
          children: [
            FadeTransition(
              opacity: _opacityAnimation,
              child: ModalBarrier(
                color: style.barrierColor,
                dismissible: widget.isDismissible,
                semanticsLabel: widget.barrierLabel ?? MaterialLocalizations.of(context).modalBarrierDismissLabel,
                onDismiss: _effectiveController.hide,
              ),
            ),
            FadeTransition(
              opacity: _opacityAnimation,
              child: SBBPopoverLayout(
                placement: widget.placement,
                targetPosition: _targetPosition,
                targetSize: _targetSize,
                showNotch: widget.showNotch,
                alignNotchToTarget: widget.alignNotchToTarget,
                color: style.backgroundColor ?? SBBColors.milk,
                popoverConstraints: style.constraints ?? const BoxConstraints(),
                sideOffset: widget.offset.dy,
                alignmentOffset: widget.offset.dx,
                viewportMargin: _effectiveViewportMargin(context),
                // scale animation is passed down to scale around anchor
                scaleAnimation: _scaleAnimation,
                child: Material(
                  type: .transparency,
                  child: _buildContent(context, style),
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

/// The popover's header row. Mirrors SBBBottomSheet's layout contract:
/// [leading] - [title] (expanded) - [trailing] - [closeButton], with
/// single-child fallbacks aligning trailing content to the right.
class _PopoverHeaderRow extends StatelessWidget {
  const _PopoverHeaderRow({
    this.title,
    this.leading,
    this.trailing,
    this.closeButton,
  });

  final Widget? title;
  final Widget? leading;
  final Widget? trailing;
  final Widget? closeButton;

  @override
  Widget build(BuildContext context) {
    final nonNullChildren = [title, leading, trailing, closeButton].nonNulls.toList(growable: false);

    if (nonNullChildren.isEmpty) return const SizedBox.shrink();

    final Widget child;
    if (nonNullChildren.length > 1) {
      child = Row(
        spacing: SBBSpacing.xSmall,
        children: [
          ?leading,
          if (title != null) Expanded(child: title!) else Spacer(),
          ?trailing,
          ?closeButton,
        ],
      );
    } else if (closeButton != null || trailing != null) {
      child = Align(alignment: .centerRight, child: closeButton ?? trailing);
    } else {
      child = nonNullChildren.first;
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: SBBSpacing.xLarge),
      child: child,
    );
  }
}
