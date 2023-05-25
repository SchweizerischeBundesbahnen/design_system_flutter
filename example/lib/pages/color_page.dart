import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class ColorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            sbbDefaultSpacing,
            sbbDefaultSpacing,
            sbbDefaultSpacing,
            sbbDefaultSpacing * 0.5,
          ),
          child: const ThemeModeSegmentedButton(),
        ),
        _ColorShowcase(
          title: 'Colors',
          colorEntries: _colors,
        ),
        _ColorShowcase(
          title: 'Functional colors',
          colorEntries: _functionalColors,
        ),
        _ColorShowcase(
          title: 'Off brand colors',
          colorEntries: _offBrandColors,
        ),
      ],
    );
  }
}

class _ColorShowcase extends StatelessWidget {
  const _ColorShowcase({
    Key? key,
    required this.title,
    required this.colorEntries,
  }) : super(key: key);

  final String title;
  final List<_ColorEntry> colorEntries;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(sbbDefaultSpacing * 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: sbbDefaultSpacing * 0.5,
            ),
            child: Text(
              title,
              style: SBBControlStyles.of(context).listHeaderTextStyle,
            ),
          ),
          // const SBBListHeader('Small Icons'),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: sbbDefaultSpacing * 10,
            ),
            itemCount: colorEntries.length,
            itemBuilder: (BuildContext context, index) {
              final colorEntry = colorEntries[index];
              return _ColorShowcaseCard(
                colorEntry: colorEntry,
              );
            },
          )
        ],
      ),
    );
  }
}

class _ColorShowcaseCard extends StatelessWidget {
  const _ColorShowcaseCard({
    Key? key,
    required this.colorEntry,
  }) : super(key: key);

  final _ColorEntry colorEntry;

  @override
  Widget build(BuildContext context) {
    final valueString =
        colorEntry.color.value.toRadixString(16).padLeft(8, '0').toUpperCase();
    final hexString = valueString.substring(2);
    final opacityString = valueString.substring(0, 2);
    const colorValueTextStyle = SBBTextStyles.helpersLabel;
    final colorValueSecondaryTextStyle = SBBTextStyles.helpersLabel.copyWith(
      color: SBBControlStyles.of(context).selectLabel?.textStyleDisabled?.color,
    );
    return SBBGroup(
      useShadow: true,
      margin: EdgeInsets.all(
        sbbDefaultSpacing * 0.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: colorEntry.color,
            ),
          ),
          // Divider(),
          Container(
            padding: EdgeInsets.all(
              sbbDefaultSpacing * 0.5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(colorEntry.name),
                Row(
                  children: [
                    Text(
                      '#$opacityString',
                      style: colorValueSecondaryTextStyle,
                    ),
                    Expanded(
                      child: Text(
                        hexString,
                        style: colorValueTextStyle,
                      ),
                    ),
                  ],
                ),
                // Text(alphaString),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorEntry {
  const _ColorEntry(
    this.name,
    this.color,
  );

  final String name;
  final Color color;
}

const _colors = [
  _ColorEntry('red', SBBColors.red),
  _ColorEntry('red125', SBBColors.red125),
  _ColorEntry('red150', SBBColors.red150),
  _ColorEntry('redDarkMode', SBBColors.redDarkMode),
  _ColorEntry('white', SBBColors.white),
  _ColorEntry('milk', SBBColors.milk),
  _ColorEntry('cloud', SBBColors.cloud),
  _ColorEntry('silver', SBBColors.silver),
  _ColorEntry('aluminum', SBBColors.aluminum),
  _ColorEntry('platinum', SBBColors.platinum),
  _ColorEntry('cement', SBBColors.cement),
  _ColorEntry('graphite', SBBColors.graphite),
  _ColorEntry('storm', SBBColors.storm),
  _ColorEntry('smoke', SBBColors.smoke),
  _ColorEntry('metal', SBBColors.metal),
  _ColorEntry('granite', SBBColors.granite),
  _ColorEntry('anthracite', SBBColors.anthracite),
  _ColorEntry('iron', SBBColors.iron),
  _ColorEntry('charcoal', SBBColors.charcoal),
  _ColorEntry('midnight', SBBColors.midnight),
  _ColorEntry('black', SBBColors.black),
  _ColorEntry('blue', SBBColors.blue),
  _ColorEntry('transparent', SBBColors.transparent),
];

const _functionalColors = [
  _ColorEntry('sky', SBBColors.sky),
  _ColorEntry('night', SBBColors.night),
  _ColorEntry('violet', SBBColors.violet),
  _ColorEntry('pink', SBBColors.pink),
  _ColorEntry('autumn', SBBColors.autumn),
  _ColorEntry('orange', SBBColors.orange),
  _ColorEntry('peach', SBBColors.peach),
  _ColorEntry('lemon', SBBColors.lemon),
  _ColorEntry('brown', SBBColors.brown),
  _ColorEntry('green', SBBColors.green),
  _ColorEntry('turquoise', SBBColors.turquoise),
];

const _offBrandColors = [
  _ColorEntry('royal', SBBColors.royal),
  _ColorEntry('royal125', SBBColors.royal125),
  _ColorEntry('royal150', SBBColors.royal150),
];
