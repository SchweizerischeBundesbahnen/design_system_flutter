import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class TypographyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: <Widget>[
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        const TypographyExample(
            'Extra Large (Light)', SBBTextStyles.extraLargeLight),
        const SizedBox(height: sbbDefaultSpacing),
        const TypographyExample('Large (Light)', SBBTextStyles.largeLight),
        const SizedBox(height: sbbDefaultSpacing),
        const TypographyExample('Large (Bold)', SBBTextStyles.largeBold),
        const SizedBox(height: sbbDefaultSpacing),
        const TypographyExample('Medium (Light)', SBBTextStyles.mediumLight),
        const SizedBox(height: sbbDefaultSpacing),
        const TypographyExample('Medium (Bold)', SBBTextStyles.mediumBold),
        const SizedBox(height: sbbDefaultSpacing),
        const TypographyExample('Small (Light)', SBBTextStyles.smallLight),
        const SizedBox(height: sbbDefaultSpacing),
        const TypographyExample('Small (Bold)', SBBTextStyles.smallBold),
        const SizedBox(height: sbbDefaultSpacing),
        const TypographyExample(
            'Extra Small (Light)', SBBTextStyles.extraSmallLight),
        const SizedBox(height: sbbDefaultSpacing),
        const TypographyExample(
            'Extra Small (Bold)', SBBTextStyles.extraSmallBold),
      ],
    );
  }
}

class TypographyExample extends StatelessWidget {
  const TypographyExample(
    this.name,
    this.style,
  );

  final String name;
  final TextStyle style;

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          SBBListHeader(name),
          SBBGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(sbbDefaultSpacing),
                  child: Text('The quick brown fox jumps over the lazy dog',
                      style: style),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(sbbDefaultSpacing),
                  child: Text(
                    'FontSize: ${style.fontSize}\n'
                    'Height: ${style.height?.toStringAsFixed(2)}\n'
                    'FontWeight: ${style.fontWeight}',
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
