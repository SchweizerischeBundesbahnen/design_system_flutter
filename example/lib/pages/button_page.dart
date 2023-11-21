import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class ButtonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    final style = SBBBaseStyle.of(context);
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
                  label: 'Primary Button Default',
                  onPressed: () {
                    sbbToast.show(message: 'SBBPrimaryButton');
                  },
                ),
                const SizedBox(height: sbbDefaultSpacing),
                SBBPrimaryButton(
                  label: 'Primary Button Disabled',
                  onPressed: null,
                ),
                const SizedBox(height: sbbDefaultSpacing),
                SBBPrimaryButton(
                  label: 'Primary Button Loading',
                  onPressed: () {},
                  isLoading: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Primary Button Negative'),
          SBBGroup(
            child: Container(
              padding: const EdgeInsets.all(sbbDefaultSpacing),
              color: style.themeValue(SBBColors.red, SBBColors.transparent),
              child: Column(
                children: [
                  SBBPrimaryButtonNegative(
                    label: 'Primary Button Negative Default',
                    onPressed: () {
                      sbbToast.show(message: 'SBBPrimaryButtonNegative');
                    },
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  const SBBPrimaryButtonNegative(
                    label: 'Primary Button Negative Disabled',
                    onPressed: null,
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBPrimaryButtonNegative(
                    label: 'Primary Button Negative Loading',
                    onPressed: () {},
                    isLoading: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Secondary Button'),
          SBBGroup(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: Column(
              children: [
                SBBSecondaryButton(
                  label: 'Secondary Button Default',
                  onPressed: () {
                    sbbToast.show(message: 'SBBSecondaryButton');
                  },
                ),
                const SizedBox(height: sbbDefaultSpacing),
                SBBSecondaryButton(
                  label: 'Secondary Button Disabled',
                  onPressed: null,
                ),
                const SizedBox(height: sbbDefaultSpacing),
                SBBSecondaryButton(
                  label: 'Secondary Button Loading',
                  onPressed: () {},
                  isLoading: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Tertiary Button Large'),
          SBBGroup(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SBBTertiaryButtonLarge(
                    label: 'Tertiary Button Large Default',
                    onPressed: () {
                      sbbToast.show(message: 'SBBTertiaryButtonLarge');
                    },
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBTertiaryButtonLarge(
                    label: 'Tertiary Button Large Disabled',
                    onPressed: null,
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBTertiaryButtonLarge(
                    label: 'Tertiary Button Large Loading',
                    onPressed: () {},
                    isLoading: true,
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBTertiaryButtonLarge(
                    label: 'Tertiary Button Large Icon',
                    icon: SBBIcons.plus_small,
                    onPressed: () {
                      sbbToast.show(message: 'SBBTertiaryButtonLarge');
                    },
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBTertiaryButtonLarge(
                    label: 'Tertiary Button Large Icon Disabled',
                    icon: SBBIcons.plus_small,
                    onPressed: null,
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBTertiaryButtonLarge(
                    label: 'Tertiary Button Large Icon Loading',
                    icon: SBBIcons.plus_small,
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
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SBBTertiaryButtonSmall(
                    label: 'Tertiary Button Small Default',
                    onPressed: () {
                      sbbToast.show(message: 'SBBTertiaryButtonSmall');
                    },
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  const SBBTertiaryButtonSmall(
                    label: 'Tertiary Button Small Disabled',
                    onPressed: null,
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  const SBBTertiaryButtonSmall(
                    label: 'Tertiary Button Small Loading',
                    onPressed: null,
                    isLoading: true,
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  SBBTertiaryButtonSmall(
                    label: 'Tertiary Button Small Icon',
                    icon: SBBIcons.plus_small,
                    onPressed: () {
                      sbbToast.show(message: 'SBBTertiaryButtonSmall');
                    },
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  const SBBTertiaryButtonSmall(
                    label: 'Tertiary Button Small Icon Disabled',
                    icon: SBBIcons.plus_small,
                    onPressed: null,
                  ),
                  const SizedBox(height: sbbDefaultSpacing),
                  const SBBTertiaryButtonSmall(
                    label: 'Tertiary Button Small Icon Loading',
                    icon: SBBIcons.plus_small,
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
                    sbbToast.show(message: 'SBBIconButtonLarge');
                  },
                  icon: SBBIcons.pen_small,
                ),
                const SizedBox(width: sbbDefaultSpacing),
                const SBBIconButtonLarge(
                  onPressed: null,
                  icon: SBBIcons.pen_small,
                ),
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
                    sbbToast.show(message: 'SBBIconButtonSmall');
                  },
                  icon: SBBIcons.circle_information_small_small,
                ),
                const SizedBox(width: sbbDefaultSpacing),
                const SBBIconButtonSmall(
                  onPressed: null,
                  icon: SBBIcons.circle_information_small_small,
                ),
                const SizedBox(width: sbbDefaultSpacing),
              ],
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Icon Button Small Negative'),
          SBBGroup(
            child: Container(
              padding: const EdgeInsets.all(sbbDefaultSpacing),
              color: style.themeValue(SBBColors.red, SBBColors.transparent),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SBBIconButtonSmallNegative(
                    onPressed: () {
                      sbbToast.show(message: 'SBBIconButtonSmallNegative');
                    },
                    icon: SBBIcons.circle_information_small_small,
                  ),
                  const SizedBox(width: sbbDefaultSpacing),
                  const SBBIconButtonSmallNegative(
                    onPressed: null,
                    icon: SBBIcons.circle_information_small_small,
                  ),
                  const SizedBox(width: sbbDefaultSpacing),
                ],
              ),
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Icon Button Small Borderless'),
          SBBGroup(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SBBIconButtonSmallBorderless(
                  onPressed: () {
                    sbbToast.show(message: 'SBBIconButtonSmallBorderless');
                  },
                  icon: SBBIcons.drag_small,
                ),
                const SizedBox(width: sbbDefaultSpacing),
                const SBBIconButtonSmallBorderless(
                  onPressed: null,
                  icon: SBBIcons.drag_small,
                ),
                const SizedBox(width: sbbDefaultSpacing),
              ],
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Icon Form Button'),
          SBBGroup(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SBBIconFormButton(
                  onPressed: () {
                    sbbToast.show(message: 'SBBIconFormButton');
                  },
                  icon: SBBIcons.pen_small,
                ),
                const SizedBox(width: sbbDefaultSpacing),
                const SBBIconFormButton(
                  onPressed: null,
                  icon: SBBIcons.pen_small,
                ),
              ],
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Icon Text Button'),
          Row(
            children: [
              const SizedBox(height: sbbDefaultSpacing),
              SBBIconTextButton(
                onPressed: () {
                  sbbToast.show(message: 'SBBIconTextButton');
                },
                icon: SBBIcons.station_large,
                label: 'Default',
              ),
              const SizedBox(width: sbbDefaultSpacing),
              const SBBIconTextButton(
                onPressed: null,
                icon: SBBIcons.station_large,
                label: 'Disabled',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
