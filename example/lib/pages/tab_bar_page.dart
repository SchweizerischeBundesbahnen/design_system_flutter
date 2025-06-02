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
  late TabBarController controller = TabBarController(items, items.first)
    ..setWarnings([
      TabBarWarningSetting(id: '3', semantics: '', shown: false),
      TabBarWarningSetting(id: '2', semantics: '', shown: false),
    ]);

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
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
            child: Row(
              spacing: 8.0,
              children: [
                Expanded(
                  child: SBBPrimaryButton(
                    label: 'toggle visibility',
                    onPressed: () => setState(() => visible = !visible),
                  ),
                ),
                Expanded(
                  child: SBBPrimaryButton(
                    label: 'move warning',
                    onPressed: () => {},
                  ),
                ),
              ],
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
  String translate(BuildContext context) => 'ItemEINSTELLUNGEN $id';
}
