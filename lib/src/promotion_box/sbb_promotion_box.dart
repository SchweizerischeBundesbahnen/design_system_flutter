import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/promotion_box/promotion_box_layout.dart';

const _promotionBoxNoiseAsset = 'packages/sbb_design_system_mobile/lib/assets/noise.png';

/// The SBB Promotion Box.
/// Use according to [documentation](https://digital.sbb.ch/en/design-system/mobile/components/promotion-box/)
///
/// Provide either [badge] for a custom badge widget or [badgeText] for the
/// standard badge design. These parameters are mutually exclusive.
///
/// When using a custom [badge] widget, it will be positioned centered at the
/// top edge of the promotion box content, with half of the badge appearing above
/// the box border. The badge is rendered on top of the content. For the default
/// styling, use [SBBPromotionBoxBadge].
///
/// A title is required: provide either [title] for a custom title widget or
/// [titleText] for the standard title design. These parameters are mutually exclusive.
///
/// Provide either [subtitle] for a custom subtitle widget or [subtitleText] for
/// the standard subtitle design. These parameters are mutually exclusive.
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
  /// Creates an [SBBPromotionBox].
  ///
  /// Exactly one of [badgeText] or [badge] must be provided.
  /// Exactly one of [titleText] or [title] must be provided.
  /// At most one of [subtitleText] or [subtitle] may be provided.
  ///
  /// For programmatic hide and show of the promotion box, provide a [controller].
  /// If no controller is given, an internal one is created automatically.
  ///
  /// If [onTap] is not null and no [trailing] is provided, a chevron icon is
  /// displayed as the trailing indicator.
  ///
  /// If [onDismissed] is not null or [isDismissable] is true, an inline dismiss
  /// button is displayed aligned with the title row.
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
    this.isDismissable = true,
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
  /// Only relevant if [isDismissable] is true.
  /// This will not be invoked if the hiding is done through the [SBBPromotionBoxController].
  final GestureTapCallback? onDismissed;

  /// Whether a dismiss button is shown aligned with the title row of the [SBBPromotionBox].
  ///
  /// If true, an inline [InkWell] close button is displayed in the title row.
  /// Tapping it will hide the promotion box via the [SBBPromotionBoxController]
  /// and invoke [onDismissed].
  ///
  /// Defaults to true.
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

  /// Ignored if a custom [badge] is set.
  final SBBPromotionBoxBadgeStyle? badgeStyle;

  @override
  State<SBBPromotionBox> createState() => _SBBPromotionBoxState();
}

class _SBBPromotionBoxState extends State<SBBPromotionBox> with SingleTickerProviderStateMixin {
  SBBPromotionBoxController? _internalController;

  SBBPromotionBoxController get _effectiveController =>
      widget.controller ?? (_internalController ??= SBBPromotionBoxController());

  @override
  void initState() {
    super.initState();
    _effectiveController.attach(this);
  }

