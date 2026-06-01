import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/promotion_box/promotion_box_layout.dart';
import 'package:sbb_design_system_mobile/src/promotion_box/theme/default_sbb_promotion_box_theme_data.dart';
import 'package:sbb_design_system_mobile/src/shared/utils.dart';

const _promotionBoxNoiseAsset = 'packages/sbb_design_system_mobile/lib/assets/noise.png';

/// The SBB Promotion Box.
///
/// Typically used to introduce new features or considerable changes within an application.
///
/// The promotion box consists of a badge, a title row, an optional subtitle and a trailing part.
///
/// * The title is required: provide either [title] for a custom title widget or
/// [titleText] for the standard title design. These parameters are mutually exclusive.
/// * Provide either [subtitle] for a custom subtitle widget or [subtitleText] for
/// the standard subtitle design. These parameters are mutually exclusive.
/// * Provide either [badge] for a custom badge widget or [badgeText] for the
/// standard badge design. These parameters are mutually exclusive.
/// When using a custom [badge] widget, it will be positioned centered at the
/// top edge of the promotion box content, with half of the badge appearing above
/// the box border. The badge is rendered on top of the content. For the default
/// badge with pill shape look and halo, use [SBBPromotionBoxBadge].
///
/// ## Layout rules
///
/// The dismiss button (shown when [isDismissable] is true) is a simple [InkWell]
/// and is always aligned in the title row.
///
/// **When no subtitle is set:**
/// The trailing widget is shown left of the dismiss button with a gap of
/// [SBBSpacing.xSmall]. If [trailing] is provided, that widget is used.
/// Otherwise, only if [onTap] is set, a chevron icon is shown.
///
/// **When a subtitle is set:**
/// The trailing widget is placed to the right of the subtitle, vertically centered.
/// If [trailing] is provided, that widget is used. Otherwise, only if [onTap]
/// is set, a chevron icon is shown.
class SBBPromotionBox extends StatefulWidget {
  const SBBPromotionBox({
    super.key,
    this.controller,
    this.badge,
    this.badgeText,
    this.title,
    this.titleText,
    this.subtitle,
    this.subtitleText,
    this.onTap,
    this.onDismissed,
    this.isDismissable = false,
    this.trailing,
    this.onTapSemanticsHint,
    this.style,
    this.badgeStyle,
  }) : assert(badgeText != null || badge != null, 'One of badgeText or badge must be provided!'),
       assert(badgeText == null || badge == null, 'Cannot provide both badgeText and badge!'),
       assert(titleText != null || title != null, 'Either title or titleText must be provided!'),
       assert(titleText == null || title == null, 'Cannot provide both titleText and title!'),
       assert(subtitleText == null || subtitle == null, 'Cannot provide both subtitleText and subtitle!');

  /// An optional controller to programmatically show and hide the [SBBPromotionBox].
  ///
  /// If not provided, an internal controller is created automatically.
  final SBBPromotionBoxController? controller;

  /// A custom badge widget.
  ///
  /// Typically, the [SBBPromotionBoxBadge] is used, which allows for custom content and custom styling.
  ///
  /// The badge is positioned centered at the top edge of the promotion box, with half of
  /// its height appearing above the box border. The badge is rendered on top of the content.
  ///
  /// Cannot be used together with [badgeText].
  final Widget? badge;

  /// Text string to display as the badge label using a standard [SBBPromotionBoxBadge].
  ///
  /// Cannot be used together with [badge].
  final String? badgeText;

  /// A custom widget displayed as the title.
  ///
  /// The title is always required. Use [titleText] for a simple text title.
  ///
  /// Cannot be used together with [titleText].
  final Widget? title;

  /// Text string to display as the title using the standard design.
  ///
  /// The title is always required. Use [title] for a custom title widget.
  ///
  /// Cannot be used together with [title].
  final String? titleText;

  /// A custom widget displayed as the subtitle below the title.
  ///
  /// When a subtitle is present, the [trailing] widget (or chevron if [onTap]
  /// is set) is vertically centered alongside the subtitle, not the title.
  ///
  /// Cannot be used together with [subtitleText].
  final Widget? subtitle;

  /// Text string to display as the subtitle using the standard design.
  ///
  /// When a subtitle is present, the [trailing] widget (or chevron if [onTap]
  /// is set) is vertically centered alongside the subtitle, not the title.
  ///
  /// Cannot be used together with [subtitle].
  final String? subtitleText;

  /// Callback when the user taps the promotion box except on the dismiss button.
  ///
  /// If this is non-null and no [trailing] is provided, a chevron icon indicator
  /// will be displayed.
  final GestureTapCallback? onTap;

