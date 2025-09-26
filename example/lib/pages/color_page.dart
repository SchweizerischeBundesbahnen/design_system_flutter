import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class ColorPage extends StatelessWidget {
  const ColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
            sbbDefaultSpacing,
            sbbDefaultSpacing,
            sbbDefaultSpacing,
            sbbDefaultSpacing * 0.5,
          ),
          child: ThemeModeSegmentedButton(),
        ),
        _ColorShowcase(title: 'Colors', colorEntries: _colors),
        _ColorShowcase(title: 'Additional colors${isLight ? '' : ' [dark]'}', colorEntries: _additionalColors(context)),
        _ColorShowcase(title: 'Functional colors${isLight ? '' : ' [dark]'}', colorEntries: _functionalColors(context)),
        _ColorShowcase(title: 'Off brand / Safety colors', colorEntries: _offBrandColors),
      ],
    );
  }

  List<_ColorEntry> _additionalColors(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light ? _additionalColorsLight : _additionalColorsDark;

  List<_ColorEntry> _functionalColors(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light ? _functionalColorsLight : _functionalColorsDark;
}

class _ColorShowcase extends StatelessWidget {
  const _ColorShowcase({required this.title, required this.colorEntries});

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
            padding: const EdgeInsetsDirectional.symmetric(horizontal: sbbDefaultSpacing * 0.5),
            child: Text(title, style: SBBControlStyles.of(context).listHeaderTextStyle),
          ),
          // const SBBListHeader('Small Icons'),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: sbbDefaultSpacing * 10),
            itemCount: colorEntries.length,
            itemBuilder: (BuildContext context, index) {
              final colorEntry = colorEntries[index];
              return _ColorShowcaseCard(colorEntry: colorEntry);
            },
          ),
        ],
      ),
    );
  }
}

class _ColorShowcaseCard extends StatelessWidget {
  const _ColorShowcaseCard({required this.colorEntry});

  final _ColorEntry colorEntry;

  @override
  Widget build(BuildContext context) {
    final valueString = colorEntry.color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase();
    final hexString = valueString.substring(2);
    final opacityString = valueString.substring(0, 2);
    const colorValueTextStyle = SBBTextStyles.helpersLabel;
    final colorValueSecondaryTextStyle = SBBTextStyles.helpersLabel.copyWith(
      color: SBBControlStyles.of(context).selectLabel?.textStyleDisabled?.color,
    );
    return SBBGroup(
      margin: const EdgeInsets.all(sbbDefaultSpacing * 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Container(color: colorEntry.color)),
          // Divider(),
          Container(
            padding: const EdgeInsets.all(sbbDefaultSpacing * 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(colorEntry.name),
                Row(
                  children: [
                    Text('#$opacityString', style: colorValueSecondaryTextStyle),
                    Expanded(child: Text(hexString, style: colorValueTextStyle)),
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
  const _ColorEntry(this.name, this.color);

  final String name;
  final Color color;
}

const _colors = [
  _ColorEntry('red', SBBColors.red),
  _ColorEntry('red125', SBBColors.red125),
  _ColorEntry('red150', SBBColors.red150),
  _ColorEntry('redDark', SBBColors.redDark),
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

const _additionalColorsLight = [
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

const _additionalColorsDark = [
  _ColorEntry('sky', SBBColors.skyDark),
  _ColorEntry('night', SBBColors.nightDark),
  _ColorEntry('violet', SBBColors.violetDark),
  _ColorEntry('pink', SBBColors.pinkDark),
  _ColorEntry('autumn', SBBColors.autumnDark),
  _ColorEntry('orange', SBBColors.orangeDark),
  _ColorEntry('peach', SBBColors.peachDark),
  _ColorEntry('lemon', SBBColors.lemonDark),
  _ColorEntry('brown', SBBColors.brownDark),
  _ColorEntry('green', SBBColors.greenDark),
  _ColorEntry('turquoise', SBBColors.turquoiseDark),
];

const _functionalColorsLight = [
  _ColorEntry('success', SBBColors.success),
  _ColorEntry('warning', SBBColors.warning),
  _ColorEntry('error', SBBColors.error),
  _ColorEntry('product', SBBColors.product),
  _ColorEntry('brand', SBBColors.brand),
];

const _functionalColorsDark = [
  _ColorEntry('success', SBBColors.successDark),
  _ColorEntry('warning', SBBColors.warningDark),
  _ColorEntry('error', SBBColors.errorDark),
  _ColorEntry('product', SBBColors.productDark),
  _ColorEntry('brand', SBBColors.brandDark),
];

const _offBrandColors = [
  _ColorEntry('royal', SBBColors.royal),
  _ColorEntry('royalDark', SBBColors.royalDark),
  _ColorEntry('royal125', SBBColors.royal125),
  _ColorEntry('royal150', SBBColors.royal150),
];
