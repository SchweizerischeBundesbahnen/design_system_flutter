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
              SBBIllustration.staffFemale(),
              SizedBox(height: SBBSpacing.medium),
              SBBIllustration.staffMale(),
              SizedBox(height: SBBSpacing.medium),
              SBBIllustration.display(),
              SizedBox(height: SBBSpacing.medium),
              SBBIllustration.binoculars(),
              SizedBox(height: SBBSpacing.medium),
              SBBIllustration.telescope(),
              SizedBox(height: SBBSpacing.medium),
              SBBIllustration.train(),
              SizedBox(height: SBBSpacing.medium),
              SBBIllustration.elevator(),
              SizedBox(height: SBBSpacing.medium),
              SBBIllustration.boat(),
              SizedBox(height: SBBSpacing.medium),
              SBBIllustration.cableCar(),
            ],
          ),
        ),
      ],
    );
  }
}