  /// Callback invoked once the user taps the dismiss button.
  ///
  /// This will not be invoked if the hiding is done through the [SBBPromotionBoxController].
  final GestureTapCallback? onDismissed;

  /// If true, an inline [InkWell] close button is displayed in the title row.
  /// Tapping it will hide the promotion box via the [SBBPromotionBoxController]
  /// and invoke [onDismissed].
  final bool isDismissable;

  /// The semantic hint used if the promotion box is tappable. See [onTap].
  final String? onTapSemanticsHint;

  /// A custom trailing widget displayed to the right of the content.
  ///
  /// **When no subtitle is set:** displayed left of the dismiss button with a
  /// gap of [SBBSpacing.xSmall]. If not provided and [onTap] is set, a chevron
  /// icon is shown instead.
  ///
  /// **When a subtitle is set:** displayed vertically centered alongside the
  /// subtitle. If not provided and [onTap] is set, a chevron icon is shown instead.
  final Widget? trailing;

  /// Use to override the style of a single [SBBPromotionBox].
  ///
  /// This is [SBBPromotionBoxStyle.merge]d with the theme's [SBBPromotionBoxStyle]
  /// to create the effective style used during rendering.
  final SBBPromotionBoxStyle? style;

  /// Use this to style the standard badge built by using [badgeText].
  ///
  /// Ignored if a custom [badge] is set.
  ///
  /// This is [SBBPromotionBoxStyle.merge]d with the theme's [SBBPromotionBoxStyle]
  /// to create the effective style used during rendering.
  final SBBPromotionBoxBadgeStyle? badgeStyle;

  @override
  State<SBBPromotionBox> createState() => _SBBPromotionBoxState();
}

class _SBBPromotionBoxState extends State<SBBPromotionBox> with SingleTickerProviderStateMixin {
  SBBPromotionBoxController? _internalController;

