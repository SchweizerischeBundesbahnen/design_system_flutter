import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return DemoPageScaffold(
      body: Column(
        children: [
          const SBBListHeader('Primary Button'),
          SBBContentBox(
            padding: const .all(SBBSpacing.medium),
            child: Column(
              spacing: SBBSpacing.medium,
              children: [
                SBBPrimaryButton(
                  labelText: 'Default',
                  onPressed: () => sbbToast.show(titleText: 'SBBPrimaryButton'),
                  onLongPress: () => sbbToast.show(titleText: 'Long SBBPrimaryButton'),
                ),
                const SBBPrimaryButton(labelText: 'Disabled', onPressed: null),
                SBBPrimaryButton(onPressed: () {}, isLoading: true),
              ],
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Secondary Button'),
          SBBContentBox(
            padding: const .all(SBBSpacing.medium),
            child: Column(
              children: [
                SBBSecondaryButton(
                  labelText: 'Default',
                  onPressed: () => sbbToast.show(titleText: 'SBBSecondaryButton'),
                ),
                const SizedBox(height: SBBSpacing.medium),
                const SBBSecondaryButton(labelText: 'Disabled', onPressed: null),
                const SizedBox(height: SBBSpacing.medium),
                SBBSecondaryButton(onPressed: () {}, isLoading: true),
              ],
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Tertiary Button'),
          SBBContentBox(
            padding: const .all(SBBSpacing.medium),
            child: SizedBox(
              width: .infinity,
              child: Column(
                spacing: SBBSpacing.medium,
                children: [
                  SBBTertiaryButton(
                    iconData: SBBIcons.dog_small,
                    labelText: 'Default',
                    onPressed: () => sbbToast.show(titleText: 'SBBTertiaryButton'),
                    onLongPress: () => sbbToast.show(titleText: 'SBBTertiaryButton Long Press'),
                  ),
                  const SBBTertiaryButton(labelText: 'Disabled', onPressed: null),
                  SBBTertiaryButton(onPressed: () {}, isLoading: true),
                  SBBTertiaryButton(
                    iconData: SBBIcons.dog_small,
                    onPressed: () => sbbToast.show(titleText: 'SBBTertiaryButton only icon'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Tertiary Button Small'),
          SBBContentBox(
            padding: const .all(SBBSpacing.medium),
            child: SizedBox(
              width: .infinity,
              child: Column(
                spacing: SBBSpacing.medium,
                children: [
                  SBBTertiaryButtonSmall(
                    iconData: SBBIcons.dog_small,
                    labelText: 'Default',
                    onPressed: () => sbbToast.show(titleText: 'SBBTertiaryButtonSmall'),
                    onLongPress: () => sbbToast.show(titleText: 'SBBTertiaryButtonSmall Long Press'),
                  ),
                  const SBBTertiaryButtonSmall(labelText: 'Disabled', onPressed: null),
                  SBBTertiaryButtonSmall(onPressed: () {}, isLoading: true),
                  SBBTertiaryButtonSmall(
                    iconData: SBBIcons.dog_small,
                    onPressed: () => sbbToast.show(titleText: 'SBBTertiaryButtonSmall only icon'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Accent Button'),
          SBBContentBox(
            padding: const EdgeInsets.all(SBBSpacing.medium),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                spacing: SBBSpacing.medium,
                children: [
                  SBBAccentButton(
                    labelText: 'Default',
                    onPressed: () => sbbToast.show(titleText: 'SBBAccentButton'),
                    onLongPress: () => sbbToast.show(titleText: 'SBBAccentButton Long Press'),
                  ),
                  const SBBAccentButton(labelText: 'Disabled', onPressed: null),
                  SBBAccentButton(onPressed: () {}, isLoading: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
