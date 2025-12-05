import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

const String text = 'Lorem ipsum sit dolor';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(child: const ThemeModeSegmentedButton()),
        SliverList.list(
          children: [
            const SBBListHeader('Default'),
            SBBGroup(
              padding: const EdgeInsets.all(sbbDefaultSpacing),
              child: Column(
                spacing: sbbDefaultSpacing,
                children: [
                  SBBStatus.alert(labelText: text),
                  SBBStatus.warning(labelText: text),
                  SBBStatus.success(labelText: text),
                  SBBStatus.information(labelText: text),
                ],
              ),
            ),
            const SBBListHeader('Without text'),
            SBBGroup(
              padding: const EdgeInsets.all(sbbDefaultSpacing),
              child: Row(
                spacing: sbbDefaultSpacing,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SBBStatus.alert(),
                  SBBStatus.warning(),
                  SBBStatus.success(),
                  SBBStatus.information(),
                ],
              ),
            ),
            const SBBListHeader('Long text'),
            SBBGroup(
              padding: const EdgeInsets.all(sbbDefaultSpacing),
              child: Column(
                spacing: sbbDefaultSpacing,
                children: [
                  SBBStatus.alert(labelText: text * 10),
                  SBBStatus.warning(labelText: text * 10),
                  SBBStatus.success(labelText: text * 10),
                  SBBStatus.information(labelText: text * 10),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
