import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class LoadingIndicatorPage extends StatelessWidget {
  const LoadingIndicatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      body: Column(
        children: [
          SBBListHeader('Tiny'),
          SBBContentBox(
            padding: const .all(SBBSpacing.xSmall),
            child: Column(
              children: [
                SizedBox(width: double.infinity),
                SBBLoadingIndicator.tiny(),
                SBBLoadingIndicator.tinyCloud(),
                SBBLoadingIndicator.tinyCement(),
              ],
            ),
          ),
          SBBListHeader('Medium'),
          SBBContentBox(
            padding: const .all(SBBSpacing.xSmall),
            child: Column(
              children: [
                SizedBox(width: double.infinity),
                SBBLoadingIndicator.medium(),
                SBBLoadingIndicator.mediumCloud(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
