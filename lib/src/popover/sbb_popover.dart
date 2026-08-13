import 'dart:math' as math;
import 'dart:ui' show FlutterView;

import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/popover/render_sbb_popover.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_notch.dart';
import 'package:sbb_design_system_mobile/src/shared/utils.dart';

// Deferred follow-ups (not v1, see tasks/plan.md "Phase 3"):
// - Focus trap: Tab/Shift-Tab can still traverse onto the (barrier-obscured)
//   page behind the popover.
// - Screen-reader routing: VoiceOver/TalkBack focus doesn't jump into the
//   popover on open (no route semantics yet).

/// A popover anchored to a target widget, displayed in the enclosing
/// [Overlay] above a modal barrier.
///
/// The popover positions itself on the [placement]'s edge of the target and
/// handles viewport collisions the same way Floating UI does: if the box
/// doesn't fit on the preferred edge (and the opposite side offers more
/// room), it flips to the other side (<https://floating-ui.com/docs/flip>);
/// along the edge it shifts as far as needed to stay inside the viewport
/// (<https://floating-ui.com/docs/shift>), with the notch continuing to
/// point at the target.
///
/// The popover is shown via the `showPopover` callback passed to
/// [targetBuilder], or programmatically through a [controller]. It is
/// dismissed by tapping the barrier or the close button, pressing Escape
/// (all only if [isDismissible] allows), or through the controller.
///
/// While open, the popover keeps clear of the safe area and the on-screen
/// keyboard — re-anchoring to the target when a keyboard-driven resize
/// (e.g. a Scaffold avoiding the keyboard) moves it — and hides itself when
/// the screen geometry changes (rotation, window resize) since its captured
/// target position would be stale.
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
  /// barrier, pressing Escape, or through the close button.
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

  /// Whether the notch shifts along its edge to stay pointed at the target's
  /// center when the popover box is shifted to avoid a viewport-edge
  /// collision. When false, the notch stays centered on the popover box.
  ///
  /// Only has an effect when [showNotch] is true.
  final bool alignNotchToTarget;

  /// Nudges the popover away from its default position, in logical pixels.
  ///
  /// [Offset.dy] is the main-axis gap between the target and the popover
  /// box: a positive value always pushes the box further away from the
  /// target, on whichever edge it ends up — so it's automatically inverted
  /// when a viewport collision flips the resolved edge.
  ///
  /// [Offset.dx] is the cross-axis nudge along the aligned edge, applied on
  /// top of [placement]'s alignment. Composes with any shift from viewport
  /// clamping. Positive values move toward the cross axis's end: to the
  /// right for top/bottom placements, downward for left/right ones.
  final Offset offset;

  /// Minimum empty space to keep between the popover box and the enclosing
  /// viewport's edges, so the box never sits flush against them.
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
  Offset _targetPosition = Offset.zero;
  Size _targetSize = Size.zero;

  /// The view (and its size) the popover was shown in — when the view's size
  /// changes while the popover is open (rotation, window resize), the
  /// captured target geometry is stale and the popover dismisses itself.
  FlutterView? _viewAtShow;
  Size _viewSizeAtShow = Size.zero;

  /// The node focused before the popover opened; focus returns to it when
  /// the popover closes.
  FocusNode? _previousFocus;

  /// Takes focus when the popover opens, so hardware-keyboard events (e.g.
  /// Escape) land inside the popover instead of on the page behind it.
  /// Requested explicitly rather than via autofocus — autofocus only takes
  /// effect while nothing else holds focus, which is rarely the case when a
  /// popover opens from an interactive page.
  final FocusNode _popoverFocusNode = FocusNode(debugLabel: 'SBBPopover');

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

  // Dismiss on rotation/window resize: the target geometry captured at
  // show-time is stale the moment the view's size changes, and a popover
  // floating at a stale position is worse than a closed one (same behavior
  // as Material menus). Keyboard appearance changes viewInsets, not the
  // view's size, so typing inside the popover doesn't dismiss it — instead
  // the popover re-anchors: a resizing ancestor (e.g. a Scaffold avoiding
  // the keyboard) may move the target during the upcoming frame, so its
  // geometry is re-captured once that frame's layout has run, and the
  // rebuild picks up the new insets in [_effectiveViewportMargin].
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
    _targetPosition = renderBox.localToGlobal(Offset.zero, ancestor: overlay);
    _targetSize = renderBox.size;
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
    _captureTargetGeometry();
    final view = View.of(context);
    _viewAtShow = view;
    _viewSizeAtShow = view.physicalSize;
    _previousFocus = FocusManager.instance.primaryFocus;
    if (!_overlayController.isShowing) {
      _overlayController.show();
    }
    // The overlay child only mounts with the next frame — the focus node has
    // no context to focus before then.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _overlayController.isShowing) _popoverFocusNode.requestFocus();
    });
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
    _popoverFocusNode.dispose();
    super.dispose();
  }

  /// Assembles the popover content: an optional header row (mirroring
  /// [SBBBottomSheet]'s contract) above the [SBBPopover.builder] body.
  Widget _buildContent(BuildContext context, SBBPopoverStyle style) {
    final padding = style.padding ?? EdgeInsets.zero;

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

    // Unlike the full-width bottom sheet, the popover sizes itself to its
    // content — but the header row contains flex children (Expanded/Spacer)
    // that would greedily fill the whole available width. IntrinsicWidth
    // bounds the column to the widest child's natural width instead.
    return IntrinsicWidth(
      child: Column(
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
      ),
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

  /// Hardware-keyboard support: the inner [Focus] takes focus when the
  /// popover opens (see [_popoverFocusNode]), so key events land inside it;
  /// Escape then arrives as a [DismissIntent] (via [WidgetsApp]'s default
  /// shortcuts) and is handled here — only while [SBBPopover.isDismissible]
  /// allows it.
  Widget _withKeyboardDismiss(Widget child) {
    child = Focus(focusNode: _popoverFocusNode, child: child);
    if (!widget.isDismissible) return child;
    return Actions(
      actions: <Type, Action<Intent>>{
        DismissIntent: CallbackAction<DismissIntent>(
          onInvoke: (_) {
            _effectiveController.hide();
            return null;
          },
        ),
      },
      child: child,
    );
  }

  /// The usable-viewport margin: the configured [SBBPopover.viewportMargin],
  /// widened per edge wherever the safe area or the on-screen keyboard
  /// insets further (max per edge, so the two never stack up).
  ///
  /// Insets are read from the raw [FlutterView] instead of the inherited
  /// [MediaQuery]: an ancestor may have consumed them before they reach this
  /// subtree — most notably a Scaffold with `resizeToAvoidBottomInset`
  /// removes the keyboard's bottom inset for its body — but the popover lays
  /// out in the enclosing full-view [Overlay], which the keyboard still
  /// overlaps. Rebuilds on inset changes are driven by [didChangeMetrics]
  /// rather than a MediaQuery dependency.
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
                notch: widget.showNotch
                    ? SBBPopoverNotch.single(alignWithTarget: widget.alignNotchToTarget)
                    : const SBBPopoverNotch.none(),
                color: style.backgroundColor ?? SBBColors.milk,
                popoverConstraints: style.constraints ?? const BoxConstraints(),
                sideOffset: widget.offset.dy,
                alignmentOffset: widget.offset.dx,
                viewportMargin: _effectiveViewportMargin(context),
                scaleAnimation: _scaleAnimation,
                child: Material(
                  type: MaterialType.transparency,
                  child: _withKeyboardDismiss(_buildContent(context, style)),
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
///
/// The flex children (Expanded/Spacer) fill whatever width the enclosing
/// IntrinsicWidth settles on, keeping trailing content and the close button
/// pinned to the popover's right edge even when the body is wider than the
/// header's natural width.
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
