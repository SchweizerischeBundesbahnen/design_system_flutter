import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class TypographyPage extends StatelessWidget {
  const TypographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = SBBBaseStyle.of(context).redTextTheme;
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: <Widget>[
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        SBBListHeader('SBB Font Light (Default)'),
        SBBGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TypographyShowcase('sbbTextStyle.xxLarge', sbbTextStyle.xxLarge),
              _TypographyShowcase('sbbTextStyle.xLarge', sbbTextStyle.xLarge),
              _TypographyShowcase('sbbTextStyle.large', sbbTextStyle.large),
              _TypographyShowcase('sbbTextStyle.medium', sbbTextStyle.medium),
              _TypographyShowcase('sbbTextStyle.small', sbbTextStyle.small),
              _TypographyShowcase('sbbTextStyle.xSmall', sbbTextStyle.xSmall, isLastElement: true),
            ],
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing),
        SBBListHeader('SBB Font Bold'),
        SBBGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TypographyShowcase('sbbTextStyle.xxLarge.boldStyle', sbbTextStyle.xxLarge.boldStyle),
              _TypographyShowcase('sbbTextStyle.xLarge.boldStyle', sbbTextStyle.xLarge.boldStyle),
              _TypographyShowcase('sbbTextStyle.large.boldStyle', sbbTextStyle.large.boldStyle),
              _TypographyShowcase('sbbTextStyle.medium.boldStyle', sbbTextStyle.medium.boldStyle),
              _TypographyShowcase('sbbTextStyle.small.boldStyle', sbbTextStyle.small.boldStyle),
              _TypographyShowcase(
                'sbbTextStyle.xSmall.boldStyle',
                sbbTextStyle.xSmall.boldStyle,
                isLastElement: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing),
        SBBListHeader('Red Text Theme'),
        SBBGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TypographyShowcase('SBBBaseStyle.redTextTheme.bodyLarge', textTheme.bodyLarge!),
              _TypographyShowcase('SBBBaseStyle.redTextTheme.bodyMedium', textTheme.bodyMedium!),
              _TypographyShowcase(
                'SBBBaseStyle.redTextTheme.bodySmall',
                textTheme.bodySmall!,
                isLastElement: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TypographyShowcase extends StatelessWidget {
  const _TypographyShowcase(this.name, this.style, {this.isLastElement = false});

  final String name;
  final TextStyle style;
  final bool isLastElement;

  @override
  Widget build(BuildContext context) {
    final labelColor = SBBBaseStyle.of(context).labelColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: sbbDefaultSpacing),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
          child: Text('The quick brown fox jumps over the lazy dog', style: style),
        ),
        const SizedBox(height: sbbDefaultSpacing * 0.5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
          child: Text('$name', style: sbbTextStyle.xSmall.romanStyle.copyWith(color: labelColor)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
          child: Text(
            'FontFamily: ${style.fontFamily?.split('/').last}, '
            'FontSize: ${style.fontSize}, '
            'Height: ${style.height?.toStringAsFixed(2)}',
            style: sbbTextStyle.xSmall.copyWith(color: labelColor),
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing),
        if (!isLastElement) const Divider(),
      ],
    );
  }
}
