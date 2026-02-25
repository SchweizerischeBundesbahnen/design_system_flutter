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
      subtitleText:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
    ),
  );

  generateTest(
    'message_test_2',
    SBBMessage(
      titleText: 'With illustration',
      subtitleText:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
      illustration: SBBIllustration.staffFemale(),
    ),
  );

  generateTest(
    'message_test_3',
    SBBMessage(
      titleText: 'With interaction',
      subtitleText:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
      action: SBBTertiaryButton(onPressed: () {}, iconData: SBBIcons.arrows_circle_small),
    ),
  );

  generateTest(
    'message_test_4',
    SBBMessage(
      titleText: 'With interaction and illustration',
      subtitleText:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
      illustration: SBBIllustration.staffMale(),
      action: SBBTertiaryButton(onPressed: () {}, iconData: SBBIcons.arrows_circle_small),
    ),
  );

  generateTest(
    'message_test_5',
    SBBMessage(
      titleText: 'Default, custom icon',
      subtitleText:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
      action: SBBTertiaryButton(onPressed: () {}, iconData: SBBIcons.three_adults_small),
    ),
  );

  generateTest(
    'message_test_6',
    SBBMessage(
      titleText: 'Error, no interaction',
      subtitleText:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
      errorText: 'Fehlercode: XYZ-9999',
      illustration: SBBIllustration.display(),
    ),
  );

  generateTest(
    'message_test_7',
    SBBMessage(
      titleText: 'Error, with interaction',
      subtitleText:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
      errorText: 'Fehlercode: XYZ-9999',
      illustration: SBBIllustration.display(),
      action: SBBTertiaryButton(onPressed: () {}, iconData: SBBIcons.arrows_circle_small),
    ),
  );

  generateTest(
    'message_test_8',
    SBBMessage(
      title: Container(color: SBBColors.turquoise, child: Text('Custom')),
      subtitleText:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.',
      illustration: Container(alignment: .center, width: 100, height: 100, color: SBBColors.red),
    ),
  );
}

class MessageTest extends StatelessWidget {
  static const String _parent = 'lib/assets/illustrations';
  static const String _package = 'sbb_design_system_mobile';

  const MessageTest({super.key, required this.sbbMessage});

  final SBBMessage sbbMessage;

  AssetImage _image(Brightness brightness, String assetName) {
    final path = '$_parent/${brightness.name}/$assetName';
    return AssetImage(path, package: _package);
  }

  @override
  Widget build(BuildContext context) {
    [
      'man.png',
      'woman.png',
      'display.png',
    ].expand((i) => Brightness.values.map((b) => precacheImage(_image(b, i), context))).toList();
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
