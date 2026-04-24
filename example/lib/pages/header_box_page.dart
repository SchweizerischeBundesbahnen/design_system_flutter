import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

part 'header_box_page.floating.dart';

class HeaderBoxPage extends StatefulWidget {
  const HeaderBoxPage({super.key});

  @override
  State<HeaderBoxPage> createState() => _HeaderBoxPageState();
}

class _HeaderBoxPageState extends State<HeaderBoxPage> {
  final items = <SBBTabBarItem>[
    _DemoItem(0, SBBIcons.paragraph_small),
    _DemoItem(1, SBBIcons.lock_closed_small),
    _DemoItem(2, SBBIcons.arrows_up_down_small),
    _DemoItem(3, SBBIcons.merge_small),
  ];

  late PageController _pageViewController;
  late SBBTabBarController _tabBarController;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabBarController = SBBTabBarController(items, items.first);
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
            children: [
              DesignGuidelinePage(),
              StaticPage(),
              ScrollablePage(),
              FloatingPage(),
            ],
          ),
        ),
        SBBTabBar.controller(
          onTabChanged: (task) async {
            task.then((value) => _handlePageViewChanged(int.parse(value.id)));
          },
          controller: _tabBarController,
          onTap: (tab) {},
        ),
      ],
    );
  }

  void _handlePageViewChanged(int newPageIndex) {
    FocusManager.instance.primaryFocus?.unfocus();
    _pageViewController.animateToPage(
      newPageIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

class DesignGuidelinePage extends StatelessWidget {
  const DesignGuidelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return DemoPageScaffold(
      body: Column(
        children: [
          const SBBListHeader('Default'),
          SBBHeaderbox(
            title: 'Title',
            leadingIcon: SBBIcons.dog_small,
            secondaryLabel: 'Subtext',
            flap: SBBHeaderboxFlap(
              title: 'Additional text or information',
              leadingIcon: SBBIcons.sign_exclamation_point_small,
              trailingIcon: SBBIcons.circle_information_small_small,
            ),
            trailingWidget: SBBTertiaryButtonSmall(
              labelText: 'Label',
              iconData: SBBIcons.dog_small,
              onPressed: () => sbbToast.show(titleText: 'Default pressed', bottom: 96.0),
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Large'),
          SBBHeaderbox.large(
            title: 'Title',
            leadingIcon: SBBIcons.dog_medium,
            secondaryLabel: 'Subtext',
            trailingWidget: SBBTertiaryButton(
              iconData: SBBIcons.dog_small,
              onPressed: () => sbbToast.show(titleText: 'Large pressed', bottom: 96.0),
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Custom'),
          const SBBHeaderbox.custom(
            padding: .zero,
            flap: SBBHeaderboxFlap.custom(
              child: Center(child: Text('Choooooo!', style: SBBTextStyles.xSmallBold)),
            ),
            child: Center(child: Text('🚂｡🚋｡🚋｡🚋｡🚋˙⊹⁺.')),
          ),
        ],
      ),
    );
  }
}

class StaticPage extends StatefulWidget {
  const StaticPage({super.key});

  @override
  State<StaticPage> createState() => _StaticPageState();
}

class _StaticPageState extends State<StaticPage> {
  bool _headerBoxExpanded = false;
  final _expandedHeight = 340.0;
  final _collapsedHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == .dark;
    return Stack(
      children: [
        _body(),
        SBBHeaderbox.custom(
          child: Column(
            mainAxisSize: .min,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text('Static Screen', style: SBBTextStyles.mediumBold),
                      Text(
                        'Click to expand Headerbox.',
                        style: SBBTextStyles.smallLight.copyWith(
                          color: isDark ? SBBColors.graphite : SBBColors.granite,
                        ),
                      ),
                    ],
                  ),
                  SBBTertiaryButtonSmall(
                    labelText: 'Expand',
                    onPressed: () => setState(() => _headerBoxExpanded = !_headerBoxExpanded),
                  ),
                ],
              ),
              AnimatedContainer(
                curve: Curves.easeInOut,
                height: _headerBoxExpanded ? _expandedHeight : _collapsedHeight,
                duration: Durations.long4,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Center _body() {
    return Center(
      child: SBBMessage(
        titleText: 'Cover me!',
        subtitleText: 'This screen is non scrollable.\nUsing a Stack, the Headerbox will simply lay on top of it.',
      ),
    );
  }
}

class ScrollablePage extends StatefulWidget {
  const ScrollablePage({super.key});

  @override
  State<ScrollablePage> createState() => _ScrollablePageState();
}

class _ScrollablePageState extends State<ScrollablePage> {
  bool _headerBoxExpanded = false;
  final _expandedHeight = 300.0;
  final _collapsedHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    final isDark = Theme.of(context).brightness == .dark;
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(
          child: Column(
            mainAxisSize: .min,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text('Scrollable Screen', style: SBBTextStyles.mediumBold),
                      Text(
                        'Click to expand Headerbox.',
                        style: SBBTextStyles.smallLight.copyWith(
                          color: isDark ? SBBColors.graphite : SBBColors.granite,
                        ),
                      ),
                    ],
                  ),
                  SBBTertiaryButtonSmall(
                    labelText: 'Expand',
                    onPressed: () => setState(() => _headerBoxExpanded = !_headerBoxExpanded),
                  ),
                ],
              ),
              AnimatedContainer(
                curve: Curves.easeInOut,
                height: _headerBoxExpanded ? _expandedHeight : _collapsedHeight,
                duration: Durations.long4,
              ),
            ],
          ),
        ),
        SliverList.builder(
          itemCount: 60,
          itemBuilder: (context, index) => SBBListItem(
            titleText: 'Item $index',
            onTap: () => sbbToast.show(titleText: 'Pressed Item $index', bottom: 96.0),
          ),
        ),
      ],
    );
  }
}

class _DemoItem extends SBBTabBarItem {
  _DemoItem(int id, IconData icon) : super(id.toString(), icon);

  @override
  String translate(BuildContext context) => '';
}
