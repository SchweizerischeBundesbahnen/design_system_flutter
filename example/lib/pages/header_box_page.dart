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

class DesignGuidelinePage extends StatefulWidget {
  const DesignGuidelinePage({super.key});

  @override
  State<DesignGuidelinePage> createState() => _DesignGuidelinePageState();
}

class _DesignGuidelinePageState extends State<DesignGuidelinePage> {
  bool flapEnabled = true;

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return DemoPageScaffold(
      body: Column(
        children: [
          SBBCheckboxListItemBoxed(
            titleText: 'Show flap',
            value: flapEnabled,
            onChanged: (value) => setState(() {
              flapEnabled = value!;
            }),
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Default'),
          SBBHeaderBox(
            titleText: 'Title',
            leadingIconData: SBBIcons.unicorn_small,
            subtitleText: 'Subtext',
            flap: flapEnabled
                ? SBBHeaderBoxFlap(
                    labelText: 'Additional text or information',
                    leadingIconData: SBBIcons.sign_exclamation_point_small,
                    trailingIconData: SBBIcons.circle_information_small,
                  )
                : null,
            trailing: SBBTertiaryButtonSmall(
              labelText: 'Label',
              iconData: SBBIcons.dog_small,
              onPressed: () => sbbToast.show(titleText: 'Default pressed', bottom: 96.0),
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Large'),
          SBBHeaderBoxLarge(
            titleText: 'Title',
            leadingIconData: SBBIcons.unicorn_small,
            subtitleText: 'Subtext',
            trailing: SBBTertiaryButton(
              iconData: SBBIcons.dog_small,
              onPressed: () => sbbToast.show(titleText: 'Large pressed', bottom: 96.0),
            ),
            flap: flapEnabled
                ? SBBHeaderBoxFlap(
                    labelText: 'Additional text or information',
                    leadingIconData: SBBIcons.sign_exclamation_point_small,
                    trailingIconData: SBBIcons.circle_information_small,
                  )
                : null,
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Custom'),
          SBBHeaderBox(
            padding: .zero,
            flap: flapEnabled
                ? SBBHeaderBoxFlap(
                    label: Center(child: Text('Choooooo!', style: SBBTextStyles.xSmallBold)),
                  )
                : null,
            title: Center(child: Text('🚂｡🚋｡🚋｡🚋｡🚋˙⊹⁺.')),
            isLoading: true,
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
        SBBHeaderBox(
          title: Column(
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
                        'Click to expand Header-Box.',
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
                curve: Curves.easeInOutCubic,
                height: _headerBoxExpanded ? _expandedHeight : _collapsedHeight,
                duration: Durations.medium4,
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
        subtitleText: 'This screen is non scrollable.\nUsing a Stack, the Header-Box will simply lay on top of it.',
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
  int _option = 0;

  bool _floating = true;
  bool _resizing = true;
  FloatingHeaderSnapMode _snapMode = .scroll;
  SBBHeaderBoxTopMode _topMode = .hideable;
  SBBHeaderBoxFlapMode _flapMode = .static;

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderBox(
          top: Padding(
            padding: EdgeInsets.all(SBBSpacing.medium),
            child: SBBSegmentedButtonFilled(
              segments: [
                SBBButtonSegment(value: 0, labelText: 'Option 1'),
                SBBButtonSegment(value: 1, labelText: 'Option 2'),
              ],
              selected: _option,
              onSelectionChanged: (value) {
                setState(() {
                  _option = value;
                });
              },
            ),
          ),
          titleText: 'Sliver Usage',
          subtitleText: 'Try scrolling with the different options.',
          config: SBBSliverHeaderBoxConfig(
            floating: _floating,
            resizing: _resizing,
            snapMode: _snapMode,
            topMode: _topMode,
            flapMode: _flapMode,
          ),
          flap: SBBHeaderBoxFlap(
            labelText: 'This is a flap',
          ),
          body: SBBContractible(
            child: Column(
              children: SBBDivider.divideItems(
                context: context,
                items: [
                  SBBDropdown(
                    triggerDecoration: SBBInputDecoration(
                      labelText: 'Snap Mode',
                      contentPadding: EdgeInsets.zero,
                    ),
                    selectedItem: _snapMode,
                    items: [
                      SBBDropdownItem(value: FloatingHeaderSnapMode.scroll, label: 'Scroll'),
                      SBBDropdownItem(value: FloatingHeaderSnapMode.overlay, label: 'Overlay'),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _snapMode = value!;
                      });
                    },
                  ),
                  SBBDropdown(
                    triggerDecoration: SBBInputDecoration(
                      labelText: 'Top Mode',
                      contentPadding: EdgeInsets.zero,
                    ),
                    selectedItem: _topMode,
                    items: [
                      SBBDropdownItem(value: SBBHeaderBoxTopMode.static, label: 'Static'),
                      SBBDropdownItem(value: SBBHeaderBoxTopMode.hideable, label: 'Hideable'),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _topMode = value!;
                      });
                    },
                  ),
                  SBBDropdown(
                    triggerDecoration: SBBInputDecoration(
                      labelText: 'Flap Mode',
                      contentPadding: EdgeInsets.zero,
                    ),
                    selectedItem: _flapMode,
                    items: [
                      SBBDropdownItem(value: SBBHeaderBoxFlapMode.static, label: 'Static'),
                      SBBDropdownItem(value: SBBHeaderBoxFlapMode.hideable, label: 'Hideable'),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _flapMode = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SBBContentBox(
            margin: EdgeInsets.symmetric(
              horizontal: SBBSpacing.xSmall,
              vertical: SBBSpacing.medium,
            ),
            child: Column(
              children: SBBDivider.divideItems(
                context: context,
                items: [
                  SBBCheckboxListItem(
                    value: _resizing,
                    titleText: 'Resizing',
                    subtitleText: 'Header will expand and contract on scroll',
                    onChanged: (resizing) {
                      setState(() {
                        _resizing = resizing!;
                      });
                    },
                  ),
                  SBBCheckboxListItem(
                    value: _floating,
                    titleText: 'Floating',
                    subtitleText: 'Header will appear first when scrolling back',
                    onChanged: (floating) {
                      setState(() {
                        _floating = floating!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverList.separated(
          itemCount: 60,
          itemBuilder: (context, index) => SBBListItem(
            titleText: 'Item $index',
            onTap: () => sbbToast.show(titleText: 'Pressed Item $index', bottom: 96.0),
          ),
          separatorBuilder: SBBDivider.separatorBuilder,
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
