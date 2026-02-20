import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

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

  bool _isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(
          child: Column(
            spacing: SBBSpacing.small,
            children: [
              const ThemeModeSegmentedButton(),
              SBBSegmentedButton(
                segments: [
                  SBBButtonSegment(value: true, labelText: 'All enabled'),
                  SBBButtonSegment(value: false, labelText: 'All Disabled'),
                ],
                selected: _isEnabled,
                onSelectionChanged: (update) => setState(() => _isEnabled = update),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(
            vertical: SBBSpacing.xLarge,
            horizontal: SBBSpacing.xxSmall,
          ).copyWith(top: SBBSpacing.medium),
          sliver: SliverList.list(
            children: [
              const SBBListHeader('Default'),
              SBBContentBox(
                margin: const .symmetric(horizontal: SBBSpacing.medium),
                padding: const .all(SBBSpacing.medium),
                child: SBBSlider(
                  onChanged: _isEnabled
                      ? (value) {
                          setState(() {
                            _defaultSliderValue = value;
                          });
                        }
                      : null,
                  leadingIconData: SBBIcons.walk_slow_small,
                  trailingIconData: SBBIcons.walk_fast_small,
                  value: _defaultSliderValue,
                  max: _sliderMaxValue,
                ),
              ),
              const SBBListHeader('Without Icons'),
              SBBContentBox(
                margin: const .symmetric(horizontal: SBBSpacing.medium),
                padding: const .all(SBBSpacing.medium),
                child: SBBSlider(
                  onChanged: _isEnabled
                      ? (value) {
                          setState(() {
                            _iconlessSliderValue = value;
                          });
                        }
                      : null,
                  value: _iconlessSliderValue,
                  max: _sliderMaxValue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
