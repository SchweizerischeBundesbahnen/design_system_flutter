import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class HeaderBoxPage extends StatefulWidget {
  const HeaderBoxPage({super.key});

  @override
  State<HeaderBoxPage> createState() => _HeaderBoxPageState();
}

class _HeaderBoxPageState extends State<HeaderBoxPage> {
  final items = <TabBarItem>[
    _DemoItem(0, SBBIcons.train_small),
    _DemoItem(1, SBBIcons.station_small),
    _DemoItem(2, SBBIcons.archive_box_small),
  ];

  late PageController _pageViewController;
  late TabBarController _tabBarController;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabBarController = TabBarController(items.first);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageViewController,
          children: <Widget>[
            SBBHeaderbox.custom(
              flap: SBBHeaderboxFlap(
                title: 'Heeeeelp',
                leadingIcon: SBBIcons.dog_small,
                trailingIcon: SBBIcons.airplane_small,
              ),
              child: Row(
                children: [Icon(SBBIcons.dog_medium), Text('Hello')],
              ),
            ),
            Center(
              child: Text('Second Page'),
            ),
            Center(
              child: Text('Third Page'),
            ),
          ],
        )),
        SBBTabBar(
          items: items,
          onTabChanged: (task) async {
            task.then((value) => _handlePageViewChanged(int.parse(value.id)));
          },
          controller: _tabBarController,
          onTap: (tab) {},
        )
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

class _DemoItem extends TabBarItem {
  _DemoItem(int id, IconData icon) : super(id.toString(), icon);

  @override
  String translate(BuildContext context) => '';
}
