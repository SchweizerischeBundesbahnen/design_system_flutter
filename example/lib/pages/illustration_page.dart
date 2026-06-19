import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class IllustrationPage extends StatelessWidget {
  const IllustrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      body: Column(
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
    );
  }
}
