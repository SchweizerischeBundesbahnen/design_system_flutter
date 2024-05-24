import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  testWidgets('status test', (WidgetTester tester) async {
    final widget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SBBStatus.valid(),
        SBBStatus.warning(),
        SBBStatus.invalid(),
        SBBStatus.inProgress(),
        SBBStatus.inactive(),
        SBBStatus.valid(
          showIcon: false,
          text: 'Success',
        ),
        SBBStatus.warning(
          showIcon: false,
          text: 'Warning',
        ),
        SBBStatus.invalid(
          showIcon: false,
          text: 'Failure',
        ),
        SBBStatus.inProgress(
          showIcon: false,
          text: 'In Progress',
        ),
        SBBStatus.inactive(
          showIcon: false,
          text: 'Offline',
        ),
        SBBStatus.valid(
          text: 'Everything is valid',
        ),
        SBBStatus.warning(
          text: 'There is a potential problem',
        ),
        SBBStatus.invalid(
          text: 'Somethign needs to be corrected',
        ),
        SBBStatus.inProgress(
          text: 'Process is in progress',
        ),
        SBBStatus.inactive(
          text: 'Application is offline',
        ),
      ],
    );

    await Specs.run(
      Specs.webSpecs,
      widget,
      tester,
      'status_test',
      find.byType(Column).first,
      hostType: HostPlatform.web,
    );
  });
}
