import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/promotion_box/promotion_box_layout.dart';
import 'package:sbb_design_system_mobile/src/shared/close_button.dart';

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
/// Provide either [title] for a custom title widget or [titleText] for the
/// standard title design. These parameters are mutually exclusive.
///
/// Provide either [subtitle] for a custom subtitle widget or [subtitleText] for
/// the standard subtitle design. These parameters are mutually exclusive.
class SBBPromotionBox extends StatefulWidget {
  /// Creates an [SBBPromotionBox].
  ///
  /// Exactly one of [badgeText] or [badge] must be provided.
  /// At most one of [titleText] or [title] may be provided.
  /// At most one of [subtitleText] or [subtitle] may be provided.
  ///
  /// For programmatic hide and show of the promotion box, provide a [controller].
  /// If no controller is given, an internal one is created automatically.
  ///
  /// If [onTap] is not null, the promotion box is tappable and displays a chevron icon to the right of the subtitle.
  ///
  /// If [onClose] is not null, a DismissButton will be displayed to the top right of the [SBBPromotionBox], which the
  /// user can tap to dismiss the promotion box. This triggers the `hide` method in the [SBBPromotionBoxController].
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
  /// Cannot be used together with [titleText].
  final Widget? title;

  /// Text string to display as the title using the standard design.
  ///
  /// Cannot be used together with [title].
  final String? titleText;

  /// A custom widget displayed as the subtitle.
  ///
  /// Cannot be used together with [subtitleText].
  final Widget? subtitle;

  /// Text string to display as the subtitle using the standard design.
  ///
  /// Cannot be used together with [subtitle].
  final String? subtitleText;

  /// Callback when the user taps the promotion box except on the dismiss button
  /// in the top right corner.
  ///
  /// If this is non null, the [SBBPromotionBox] will be tappable and a chevron
  /// will be displayed right of the subtitle, if [subtitleText] is used.
  final GestureTapCallback? onTap;

  /// Callback invoked once the user taps the dismiss button.
  ///
  /// Only relevant if [isDismissable] is true.
  /// This will not be invoked if the hiding is done through the [SBBPromotionBoxController].
  final GestureTapCallback? onDismissed;

  /// Whether a dismiss button is shown in the top right corner of the [SBBPromotionBox].
  ///
  /// If true, a close button will be displayed. Tapping it will hide the promotion box
  /// via the [SBBPromotionBoxController] and invoke [onDismissed].
  ///
  /// Defaults to false.
  final bool isDismissable;

  /// The semantic hint used if the promotion box is tappable. See [onTap].
  final String? onTapSemanticsHint;

  /// The trailing widget is displayed right of the content with a padding.
  final Widget? trailing;

  /// Use to override the style of a single [SBBPromotionBox].
  ///
  /// This is [PromotionBoxStyle.merge]d with the theme's [PromotionBoxStyle] to create the final one.
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
      // Detach old external controller (it manages its own lifecycle).
      // Internal controller is re-created lazily via _effectiveController getter.
      oldWidget.controller?.detach();
      _effectiveController.attach(this);
    }
  }

  @override
  void dispose() {
    _effectiveController.detach();
    super.dispose();
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

  Widget _buildContent() {
    if (widget.title != null || widget.subtitle != null || widget.titleText != null || widget.subtitleText != null) {
      return _DefaultContent(
        title: widget.title,
        titleText: widget.titleText,
        subtitle: widget.subtitle,
        subtitleText: widget.subtitleText,
        onTap: widget.onTap,
        isDismissable: widget.isDismissable,
      );
    }
    // No title/subtitle provided: render nothing (custom content via leading/trailing only).
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).sbbBaseStyle;

    final style = Theme.of(context).sbbPromotionBoxTheme.style!;
    final resolvedStyle = widget.style != null ? style.merge(widget.style!) : style;

    final boxContent = Container(
      decoration: BoxDecoration(
        border: Border.all(color: resolvedStyle.borderColor!),
        borderRadius: SBBPromotionBoxStyle.borderRadius,
        image: DecorationImage(
          image: const AssetImage(_promotionBoxNoiseAsset),
          repeat: ImageRepeat.repeat,
          fit: BoxFit.none,
          opacity: resolvedStyle.backgroundTextureOpacity!,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: resolvedStyle.backgroundGradientColors!,
          stops: SBBPromotionBoxStyle.backgroundGradientStops,
        ),
      ),
      child: Material(
        color: SBBColors.transparent,
        child: Semantics(
          hint: widget.onTapSemanticsHint,
          child: InkWell(
            focusColor: baseStyle.themeValue(SBBColors.milk, SBBColors.iron),
            hoverColor: baseStyle.themeValue(SBBColors.milk, SBBColors.iron),
            customBorder: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(SBBSpacing.medium)),
            ),
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.all(SBBSpacing.medium).copyWith(right: SBBSpacing.xSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: _buildContent()),
                  if (widget.trailing != null)
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: widget.trailing!),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    final boxWithOptionalClose = widget.isDismissable
        ? Stack(
            children: [
              boxContent,
              Positioned(
                top: 2.0,
                right: 0.0,
                child: SBBCloseButton(
                  onTap: () async {
                    await _effectiveController.hide();
                    widget.onDismissed?.call();
                  },
                ),
              ),
            ],
          )
        : boxContent;

    return _animationBuilder(
      animation: _effectiveController.animation,
      child: PromotionBoxLayout(
        badge: _buildBadge(),
        content: boxWithOptionalClose,
      ),
    );
  }
}

class _DefaultContent extends StatelessWidget {
  const _DefaultContent({
    this.title,
    this.titleText,
    this.subtitle,
    this.subtitleText,
    this.onTap,
    this.isDismissable = false,
  });

  final Widget? title;
  final String? titleText;
  final Widget? subtitle;
  final String? subtitleText;
  final GestureTapCallback? onTap;
  final bool isDismissable;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final crossColor = Theme.of(context).sbbBaseStyle.colorScheme.iconPrimary;

    final titleWidget = title ?? (titleText != null ? Text(titleText!, style: textTheme.titleMedium) : null);
    final subtitleWidget = subtitle ?? (subtitleText != null ? Text(subtitleText!, style: textTheme.bodyMedium) : null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (titleWidget != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: titleWidget),
              if (isDismissable) const SizedBox(width: sbbIconSizeSmall),
              const SizedBox(width: SBBSpacing.xSmall),
            ],
          ),
        if (titleWidget != null && subtitleWidget != null) const SizedBox(height: SBBSpacing.xSmall),
        if (subtitleWidget != null)
          Row(
            children: [
              Expanded(child: subtitleWidget),
              onTap != null
                  ? Icon(SBBIcons.chevron_small_right_small, color: crossColor, size: sbbIconSizeSmall)
                  : const SizedBox(width: SBBSpacing.xSmall),
            ],
          ),
      ],
    );
  }
}
