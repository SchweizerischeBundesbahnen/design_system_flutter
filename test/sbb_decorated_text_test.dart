import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('decorated_text', (WidgetTester tester) async {
    final tappableKey = ValueKey('tappableDecoratedText');
    final widget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: SBBSpacing.xSmall, vertical: SBBSpacing.medium),
      child: Column(
        spacing: SBBSpacing.medium,
        children: [
          SBBDecoratedText(
            key: tappableKey,
            value: 'Value',
            decoration: SBBInputDecoration(labelText: 'Default'),
            onTap: () {},
          ),
          SBBDecoratedText(
            value: '',
            decoration: SBBInputDecoration(
              labelText: 'With Placeholder',
              placeholderText: 'Placeholder',
            ),
            onTap: () {},
          ),
          SBBDecoratedText(
            value: 'Value',
            decoration: SBBInputDecoration(
              labelText: 'With Leading Icon',
              leadingIconData: SBBIcons.dog_small,
            ),
            onTap: () {},
          ),
          SBBDecoratedText(
            value: 'Value',
            decoration: SBBInputDecoration(
              labelText: 'With Trailing Icon',
              leadingIconData: SBBIcons.dog_small,
              trailingIconData: SBBIcons.chevron_small_right_circle_small,
            ),
            onTap: () {},
          ),
          SBBDecoratedText(
            value: 'Value',
            decoration: SBBInputDecoration(
              labelText: 'Error',
              errorText: 'This is an error!',
            ),
            onTap: () {},
          ),
          SBBDecoratedText(
            value: 'Value',
            decoration: SBBInputDecoration(labelText: 'Disabled'),
            onTap: null,
          ),
          SBBDecoratedText(
            value: 'I am \nmulti \nline',
            maxLines: 3,
            minLines: 3,
            decoration: SBBInputDecoration(
              labelText: 'Multiline',
              leadingIconData: SBBIcons.dog_small,
              contentPadding: EdgeInsets.only(left: SBBSpacing.medium, top: SBBSpacing.xSmall),
            ),
            onTap: () {},
          ),
        ],
      ),
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'decorated_text',
      find.byType(Column).first,
    );

    await tester.press(find.byKey(tappableKey));
    await tester.pumpAndSettle();

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'decorated_text_pressed',
      find.byType(Column).first,
    );
  });

  testWidgets('decorated_text_boxed', (WidgetTester tester) async {
    final tappableKey = ValueKey('tappableDecoratedTextBoxed');
    final widget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: SBBSpacing.xSmall, vertical: SBBSpacing.medium),
      child: Column(
        spacing: SBBSpacing.medium,
        children: [
          SBBDecoratedTextBoxed(
            key: tappableKey,
            value: 'Value',
            decoration: SBBInputDecoration(
              labelText: 'Default',
              leadingIconData: SBBIcons.unicorn_small,
            ),
            onTap: () {},
          ),
          SBBDecoratedTextBoxed(
            value: '',
            decoration: SBBInputDecoration(
              labelText: 'With Placeholder',
              placeholderText: 'Placeholder',
              leadingIconData: SBBIcons.unicorn_small,
            ),
            onTap: () {},
          ),
          SBBDecoratedTextBoxed(
            value: 'Value',
            decoration: SBBInputDecoration(
              labelText: 'With Trailing Icon',
              leadingIconData: SBBIcons.unicorn_small,
              trailingIconData: SBBIcons.circle_information_small_small,
            ),
            onTap: () {},
          ),
          SBBDecoratedTextBoxed(
            value: 'With Error',
            decoration: SBBInputDecoration(
              labelText: 'Error',
              errorText: 'Error Text',
              leadingIconData: SBBIcons.unicorn_small,
            ),
            onTap: () {},
          ),
          SBBDecoratedTextBoxed(
            value: 'Disabled',
            onTap: null,
            decoration: SBBInputDecoration(
              labelText: 'Disabled',
              leadingIconData: SBBIcons.unicorn_small,
            ),
          ),
        ],
      ),
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'decorated_text_boxed',
      find.byType(Column).first,
    );

    await tester.press(find.byKey(tappableKey));
    await tester.pumpAndSettle();

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'decorated_text_boxed_pressed',
      find.byType(Column).first,
    );
  });
}
