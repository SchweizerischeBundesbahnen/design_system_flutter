import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import '../sbb_internal.dart';

const _headerBoxMinHeight = 56.0;
const _headerBoxNavBarExtensionHeight = 24.0;
const _headerBoxRadius = Radius.circular(sbbDefaultSpacing);
const _headerBoxFlapTopMargin = 8.0;

class SBBHeaderbox extends StatelessWidget {
  SBBHeaderbox({
    Key? key,
    required String title,
    IconData? leadingIcon,
    String? secondaryLabel,
    Widget? trailingWidget,
    SBBHeaderboxFlap? flap,
  }) : this.custom(
          key: key,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (leadingIcon != null) ...[Icon(leadingIcon), SizedBox(width: sbbDefaultSpacing * .5)],
                        Expanded(child: Text(title, style: SBBTextStyles.mediumBold, overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    if (secondaryLabel != null)
                      Text(secondaryLabel, style: SBBTextStyles.smallLight.copyWith(color: SBBColors.granite))
                  ],
                ),
              ),
              SizedBox(width: sbbDefaultSpacing * .5),
              if (trailingWidget != null) trailingWidget,
            ],
          ),
          flap: flap,
        );

  SBBHeaderbox.large({
    Key? key,
    required String title,
    IconData? leadingIcon,
    String? secondaryLabel,
    Widget? trailingWidget,
    SBBHeaderboxFlap? flap,
  }) : this.custom(
          key: key,
          child: Row(
            children: [
              if (leadingIcon != null) ...[Icon(leadingIcon, size: 36), SizedBox(width: sbbDefaultSpacing * .5)],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: SBBTextStyles.mediumBold, overflow: TextOverflow.ellipsis),
                    SizedBox(height: sbbDefaultSpacing * .25),
                    if (secondaryLabel != null) Text(secondaryLabel, style: SBBTextStyles.mediumLight)
                  ],
                ),
              ),
              SizedBox(width: sbbDefaultSpacing * .5),
              if (trailingWidget != null) trailingWidget,
            ],
          ),
          flap: flap,
        );

  const SBBHeaderbox.custom({
    super.key,
    this.margin = const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
    required this.child,
    this.padding = const EdgeInsets.all(sbbDefaultSpacing),
    this.flap,
  });

  final EdgeInsets margin;
  final Widget child;
  final EdgeInsets padding;
  final SBBHeaderboxFlap? flap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _HeaderBoxBackgroundBar(),
        Padding(padding: margin, child: _HeaderBoxTop(padding: padding, flap: flap, child: child)),
      ],
    );
  }
}

class _HeaderBoxTop extends StatelessWidget {
  const _HeaderBoxTop({
    required this.child,
    required this.padding,
    this.flap,
  });

  final EdgeInsets padding;
  final Widget child;
  final Widget? flap;

  @override
  Widget build(BuildContext context) {
    return flap != null ? _flappedHeaderBox(context) : _headerBox(context);
  }

  Widget _flappedHeaderBox(BuildContext context) {
    return Container(
      decoration: _flappedBackgroundDecoration(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: _headerBoxFlapTopMargin),
            child: _headerBox(context),
          ),
          flap!,
        ],
      ),
    );
  }

  Widget _headerBox(BuildContext context) {
    final SBBHeaderBoxStyle style = SBBHeaderBoxStyle.of(context);
    return Container(
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.all(_headerBoxRadius),
        boxShadow: _headerBoxShadow,
      ),
      constraints: BoxConstraints(minHeight: _headerBoxMinHeight, minWidth: double.infinity),
      padding: padding,
      child: child,
    );
  }

  BoxDecoration _flappedBackgroundDecoration(BuildContext context) {
    final Color flapBackgroundColor = SBBHeaderBoxStyle.of(context).flapBackgroundColor!;
    return BoxDecoration(
      boxShadow: SBBInternal.defaultBoxShadow,
      borderRadius: BorderRadius.only(bottomLeft: _headerBoxRadius, bottomRight: _headerBoxRadius),
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [flapBackgroundColor, flapBackgroundColor, SBBColors.white.withAlpha(0)],
        stops: [0.0, 0.5, 1.0],
      ),
    );
  }

  List<BoxShadow> get _headerBoxShadow =>
      [BoxShadow(color: SBBColors.black.withAlpha(32), blurRadius: 4.0, offset: Offset(0, 2.0))];
}

class _HeaderBoxBackgroundBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // take AppBar background color to align with e.g. SBBHeader
    final Color? headerColorPrimary = Theme.of(context).appBarTheme.backgroundColor;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        color: headerColorPrimary,
        height: _headerBoxNavBarExtensionHeight,
      ),
    );
  }
}
