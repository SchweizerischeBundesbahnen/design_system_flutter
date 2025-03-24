import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  State<TabBarPage> createState() => TabBarPageState();
}

class TabBarPageState extends State<TabBarPage> {
  var items = <TabBarItem>[
    _DemoItem('1', SBBIcons.train_small),
    _DemoItem('2', SBBIcons.station_small),
    _DemoItem('3', SBBIcons.archive_box_small),
    _DemoItem('4', SBBIcons.archive_box_small),
    _DemoItem('5', SBBIcons.archive_box_small),
    _DemoItem('6', SBBIcons.archive_box_small),
    // _DemoItem('7', SBBIcons.archive_box_small),
  ];

  bool visible = true;

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(sbbDefaultSpacing),
          child: ThemeModeSegmentedButton(),
        ),
        Expanded(child: Container()),
        SBBTabBar(
          items: items,
          showWarning: true,
          onTabChanged: (task) async {},
          warningSemantics: 'Warning',
          onTap: (tab) {
            sbbToast.show(message: 'Tab tapped: Item ${tab.id}');
          },
        ),
        Expanded(child: Container()),
        SBBPrimaryButton(
          label: 'toggle',
          onPressed: () => setState(() => items = <TabBarItem>[
                _DemoItem('1', SBBIcons.train_small),
                _DemoItem('2', SBBIcons.station_small),
                _DemoItem('3', SBBIcons.archive_box_small),
                _DemoItem('4', SBBIcons.arrow_compass_small),
                _DemoItem('5', SBBIcons.station_small),
              ]),
        ),
      ],
    );
  }
}

class _DemoItem extends TabBarItem {
  _DemoItem(super.id, super.icon);

  @override
  String translate(BuildContext context) => 'Item $id';
}
