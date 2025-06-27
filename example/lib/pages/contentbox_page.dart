import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class ContentboxPage extends StatelessWidget {
  const ContentboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    content(String text) =>
        SizedBox(height: sbbDefaultSpacing * 2, width: double.infinity, child: Center(child: Text(text)));
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: <Widget>[
        ThemeModeSegmentedButton(),
        SBBContentbox(child: content('Default')),
        SBBContentbox(color: SBBColors.royal, child: content('Different Color')),
        SBBContentbox(padding: EdgeInsets.symmetric(vertical: sbbDefaultSpacing), child: content('Extra padding')),
        SBBContentbox(margin: EdgeInsets.all(sbbDefaultSpacing * 4), child: content('Extra margin')),
      ],
    );
  }
}
