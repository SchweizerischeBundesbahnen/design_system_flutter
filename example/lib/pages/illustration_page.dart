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
              SBBIllustration.staffMale(),
              SBBIllustration.display(),
              SBBIllustration.binoculars(),
              SBBIllustration.telescope(),
              SBBIllustration.train(),
              SBBIllustration.elevator(),
              SBBIllustration.boat(),
              SBBIllustration.cableCar(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _content(String text) {
    return SizedBox(
      height: SBBSpacing.xLarge,
      width: .infinity,
      child: Center(child: Text(text)),
    );
  }
}
