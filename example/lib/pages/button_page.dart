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
          SBBGroup(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: Column(
              children: [
                SBBPrimaryButton(
                  labelText: 'Default',
                  onPressed: () {
                    sbbToast.show(title: 'SBBPrimaryButton');
                  },
                ),
                const SizedBox(height: sbbDefaultSpacing),
                const SBBPrimaryButton(labelText: 'Disabled', onPressed: null),
                const SizedBox(height: sbbDefaultSpacing),
                SBBPrimaryButton(labelText: 'Loading', onPressed: () {}, isLoading: true),
              ],
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Secondary Button'),
          SBBGroup(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: Column(
              children: [
                SBBSecondaryButton(
                  labelText: 'Default',
                  onPressed: () {
                    sbbToast.show(title: 'SBBSecondaryButton');
                  },
                ),
                const SizedBox(height: sbbDefaultSpacing),
                const SBBSecondaryButton(labelText: 'Disabled', onPressed: null),
                const SizedBox(height: sbbDefaultSpacing),
                SBBSecondaryButton(labelText: 'Loading', onPressed: () {}, isLoading: true),
              ],
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Tertiary Button Large'),
          SBBGroup(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SBBTertiaryButton(
                    labelText: 'Default',
                    onPressed: () {
                      sbbToast.show(title: 'SBBTertiaryButtonLarge');
                    },
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  const SBBTertiaryButton(labelText: 'Disabled', onPressed: null),
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBTertiaryButton(labelText: 'Loading', onPressed: () {}, isLoading: true),
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBTertiaryButton(
                    labelText: 'Icon',
                    iconData: SBBIcons.dog_small,
                    onPressed: () {
                      sbbToast.show(title: 'SBBTertiaryButtonLarge');
                    },
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  const SBBTertiaryButton(
                    labelText: 'Icon Disabled',
                    iconData: SBBIcons.dog_small,
                    onPressed: null,
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBTertiaryButton(
                    labelText: 'Icon Loading',
                    iconData: SBBIcons.dog_small,
                    onPressed: () {},
                    isLoading: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Tertiary Button Small'),
          SBBGroup(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SBBTertiaryButtonSmall(
                    labelText: 'Default',
                    onPressed: () {
                      sbbToast.show(title: 'SBBTertiaryButtonSmall');
                    },
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  const SBBTertiaryButtonSmall(labelText: 'Disabled', onPressed: null),
                  const SizedBox(height: sbbDefaultSpacing),
                  const SBBTertiaryButtonSmall(labelText: 'Loading', onPressed: null, isLoading: true),
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBTertiaryButtonSmall(
                    labelText: 'Icon',
                    iconData: SBBIcons.dog_small,
                    onPressed: () {
                      sbbToast.show(title: 'SBBTertiaryButtonSmall');
                    },
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  const SBBTertiaryButtonSmall(
                    labelText: 'Icon Disabled',
                    iconData: SBBIcons.dog_small,
                    onPressed: null,
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  const SBBTertiaryButtonSmall(
                    labelText: 'Icon Loading',
                    iconData: SBBIcons.dog_small,
                    onPressed: null,
                    isLoading: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Icon Button Large'),
          SBBGroup(
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
          SBBGroup(
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
