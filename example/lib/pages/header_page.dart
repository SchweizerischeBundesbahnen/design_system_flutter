import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class HeaderPage extends StatelessWidget {
  const HeaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(sbbDefaultSpacing),
          child: ThemeModeSegmentedButton(),
        ),
        const SBBListHeader('No leading Widget'),
        const SBBHeader(title: 'Title', automaticallyImplyLeading: false),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Menu'),
        const SBBHeader.menu(title: 'Title'),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Back'),
        const SBBHeader.back(title: 'Title'),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Close'),
        const SBBHeader.close(title: 'Title'),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('With Callback on SBB Signet'),
        SBBHeader(
          title: 'Title',
          automaticallyImplyLeading: false,
          onPressedLogo: () => Navigator.maybePop(context),
          logoTooltip: 'Back to home',
        ),
        const SizedBox(height: sbbDefaultSpacing),
      ],
    );
  }
}