  @override
  void didUpdateWidget(covariant SBBPromotionBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.detach();
      _effectiveController.attach(this);
    }
  }

  @override
  void dispose() {
    _effectiveController.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).sbbPromotionBoxTheme;
    final effectiveStyle = themeData.style!.merge(widget.style);

    final Widget titleWidget = _titleWidget(effectiveStyle);
    final Widget? subtitleWidget = _subtitleWidget(effectiveStyle);
    final Widget? trailingWidget = _trailingWidget(effectiveStyle);
    final Widget? dismissButton = _dismissButton(context, effectiveStyle);

    final Widget titleRow = _titleRow(titleWidget, trailingWidget, dismissButton);
    final Widget? subtitleRow = _subtitleRow(subtitleWidget, trailingWidget);

    final Widget content = subtitleRow != null
        ? Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: SBBSpacing.xSmall,
            children: [titleRow, subtitleRow],
          )
        : titleRow;

    final decoratedContent = ClipRRect(
      borderRadius: SBBPromotionBoxStyle.borderRadius,
      child: effectiveStyle.backgroundBuilder != null
          ? effectiveStyle.backgroundBuilder!(
              context,
              effectiveStyle,
              _inkWellContent(context, effectiveStyle, content),
            )
          : _defaultBackgroundDecoration(context, effectiveStyle, content),
    );

    return _animationBuilder(
      animation: _effectiveController.animation,
      child: PromotionBoxLayout(
        badge: _buildBadge(),
        content: decoratedContent,
      ),
    );
  }

  Widget _inkWellContent(BuildContext context, SBBPromotionBoxStyle effectiveStyle, Widget content) {
    return Material(
      color: SBBColors.transparent,
      child: Semantics(
        onTapHint: widget.onTap != null ? widget.onTapSemanticsHint : null,
        child: InkWell(
          overlayColor: effectiveStyle.overlayColor,
          customBorder: const RoundedRectangleBorder(borderRadius: SBBPromotionBoxStyle.borderRadius),
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.all(SBBSpacing.medium),
            child: content,
          ),
        ),
      ),
    );
  }

  Widget _defaultBackgroundDecoration(
    BuildContext context,
    SBBPromotionBoxStyle effectiveStyle,
    Widget content,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: effectiveStyle.borderColor!),
        borderRadius: SBBPromotionBoxStyle.borderRadius,
        image: DecorationImage(
          image: const AssetImage(_promotionBoxNoiseAsset),
          repeat: ImageRepeat.repeat,
          fit: BoxFit.none,
          opacity: effectiveStyle.backgroundTextureOpacity!,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: effectiveStyle.backgroundGradientColors!,
          stops: SBBPromotionBoxStyle.backgroundGradientStops,
        ),
      ),
      child: _inkWellContent(context, effectiveStyle, content),
    );
  }

  // Build subtitle row with trailing aligned center-vertically
  Widget? _subtitleRow(Widget? subtitleWidget, Widget? trailingWidget) {
    Widget? subtitleRow;
    if (subtitleWidget != null) {
      subtitleRow = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: subtitleWidget),
          if (trailingWidget != null) ...[
            const SizedBox(width: SBBSpacing.xSmall),
            trailingWidget,
          ],
        ],
      );
    }
    return subtitleRow;
  }

  // Build title row:
  // When no subtitle: trailing (+ gap) and dismiss button are in the title row.
  // When subtitle present: only dismiss button is in title row; trailing goes with subtitle.
  Widget _titleRow(Widget titleWidget, Widget? trailingWidget, Widget? dismissButton) {
    final hasSubtitle = widget.subtitle != null || widget.subtitleText != null;
    Widget titleRow;
    if (!hasSubtitle) {
      // No subtitle: [title] [trailing gap trailing] [xSmall gap dismiss]
      titleRow = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: titleWidget),
          if (trailingWidget != null) ...[
            const SizedBox(width: SBBSpacing.xSmall),
            trailingWidget,
          ],
          if (dismissButton != null) ...[
            const SizedBox(width: SBBSpacing.xSmall),
            dismissButton,
          ],
        ],
      );
    } else {
      // Subtitle present: dismiss button aligned with title row only
      titleRow = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: titleWidget),
          if (dismissButton != null) ...[
            const SizedBox(width: SBBSpacing.xSmall),
            dismissButton,
          ],
        ],
      );
    }
    return titleRow;
  }

  Widget? _dismissButton(BuildContext context, SBBPromotionBoxStyle effectiveStyle) {
    Widget? dismissButton;
    if (widget.isDismissable) {
      dismissButton = Semantics(
        label: MaterialLocalizations.of(context).closeButtonTooltip,
        button: true,
        child: InkWell(
          borderRadius: BorderRadius.circular(sbbIconSizeSmall),
          onTap: () async {
            await _effectiveController.hide();
            widget.onDismissed?.call();
          },
          child: _addDefaultAncestorWithResolved(
            child: const Icon(SBBIcons.cross_small, size: sbbIconSizeSmall),
            foregroundColor: effectiveStyle.titleForegroundColor,
          ),
        ),
      );
    }
    return dismissButton;
  }

  Widget? _trailingWidget(SBBPromotionBoxStyle effectiveStyle) {
    Widget? trailingWidget = widget.trailing;
    if (trailingWidget == null && widget.onTap != null) {
      trailingWidget = const Icon(SBBIcons.chevron_small_right_small, size: sbbIconSizeSmall);
    }
    if (trailingWidget != null) {
      trailingWidget = _addDefaultAncestorWithResolved(
        child: trailingWidget,
        foregroundColor: effectiveStyle.trailingForegroundColor,
      );
    }
    return trailingWidget;
  }

  Widget? _subtitleWidget(SBBPromotionBoxStyle effectiveStyle) {
    Widget? subtitleWidget =
        widget.subtitle ??
        (widget.subtitleText != null
            ? Text(widget.subtitleText!, maxLines: effectiveStyle.subtitleTextMaxLines)
            : null);
    if (subtitleWidget != null) {
      subtitleWidget = _addDefaultAncestorWithResolved(
        child: subtitleWidget,
        foregroundColor: effectiveStyle.subtitleForegroundColor,
        textStyle: effectiveStyle.subtitleTextStyle,
      );
    }
    return subtitleWidget;
  }

  Widget _titleWidget(SBBPromotionBoxStyle effectiveStyle) {
    Widget titleWidget =
        widget.title ??
        Text(
          widget.titleText!,
          maxLines: effectiveStyle.titleTextMaxLines,
          overflow: TextOverflow.ellipsis,
        );
    titleWidget = _addDefaultAncestorWithResolved(
      child: titleWidget,
      foregroundColor: effectiveStyle.titleForegroundColor,
      textStyle: effectiveStyle.titleTextStyle,
    );
    return titleWidget;
  }

  Widget _animationBuilder({required Animation<double> animation, required Widget child}) {
    return SizeTransition(
      axisAlignment: -1.0,
      sizeFactor: animation,
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  Widget _buildBadge() {
    if (widget.badge != null) return widget.badge!;
    return SBBPromotionBoxBadge(labelText: widget.badgeText, style: widget.badgeStyle);
  }

  /// Applies [foregroundColor] and optional [textStyle] to [child] using
  /// [DefaultTextStyle] and [IconTheme], similarly to how [SBBListItem] works.
  Widget _addDefaultAncestorWithResolved({
    required Widget child,
    required Color? foregroundColor,
    TextStyle? textStyle,
  }) {
    final resolvedTextStyle = textStyle?.copyWith(color: foregroundColor) ?? TextStyle(color: foregroundColor);
    return DefaultTextStyle.merge(
      style: resolvedTextStyle,
      child: IconTheme.merge(
        data: IconThemeData(color: foregroundColor),
        child: child,
      ),
    );
  }
}
