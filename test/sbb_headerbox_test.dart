import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  generateTest('headerbox_1', HeaderboxTest());
  generateTest('headerbox_sliver_expanded', FloatingHeaderboxTest());
  generateTest('headerbox_sliver_contracted', FloatingHeaderboxTest(scrollOffset: 500.0));
  generateTest('headerbox_sliver_contracted_after_update', FloatingHeaderboxWithUpdateTest());
}

void generateTest(String name, Widget widget) {
  testWidgets(name, (WidgetTester tester) async {
    await TestSpecs.run(TestSpecs.themedSpecs, widget, tester, name, find.byType(Column).first);
  });
}

class HeaderboxTest extends StatelessWidget {
  const HeaderboxTest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                contractibleChild: Container(
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
                  SBBContractionListener(
                    builder: (context, state, _) => Opacity(
                      opacity: state.expansionValue,
                      child: Text('Opacity: ${state.expansionValue.toStringAsFixed(1)}'),
                    ),
                  ),
                  SBBContractible.crossfade(
                    contractedChild: Text("Contracted"),
                    expandedChild: Text("Expanded", style: SBBTextStyles.extraExtraLargeBold),
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
                  SBBSliverFloatingHeaderbox.custom(
                    flapMode: SBBHeaderboxFlapMode.hideable,
                    children: [
                      SBBContractible.crossfade(
                        contractedChild: SizedBox(height: 50, child: Text("Contracted")),
                        expandedChild: SizedBox(
                          height: 100,
                          child: Text("Expanded", style: SBBTextStyles.extraExtraLargeBold),
                        ),
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
      },
    );
  }
}
