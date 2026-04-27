import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  generateTest('header_box_1', HeaderBoxTest());
  generateTest('header_box_sliver_expanded', FloatingHeaderboxTest());
  generateTest('header_box_sliver_contracted', FloatingHeaderboxTest(scrollOffset: 500.0));
  generateTest('header_box_sliver_contracted_after_update', FloatingHeaderboxWithUpdateTest());
}

void generateTest(String name, Widget widget) {
  testWidgets(name, (WidgetTester tester) async {
    await TestSpecs.run(TestSpecs.themedSpecs, widget, tester, name, find.byType(Column).first);
  });
}

class HeaderBoxTest extends StatelessWidget {
  const HeaderBoxTest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: SBBSpacing.medium),
        const SBBListHeader('Default'),
        SBBHeaderBox(
          titleText: 'Title',
          leadingIconData: SBBIcons.dog_small,
          subtitleText: 'Subtext',
          flap: SBBHeaderBoxFlap(
            labelText: 'Additional text or information',
            leadingIconData: SBBIcons.sign_exclamation_point_small,
            trailingIconData: SBBIcons.circle_information_small,
          ),
          trailing: SBBTertiaryButtonSmall(labelText: 'Label', iconData: SBBIcons.dog_small, onPressed: () => {}),
        ),
        const SizedBox(height: SBBSpacing.medium),
        const SBBListHeader('Large'),
        SBBHeaderBoxLarge(
          titleText: 'Title',
          leadingIconData: SBBIcons.dog_medium,
          subtitleText: 'Subtext',
          trailing: SBBTertiaryButton(iconData: SBBIcons.dog_small, onPressed: () => {}),
        ),
        const SizedBox(height: SBBSpacing.medium),
        const SBBListHeader('Custom'),
        SBBHeaderBox(
          padding: .zero,
          flap: SBBHeaderBoxFlap(
            label: Center(child: Text('Custom Flappy!', style: SBBTextStyles.xSmallBold)),
          ),
          body: Row(
            mainAxisAlignment: .spaceEvenly,
            children: [
              Container(color: SBBColors.red, width: 25, height: 25),
              Container(color: SBBColors.granite, width: 25, height: 25),
              Container(color: SBBColors.graphite, width: 25, height: 25),
            ],
          ),
        ),
      ],
    );
  }
}

class FloatingHeaderboxTest extends StatelessWidget {
  const FloatingHeaderboxTest({
    super.key,
    this.scrollOffset = 0.0,
  });

  final double scrollOffset;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: CustomScrollView(
            controller: ScrollController(initialScrollOffset: scrollOffset),
            slivers: [
              SBBSliverHeaderBox(
                titleText: 'Title',
                leadingIconData: SBBIcons.dog_small,
                subtitleText: 'Subtext',
                flap: SBBHeaderBoxFlap(
                  labelText: 'Additional text or information',
                  leadingIconData: SBBIcons.sign_exclamation_point_small,
                  trailingIconData: SBBIcons.circle_information_small,
                ),
                trailing: SBBTertiaryButtonSmall(
                  labelText: 'Label',
                  iconData: SBBIcons.dog_small,
                  onPressed: () => {},
                ),
                body: SBBContractible(
                  child: Container(
                    height: 50,
                    color: Colors.black,
                  ),
                ),
              ),
              SliverList.separated(
                itemBuilder: (_, i) => ListTile(key: ValueKey(i), title: Text(i.toString())),
                separatorBuilder: (_, _) => Divider(),
              ),
            ],
          ),
        ),
        Flexible(
          child: CustomScrollView(
            controller: ScrollController(initialScrollOffset: scrollOffset),
            slivers: [
              SBBSliverHeaderBox(
                flap: SBBHeaderBoxFlap(
                  labelText: 'Additional text or information',
                  leadingIconData: SBBIcons.sign_exclamation_point_small,
                  trailingIconData: SBBIcons.circle_information_small,
                ),
                config: SBBSliverHeaderBoxConfig(flapMode: .hideable),
                body: SBBCascadeColumn(
                  children: [
                    Text('Static'),
                    SBBContractionListener(
                      builder: (context, state, _) => Opacity(
                        opacity: state.expansionValue,
                        child: Text('Opacity: ${state.expansionValue.toStringAsFixed(1)}'),
                      ),
                    ),
                    SBBContractibleCrossfade(
                      contractedChild: Text('Contracted'),
                      expandedChild: Text('Expanded', style: SBBTextStyles.xxLargeBold),
                    ),
                  ],
                ),
              ),
              SliverList.separated(
                itemBuilder: (context, i) => ListTile(key: ValueKey(i), title: Text(i.toString())),
                separatorBuilder: (_, _) => Divider(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FloatingHeaderboxWithUpdateTest extends StatelessWidget {
  const FloatingHeaderboxWithUpdateTest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // The future builder will cause a rebuild with the same layout.
    // In the past, we had an issue with `SBBContractible` losing its state.
    return FutureBuilder(
      future: Future.value(),
      builder: (context, asyncSnapshot) {
        return Column(
          children: [
            Flexible(
              child: CustomScrollView(
                controller: ScrollController(initialScrollOffset: 500),
                slivers: [
                  SBBSliverHeaderBox(
                    config: SBBSliverHeaderBoxConfig(
                      flapMode: .hideable,
                    ),
                    body: SBBCascadeColumn(
                      children: [
                        SBBContractibleCrossfade(
                          contractedChild: SizedBox(height: 50, child: Text('Contracted')),
                          expandedChild: SizedBox(
                            height: 100,
                            child: Text('Expanded', style: SBBTextStyles.xxLargeBold),
                          ),
                        ),
                      ],
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
          ],
        );
      },
    );
  }
}
