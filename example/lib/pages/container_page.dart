import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class ContainerPage extends StatelessWidget {
  const ContainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    content(String text) => SizedBox(
      height: sbbDefaultSpacing * 2,
      width: double.infinity,
      child: Center(child: Text(text)),
    );
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(child: ThemeModeSegmentedButton()),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5, vertical: sbbDefaultSpacing),
          sliver: SliverList.list(
            children: [
              SBBListHeader('ContentBox'),
              SBBContentBox(child: content('Default')),
              SizedBox(height: sbbDefaultSpacing),
              SBBContentBox(color: SBBColors.royal, child: content('Different Color')),
              SizedBox(height: sbbDefaultSpacing),
              SBBContentBox(
                padding: EdgeInsets.symmetric(vertical: sbbDefaultSpacing),
                child: content('Extra padding'),
              ),
              SizedBox(height: sbbDefaultSpacing),
              SBBContentBox(margin: EdgeInsets.all(sbbDefaultSpacing * 4), child: content('Extra margin')),
            ],
          ),
        ),
      ],
    );
  }
}
