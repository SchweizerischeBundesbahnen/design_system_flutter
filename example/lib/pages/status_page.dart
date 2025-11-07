import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

const String text = 'Lorem ipsum sit dolor';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: [
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Default'),
        SBBGroup(
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: Column(
            spacing: sbbDefaultSpacing,
            children: [
              SBBStatus.alert(text: text),
              SBBStatus.warning(text: text),
              SBBStatus.success(text: text),
              SBBStatus.information(text: text),
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
              SBBStatus.alert(text: '$text $text $text $text'),
              SBBStatus.warning(text: '$text $text $text $text'),
              SBBStatus.success(text: '$text $text $text $text'),
              SBBStatus.information(text: '$text $text $text $text'),
            ],
          ),
        ),
      ],
    );
  }
}
