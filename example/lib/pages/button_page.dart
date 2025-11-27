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
                    SBBPrimaryButton(onPressed: () {}, isLoading: true),
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
                      onPressed: () => sbbToast.show(title: 'SBBSecondaryButton'),
                      // onLongPress: () => sbbToast.show(title: 'Long SBBSecondaryButton'),
                    ),
                    const SizedBox(height: sbbDefaultSpacing),
                    const SBBSecondaryButton(labelText: 'Disabled', onPressed: null),
                    const SizedBox(height: sbbDefaultSpacing),
                    SBBSecondaryButton(onPressed: () {}, isLoading: true),
                  ],
                ),
              ),
              const SizedBox(height: sbbDefaultSpacing),
              const SBBListHeader('Tertiary Button'),
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
                        onLongPress: () => sbbToast.show(title: 'SBBTertiaryButton Long Press'),
                      ),
                      const SBBTertiaryButton(labelText: 'Disabled', onPressed: null),
                      SBBTertiaryButton(onPressed: () {}, isLoading: true),
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
                        onPressed: () => sbbToast.show(title: 'SBBTertiaryButtonSmall'),
                        onLongPress: () => sbbToast.show(title: 'SBBTertiaryButtonSmall Long Press'),
                      ),
                      const SBBTertiaryButtonSmall(labelText: 'Disabled', onPressed: null),
                      SBBTertiaryButtonSmall(onPressed: () {}, isLoading: true),
                      SBBTertiaryButtonSmall(
                        iconData: SBBIcons.dog_small,
                        onPressed: () => sbbToast.show(title: 'SBBTertiaryButtonSmall only icon'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
