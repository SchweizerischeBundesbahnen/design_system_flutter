import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('headerbox_1', (WidgetTester tester) async {
    final widget = Column(
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
          trailingWidget: SBBTertiaryButtonSmall(label: 'Label', icon: SBBIcons.dog_small, onPressed: () => {}),
        ),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Large'),
        SBBHeaderbox.large(
          title: 'Title',
          leadingIcon: SBBIcons.dog_medium,
          secondaryLabel: 'Subtext',
          trailingWidget: SBBIconButtonLarge(icon: SBBIcons.dog_small, onPressed: () => {}),
        ),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Custom'),
        SBBHeaderbox.custom(
          padding: EdgeInsets.zero,
          flap: SBBHeaderboxFlap.custom(
            child: Center(child: Text('Custom Flappy!', style: SBBTextStyles.extraSmallBold)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(color: SBBColors.red, width: 25, height: 25),
              Container(color: SBBColors.granite, width: 25, height: 25),
              Container(color: SBBColors.graphite, width: 25, height: 25),
            ],
          ),
        ),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'headerbox_1',
      find.byType(Column).first,
    );
  });

  generateSliverTest('headerbox_sliver_expanded', 0.0);
  generateSliverTest('headerbox_sliver_contracted', 500.0);
}

void generateSliverTest(String name, double scrollOffset) {
  testWidgets(name, (WidgetTester tester) async {
    final widget = Column(
      children: [
        Flexible(
          child: CustomScrollView(
            controller: ScrollController(initialScrollOffset: scrollOffset),
            slivers: [
              SBBSliverFloatingHeaderbox(
                title: 'Title',
                leadingIcon: SBBIcons.dog_small,
                secondaryLabel: 'Subtext',
                flap: SBBHeaderboxFlap(
                  title: 'Additional text or information',
                  leadingIcon: SBBIcons.sign_exclamation_point_small,
                  trailingIcon: SBBIcons.circle_information_small_small,
                ),
                trailingWidget: SBBTertiaryButtonSmall(label: 'Label', icon: SBBIcons.dog_small, onPressed: () => {}),
                collapsibleChild: Container(
                  height: 50,
                  color: Colors.black,
                ),
              ),
              SliverList.separated(
                itemBuilder: (context, i) => ListTile(key: ValueKey(i), title: Text(i.toString())),
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            ],
          ),
        ),
        Flexible(
          child: CustomScrollView(
            controller: ScrollController(initialScrollOffset: scrollOffset),
            slivers: [
              SBBSliverFloatingHeaderbox.custom(
                flap: SBBHeaderboxFlap(
                  title: 'Additional text or information',
                  leadingIcon: SBBIcons.sign_exclamation_point_small,
                  trailingIcon: SBBIcons.circle_information_small_small,
                ),
                flapMode: SBBHeaderboxFlapMode.hideable,
                children: [
                  Text('Static'),
                  SBBStackedItem.aligned(
                    builder:
                        (context, state, _) => Opacity(
                          opacity: state.expansionRate,
                          child: Text('Opacity: ${state.expansionRate.toStringAsFixed(1)}'),
                        ),
                  ),
                  SBBStackedItem.crossfade(
                    firstChild: Text("Contracted"),
                    secondChild: Text("Expanded", style: SBBTextStyles.extraExtraLargeBold),
                  ),
                ],
              ),
              SliverList.separated(
                itemBuilder: (context, i) => ListTile(key: ValueKey(i), title: Text(i.toString())),
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            ],
          ),
        ),
      ],
    );

    await TestSpecs.run(TestSpecs.themedSpecs, widget, tester, name, find.byType(Column).first);
  });
}
