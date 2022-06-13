import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

void main() {
  testGoldens('accordion basic test', (WidgetTester tester) async {
    final builder = GoldenBuilder.column(
        wrap: (w) => TestApp.expanded(child: w, hostType: HostPlatform.web))
      ..addScenario(
        'Accordion',
        Column(
          children: [
            SBBAccordion.single(
              title: 'Title text',
              body: Text('Body is not expanded.'),
              isExpanded: false,
              singleAccordionCallback: (_) {},
            ),
            SBBAccordion.single(
              title: 'Title text',
              body: Text('Body is expanded.'),
              isExpanded: true,
              singleAccordionCallback: (_) {},
            ),
          ],
        ),
      );
    await tester.pumpWidgetBuilder(builder.build());
    await multiScreenGolden(tester, 'accordion', devices: TestApp.web_devices);
  });
}
