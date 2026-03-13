import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name) {
    testWidgets(name, (WidgetTester tester) async {
      await TestSpecs.run(
        TestSpecs.themedSpecs,
        PopupTest(),
        tester,
        name,
        find.byType(PopupTest),
      );
    });
  }

  generateTest('sbb_popup_test');
}

class PopupTest extends StatelessWidget {
  const PopupTest({super.key});

  @override
  Widget build(BuildContext context) {
    return SBBContentBox(
      padding: const EdgeInsets.all(SBBSpacing.medium),
      child: Column(
        spacing: SBBSpacing.medium,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title only
          SBBPopup(
            titleText: 'Title',
            body: _popupBody(),
          ),
          // Title + leading icon
          SBBPopup(
            titleText: 'Title',
            leadingIconData: SBBIcons.dog_small,
            style: SBBPopupStyle(backgroundColor: SBBColors.peach),
            body: _popupBody(),
          ),
          // Leading icon only (no title)
          SBBPopup(
            leadingIconData: SBBIcons.three_adults_small,
            body: _popupBody(),
          ),
          // Leading + trailing icons, no title
          SBBPopup(
            leadingIconData: SBBIcons.three_adults_small,
            trailingIconData: SBBIcons.warning_light_small,
            body: _popupBody(),
          ),
          // Title without close button
          SBBPopup(
            titleText: 'Title',
            showCloseButton: false,
            body: _popupBody(),
          ),
          // No header at all, body only
          SBBPopup(
            showCloseButton: false,
            body: Container(height: 20, width: double.infinity, color: SBBColors.turquoise),
          ),
          // Custom title widget
          SBBPopup(
            title: Container(
              height: 10,
              width: double.infinity,
              color: SBBColors.lemon,
            ),
            body: Container(height: 20, width: double.infinity, color: SBBColors.turquoise),
          ),
        ],
      ),
    );
  }

  Widget _popupBody() => const Text(
    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
    'sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
  );
}