  SBBPromotionBoxController get _effectiveController =>
      widget.controller ?? (_internalController ??= SBBPromotionBoxController());

  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      value: _effectiveController.value ? 1.0 : 0.0,
      duration: kThemeAnimationDuration,
    );
    _effectiveController.addListener(_animate);
  }

  @override
  void didUpdateWidget(covariant SBBPromotionBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_animate);
      _effectiveController.addListener(_animate);
      if (widget.controller?.value != oldWidget.controller?.value) _animate();
    }
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_animate);
    _animationController.dispose();
    _internalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SBBPromotionBoxStyle effectiveStyle = _effectiveStyle(context);

    final titleWidget = _titleWidget(effectiveStyle);
    final subtitleWidget = _subtitleWidget(effectiveStyle);
    final trailingWidget = _trailingWidget(effectiveStyle);
    final dismissButton = _dismissButton(context, effectiveStyle);

    final titleRow = _titleRow(titleWidget, trailingWidget, dismissButton);
    final subtitleRow = _subtitleRow(subtitleWidget, trailingWidget);

    final Widget content = subtitleRow != null
        ? Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: SBBSpacing.xSmall,
            children: [titleRow, subtitleRow],
          )
        : titleRow;

    final contentWithBackground = effectiveStyle.backgroundBuilder != null
        ? effectiveStyle.backgroundBuilder!(context, effectiveStyle, _inkWellContent(context, effectiveStyle, content))
        : _defaultDecoratedContent(context, effectiveStyle, _inkWellContent(context, effectiveStyle, content));

    return _animationBuilder(
      animation: _animationController,
      child: PromotionBoxLayout(
        badge: widget.badge ?? SBBPromotionBoxBadge(labelText: widget.badgeText, style: widget.badgeStyle),
        content: ClipRRect(borderRadius: SBBPromotionBoxStyle.borderRadius, child: contentWithBackground),
      ),
    );
  }

  SBBPromotionBoxStyle _effectiveStyle(BuildContext context) {
    final themeData = Theme.of(context).sbbPromotionBoxTheme;
    final effectiveStyle = themeData.style!.merge(widget.style);
    return effectiveStyle;
  }

  Widget _inkWellContent(BuildContext context, SBBPromotionBoxStyle effectiveStyle, Widget content) {
    return Material(
      color: SBBColors.transparent,
      child: Semantics(
        onTapHint: widget.onTap != null ? widget.onTapSemanticsHint : null,
        child: InkWell(
          overlayColor: effectiveStyle.overlayColor,
          borderRadius: SBBPromotionBoxStyle.borderRadius,
          onTap: widget.onTap,
          child: Padding(padding: effectiveStyle.padding!, child: content),
        ),
      ),
    );
  }

  Widget _defaultDecoratedContent(BuildContext context, SBBPromotionBoxStyle effectiveStyle, Widget content) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: .all(color: effectiveStyle.borderColor!),
        borderRadius: SBBPromotionBoxStyle.borderRadius,
        image: DecorationImage(
          image: const AssetImage(_promotionBoxNoiseAsset),
          repeat: .repeat,
          fit: .none,
          opacity: effectiveStyle.backgroundTextureOpacity!,
        ),
        gradient: LinearGradient(
          begin: .topCenter,
          end: .bottomCenter,
          colors: effectiveStyle.backgroundGradientColors!,
          stops: effectiveStyle.backgroundGradientStops ?? defaultGradientStops,
        ),
      ),
      child: content,
    );
  }

  // Build subtitle row with trailing aligned center-vertically
  Widget? _subtitleRow(Widget? subtitleWidget, Widget? trailingWidget) {
    if (subtitleWidget == null) return null;

    return Row(
      crossAxisAlignment: .center,
      spacing: SBBSpacing.xSmall,
      children: [
        Expanded(child: subtitleWidget),
        ?trailingWidget,
      ],
    );
  }

  Widget _titleRow(Widget titleWidget, Widget? trailingWidget, Widget? dismissButton) {
    final hasSubtitle = widget.subtitle != null || widget.subtitleText != null;
    if (!hasSubtitle) {
      // No subtitle: [title] [trailing] [dismissButton]
      return Row(
        crossAxisAlignment: .center,
        spacing: SBBSpacing.xSmall,
        children: [
          Expanded(child: titleWidget),
          ?trailingWidget,
          ?dismissButton,
        ],
      );
    } else {
      // Has subtitle: [title] [dismissButton]
      return Row(
        crossAxisAlignment: .center,
        spacing: SBBSpacing.xSmall,
        children: [
          Expanded(child: titleWidget),
          ?dismissButton,
        ],
      );
    }
  }

  Widget? _dismissButton(BuildContext context, SBBPromotionBoxStyle effectiveStyle) {
    if (!widget.isDismissable) return null;

    return Material(
      borderRadius: .circular(sbbIconSizeSmall),
      color: SBBColors.transparent,
      child: Semantics(
        label: MaterialLocalizations.of(context).closeButtonTooltip,
        button: true,
        child: InkWell(
          borderRadius: .circular(sbbIconSizeSmall),
          onTap: () {
            _effectiveController.hide();
            widget.onDismissed?.call();
          },
          child: addDefaultAncestorWithResolved(
            child: const Icon(SBBIcons.cross_tiny_small, size: sbbIconSizeSmall),
            foregroundColor: effectiveStyle.dismissButtonForegroundColor,
          ),
        ),
      ),
    );
  }

  Widget? _trailingWidget(SBBPromotionBoxStyle effectiveStyle) {
    Widget? trailingWidget = widget.trailing;
    if (trailingWidget == null && widget.onTap != null) {
      trailingWidget = const Icon(SBBIcons.chevron_small_right_small, size: sbbIconSizeSmall);
    }
    return addDefaultAncestorWithResolved(
      child: trailingWidget,
      foregroundColor: effectiveStyle.trailingForegroundColor,
    );
  }

  Widget? _subtitleWidget(SBBPromotionBoxStyle effectiveStyle) {
    Widget? subtitleWidget = widget.subtitle;
    if (subtitleWidget == null && widget.subtitleText != null) {
      subtitleWidget = Text(widget.subtitleText!, maxLines: effectiveStyle.subtitleTextMaxLines, overflow: .ellipsis);
    }

    return addDefaultAncestorWithResolved(
      child: subtitleWidget,
      foregroundColor: effectiveStyle.subtitleForegroundColor,
      textStyle: effectiveStyle.subtitleTextStyle,
    );
  }

  Widget _titleWidget(SBBPromotionBoxStyle effectiveStyle) {
    final Widget titleWidget = widget.title ?? Text(widget.titleText!, maxLines: effectiveStyle.titleTextMaxLines);

    return addDefaultAncestorWithResolved(
      child: titleWidget,
      foregroundColor: effectiveStyle.titleForegroundColor,
      textStyle: effectiveStyle.titleTextStyle,
    )!;
  }

  Widget _animationBuilder({required Animation<double> animation, required Widget child}) {
    return SizeTransition(
      axisAlignment: -1.0,
      sizeFactor: animation,
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  void _animate() => _animationController.animateTo(_effectiveController.value ? 1.0 : 0.0);
}
