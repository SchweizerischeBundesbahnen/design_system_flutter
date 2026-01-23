import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import '../shared/close_button.dart';
import 'sbb_promotion_box_badge.dart';

part 'promotion_box.assets.dart';

const _gradientStops = [0.0, 0.406, 0.672, 1.0];

/// The SBB Promotion Box.
/// Use according to [documentation](https://digital.sbb.ch/en/design-system/mobile/components/promotion-box/)
///
/// The default constructor creates the Promotion Box as specified in the design guidelines.
/// For complete customization, use the `custom` constructor.
class SBBPromotionBox extends StatefulWidget {
  /// The default SBBPromotionBox. Use this to create the PromotionBox according to the design guidelines.
  ///
  /// For programmatic hide and show of the promotion box, use the [onControllerCreated] callback and the
  /// given [ClosableBoxController].
  ///
  /// If [onTap] is not null, the promotion box is tappable and displays a chevron icon to the right of the [subtitle].
  ///
  /// If [onClose] is not null, a DismissButton will be displayed to the top right of the [SBBPromotionBox], which the
  /// user can tap to dismiss the promotion box. This triggers the `hide` method in the [ClosableBoxController].
  SBBPromotionBox({
    required String title,
    required String subtitle,
    required String badgeText,
    Key? key,
    Function(ClosableBoxController controller)? onControllerCreated,
    GestureTapCallback? onTap,
    GestureTapCallback? onClose,
    String? onTapSemanticsHint,
  }) : this._base(
         content: _DefaultContent(title: title, subtitle: subtitle, onTap: onTap, onClose: onClose),
         key: key,
         badgeText: badgeText,
         onControllerCreated: onControllerCreated,
         onTap: onTap,
         onClose: onClose,
         onTapSemanticsHint: onTapSemanticsHint,
       );

  /// Allows for complete customization of the content of the [SBBPromotionBox].
  const SBBPromotionBox.custom({
    required Widget content,
    required String badgeText,
    Key? key,
    Function(ClosableBoxController controller)? onControllerCreated,
    GestureTapCallback? onTap,
    String? onTapSemanticsHint,
    Widget? leading,
    Widget? trailing,
    @Deprecated('Deprecated. Will be removed in the next major release. Use [style] instead') Color? badgeColor,
    @Deprecated('Deprecated. Will be removed in the next major release. Use [style] instead') Color? badgeShadowColor,
    @Deprecated('Deprecated. Will be removed in the next major release. Use [style] instead')
    List<Color>? gradientColors,
    PromotionBoxStyle? style,
  }) : this._base(
         content: content,
         badgeText: badgeText,
         key: key,
         onControllerCreated: onControllerCreated,
         onTap: onTap,
         onTapSemanticsHint: onTapSemanticsHint,
         onClose: null,
         leading: leading,
         trailing: trailing,
         badgeColor: badgeColor,
         badgeShadowColor: badgeShadowColor,
         gradientColors: gradientColors,
         style: style,
       );

  const SBBPromotionBox._base({
    required this.content,
    required this.badgeText,
    super.key,
    this.onControllerCreated,
    this.onTap,
    this.onTapSemanticsHint,
    this.onClose,
    this.leading,
    this.trailing,
    this.badgeColor,
    this.badgeShadowColor,
    this.gradientColors,
    this.style,
  }) : assert(
         !(style != null && (badgeColor != null || badgeShadowColor != null || gradientColors != null)),
         'Cannot set PromotionBoxStyle in combination with badgeColor, badgeShadowColor or gradientColors.',
       );

  /// The content between the [leading] and [trailing] Widgets.
  final Widget content;

  /// The text shown on the top badge of the [SBBPromotionBox].
  final String badgeText;

  /// Callback for receiving the [ClosableBoxController] to programmatically hide
  /// and show the SBBPromotionBox.
  final Function(ClosableBoxController controller)? onControllerCreated;

  /// Callback when the user taps the promotion box except on the dismiss button
  /// in the top right corner.
  ///
  /// If this is non null, the [SBBPromotionBox] will be tappable and a chevron
  /// will be displayed right of the [subtitle], if the default constructor is used.
  final GestureTapCallback? onTap;

  /// Callback for once the user taps the DismissButton.
  ///
  /// This will not be invoked, if the hiding is done through the [ClosableBoxController].
  final GestureTapCallback? onClose;

  /// The semantic hint used if the promotion box is tappable. See [onTap].
  final String? onTapSemanticsHint;

  /// The leading widget is displayed left of the [content] with a padding.
  final Widget? leading;

  /// The trailing widget is displayed right of the [content] with a padding.
  final Widget? trailing;

  /// The color of the badge used to override the one defined in the [PromotionBoxStyle].
  ///
  /// Cannot be used if [style] is set.
  ///
  /// If null, the one defined in the style will be taken.
  @Deprecated('Deprecated. Will be removed in the next major release. Use [style] instead')
  final Color? badgeColor;

