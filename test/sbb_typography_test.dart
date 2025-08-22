import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app.dart';

void main() {
  void testWidget(String name, Widget widget) {
    testWidgets(name, (WidgetTester tester) async {
      await TestSpecs.run(TestSpecs.themedSpecs, widget, tester, name, find.byType(Column).first);
    });
  }

  void generateTest(String name, List<TextStyle?> textStyles) {
    final widget = TypographyTest(name: name, textStyles: textStyles);
    testWidget(name, widget);
  }

  generateTest('typography_defaults', [
    // misc
    null, // default text style
    SBBTextStyles.helpersLabel,
    // light font constants
    SBBTextStyles.extraExtraLargeLight,
    SBBTextStyles.extraLargeLight,
    SBBTextStyles.largeLight,
    SBBTextStyles.mediumLight,
    SBBTextStyles.smallLight,
    SBBTextStyles.extraSmallLight,
    // bold font constants
    SBBTextStyles.extraExtraLargeBold,
    SBBTextStyles.extraLargeBold,
    SBBTextStyles.largeBold,
    SBBTextStyles.mediumBold,
    SBBTextStyles.smallBold,
    SBBTextStyles.extraSmallBold,
  ]);

  generateTest('typography_ultra_light', [
    sbbTextStyle.ultraLightStyle.xxLarge,
    sbbTextStyle.ultraLightStyle.xLarge,
    sbbTextStyle.ultraLightStyle.large,
    sbbTextStyle.ultraLightStyle.medium,
    sbbTextStyle.ultraLightStyle.small,
    sbbTextStyle.ultraLightStyle.xSmall,
    sbbTextStyle.ultraLightStyle.xxLarge.italic,
    sbbTextStyle.ultraLightStyle.xLarge.italic,
    sbbTextStyle.ultraLightStyle.large.italic,
    sbbTextStyle.ultraLightStyle.medium.italic,
    sbbTextStyle.ultraLightStyle.small.italic,
    sbbTextStyle.ultraLightStyle.xSmall.italic,
  ]);

  generateTest('typography_thin', [
    sbbTextStyle.thinStyle.xxLarge,
    sbbTextStyle.thinStyle.xLarge,
    sbbTextStyle.thinStyle.large,
    sbbTextStyle.thinStyle.medium,
    sbbTextStyle.thinStyle.small,
    sbbTextStyle.thinStyle.xSmall,
    sbbTextStyle.thinStyle.xxLarge.italic,
    sbbTextStyle.thinStyle.xLarge.italic,
    sbbTextStyle.thinStyle.large.italic,
    sbbTextStyle.thinStyle.medium.italic,
    sbbTextStyle.thinStyle.small.italic,
    sbbTextStyle.thinStyle.xSmall.italic,
  ]);

  generateTest('typography_light', [
    sbbTextStyle.lightStyle.xxLarge,
    sbbTextStyle.lightStyle.xLarge,
    sbbTextStyle.lightStyle.large,
    sbbTextStyle.lightStyle.medium,
    sbbTextStyle.lightStyle.small,
    sbbTextStyle.lightStyle.xSmall,
    sbbTextStyle.lightStyle.xxLarge.italic,
    sbbTextStyle.lightStyle.xLarge.italic,
    sbbTextStyle.lightStyle.large.italic,
    sbbTextStyle.lightStyle.medium.italic,
    sbbTextStyle.lightStyle.small.italic,
    sbbTextStyle.lightStyle.xSmall.italic,
  ]);

  generateTest('typography_roman', [
    sbbTextStyle.romanStyle.xxLarge,
    sbbTextStyle.romanStyle.xLarge,
    sbbTextStyle.romanStyle.large,
    sbbTextStyle.romanStyle.medium,
    sbbTextStyle.romanStyle.small,
    sbbTextStyle.romanStyle.xSmall,
    sbbTextStyle.romanStyle.xxLarge.italic,
    sbbTextStyle.romanStyle.xLarge.italic,
    sbbTextStyle.romanStyle.large.italic,
    sbbTextStyle.romanStyle.medium.italic,
    sbbTextStyle.romanStyle.small.italic,
    sbbTextStyle.romanStyle.xSmall.italic,
  ]);

  generateTest('typography_bold', [
    sbbTextStyle.boldStyle.xxLarge,
    sbbTextStyle.boldStyle.xLarge,
    sbbTextStyle.boldStyle.large,
    sbbTextStyle.boldStyle.medium,
    sbbTextStyle.boldStyle.small,
    sbbTextStyle.boldStyle.xSmall,
    sbbTextStyle.boldStyle.xxLarge.italic,
    sbbTextStyle.boldStyle.xLarge.italic,
    sbbTextStyle.boldStyle.large.italic,
    sbbTextStyle.boldStyle.medium.italic,
    sbbTextStyle.boldStyle.small.italic,
    sbbTextStyle.boldStyle.xSmall.italic,
  ]);

  generateTest('typography_condensed_bold', [
    sbbTextStyle.condensedBoldStyle.xxLarge,
    sbbTextStyle.condensedBoldStyle.xLarge,
    sbbTextStyle.condensedBoldStyle.large,
    sbbTextStyle.condensedBoldStyle.medium,
    sbbTextStyle.condensedBoldStyle.small,
    sbbTextStyle.condensedBoldStyle.xSmall,
    sbbTextStyle.condensedBoldStyle.xxLarge.italic,
    sbbTextStyle.condensedBoldStyle.xLarge.italic,
    sbbTextStyle.condensedBoldStyle.large.italic,
    sbbTextStyle.condensedBoldStyle.medium.italic,
    sbbTextStyle.condensedBoldStyle.small.italic,
    sbbTextStyle.condensedBoldStyle.xSmall.italic,
  ]);

  generateTest('typography_condensed_heavy', [
    sbbTextStyle.condensedHeavyStyle.xxLarge,
    sbbTextStyle.condensedHeavyStyle.xLarge,
    sbbTextStyle.condensedHeavyStyle.large,
    sbbTextStyle.condensedHeavyStyle.medium,
    sbbTextStyle.condensedHeavyStyle.small,
    sbbTextStyle.condensedHeavyStyle.xSmall,
    sbbTextStyle.condensedHeavyStyle.xxLarge.italic,
    sbbTextStyle.condensedHeavyStyle.xLarge.italic,
    sbbTextStyle.condensedHeavyStyle.large.italic,
    sbbTextStyle.condensedHeavyStyle.medium.italic,
    sbbTextStyle.condensedHeavyStyle.small.italic,
    sbbTextStyle.condensedHeavyStyle.xSmall.italic,
  ]);

  testWidget('typography_red_text_theme', TypographyRedThemeTest());
}

class TypographyTest extends StatelessWidget {
  static const exampleText = 'The quick brown fox jumps over the lazy dog';

  const TypographyTest({super.key, required this.name, required this.textStyles});

  final String name;
  final List<TextStyle?> textStyles;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SBBListHeader(name),
        SizedBox(
          width: double.infinity,
          child: SBBGroup(
            padding: EdgeInsets.all(sbbDefaultSpacing),
            child: Column(
              spacing: sbbDefaultSpacing * 0.5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: textStyles.map((e) => Text(exampleText, style: e)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class TypographyRedThemeTest extends StatelessWidget {
  const TypographyRedThemeTest({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = SBBBaseStyle.of(context).redTextTheme;
    return TypographyTest(
      name: 'typography_red_text_theme',
      textStyles: [textTheme.bodyLarge, textTheme.bodyMedium, textTheme.bodySmall],
    );
  }
}
