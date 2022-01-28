import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class GroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const childPlaceholder = SizedBox(height: 125.0, width: double.infinity);
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: <Widget>[
        ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Without Shadow (Default)'),
        const SBBGroup(
          child: childPlaceholder,
        ),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('With Shadow (ignored in Dark Mode)'),
        const SBBGroup(
          useShadow: true,
          child: childPlaceholder,
        ),
      ],
    );
  }
}
