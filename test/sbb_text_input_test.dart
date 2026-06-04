import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('text_input', (WidgetTester tester) async {
    final boxedPressableKey = ValueKey('focusedTextInput');
    final widget = Padding(
      padding: const .symmetric(horizontal: SBBSpacing.xSmall, vertical: SBBSpacing.medium),
      child: Column(
        children: [
          SBBListHeader('Standalone'),
          Column(
            spacing: SBBSpacing.xSmall,
            children: _textInputItems(
              pressableItemKey: boxedPressableKey,
              borderType: .standalone,
            ),
          ),
        ],
      ),
    );
    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'text_input_boxed',
      find.byType(Column).first,
    );

    await tester.tap(find.byKey(boxedPressableKey));
    await tester.pumpAndSettle();

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'text_input_boxed_focused',
      find.byType(Column).first,
    );
  });

  testWidgets('text_input_listed', (WidgetTester tester) async {
    final pressableKey = ValueKey('focusedTextInputListed');
    final widget = Builder(
      builder: (context) {
        return Padding(
          padding: const .symmetric(horizontal: SBBSpacing.xSmall, vertical: SBBSpacing.medium),
          child: Column(
            children: [
              SBBListHeader('Listed'),
              SBBContentBox(
                child: Column(
                  children: SBBListItem.divideListItems(
                    context: context,
                    items: _textInputItems(
                      pressableItemKey: pressableKey,
                      borderType: .boxedOrListed,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'text_input',
      find.byType(Column).first,
    );
    await tester.tap(find.byKey(pressableKey));
    await tester.pumpAndSettle();

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'text_input_focused',
      find.byType(Column).first,
    );
  });

  testWidgets('text_input_boxed', (WidgetTester tester) async {
    final boxedPressableKey = ValueKey('boxedFocusedTextInput');
    final widget = Padding(
      padding: const .symmetric(horizontal: SBBSpacing.xSmall, vertical: SBBSpacing.medium),
      child: Column(
        children: [
          SBBListHeader('Boxed'),
          Column(
            spacing: SBBSpacing.xSmall,
            children: [
              SBBTextInputBoxed(
                decoration: SBBInputDecoration(
                  labelText: 'Default',
                  leadingIconData: SBBIcons.unicorn_small,
                ),
              ),
              SBBTextInputBoxed(
                decoration: SBBInputDecoration(
                  labelText: 'With Trailing Icon',
                  leadingIconData: SBBIcons.unicorn_small,
                  trailingIconData: SBBIcons.circle_information_small_small,
                ),
              ),
              SBBTextInputBoxed(
                key: boxedPressableKey,
                decoration: SBBInputDecoration(
                  labelText: 'With Placeholder',
                  placeholderText: 'Placeholder',
                  leadingIconData: SBBIcons.unicorn_small,
                ),
              ),
              SBBTextInputBoxed(
                decoration: SBBInputDecoration(
                  labelText: 'With Custom Button',
                  placeholderText: 'Press the Button!',
                  leadingIconData: SBBIcons.unicorn_small,
                  trailing: SBBTertiaryButtonSmall(
                    iconData: SBBIcons.dog_small,
                    onPressed: () {},
                  ),
                ),
              ),
              SBBTextInputBoxed(
                decoration: SBBInputDecoration(
                  labelText: 'Error message',
                  errorText: 'This is an error!',
                  leadingIconData: SBBIcons.unicorn_small,
                ),
              ),
              SBBTextInputBoxed(
                decoration: SBBInputDecoration(leadingIconData: SBBIcons.unicorn_small, labelText: 'Disabled'),
                controller: TextEditingController()..value = const TextEditingValue(text: 'Value'),
                enabled: false,
              ),
            ],
          ),
        ],
      ),
    );
    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'text_input_boxed',
      find.byType(Column).first,
    );

    await tester.tap(find.byKey(boxedPressableKey));
    await tester.pumpAndSettle();

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'text_input_boxed_focused',
      find.byType(Column).first,
    );
  });
}

List<Widget> _textInputItems({required ValueKey<String> pressableItemKey, required SBBInputBorderType borderType}) {
  return [
    SBBTextInputBoxed(
      decoration: SBBInputDecoration(
        labelText: 'Default',
        leadingIconData: SBBIcons.unicorn_small,
        borderType: borderType,
      ),
    ),
    SBBTextInputBoxed(
      decoration: SBBInputDecoration(
        labelText: 'With Trailing Icon',
        leadingIconData: SBBIcons.unicorn_small,
        trailingIconData: SBBIcons.circle_information_small_small,
        borderType: borderType,
      ),
    ),
    SBBTextInputBoxed(
      key: pressableItemKey,
      decoration: SBBInputDecoration(
        labelText: 'With Placeholder',
        placeholderText: 'Placeholder',
        leadingIconData: SBBIcons.unicorn_small,
        borderType: borderType,
      ),
    ),
    SBBTextInputBoxed(
      decoration: SBBInputDecoration(
        labelText: 'With Custom Button',
        placeholderText: 'Press the Button!',
        leadingIconData: SBBIcons.unicorn_small,
        trailing: SBBTertiaryButtonSmall(
          iconData: SBBIcons.dog_small,
          onPressed: () {},
        ),
        borderType: borderType,
      ),
    ),
    SBBTextInputBoxed(
      decoration: SBBInputDecoration(
        labelText: 'Error message',
        errorText: 'This is an error!',
        leadingIconData: SBBIcons.unicorn_small,
        borderType: borderType,
      ),
    ),
    SBBTextInputBoxed(
      decoration: SBBInputDecoration(
        leadingIconData: SBBIcons.unicorn_small,
        labelText: 'Disabled',
        borderType: borderType,
      ),
      controller: TextEditingController()..value = const TextEditingValue(text: 'Value'),
      enabled: false,
    ),
  ];
}