  /// The shadow color of the badge used to override the one defined in the [PromotionBoxStyle].
  ///
  /// Cannot be used if [style] is set.
  ///
  /// If null, the one defined in the style will be taken.
  @Deprecated('Deprecated. Will be removed in the next major release. Use [style] instead')
  final Color? badgeShadowColor;

  /// The gradient colors of the [SBBPromotionBox] used to override the one defined in the [PromotionBoxStyle].
  ///
  /// If null, the one defined in the style will be taken.
  ///
  /// Cannot be used if [style] is set.
  ///
  /// Use this to override the background color of the [SBBPromotionBox].
  @Deprecated('Deprecated. Will be removed in the next major release. Use [style] instead')
  final List<Color>? gradientColors;

  /// Use to override style of single SBBPromotionBox in custom constructor.
  ///
  /// Cannot be used if [gradientColors], [badgeShadowColor] or [badgeColor] are set.
  ///
  /// This is [PromotionBoxStyle.merge] with the theme's [PromotionBoxStyle] to create the final one.
  final PromotionBoxStyle? style;

  @override
  State<SBBPromotionBox> createState() => _SBBPromotionBoxState();
}

class _SBBPromotionBoxState extends State<SBBPromotionBox> with SingleTickerProviderStateMixin {
  final _badgeKey = GlobalKey();
  late final ClosableBoxController _controller = ClosableBoxController(this);

  Size _badgeSize = Size.zero;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _repaint());
    widget.onControllerCreated?.call(_controller);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repaint();
  }

  void _repaint() {
    _recalculateBadgeSize();
  }

  void _recalculateBadgeSize() {
    final renderObject = _badgeKey.currentContext?.findRenderObject();
    if (renderObject != null) {
      final renderBox = renderObject as RenderBox;
      setState(() => _badgeSize = renderBox.size);
    }
  }

  Widget _animationBuilder({required Animation<double> animation, required Widget child}) {
    return SizeTransition(
      axisAlignment: -1.0,
      sizeFactor: animation,
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = SBBBaseStyle.of(context);
    final paddingTop = _badgeSize.height / 2.0;

    final style = SBBControlStyles.of(context).promotionBox!;
    final resolvedStyle = widget.style != null ? style.merge(widget.style!) : style;

    return _animationBuilder(
      animation: _controller.animation,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SBBPromotionBoxBadgeShadow(
                badgeSize: _badgeSize,
                shadowColor: widget.badgeShadowColor ?? resolvedStyle.badgeShadowColor!,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: paddingTop),
              decoration: BoxDecoration(
                border: Border.all(color: resolvedStyle.borderColor!),
                borderRadius: const BorderRadius.all(Radius.circular(sbbDefaultSpacing)),
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
                    // TODO: replace these with own SBBPromotionBoxThemeData values
                    focusColor: baseStyle.themeValue(SBBColors.milk, SBBColors.iron),
                    hoverColor: baseStyle.themeValue(SBBColors.milk, SBBColors.iron),
                    customBorder: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(sbbDefaultSpacing)),
                    ),
                    onTap: widget.onTap,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        sbbDefaultSpacing,
                        sbbDefaultSpacing,
                        sbbDefaultSpacing * .5,
                        sbbDefaultSpacing,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (widget.leading != null)
                            Padding(padding: const EdgeInsets.only(right: 8.0), child: widget.leading!),
                          Expanded(child: widget.content),
                          if (widget.trailing != null)
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: widget.trailing!),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SBBPromotionBoxBadge(
                key: _badgeKey,
                text: widget.badgeText,
                badgeColor: widget.badgeColor ?? resolvedStyle.badgeColor!,
                badgeBorderColor: resolvedStyle.badgeBorderColor!,
                badgeTextStyle: resolvedStyle.badgeTextStyle!,
              ),
            ),
            if (widget.onClose != null)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: SBBCloseButton(
                    onTap: () async {
                      await _controller.hide();
                      widget.onClose!.call();
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DefaultContent extends StatelessWidget {
  const _DefaultContent({required this.title, required this.subtitle, this.onTap, this.onClose});

  final String title;
  final String subtitle;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final crossColor = SBBBaseStyle.of(context).iconColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Text(title, style: textTheme.titleMedium)),
            if (onClose != null) const SizedBox(width: sbbIconSizeSmall),
            const SizedBox(width: sbbDefaultSpacing * .5),
          ],
        ),
        const SizedBox(height: sbbDefaultSpacing * .5),
        Row(
          children: [
            Expanded(child: Text(subtitle, style: textTheme.bodyMedium)),
            onTap != null
                ? Icon(SBBIcons.chevron_small_right_small, color: crossColor, size: sbbIconSizeSmall)
                : const SizedBox(width: sbbDefaultSpacing * .5),
          ],
        ),
      ],
    );
  }
}
