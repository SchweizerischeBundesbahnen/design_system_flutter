import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class IconPage extends StatelessWidget {
  const IconPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      child: Column(
        children: [
          const ThemeModeSegmentedButton(),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Small Icons'),
          _IconShowCase(
            icons: SBBIconsIndex.iconsSmall,
            iconSize: sbbIconSizeSmall,
            sbbToast: sbbToast,
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Medium Icons'),
          _IconShowCase(
            icons: SBBIconsIndex.iconsMedium,
            iconSize: sbbIconSizeMedium,
            sbbToast: sbbToast,
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Large Icons'),
          _IconShowCase(
            icons: SBBIconsIndex.iconsLarge,
            iconSize: sbbIconSizeLarge,
            sbbToast: sbbToast,
          ),
        ],
      ),
    );
  }
}

class _IconShowCase extends StatelessWidget {
  const _IconShowCase({
    required this.icons,
    required this.iconSize,
    required this.sbbToast,
  });

  final List<Map<String, Object>> icons;
  final double iconSize;
  final SBBToast sbbToast;

  @override
  Widget build(BuildContext context) {
    return SBBGroup(
      padding: const EdgeInsets.all(sbbDefaultSpacing / 2),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: iconSize + sbbDefaultSpacing,
        ),
        itemCount: icons.length,
        itemBuilder: (BuildContext context, index) {
          final icon = icons[index];
          return IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(icon['icon'] as IconData, size: iconSize),
            onPressed: () {
              sbbToast.show(title: icon['name'] as String);
            },
          );
        },
      ),
    );
  }
}
