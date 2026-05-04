import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/promotion_box/promotion_box_layout.dart';
import 'package:sbb_design_system_mobile/src/shared/close_button.dart';

part 'promotion_box.assets.dart';

const _gradientStops = [0.0, 0.406, 0.672, 1.0];

/// The SBB Promotion Box.
/// Use according to [documentation](https://digital.sbb.ch/en/design-system/mobile/components/promotion-box/)
///
/// Provide either [badge] for a custom badge widget or [badgeText] for the
/// standard badge design. These parameters are mutually exclusive.
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
  /// For programmatic hide and show of the promotion box, use the [onControllerCreated] callback and the
  /// given [ClosableBoxController].
  ///
  /// If [onTap] is not null, the promotion box is tappable and displays a chevron icon to the right of the subtitle.
  ///
  /// If [onClose] is not null, a DismissButton will be displayed to the top right of the [SBBPromotionBox], which the
  /// user can tap to dismiss the promotion box. This triggers the `hide` method in the [ClosableBoxController].
  const SBBPromotionBox({
    super.key,
    this.badge,
    this.badgeText,
    this.title,
    this.titleText,
    this.subtitle,
    this.subtitleText,
    this.onControllerCreated,
    this.onTap,
    this.onClose,
    this.onTapSemanticsHint,
    this.leading,
    this.trailing,
    this.gradientColors,
    this.style,
    this.badgeStyle,
  }) : assert(badgeText != null || badge != null, 'One of badgeText or badge must be provided!'),
       assert(badgeText == null || badge == null, 'Cannot provide both badgeText and badge!'),
       assert(titleText == null || title == null, 'Cannot provide both titleText and title!'),
       assert(subtitleText == null || subtitle == null, 'Cannot provide both subtitleText and subtitle!');

  /// A custom badge widget.
  ///
  /// Typically, the [SBBPromotionBoxBadge] is used here for custom content and custom styling.
  ///
  /// Cannot be used together with [badgeText].
  final Widget? badge;

  /// Text string to display as the badge label using the standard design.
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

  /// Callback for receiving the [ClosableBoxController] to programmatically hide
  /// and show the SBBPromotionBox.
  final Function(ClosableBoxController controller)? onControllerCreated;

  /// Callback when the user taps the promotion box except on the dismiss button
  /// in the top right corner.
  ///
  /// If this is non null, the [SBBPromotionBox] will be tappable and a chevron
  /// will be displayed right of the subtitle, if [subtitleText] is used.
  final GestureTapCallback? onTap;

  /// Callback for once the user taps the DismissButton.
  ///
  /// This will not be invoked, if the hiding is done through the [ClosableBoxController].
  final GestureTapCallback? onClose;

  /// The semantic hint used if the promotion box is tappable. See [onTap].
  final String? onTapSemanticsHint;

  /// The leading widget is displayed left of the content with a padding.
  final Widget? leading;

  /// The trailing widget is displayed right of the content with a padding.
  final Widget? trailing;

  /// The gradient colors of the [SBBPromotionBox] used to override the one defined in the [PromotionBoxStyle].
  ///
  /// If null, the one defined in the style will be taken.
  ///
  /// Use this to override the background color of the [SBBPromotionBox].
  @Deprecated('Deprecated. Will be removed in the next major release. Use [style] instead')
  final List<Color>? gradientColors;

  /// Use to override the style of a single [SBBPromotionBox].
  ///
  /// This is [PromotionBoxStyle.merge]d with the theme's [PromotionBoxStyle] to create the final one.
  final PromotionBoxStyle? style;

  /// Ignored if a custom [badge] is set.
  final SBBPromotionBoxBadgeStyle? badgeStyle;

  @override
  State<SBBPromotionBox> createState() => _SBBPromotionBoxState();
}

class _SBBPromotionBoxState extends State<SBBPromotionBox> with SingleTickerProviderStateMixin {
  late final ClosableBoxController _controller = ClosableBoxController(this);

  @override
  void initState() {
    super.initState();
    widget.onControllerCreated?.call(_controller);
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
        onClose: widget.onClose,
      );
    }
    // No title/subtitle provided: render nothing (custom content via leading/trailing only).
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).sbbBaseStyle;

    final style = SBBControlStyles.of(context).promotionBox!;
    final resolvedStyle = widget.style != null ? style.merge(widget.style!) : style;

    final boxContent = Container(
      decoration: BoxDecoration(
        border: Border.all(color: resolvedStyle.borderColor!),
        borderRadius: const BorderRadius.all(Radius.circular(SBBSpacing.medium)),
        image: DecorationImage(
          image: const AssetImage(_PromotionBoxAssets.noise),
          repeat: ImageRepeat.repeat,
          fit: BoxFit.none,
          opacity: resolvedStyle.textureOpacity!,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: widget.gradientColors ?? resolvedStyle.gradientColors!,
          stops: _gradientStops,
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
                  if (widget.leading != null)
                    Padding(padding: const EdgeInsets.only(right: 8.0), child: widget.leading!),
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

    final boxWithOptionalClose = widget.onClose != null
        ? Stack(
            children: [
              boxContent,
              Positioned(
                top: 2.0,
                right: 0.0,
                child: SBBCloseButton(
                  onTap: () async {
                    await _controller.hide();
                    widget.onClose!.call();
                  },
                ),
              ),
            ],
          )
        : boxContent;

    return _animationBuilder(
      animation: _controller.animation,
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
    this.onClose,
  });

  final Widget? title;
  final String? titleText;
  final Widget? subtitle;
  final String? subtitleText;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onClose;

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
              if (onClose != null) const SizedBox(width: sbbIconSizeSmall),
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
