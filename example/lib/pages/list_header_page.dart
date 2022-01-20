import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ListHeaderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return ListView(
      padding: EdgeInsets.all(sbbDefaultSpacing),
      children: [
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('List Header'),
        SBBGroup(child: Container(height: 125.0)),
        const SizedBox(height: sbbDefaultSpacing),
        SBBListHeader(
          'List Header with Call to Action',
          onCallToAction: () {
            sbbToast.show(message: 'Call to Action');
          },
          icon: SBBIcons.circle_information_small_small,
        ),
        SBBGroup(child: Container(height: 125.0)),
        const SizedBox(height: sbbDefaultSpacing),
      ],
    );
  }
}
