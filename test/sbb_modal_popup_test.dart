import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name) {
    testWidgets(name, (WidgetTester tester) async {
      final widget = ModalPopupTest();

      await TestSpecs.run(
        TestSpecs.themedSpecs,
        widget,
        tester,
        '${name}_initial',
        find.byType(ModalPopupTest),
      );
    });
  }

  generateTest('modal_popup_test_1');
}

class ModalPopupTest extends StatelessWidget {
  const ModalPopupTest({super.key});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const SBBListHeader('Modal Popup'),
      SBBGroup(
        child: Padding(
          padding: const EdgeInsets.all(sbbDefaultSpacing * .5),
          child: Column(
            children: [
              SBBModalPopup(title: 'Titel', child: _modalContent(context)),
              SizedBox(height: sbbDefaultSpacing * .5),
              SBBModalPopup(
                title: 'Titel',
                backgroundColor: SBBColors.peach,
                child: _modalContent(context),
              ),
              SizedBox(height: sbbDefaultSpacing * .5),
              SBBModalPopup(title: 'Titel', showCloseButton: false, child: _modalContent(context)),
            ],
          ),
        ),
      ),
    ],
  );

  Widget _modalContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        sbbDefaultSpacing,
        0.0,
        sbbDefaultSpacing,
        sbbDefaultSpacing,
      ),
      child: const Text(
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
      ),
    );
  }
}
