import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class ListHeaderPage extends StatelessWidget {
  const ListHeaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: [
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('List Header'),
        SBBContentBox(child: Container(height: 125.0)),
        const SizedBox(height: sbbDefaultSpacing),
      ],
    );
  }
}
