import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(color: Colors.yellow, width: 360, height: 10),
        SBBModalAnchoredBuilder(
          collapsedBuilder:
              (context, showOverlay) => SBBIconButtonLarge(icon: SBBIcons.airplane_medium, onPressed: showOverlay),
          overlayBuilder: (context, _) {
            return SBBPopover(child: Container(height: 200, width: 200));
          },
        ),
        Container(color: Colors.green, width: 100, height: 100),
      ],
    );
    content(String text) => SizedBox(
      height: sbbDefaultSpacing * 2,
      width: double.infinity,
      child: Center(child: Text(text)),
    );
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: <Widget>[
        ThemeModeSegmentedButton(),
        SizedBox(height: sbbDefaultSpacing * 2),
        // SBBPopover(),
        SBBGroup(child: content('Default')),
        SizedBox(height: sbbDefaultSpacing),
        SBBGroup(color: SBBColors.royal, child: content('Different Color')),
        SizedBox(height: sbbDefaultSpacing),
        SBBGroup(padding: EdgeInsets.symmetric(vertical: sbbDefaultSpacing), child: content('Extra padding')),
        SizedBox(height: sbbDefaultSpacing),
        SBBGroup(margin: EdgeInsets.all(sbbDefaultSpacing * 4), child: content('Extra margin')),
      ],
    );
  }
}
