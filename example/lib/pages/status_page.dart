import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

const String text = 'Lorem ipsum sit dolor';

class StatusPage extends StatelessWidget {
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
              SBBStatus.alert(text: text),
              const SizedBox(height: sbbDefaultSpacing),
              SBBStatus.warning(text: text),
              const SizedBox(height: sbbDefaultSpacing),
              SBBStatus.success(text: text),
              const SizedBox(height: sbbDefaultSpacing),
              SBBStatus.information(text: text),
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
              SBBStatus.alert(text: '$text $text $text $text'),
              const SizedBox(height: sbbDefaultSpacing),
              SBBStatus.warning(text: '$text $text $text $text'),
              const SizedBox(height: sbbDefaultSpacing),
              SBBStatus.success(text: '$text $text $text $text'),
              const SizedBox(height: sbbDefaultSpacing),
              SBBStatus.information(text: '$text $text $text $text'),
              const SizedBox(height: sbbDefaultSpacing),
            ],
          ),
        ),
      ],
    );
  }
}
