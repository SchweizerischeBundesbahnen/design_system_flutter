import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class ContainerPage extends StatelessWidget {
  const ContainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      body: Column(
        children: [
          SBBListHeader('ContentBox'),
          SBBContentBox(child: _content('Default')),
          SizedBox(height: SBBSpacing.medium),
          SBBContentBox(color: SBBColors.royal, child: _content('Different Color')),
          SizedBox(height: SBBSpacing.medium),
          SBBContentBox(
            padding: .symmetric(vertical: SBBSpacing.medium),
            child: _content('Extra padding'),
          ),
          SizedBox(height: SBBSpacing.medium),
          SBBContentBox(margin: .all(64.0), child: _content('Extra margin')),
        ],
      ),
    );
  }

  Widget _content(String text) {
    return SizedBox(
      height: SBBSpacing.xLarge,
      width: .infinity,
      child: Center(child: Text(text)),
    );
  }
}
