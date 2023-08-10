import 'dart:ui';

import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import 'promotion_badge.dart';

part 'promotion_box.assets.dart';

part 'promotion_box.controller.dart';

part 'promotion_box.style.dart';

class PromotionBox extends StatefulWidget {
  const PromotionBox({
    required this.title,
    required this.description,
    required this.badgeText,
    super.key,
    this.isClosable = true,
    this.onControllerCreated,
    this.onTap,
  });

  final String title;
  final String description;
  final String badgeText;
  final bool isClosable;
  final Function(PromotionBoxController controller)? onControllerCreated;
  final GestureTapCallback? onTap;

  @override
  State<PromotionBox> createState() => _PromotionBoxState();
}

class _PromotionBoxState extends State<PromotionBox>
    with SingleTickerProviderStateMixin {
  final _badgeKey = GlobalKey();
  late PromotionBoxController _controller = PromotionBoxController(this);

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
    final textTheme = Theme.of(context).textTheme;
    final crossColor = SBBBaseStyle.of(context).defaultTextColor;
    final style = SBBControlStyles.of(context).promotionBox!;
    final iconStyle = SBBButtonStyles.of(context).iconTextStyle;
    final paddingTop = _badgeSize.height / 2.0;
    return _animationBuilder(
      animation: _controller._animation,
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
                  borderRadius: BorderRadius.all(
                    Radius.circular(sbbDefaultSpacing + 5.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: style.badgeShadowColor!,
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
                borderRadius: BorderRadius.all(
                  Radius.circular(sbbDefaultSpacing),
                ),
                image: DecorationImage(
                  image: AssetImage(_PromotionBoxAssets.noise),
                  repeat: ImageRepeat.repeat,
                  fit: BoxFit.none,
                  opacity: style.textureOpacity!,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: style.gradientColors!,
                ),
              ),
              child: Material(
                color: SBBColors.transparent,
                child: InkWell(
                  focusColor: iconStyle?.backgroundColorHighlighted,
                  hoverColor: iconStyle?.backgroundColorHighlighted,
                  customBorder: RoundedRectangleBorder(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.title,
                                style: textTheme.titleMedium,
                              ),
                            ),
                            if (widget.isClosable)
                              SizedBox(width: sbbIconSizeSmall),
                          ],
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.description,
                                style: textTheme.bodyMedium,
                              ),
                            ),
                            SizedBox(
                              width: 24.0,
                              child: widget.onTap == null
                                  ? null
                                  : Icon(
                                      SBBIcons.chevron_small_right_small,
                                      color: crossColor,
                                      size: sbbIconSizeSmall,
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: PromotionBadge(
                key: _badgeKey,
                text: widget.badgeText,
              ),
            ),
            if (widget.isClosable)
              Align(
                alignment: Alignment.topRight,
                child: Material(
                  color: SBBColors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Semantics(
                      label:
                          MaterialLocalizations.of(context).closeButtonTooltip,
                      button: true,
                      child: InkWell(
                        focusColor: iconStyle?.backgroundColorHighlighted,
                        hoverColor: iconStyle?.backgroundColorHighlighted,
                        customBorder: CircleBorder(),
                        onTap: () => _controller.hide(),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            SBBIcons.cross_small,
                            color: crossColor,
                            size: sbbIconSizeSmall,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
