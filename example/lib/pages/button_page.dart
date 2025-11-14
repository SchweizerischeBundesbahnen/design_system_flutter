import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(child: ThemeModeSegmentedButton()),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          sliver: SliverList.list(
            children: [
              const SizedBox(height: sbbDefaultSpacing),
              const SBBListHeader('Primary Button'),
              SBBGroup(
                padding: const EdgeInsets.all(sbbDefaultSpacing),
                child: Column(
                  spacing: sbbDefaultSpacing,
                  children: [
                    SBBPrimaryButton(
                      labelText: 'Default',
                      onPressed: () => sbbToast.show(title: 'SBBPrimaryButton'),
                      onLongPress: () => sbbToast.show(title: 'Long SBBPrimaryButton'),
                    ),
                    const SBBPrimaryButton(labelText: 'Disabled', onPressed: null),
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
                    spacing: sbbDefaultSpacing,
                    children: [
                      SBBTertiaryButton(
                        iconData: SBBIcons.dog_small,
                        labelText: 'Default',
                        onPressed: () => sbbToast.show(title: 'SBBTertiaryButton'),
                      ),
                      const SBBTertiaryButton(labelText: 'Disabled', onPressed: null),
                      SBBTertiaryButton(labelText: 'Loading', onPressed: () {}, isLoading: true),
                      SBBTertiaryButton(
                        iconData: SBBIcons.dog_small,
                        onPressed: () => sbbToast.show(title: 'SBBTertiaryButton only icon'),
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
                    spacing: sbbDefaultSpacing,
                    children: [
                      SBBTertiaryButtonSmall(
                        iconData: SBBIcons.dog_small,
                        labelText: 'Default',
                        onPressed: () => sbbToast.show(title: 'SBBTertiaryButton'),
                      ),
                      const SBBTertiaryButtonSmall(labelText: 'Disabled', onPressed: null),
                      SBBTertiaryButtonSmall(labelText: 'Loading', onPressed: () {}, isLoading: true),
                      SBBTertiaryButtonSmall(iconData: SBBIcons.dog_small, onPressed: () {}),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: sbbDefaultSpacing),
              const SBBListHeader('Icon Button Large'),
              SBBGroup(
                padding: const EdgeInsets.all(sbbDefaultSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: sbbDefaultSpacing,
                  children: [
                    SBBIconButtonLarge(
                      onPressed: () => sbbToast.show(title: 'SBBIconButtonLarge'),
                      icon: SBBIcons.glass_cocktail_small,
                    ),
                    const SBBIconButtonLarge(onPressed: null, icon: SBBIcons.glass_cocktail_small),
                  ],
                ),
              ),
              const SizedBox(height: sbbDefaultSpacing),
              const SBBListHeader('Icon Button Small'),
              SBBGroup(
                padding: const EdgeInsets.all(sbbDefaultSpacing),
                child: Row(
                  spacing: sbbDefaultSpacing,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SBBIconButtonSmall(
                      onPressed: () => sbbToast.show(title: 'SBBIconButtonSmall'),
                      icon: SBBIcons.glass_cocktail_small,
                    ),
                    const SBBIconButtonSmall(onPressed: null, icon: SBBIcons.glass_cocktail_small),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
