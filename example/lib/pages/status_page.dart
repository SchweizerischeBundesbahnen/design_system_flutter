import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

const String text = 'Lorem ipsum sit dolor';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      body: Column(
        children: [
          const SBBListHeader('Default'),
          SBBContentBox(
            padding: const .all(SBBSpacing.medium),
            child: Column(
              spacing: SBBSpacing.medium,
              children: [
                SBBStatus.alert(labelText: text),
                SBBStatus.warning(labelText: text),
                SBBStatus.success(labelText: text),
                SBBStatus.information(labelText: text),
              ],
            ),
          ),
          const SBBListHeader('Without text'),
          SBBContentBox(
            padding: const .all(SBBSpacing.medium),
            child: Row(
              spacing: SBBSpacing.medium,
              mainAxisAlignment: .center,
              children: [
                SBBStatus.alert(),
                SBBStatus.warning(),
                SBBStatus.success(),
                SBBStatus.information(),
              ],
            ),
          ),
          const SBBListHeader('Long text'),
          SBBContentBox(
            padding: const .all(SBBSpacing.medium),
            child: Column(
              spacing: SBBSpacing.medium,
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
    );
  }
}
