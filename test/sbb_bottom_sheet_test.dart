import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name, {bool isCustom = false}) {
    testWidgets(name, (WidgetTester tester) async {
      await TestSpecs.run(
        TestSpecs.themedSpecs,
        ModalSheetTest(),
        tester,
        '${name}_initial',
        find.byType(ModalSheetTest),
      );
    });
  }

  generateTest('bottom_sheet_test_1');
}

class ModalSheetTest extends StatelessWidget {
  const ModalSheetTest({super.key});

  @override
  Widget build(BuildContext context) {
    return SBBContentBox(
      padding: const .all(SBBSpacing.medium),
      child: Column(
        spacing: SBBSpacing.medium,
        mainAxisSize: .min,
        children: [
          SBBBottomSheet(titleText: 'Title', body: _modalContent()),
          SBBBottomSheet(
            titleText: 'Title',
            leadingIconData: SBBIcons.dog_small,
            style: SBBBottomSheetStyle(backgroundColor: SBBColors.peach),
            body: _modalContent(),
          ),
          SBBBottomSheet(titleText: 'Title', showCloseButton: false, body: _modalContent()),
          SBBBottomSheet(
            body: Container(height: 20, width: double.infinity, color: SBBColors.turquoise),
            title: Container(
              height: 10,
              width: double.infinity,
              color: SBBColors.lemon,
            ),
          ),
        ],
      ),
    );
  }

  Widget _modalContent() => const Text(
    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
    'sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. '
    'At vero eos et accusam et justo duo dolores et ea rebum. '
    'Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
  );
}
