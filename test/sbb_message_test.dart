import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name, SBBMessage message) {
    testGoldens(name, (WidgetTester tester) async {
      final builder = GoldenBuilder.column(wrap: (w) => TestApp.expanded(child: w))
        ..addScenario(
          'message tests',
          MessageTest(sbbMessage: message),
        );

      await tester.pumpWidgetBuilder(builder.build());
      await multiScreenGolden(tester, name, devices: TestApp.native_devices);
    });
  }

  generateTest(
    'message_test_1',
    SBBMessage.info(
      title: 'Info',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
      messageCode: 'Error-Code: XYZ-9999',
      onInteraction: () {},
    ),
  );

  generateTest(
    'message_test_2',
    SBBMessage.warning(
      title: 'Warning, no messageCode',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
      onInteraction: () {},
    ),
  );

  generateTest(
    'message_test_3',
    SBBMessage.success(
      title: 'Success',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
      onInteraction: () {},
    ),
  );

  generateTest(
    'message_test_4',
    SBBMessage.error(
      title: 'Error, no interaction',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
    ),
  );

  generateTest(
    'message_test_5',
    SBBMessage.hint(
      title: 'Hint, custom icon',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
      onInteraction: () {},
      interactionIcon: SBBIcons.train_medium,
    ),
  );
}

class MessageTest extends StatelessWidget {
  const MessageTest({Key? key, required this.sbbMessage}) : super(key: key);

  final SBBMessage sbbMessage;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SBBListHeader('SBBMessage'),
          Container(
            width: 400.0,
            child: SBBGroup(
              padding: const EdgeInsets.all(sbbDefaultSpacing / 2),
              child: sbbMessage,
            ),
          ),
        ],
      );
}
