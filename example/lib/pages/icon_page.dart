import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class IconPage extends StatelessWidget {
  const IconPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return DemoPageScaffold(
      body: Column(
        children: [
          const SBBListHeader('Small Icons'),
          _IconShowCase(icons: SBBIconsIndex.iconsSmall, iconSize: sbbIconSizeSmall, sbbToast: sbbToast),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Medium Icons'),
          _IconShowCase(icons: SBBIconsIndex.iconsMedium, iconSize: sbbIconSizeMedium, sbbToast: sbbToast),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Large Icons'),
          _IconShowCase(icons: SBBIconsIndex.iconsLarge, iconSize: sbbIconSizeLarge, sbbToast: sbbToast),
        ],
      ),
    );
  }
}

class _IconShowCase extends StatelessWidget {
  const _IconShowCase({required this.icons, required this.iconSize, required this.sbbToast});

  final List<Map<String, Object>> icons;
  final double iconSize;
  final SBBToast sbbToast;

  @override
  Widget build(BuildContext context) {
    return SBBContentBox(
      padding: const .all(SBBSpacing.xSmall),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: iconSize + SBBSpacing.medium),
        itemCount: icons.length,
        itemBuilder: (context, index) {
          final icon = icons[index];
          return IconButton(
            padding: .zero,
            icon: Icon(icon['icon'] as IconData, size: iconSize),
            onPressed: () {
              sbbToast.show(titleText: icon['name'] as String);
            },
          );
        },
      ),
    );
  }
}
