import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('text_input_form_field', (WidgetTester tester) async {
    final validateButton = ValueKey('textInputFormFieldValidateButtonKey');
    final formKey = GlobalKey<FormState>();
    final widget = Builder(
      builder: (context) {
        return Form(
          key: formKey,
          child: Padding(
            padding: const .symmetric(horizontal: SBBSpacing.xSmall, vertical: SBBSpacing.medium),
            child: Column(
              children: [
                SBBListHeader('Listed'),
                SBBContentBox(
                  child: Column(
                    children: SBBListItem.divideListItems(
                      context: context,
                      items: [
                        SBBTextInputFormField(
                          decoration: SBBInputDecoration(
                            labelText: 'Default',
                            leadingIconData: SBBIcons.unicorn_small,
                          ),
                        ),
                        SBBTextInputFormField(
                          decoration: SBBInputDecoration(
                            labelText: 'With Trailing Icon',
                            leadingIconData: SBBIcons.unicorn_small,
                            trailingIconData: SBBIcons.circle_information_small_small,
                          ),
                        ),
                        SBBTextInputFormField(
                          decoration: SBBInputDecoration(
                            labelText: 'With Placeholder',
                            placeholderText: 'Placeholder',
                            leadingIconData: SBBIcons.unicorn_small,
                          ),
                        ),
                        SBBTextInputFormField(
                          decoration: SBBInputDecoration(
                            labelText: 'With Validation',
                            leadingIconData: SBBIcons.unicorn_small,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ).toList(growable: false),
                  ),
                ),
                SizedBox(height: SBBSpacing.medium),
                SBBPrimaryButton(
                  key: validateButton,
                  labelText: 'Validate',
                  onPressed: () {
                    formKey.currentState?.validate();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'text_input_form_field',
      find.byType(Column).first,
    );
    await tester.tap(find.byKey(validateButton));
    await tester.pumpAndSettle();

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'text_input_form_field_validated',
      find.byType(Column).first,
    );
  });
}
