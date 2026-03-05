import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String? errorText;
  final _listedFormKey = GlobalKey<FormState>();
  final _boxedFormKey = GlobalKey<FormState>();

  final emptyTextEditingController = TextEditingController();
  final defaultTextEditingController = TextEditingController.fromValue(TextEditingValue(text: 'Default'));
  final secondTextEditingController = TextEditingController();
  final validatedTextEditingController = TextEditingController();

  void _resetAllForms() {
    _listedFormKey.currentState?.reset();
    _boxedFormKey.currentState?.reset();
    emptyTextEditingController.clear();
    defaultTextEditingController.value = TextEditingValue(text: 'Default');
    secondTextEditingController.clear();
    validatedTextEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    final theme = Theme.of(context);
    final textInputDecorationTheme = theme.sbbInputDecorationTheme;
    final withVerticalPadding = textInputDecorationTheme?.copyWith(
      contentPadding: EdgeInsets.symmetric(horizontal: SBBSpacing.medium),
    );
    final extensions = Map.from(theme.extensions);
    extensions.remove(SBBInputDecorationThemeData);

    return Theme(
      data: theme.copyWith(extensions: [...extensions.values, ?withVerticalPadding]),
      child: CustomScrollView(
        slivers: [
          SBBSliverHeaderbox.custom(
            child: Column(
              spacing: SBBSpacing.xSmall,
              children: [
                ThemeModeSegmentedButton(),
                SBBSecondaryButton(
                  labelText: 'Reset All',
                  onPressed: () {
                    _resetAllForms();
                    sbbToast.show(title: 'All forms reset');
                  },
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              vertical: SBBSpacing.xSmall,
              horizontal: SBBSpacing.xSmall,
            ).copyWith(bottom: SBBSpacing.xLarge),
            sliver: SliverList.list(
              children: [
                SBBListHeader('Listed'),
                Form(
                  key: _listedFormKey,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 200),
                    child: Align(
                      alignment: .topCenter,
                      child: SBBContentBox(
                        child: Column(
                          children: SBBListItem.divideListItems(
                            context: context,
                            items: [
                              SBBTextInputFormField(
                                decoration: SBBInputDecoration(
                                  labelText: 'Default',
                                  leadingIconData: SBBIcons.unicorn_small,
                                ),
                                controller: defaultTextEditingController,
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
                                  labelText: 'Field with validation',
                                  leadingIconData: SBBIcons.unicorn_small,
                                ),
                                controller: secondTextEditingController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Field is required';
                                  }
                                  if (value.length < 6) {
                                    return 'Please enter at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              SBBTextInputFormField(
                                decoration: SBBInputDecoration(
                                  leadingIconData: SBBIcons.unicorn_small,
                                  labelText: 'Disabled',
                                ),
                                controller: TextEditingController()..value = const TextEditingValue(text: 'Value'),
                                enabled: false,
                              ),
                            ],
                          ).toList(growable: false),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: SBBSpacing.medium),
                SBBListHeader('Boxed'),
                Form(
                  key: _boxedFormKey,
                  child: Column(
                    spacing: SBBSpacing.xSmall,
                    children: [
                      SBBTextInputBoxedFormField(
                        decoration: SBBInputDecoration(
                          labelText: 'Simple Field',
                          leadingIconData: SBBIcons.unicorn_small,
                        ),
                        controller: defaultTextEditingController,
                      ),
                      SBBTextInputBoxedFormField(
                        decoration: SBBInputDecoration(
                          labelText: 'Email (with Validator)',
                          leadingIconData: SBBIcons.unicorn_small,
                        ),
                        controller: validatedTextEditingController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SBBTextInputBoxedFormField(
                        decoration: SBBInputDecoration(
                          labelText: 'With Trailing Icon',
                          leadingIconData: SBBIcons.unicorn_small,
                          trailingIconData: SBBIcons.circle_information_small_small,
                        ),
                      ),
                      SizedBox(height: SBBSpacing.xSmall),
                      SBBPrimaryButton(
                        labelText: 'Save',
                        onPressed: () {
                          final boxValidate = _boxedFormKey.currentState!.validate();
                          final listValidate = _listedFormKey.currentState!.validate();
                          if (boxValidate && listValidate) {
                            _listedFormKey.currentState!.save();
                            _boxedFormKey.currentState!.save();
                            sbbToast.show(title: 'Form saved successfully');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    validatedTextEditingController.dispose();
    super.dispose();
  }
}
