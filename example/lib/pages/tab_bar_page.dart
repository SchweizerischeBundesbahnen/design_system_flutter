import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  State<TabBarPage> createState() => TabBarPageState();
}

class TabBarPageState extends State<TabBarPage> {
  final items = <_DemoItem>[
    _DemoItem('0', SBBIcons.train_small),
    _DemoItem('1', SBBIcons.station_small),
    _DemoItem('2', SBBIcons.archive_box_small),
    _DemoItem('3', SBBIcons.arrow_compass_small),
    _DemoItem('4', SBBIcons.arrow_compass_small),
  ];

  late PageController _pageViewController;
  late SBBTabBarController _tabBarController;

  bool visible = true;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabBarController = SBBTabBarController(items, items.first)
      ..setWarnings([
        SBBTabBarWarningSetting(id: '2', semantics: 'Warning 1', shown: false),
      ])
      ..setBadges([
        SBBTabBarItemBadge(
          id: '3',
          badge: SBBTabBarBadgeText(labelText: '9'),
          displayMode: SBBTabBarItemBadgeDisplayMode.always,
          offset: Offset(5.0, -2.0),
        ),
        SBBTabBarItemBadge(
          id: '4',
          badge: SBBTabBarBadgeIcon(badgeIcon: SBBBadgeIconData.checkmark),
          displayMode: SBBTabBarItemBadgeDisplayMode.always,
          offset: Offset(5.0, -2.0),
        ),
        SBBTabBarItemBadge(
          id: '5',
          badge: SBBTabBarBadgeIcon(badgeIcon: SBBBadgeIconData.exclamationMark),
          autoDismiss: true,
          offset: Offset(5.0, -2.0),
        ),
      ]);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return Column(
      children: [
        Expanded(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageViewController,
            children: items.map((item) => _DemoPage(item: item)).toList(),
          ),
        ),
        SBBTabBar.controller(
          onTabChanged: (task) async {
            task.then((value) => _handlePageViewChanged(int.parse(value.id)));
          },
          controller: _tabBarController,
          onTap: (tab) {
            if (_tabBarController.selectedTab == tab) {
              sbbToast.show(titleText: 'Tab tapped: Item ${tab.id}', bottom: 112);
            }
          },
        ),
      ],
    );
  }

  void _handlePageViewChanged(int newPageIndex) {
    _pageViewController.animateToPage(
      newPageIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

class _DemoPage extends StatelessWidget {
  const _DemoPage({required this.item});

  final _DemoItem item;

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      body: Padding(
        padding: const .all(SBBSpacing.xLarge),
        child: Column(
          children: [
            Icon(item.icon),
            Text(
              item.translate(context),
              style: sbbTextStyle.boldStyle.xLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _DemoItem extends SBBTabBarItem {
  _DemoItem(super.id, super.icon);

  @override
  String translate(BuildContext context) => 'Item $id';
}
