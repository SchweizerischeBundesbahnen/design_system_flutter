import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class HeaderPage extends StatelessWidget {
  const HeaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(padding: .all(SBBSpacing.medium), child: ThemeModeSegmentedButton()),
        const SBBListHeader('No leading Widget'),
        const SBBHeader(titleText: 'Title', automaticallyImplyLeading: false),
        const SizedBox(height: SBBSpacing.medium),
        const SBBListHeader('Menu'),
        SBBHeader.menu(titleText: 'Title'),
        const SizedBox(height: SBBSpacing.medium),
        const SBBListHeader('Back'),
        SBBHeader.back(titleText: 'Title'),
        const SizedBox(height: SBBSpacing.medium),
        const SBBListHeader('Close'),
        SBBHeader.close(titleText: 'Title'),
      ],
    );
  }
}
