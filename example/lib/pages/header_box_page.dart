import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

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
            children: <Widget>[
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
    return Column(
      children: [
        const SizedBox(height: sbbDefaultSpacing),
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
            label: 'Label',
            icon: SBBIcons.dog_small,
            onPressed: () => sbbToast.show(title: 'Default pressed', bottom: sbbDefaultSpacing * 6),
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Large'),
        SBBHeaderbox.large(
          title: 'Title',
          leadingIcon: SBBIcons.dog_medium,
          secondaryLabel: 'Subtext',
          trailingWidget: SBBIconButtonLarge(
            icon: SBBIcons.dog_small,
            onPressed: () => sbbToast.show(title: 'Large pressed', bottom: sbbDefaultSpacing * 6),
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Custom'),
        const SBBHeaderbox.custom(
          padding: EdgeInsets.zero,
          flap: SBBHeaderboxFlap.custom(child: Center(child: Text('Choooooo!', style: SBBTextStyles.extraSmallBold))),
          child: Center(child: Text('🚂｡🚋｡🚋｡🚋｡🚋˙⊹⁺.')),
        ),
      ],
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        _body(),
        SBBHeaderbox.custom(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    label: 'Expand',
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
        title: 'Cover me!',
        description: 'This screen is non scrollable.\nUsing a Stack, the Headerbox will simply lay on top of it.',
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    label: 'Expand',
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
          itemBuilder:
              (context, index) => SBBListItem(
                title: 'Item $index',
                onPressed: () => sbbToast.show(title: 'Pressed Item $index', bottom: sbbDefaultSpacing * 6),
              ),
        ),
      ],
    );
  }
}

class FloatingPage extends StatefulWidget {
  const FloatingPage({super.key});

  @override
  State<FloatingPage> createState() => _FloatingPageState();
}

class _FloatingPageState extends State<FloatingPage> {
  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    final style = SBBBaseStyle.of(context);
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(
          floating: true,
          padding: EdgeInsets.zero,
          flap: SBBHeaderboxFlap(
            title: 'Thursday, 01/31/2025',
            allowFloating: true,
          ),
          child: SBBStackedColumn(
            children: [
              SBBStackedItem.crossfade(
                firstChild: Padding(
                  padding: const EdgeInsets.all(sbbDefaultSpacing),
                  child: Text(
                    'Bern → Bern Wankdorf',
                    style: SBBTextStyles.mediumBold,
                  ),
                ),
                secondChild: Padding(
                  padding: const EdgeInsets.only(left: sbbDefaultSpacing, top: sbbDefaultSpacing * 0.5),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: sbbDefaultSpacing),
                              child: _circle(context),
                            ),
                          ),
                          Positioned(
                            top: sbbDefaultSpacing * 2,
                            bottom: sbbDefaultSpacing * 2,
                            left: sbbDefaultSpacing * 0.5 - 0.5,
                            child: Container(
                              color: style.labelColor,
                              width: 1,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: sbbDefaultSpacing),
                              child: _circle(context),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: OverflowBox(
                                maxHeight: double.infinity,
                                child: SBBTextField(
                                  labelText: 'Origin',
                                ),
                              ),
                            ),
                            Flexible(
                              child: OverflowBox(
                                maxHeight: double.infinity,
                                child: SBBTextField(
                                  labelText: 'Destination',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SBBStackedItem.aligned(
                alignment: AlignmentDirectional.bottomStart,
                clipBehavior: Clip.hardEdge,
                builder: (context, state, child) => Opacity(
                  opacity: state.localExpansionRate,
                  child: child,
                ),
                child: Row(
                  children: [
                    SizedBox(width: 48),
                    Center(child: Text("Footer that gets pushed up")),
                    Spacer(),
                    Material(
                      color: SBBColors.transparent,
                      child: InkWell(
                        onTap: () => sbbToast.show(title: 'Show options', bottom: sbbDefaultSpacing * 6),
                        child: Container(
                          decoration: BoxDecoration(
                            border: BorderDirectional(
                              start: BorderSide(color: style.dividerColor!),
                            ),
                          ),
                          padding: EdgeInsets.all(12.0),
                          margin: EdgeInsets.zero,
                          child: Icon(SBBIcons.controls_small),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SliverList.builder(
          itemCount: 60,
          itemBuilder: (context, index) => SBBListItem(
            title: 'Item $index',
            onPressed: () => sbbToast.show(title: 'Pressed Item $index', bottom: sbbDefaultSpacing * 6),
          ),
        )
      ],
    );
  }

  Container _circle(BuildContext context) {
    final theme = Theme.of(context);
    var decoration = BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: theme.colorScheme.onSurface,
      ),
    );
    return Container(
      decoration: decoration,
      width: sbbDefaultSpacing,
      height: sbbDefaultSpacing,
      child: Container(
        decoration: decoration,
        margin: EdgeInsets.all(3),
      ),
    );
  }
}

class _DemoItem extends SBBTabBarItem {
  _DemoItem(int id, IconData icon) : super(id.toString(), icon);

  @override
  String translate(BuildContext context) => '';
}
