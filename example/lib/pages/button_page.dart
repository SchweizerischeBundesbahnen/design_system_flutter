import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const ThemeModeSegmentedButton(),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Primary Button'),
          SBBContentBox(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: Column(
              children: [
                SBBPrimaryButton(
                  label: 'Default',
                  onPressed: () {
                    sbbToast.show(title: 'SBBPrimaryButton');
                  },
                ),
                const SizedBox(height: sbbDefaultSpacing),
                const SBBPrimaryButton(label: 'Disabled', onPressed: null),
                const SizedBox(height: sbbDefaultSpacing),
                SBBPrimaryButton(label: 'Loading', onPressed: () {}, isLoading: true),
              ],
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Secondary Button'),
          SBBContentBox(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: Column(
              children: [
                SBBSecondaryButton(
                  label: 'Default',
                  onPressed: () {
                    sbbToast.show(title: 'SBBSecondaryButton');
                  },
                ),
                const SizedBox(height: sbbDefaultSpacing),
                const SBBSecondaryButton(label: 'Disabled', onPressed: null),
                const SizedBox(height: sbbDefaultSpacing),
                SBBSecondaryButton(label: 'Loading', onPressed: () {}, isLoading: true),
              ],
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Tertiary Button Large'),
          SBBContentBox(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SBBTertiaryButtonLarge(
                    label: 'Default',
                    onPressed: () {
                      sbbToast.show(title: 'SBBTertiaryButtonLarge');
                    },
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  const SBBTertiaryButtonLarge(label: 'Disabled', onPressed: null),
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBTertiaryButtonLarge(label: 'Loading', onPressed: () {}, isLoading: true),
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBTertiaryButtonLarge(
                    label: 'Icon',
                    icon: SBBIcons.dog_small,
                    onPressed: () {
                      sbbToast.show(title: 'SBBTertiaryButtonLarge');
                    },
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  const SBBTertiaryButtonLarge(label: 'Icon Disabled', icon: SBBIcons.dog_small, onPressed: null),
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBTertiaryButtonLarge(
                    label: 'Icon Loading',
                    icon: SBBIcons.dog_small,
                    onPressed: () {},
                    isLoading: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Tertiary Button Small'),
          SBBContentBox(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SBBTertiaryButtonSmall(
                    label: 'Default',
                    onPressed: () {
                      sbbToast.show(title: 'SBBTertiaryButtonSmall');
                    },
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  const SBBTertiaryButtonSmall(label: 'Disabled', onPressed: null),
                  const SizedBox(height: sbbDefaultSpacing),
                  const SBBTertiaryButtonSmall(label: 'Loading', onPressed: null, isLoading: true),
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBTertiaryButtonSmall(
                    label: 'Icon',
                    icon: SBBIcons.dog_small,
                    onPressed: () {
                      sbbToast.show(title: 'SBBTertiaryButtonSmall');
                    },
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  const SBBTertiaryButtonSmall(label: 'Icon Disabled', icon: SBBIcons.dog_small, onPressed: null),
                  const SizedBox(height: sbbDefaultSpacing),
                  const SBBTertiaryButtonSmall(
                    label: 'Icon Loading',
                    icon: SBBIcons.dog_small,
                    onPressed: null,
                    isLoading: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Icon Button Large'),
          SBBContentBox(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SBBIconButtonLarge(
                  onPressed: () {
                    sbbToast.show(title: 'SBBIconButtonLarge');
                  },
                  icon: SBBIcons.glass_cocktail_small,
                ),
                const SizedBox(width: sbbDefaultSpacing),
                const SBBIconButtonLarge(onPressed: null, icon: SBBIcons.glass_cocktail_small),
              ],
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Icon Button Small'),
          SBBContentBox(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SBBIconButtonSmall(
                  onPressed: () {
                    sbbToast.show(title: 'SBBIconButtonSmall');
                  },
                  icon: SBBIcons.glass_cocktail_small,
                ),
                const SizedBox(width: sbbDefaultSpacing),
                const SBBIconButtonSmall(onPressed: null, icon: SBBIcons.glass_cocktail_small),
                const SizedBox(width: sbbDefaultSpacing),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
