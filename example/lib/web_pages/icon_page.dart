import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../sbb_icons_index.dart';

class IconPage extends StatelessWidget {
  const IconPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(color: SBBColors.white),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SBBWebText.headerOne('Icons', color: SBBColors.red),
              SBBWebText.headerTwo('Ausprägungen'),
              SBBWebText.headerThree('- Small'),
              _IconGriedView(iconSize: 24.0, icons: SBBIconsIndex.iconsSmall),
              SBBWebText.headerThree('- Medium'),
              _IconGriedView(iconSize: 36.0, icons: SBBIconsIndex.iconsMedium),
              SBBWebText.headerThree('- Large'),
              _IconGriedView(iconSize: 48.0, icons: SBBIconsIndex.iconsLarge),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconGriedView extends StatelessWidget {
  const _IconGriedView({Key? key, required this.iconSize, required this.icons})
      : super(key: key);

  final double iconSize;
  final List<Map<String, Object>> icons;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        height: 200.0,
        child: GridView.builder(
          controller: ScrollController(),
          physics: PageScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: iconSize + sbbDefaultSpacing,
          ),
          itemCount: icons.length,
          itemBuilder: (BuildContext context, index) {
            final icon = icons[index];
            return IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                icon['icon'] as IconData,
                size: iconSize,
              ),
              onPressed: () {
                SBBToast.of(context).show(message: icon['name'] as String);
              },
            );
          },
        ),
      ),
    );
  }
}
