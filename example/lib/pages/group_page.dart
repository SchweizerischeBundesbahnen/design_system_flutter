import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    const childPlaceholder = SizedBox(height: 125.0, width: double.infinity);
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: const <Widget>[
        ThemeModeSegmentedButton(),
        SizedBox(height: sbbDefaultSpacing),
        SBBListHeader('Without Shadow (Default)'),
        SBBGroup(
          child: childPlaceholder,
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBListHeader('With Shadow (ignored in Dark Mode)'),
        SBBGroup(
          useShadow: true,
          child: childPlaceholder,
        ),
      ],
    );
  }
}
