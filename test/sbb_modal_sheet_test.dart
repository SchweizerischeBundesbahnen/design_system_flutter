import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name, {bool isCustom = false}) {
    testWidgets(name, (WidgetTester tester) async {
      final widget = ModalSheetTest(isCustom: isCustom);

      await TestSpecs.run(
        TestSpecs.themedSpecs,
        widget,
        tester,
        '${name}_initial',
        find.byType(ModalSheetTest),
      );
    });
  }

  generateTest('modal_sheet_test_1');
  generateTest('modal_sheet_test_2', isCustom: true);
}

class ModalSheetTest extends StatelessWidget {
  const ModalSheetTest({super.key, this.isCustom = false});

  final bool isCustom;

  @override
  Widget build(BuildContext context) => isCustom ? _customModalSheets() : _modalSheets();

  Widget _modalSheets() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SBBListHeader('Modal Sheet'),
        SBBContentBox(
          child: Padding(
            padding: const EdgeInsets.all(sbbDefaultSpacing * .5),
            child: Column(
              children: [
                SBBModalSheet(title: 'Titel', child: _modalContent()),
                SizedBox(height: sbbDefaultSpacing * .5),
                SBBModalSheet(title: 'Titel', backgroundColor: SBBColors.peach, child: _modalContent()),
                SizedBox(height: sbbDefaultSpacing * .5),
                SBBModalSheet(title: 'Titel', showCloseButton: false, child: _modalContent()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _customModalSheets() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SBBListHeader('Custom Modal Sheet'),
        SBBContentBox(
          child: Padding(
            padding: const EdgeInsets.all(sbbDefaultSpacing * .5),
            child: Column(
              children: [
                SBBModalSheet.custom(header: _modalHeader(), child: _modalContent()),
                SizedBox(height: sbbDefaultSpacing * .5),
                SBBModalSheet.custom(header: _modalHeader(), showCloseButton: false, child: _modalContent()),
                SizedBox(height: sbbDefaultSpacing * .5),
                SBBModalSheet.custom(header: _modalHeader(), backgroundColor: SBBColors.peach, child: _modalContent()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _modalContent() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(sbbDefaultSpacing, 0.0, sbbDefaultSpacing, sbbDefaultSpacing),
      child: const Text(
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
      ),
    );
  }

  Widget _modalHeader() {
    return Padding(
      padding: EdgeInsets.all(sbbDefaultSpacing),
      child: Row(
        children: [
          Icon(SBBIcons.app_icon_small),
          SizedBox(width: sbbDefaultSpacing),
          Text('Custom'),
        ],
      ),
    );
  }
}
