import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class ContainerPage extends StatelessWidget {
  const ContainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    content(String text) => SizedBox(
      height: SBBSpacing.xLarge,
      width: double.infinity,
      child: Center(child: Text(text)),
    );
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(child: ThemeModeSegmentedButton()),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: SBBSpacing.xSmall, vertical: SBBSpacing.medium),
          sliver: SliverList.list(
            children: [
              SBBListHeader('ContentBox'),
              SBBContentBox(child: content('Default')),
              SizedBox(height: SBBSpacing.medium),
              SBBContentBox(color: SBBColors.royal, child: content('Different Color')),
              SizedBox(height: SBBSpacing.medium),
              SBBContentBox(
                padding: EdgeInsets.symmetric(vertical: SBBSpacing.medium),
                child: content('Extra padding'),
              ),
              SizedBox(height: SBBSpacing.medium),
              SBBContentBox(margin: EdgeInsets.all(SBBSpacing.medium * 4), child: content('Extra margin')),
            ],
          ),
        ),
      ],
    );
  }
}
