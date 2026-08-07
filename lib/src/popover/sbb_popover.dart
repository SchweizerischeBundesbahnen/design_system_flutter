import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/popover/render_sbb_popover.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_notch.dart';
import 'package:sbb_design_system_mobile/src/shared/utils.dart';

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
    this.title,
    this.titleText,
    this.leading,
    this.leadingIconData,
    this.trailing,
    this.trailingIconData,
    this.showCloseButton = true,
    this.preferredDirection = .bottom,
    this.isDismissible = true,
    this.showNotch = true,
    this.alignNotchToTarget = true,
    this.offset = Offset.zero,
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

  /// Assembles the popover content: an optional header row (mirroring
  /// [SBBBottomSheet]'s contract) above the [SBBPopover.builder] body.
  ///
  /// Style values are taken from the base style for now — dedicated popover
  /// theming is a separate TODO.
  Widget _buildContent(BuildContext context) {
    final baseStyle = Theme.of(context).sbbBaseStyle;
    const padding = EdgeInsets.symmetric(horizontal: SBBSpacing.medium, vertical: SBBSpacing.small);

    final body = widget.builder(context, _effectiveController.hide);

    final titleWidget = addDefaultAncestorWithResolved(
      child: widget.title ?? (widget.titleText != null ? Text(widget.titleText!) : null),
      foregroundColor: baseStyle.colorScheme.textPrimary,
      textStyle: baseStyle.textTheme.largeLight,
    );
    final leadingWidget = addDefaultAncestorWithResolved(
      child: widget.leading ?? (widget.leadingIconData != null ? Icon(widget.leadingIconData) : null),
      foregroundColor: baseStyle.colorScheme.iconPrimary,
      textStyle: baseStyle.textTheme.defaultTextStyle,
    );
    final trailingWidget = addDefaultAncestorWithResolved(
      child: widget.trailing ?? (widget.trailingIconData != null ? Icon(widget.trailingIconData) : null),
      foregroundColor: baseStyle.colorScheme.iconPrimary,
      textStyle: baseStyle.textTheme.defaultTextStyle,
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
                  child: _buildContent(context),
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
