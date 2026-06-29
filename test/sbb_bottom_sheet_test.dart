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

  testWidgets('close button is reachable via SBBBottomSheet.closeButtonKey and dismisses the sheet', (
    WidgetTester tester,
  ) async {
    const bodyText = 'Bottom sheet body';
    await tester.pumpWidget(
      MaterialApp(
        theme: SBBTheme.light(),
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: ElevatedButton(
                onPressed: () => showSBBBottomSheet(
                  context: context,
                  titleText: 'Title',
                  body: const Text(bodyText),
                ),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      ),
    );

    // Open the bottom sheet.
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text(bodyText), findsOneWidget);

    // The close button can be found by its public key.
    expect(find.byKey(SBBBottomSheet.closeButtonKey), findsOneWidget);

    // Tapping the close button by key dismisses the sheet.
    await tester.tap(find.byKey(SBBBottomSheet.closeButtonKey));
    await tester.pumpAndSettle();
    expect(find.text(bodyText), findsNothing);
  });
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
          SBBBottomSheet(leadingIconData: SBBIcons.three_adults_small, body: _modalContent()),
          SBBBottomSheet(
            leadingIconData: SBBIcons.three_adults_small,
            trailingIconData: SBBIcons.warning_light_small,
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
    'sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
  );
}
