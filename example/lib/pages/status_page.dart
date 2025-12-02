import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

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
            children: [
              SBBStatus.alert(
                label: Container(color: SBBColors.green, child: Text('hello')),
              ),
              const SizedBox(height: sbbDefaultSpacing),
              SBBStatus.warning(labelText: text),
              const SizedBox(height: sbbDefaultSpacing),
              SBBStatus.success(labelText: text),
              const SizedBox(height: sbbDefaultSpacing),
              SBBStatus.information(labelText: text),
              const SizedBox(height: sbbDefaultSpacing),
            ],
          ),
        ),
        const SBBListHeader('Without text'),
        SBBGroup(
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SBBStatus.alert(),
              const SizedBox(width: sbbDefaultSpacing),
              SBBStatus.warning(),
              const SizedBox(width: sbbDefaultSpacing),
              SBBStatus.success(),
              const SizedBox(width: sbbDefaultSpacing),
              SBBStatus.information(),
              const SizedBox(width: sbbDefaultSpacing),
            ],
          ),
        ),
        const SBBListHeader('Long text'),
        SBBGroup(
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: Column(
            children: [
              SBBStatus.alert(
                labelText:
                    '$text $text $text $text $text $text $text $text $text $text $text $text $text $text $text $text ',
              ),
              const SizedBox(height: sbbDefaultSpacing),
              SBBStatus.warning(labelText: '$text $text $text $text'),
              const SizedBox(height: sbbDefaultSpacing),
              SBBStatus.success(labelText: '$text $text $text $text'),
              const SizedBox(height: sbbDefaultSpacing),
              SBBStatus.information(labelText: '$text $text $text $text'),
              const SizedBox(height: sbbDefaultSpacing),
            ],
          ),
        ),
      ],
    );
  }
}
