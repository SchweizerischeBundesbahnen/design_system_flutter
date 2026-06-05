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
        children: _decoratedTextItems(
          tappableItemKey: tappableKey,
          borderType: .standalone,
        ),
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

  testWidgets('decorated_text_listed', (WidgetTester tester) async {
    final tappableKey = ValueKey('tappableDecoratedTextListed');
    final widget = Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: SBBSpacing.xSmall, vertical: SBBSpacing.medium),
          child: SBBContentBox(
            child: Column(
              mainAxisSize: .min,
              spacing: SBBSpacing.medium,
              children: SBBDivider.divideItems(
                context: context,
                items: _decoratedTextItems(
                  tappableItemKey: tappableKey,
                  borderType: .boxedOrListed,
                ),
              ),
            ),
          ),
        );
      },
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'decorated_text_listed',
      find.byType(Column).first,
    );

    await tester.press(find.byKey(tappableKey));
    await tester.pumpAndSettle();

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'decorated_text_listed_pressed',
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

List<Widget> _decoratedTextItems({required ValueKey<String> tappableItemKey, required SBBInputBorderType borderType}) {
  return [
    SBBDecoratedText(
      key: tappableItemKey,
      value: 'Value',
      decoration: SBBInputDecoration(labelText: 'Default', borderType: borderType),
      onTap: () {},
    ),
    SBBDecoratedText(
      value: '',
      decoration: SBBInputDecoration(
        labelText: 'With Placeholder',
        placeholderText: 'Placeholder',
        borderType: borderType,
      ),
      onTap: () {},
    ),
    SBBDecoratedText(
      value: 'Value',
      decoration: SBBInputDecoration(
        labelText: 'With Leading Icon',
        leadingIconData: SBBIcons.dog_small,
        borderType: borderType,
      ),
      onTap: () {},
    ),
    SBBDecoratedText(
      value: 'Value',
      decoration: SBBInputDecoration(
        labelText: 'With Trailing Icon',
        leadingIconData: SBBIcons.dog_small,
        trailingIconData: SBBIcons.chevron_small_right_circle_small,
        borderType: borderType,
      ),
      onTap: () {},
    ),
    SBBDecoratedText(
      value: 'Value',
      decoration: SBBInputDecoration(
        labelText: 'Error',
        errorText: 'This is an error!',
        borderType: borderType,
      ),
      onTap: () {},
    ),
    SBBDecoratedText(
      value: 'Value',
      decoration: SBBInputDecoration(labelText: 'Disabled', borderType: borderType),
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
        borderType: borderType,
      ),
      onTap: () {},
    ),
  ];
}
