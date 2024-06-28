import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  testWidgets('accordion basic test', (WidgetTester tester) async {
    final widget = Column(
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
    );

    await Specs.run(
      Specs.webSpecs,
      widget,
      tester,
      'accordion',
      find.byType(Column).first,
      hostType: HostPlatform.web,
    );
  });
}
