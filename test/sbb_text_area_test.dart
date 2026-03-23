import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('text_area', (WidgetTester tester) async {
    final pressableKey = ValueKey('focusedTextArea');
    final boxedPressableKey = ValueKey('boxedFocusedTextArea');
    final widget = Builder(
      builder: (context) {
        return Padding(
          padding: const .symmetric(horizontal: SBBSpacing.xSmall, vertical: SBBSpacing.medium),
          child: Column(
            children: [
              SBBListHeader('Listed'),
              SBBContentBox(
                child: Column(
                  mainAxisSize: .min,
                  children: SBBListItem.divideListItems(
                    context: context,
                    items: [
                      SBBTextInput(
                        key: pressableKey,
                        decoration: SBBInputDecoration(
                          contentPadding: .only(top: SBBSpacing.xSmall),
                          leadingIconData: SBBIcons.unicorn_small,
                          trailingIconData: SBBIcons.circle_information_small_small,
                          labelText: 'Label',
                        ),
                        controller: TextEditingController(text: 'Value'),
                        maxLines: 3,
                      ),
                      SBBTextInput(
                        decoration: SBBInputDecoration(
                          contentPadding: .only(top: SBBSpacing.xSmall),
                          errorText: 'This is an error!',
                          leadingIconData: SBBIcons.unicorn_small,
                          trailingIconData: SBBIcons.circle_information_small_small,
                          labelText: 'Label',
                        ),
                        controller: TextEditingController(text: 'Value'),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: SBBSpacing.medium),
              SBBListHeader('Boxed'),
              SBBTextInputBoxed(
                key: boxedPressableKey,
                decoration: SBBInputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: SBBSpacing.small,
                    horizontal: SBBSpacing.medium,
                  ).copyWith(bottom: 0),
                  leadingIconData: SBBIcons.unicorn_small,
                  trailingIconData: SBBIcons.circle_information_small_small,
                  labelText: 'Label',
                ),
                controller: TextEditingController(text: 'Value'),
                maxLines: 3,
              ),
              SBBTextInputBoxed(
                decoration: SBBInputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: SBBSpacing.small,
                    horizontal: SBBSpacing.medium,
                  ).copyWith(bottom: 0),
                  leadingIconData: SBBIcons.unicorn_small,
                  trailingIconData: SBBIcons.circle_information_small_small,
                  labelText: 'Label',
                  errorText: 'This is an error',
                ),
                controller: TextEditingController(text: 'Value'),
                maxLines: 3,
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
      'text_area',
      find.byType(Column).first,
    );
    await tester.tap(find.byKey(pressableKey));
    await tester.tap(find.byKey(boxedPressableKey));
    await tester.pumpAndSettle();

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'text_area_focused',
      find.byType(Column).first,
    );
  });
}
