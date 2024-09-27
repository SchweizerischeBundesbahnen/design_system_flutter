import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class GroupPage extends StatelessWidget {
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
