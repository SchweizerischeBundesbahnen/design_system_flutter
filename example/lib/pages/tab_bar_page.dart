import 'package:flutter/services.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  State<TabBarPage> createState() => TabBarPageState();
}

class TabBarPageState extends State<TabBarPage> {
  final items = <TabBarItem>[
    _DemoItem('1', SBBIcons.train_small),
    _DemoItem('2', SBBIcons.station_small),
    _DemoItem('3', SBBIcons.archive_box_small),
    _DemoItem('4', SBBIcons.arrow_compass_small),
    _DemoItem('5', SBBIcons.arrow_compass_small),
  ];

  bool visible = true;
  late TabBarController controller = TabBarController(items, items.first);

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: SystemUiOverlay.values);
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(sbbDefaultSpacing),
            child: ThemeModeSegmentedButton(),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: sbbDefaultSpacing,
              horizontal: 8.0,
            ),
            child: SBBPrimaryButton(
              label: 'toggle',
              onPressed: () => setState(() => visible = !visible),
            ),
          ),
          Visibility(
            visible: visible,
            child: SBBTabBar(
              items: items,
              onTabChanged: (task) async {},
              controller: controller,
              onTap: (tab) {
                sbbToast.show(message: 'Tab tapped: Item ${tab.id}');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoItem extends TabBarItem {
  _DemoItem(super.id, super.icon);

  @override
  String translate(BuildContext context) => 'Item $id';
}
