import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class TabBarPage extends StatefulWidget {
  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  final items = <TabBarItem>[
    _DemoItem('1', SBBIcons.train_small),
    _DemoItem('2', SBBIcons.station_small),
    _DemoItem('3', SBBIcons.archive_box_small),
    _DemoItem('4', SBBIcons.arrow_compass_small),
    _DemoItem('5', SBBIcons.arrow_compass_small),
  ];

  bool visible = true;
  late TabBarController controller = TabBarController(items.first);

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return Column(
      children: [
        const Padding(
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: ThemeModeSegmentedButton(),
        ),
        Expanded(child: Container()),
        if (visible)
          SBBTabBar(
            items: items,
            showWarning: true,
            onTabChanged: (task) async {},
            controller: controller,
            warningSemantics: 'Warning',
            onTap: (tab) {
              sbbToast.show(message: 'Tab tapped: Item ${tab.id}');
            },
          ),
        Expanded(child: Container()),
        SBBPrimaryButton(
          label: 'toggle',
          onPressed: () => setState(() => visible = !visible),
        ),
      ],
    );
  }
}

class _DemoItem extends TabBarItem {
  _DemoItem(String id, IconData icon) : super(id, icon);

  @override
  String translate(BuildContext context) => 'Item $id';
}
