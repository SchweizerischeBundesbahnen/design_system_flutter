import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class TextInputPage extends StatefulWidget {
  const TextInputPage({super.key});

  @override
  State<TextInputPage> createState() => _TextInputPageState();
}

class _TextInputPageState extends State<TextInputPage> {
  String? errorText;

  final emptyTextEditingController = TextEditingController();
  final defaultTextEditingController = TextEditingController.fromValue(TextEditingValue(text: 'Default'));
  final errorTextEditingController = TextEditingController.fromValue(TextEditingValue(text: 'Type...'));

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(child: ThemeModeSegmentedButton()),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            vertical: SBBSpacing.xSmall,
            horizontal: SBBSpacing.xSmall,
          ).copyWith(bottom: SBBSpacing.xLarge),
          sliver: SliverList.list(
            children: [
              SBBListHeader('Listed'),
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 320),
                child: Align(
                  alignment: .topCenter,
                  child: SBBContentBox(
                    child: Column(
                      children: SBBListItem.divideListItems(
                        context: context,
                        items: [
                          SBBTextInput(
                            decoration: SBBInputDecoration(
                              labelText: 'Default',
                              leadingIconData: SBBIcons.unicorn_small,
                            ),
                            controller: defaultTextEditingController,
                          ),
                          SBBTextInput(
                            decoration: SBBInputDecoration(
                              labelText: 'With Trailing Icon',
                              leadingIconData: SBBIcons.unicorn_small,
                              trailingIconData: SBBIcons.circle_information_small_small,
                            ),
                          ),
                          SBBTextInput(
                            decoration: SBBInputDecoration(
                              labelText: 'With Placeholder',
                              placeholderText: 'Placeholder',
                              leadingIconData: SBBIcons.unicorn_small,
                            ),
                          ),
                          SBBTextInput(
                            decoration: SBBInputDecoration(
                              labelText: 'With Custom Button',
                              placeholderText: 'Press the Button!',
                              leadingIconData: SBBIcons.unicorn_small,
                              contentPadding: EdgeInsets.only(left: SBBSpacing.medium, right: SBBSpacing.xSmall),
                              trailing: SBBTertiaryButtonSmall(
                                iconData: SBBIcons.dog_small,
                                onPressed: () => sbbToast.show(titleText: 'Button pressed'),
                              ),
                            ),
                          ),
                          SBBTextInput(
                            decoration: SBBInputDecoration(
                              labelText: 'Display Error Message if input too long',
                              errorText: errorText,
                              leadingIconData: SBBIcons.unicorn_small,
                            ),
                            controller: errorTextEditingController,
                            onChanged: (value) {
                              if (errorText == null && value.length > 10) {
                                setState(() {
                                  errorText = 'Input is too long!';
                                });
                              } else if (errorText != null && value.length <= 10) {
                                setState(() {
                                  errorText = null;
                                });
                              }
                            },
                          ),
                          SBBTextInput(
                            decoration: SBBInputDecoration(
                              leadingIconData: SBBIcons.unicorn_small,
                              labelText: 'Disabled',
                            ),
                            controller: TextEditingController()..value = const TextEditingValue(text: 'Value'),
                            enabled: false,
                          ),
                        ],
                      )
                    ),
                  ),
                ),
              ),
              SizedBox(height: SBBSpacing.medium),
              SBBListHeader('Boxed'),
              Column(
                spacing: SBBSpacing.xSmall,
                children: [
                  SBBTextInputBoxed(
                    decoration: SBBInputDecoration(
                      labelText: 'Default',
                      leadingIconData: SBBIcons.unicorn_small,
                    ),
                    controller: defaultTextEditingController,
                  ),
                  SBBTextInputBoxed(
                    decoration: SBBInputDecoration(
                      labelText: 'With Trailing Icon',
                      leadingIconData: SBBIcons.unicorn_small,
                      trailingIconData: SBBIcons.circle_information_small_small,
                    ),
                  ),
                  SBBTextInputBoxed(
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
                        onPressed: () => sbbToast.show(titleText: 'Button pressed'),
                      ),
                    ),
                  ),
                  SBBTextInputBoxed(
                    decoration: SBBInputDecoration(
                      labelText: 'Display Error Message if input too long',
                      errorText: errorText,
                      leadingIconData: SBBIcons.unicorn_small,
                    ),
                    controller: errorTextEditingController,
                    onChanged: (value) {
                      if (errorText == null && value.length > 10) {
                        setState(() {
                          errorText = 'Input is too long!';
                        });
                      } else if (errorText != null && value.length <= 10) {
                        setState(() {
                          errorText = null;
                        });
                      }
                    },
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
        ),
      ],
    );
  }
}
