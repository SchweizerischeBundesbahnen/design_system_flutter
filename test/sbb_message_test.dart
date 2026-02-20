import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  void generateTest(String name, SBBMessage message) {
    testWidgets(name, (WidgetTester tester) async {
      final widget = MessageTest(sbbMessage: message);

      await TestSpecs.run(TestSpecs.themedSpecs, widget, tester, name, find.byType(MessageTest));
    });
  }

  generateTest(
    'message_test_1',
    const SBBMessage(
      titleText: 'Default',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
    ),
  );

  generateTest(
    'message_test_2',
    const SBBMessage(
      titleText: 'With illustration',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
      illustration: .Woman,
    ),
  );

  generateTest(
    'message_test_3',
    SBBMessage(
      titleText: 'With interaction',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
      onInteraction: () {},
    ),
  );

  generateTest(
    'message_test_4',
    SBBMessage(
      titleText: 'With interaction and illustration',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
      illustration: .Man,
      onInteraction: () {},
    ),
  );

  generateTest(
    'message_test_5',
    SBBMessage(
      titleText: 'Default, custom icon',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
      onInteraction: () {},
      interactionIcon: SBBIcons.train_small,
    ),
  );

  generateTest(
    'message_test_6',
    SBBMessage.error(
      titleText: 'Error, no interaction',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
      messageCode: 'Fehlercode: XYZ-9999',
    ),
  );

  generateTest(
    'message_test_7',
    SBBMessage.error(
      titleText: 'Error, with interaction',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
      messageCode: 'Fehlercode: XYZ-9999',
      illustration: .Display,
      onInteraction: () {},
    ),
  );

  generateTest(
    'message_test_8',
    SBBMessage(
      titleText: 'Custom Illustration',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
      customIllustration: Container(alignment: .center, width: 100, height: 100, color: SBBColors.red),
    ),
  );
}

class MessageTest extends StatelessWidget {
  const MessageTest({super.key, required this.sbbMessage});

  final SBBMessage sbbMessage;

  @override
  Widget build(BuildContext context) {
    MessageIllustration.values.expand((i) => Brightness.values.map((b) => precacheImage(i.asset(b), context))).toList();
    return Column(
      mainAxisSize: .min,
      children: [
        const SBBListHeader('SBBMessage'),
        SizedBox(
          width: 400.0,
          child: SBBContentBox(padding: const .all(SBBSpacing.xSmall), child: sbbMessage),
        ),
      ],
    );
  }
}
