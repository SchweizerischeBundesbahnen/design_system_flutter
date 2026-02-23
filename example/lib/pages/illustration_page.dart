import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class IllustrationPage extends StatelessWidget {
  const IllustrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(child: ThemeModeSegmentedButton()),
        SliverPadding(
          padding: const .symmetric(horizontal: SBBSpacing.xSmall, vertical: SBBSpacing.medium),
          sliver: SliverList.list(
            children: [
              SBBListHeader('Staff Female'),
              SBBIllustration.staffFemale(),
              SBBListHeader('Staff Male'),
              SBBIllustration.staffMale(),
              SBBListHeader('Display'),
              SBBIllustration.display(),
              SBBListHeader('Binoculars'),
              SBBIllustration.binoculars(),
              SBBListHeader('Telescope'),
              SBBIllustration.telescope(),
              SBBListHeader('Train'),
              SBBIllustration.train(),
              SBBListHeader('Elevator'),
              SBBIllustration.elevator(),
              SBBListHeader('Boat'),
              SBBIllustration.boat(),
              SBBListHeader('CableCar'),
              SBBIllustration.cableCar(),
            ],
          ),
        ),
      ],
    );
  }
}
