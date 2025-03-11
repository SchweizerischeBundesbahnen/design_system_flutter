import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import '../shared/close_button.dart';
import 'sbb_promotion_box_badge.dart';

part 'promotion_box.assets.dart';

class SBBPromotionBox extends StatefulWidget {
  SBBPromotionBox({
    required String title,
    required String description,
    required String badgeText,
    Key? key,
    Function(CloseableBoxController controller)? onControllerCreated,
    GestureTapCallback? onTap,
    GestureTapCallback? onClose,
    String? onTapSemanticsHint,
  }) : this._base(
          content: _DefaultContent(title: title, description: description, onTap: onTap, onClose: onClose),
          key: key,
          badgeText: badgeText,
          onControllerCreated: onControllerCreated,
          onTap: onTap,
          onClose: onClose,
          onTapSemanticsHint: onTapSemanticsHint,
        );

  const SBBPromotionBox.custom({
    required Widget content,
    required String badgeText,
    Key? key,
    Function(CloseableBoxController controller)? onControllerCreated,
    GestureTapCallback? onTap,
    String? onTapSemanticsHint,
    Widget? leading,
    Widget? trailing,
    Color? badgeColor,
    Color? badgeShadowColor,
    List<Color>? gradientColors,
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
  });

  final Widget content;
  final String badgeText;
  final Function(CloseableBoxController controller)? onControllerCreated;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onClose;
  final String? onTapSemanticsHint;
  final Widget? leading;
  final Widget? trailing;
  final Color? badgeColor;
  final Color? badgeShadowColor;
  final List<Color>? gradientColors;

  @override
  State<SBBPromotionBox> createState() => _SBBPromotionBoxState();
}

class _SBBPromotionBoxState extends State<SBBPromotionBox> with SingleTickerProviderStateMixin {
  final _badgeKey = GlobalKey();
  late final CloseableBoxController _controller = CloseableBoxController(this);

  Size _badgeSize = Size.zero;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _repaint(),
    );
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

  Widget _animationBuilder({
    required Animation<double> animation,
    required Widget child,
  }) {
    return SizeTransition(
      axisAlignment: -1.0,
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).promotionBox!;
    final iconStyle = SBBButtonStyles.of(context).iconTextStyle;
    final paddingTop = _badgeSize.height / 2.0;
    return _animationBuilder(
      animation: _controller.animation,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.0,
                    color: SBBColors.transparent,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(sbbDefaultSpacing + 5.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.badgeShadowColor ?? style.badgeShadowColor!,
                      spreadRadius: 10.0,
                    ),
                  ],
                ),
                child: SizedBox.fromSize(size: _badgeSize),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: paddingTop),
              decoration: BoxDecoration(
                border: Border.all(color: style.borderColor!),
                borderRadius: const BorderRadius.all(
                  Radius.circular(sbbDefaultSpacing),
                ),
                image: DecorationImage(
                  image: const AssetImage(_PromotionBoxAssets.noise),
                  repeat: ImageRepeat.repeat,
                  fit: BoxFit.none,
                  opacity: style.textureOpacity!,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: widget.gradientColors ?? style.gradientColors!,
                  stops: const [
                    0.0,
                    0.406,
                    0.672,
                    1.0,
                  ],
                ),
              ),
              child: Material(
                color: SBBColors.transparent,
                child: Semantics(
                  hint: widget.onTapSemanticsHint,
                  child: InkWell(
                    focusColor: iconStyle?.backgroundColorHighlighted,
                    hoverColor: iconStyle?.backgroundColorHighlighted,
                    customBorder: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(sbbDefaultSpacing),
                      ),
                    ),
                    onTap: widget.onTap,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        sbbDefaultSpacing,
                        sbbDefaultSpacing,
                        8.0,
                        sbbDefaultSpacing,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (widget.leading != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: widget.leading!,
                            ),
                          Expanded(
                            child: widget.content,
                          ),
                          if (widget.trailing != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: widget.trailing!,
                            ),
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
                badgeColor: widget.badgeColor,
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
  const _DefaultContent({
    required this.title,
    required this.description,
    this.onTap,
    this.onClose,
  });

  final String title;
  final String description;
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
          children: [
            Expanded(
              child: Text(
                title,
                style: textTheme.titleMedium,
              ),
            ),
            if (onClose != null) const SizedBox(width: sbbIconSizeSmall),
            const SizedBox(width: 8.0),
          ],
        ),
        const SizedBox(height: 4.0),
        Row(
          children: [
            Expanded(
              child: Text(
                description,
                style: textTheme.bodyMedium,
              ),
            ),
            if (onTap != null)
              Icon(
                SBBIcons.chevron_small_right_small,
                color: crossColor,
                size: sbbIconSizeSmall,
              )
            else
              const SizedBox(
                width: sbbDefaultSpacing * 0.5,
              ),
          ],
        ),
      ],
    );
  }
}
