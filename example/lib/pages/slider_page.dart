import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

const _sliderMaxValue = 100.0;

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => SliderPageState();
}

class SliderPageState extends State<SliderPage> {
  double _defaultSliderValue = 50.0;
  double _iconlessSliderValue = 50.0;
  final double _disabledSliderValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: [
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Default'),
        SBBGroup(
          margin: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: SBBSlider(
            onChanged: (value) {
              setState(() {
                _defaultSliderValue = value;
              });
            },
            value: _defaultSliderValue,
            max: _sliderMaxValue,
          ),
        ),
        const SBBListHeader('Without Icons'),
        SBBGroup(
          margin: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: SBBSlider(
            onChanged: (value) {
              setState(() {
                _iconlessSliderValue = value;
              });
            },
            value: _iconlessSliderValue,
            max: _sliderMaxValue,
            startIcon: null,
            endIcon: null,
          ),
        ),
        const SBBListHeader('Disabled'),
        SBBGroup(
          margin: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: SBBSlider(onChanged: null, value: _disabledSliderValue, max: _sliderMaxValue),
        ),
      ],
    );
  }
}
