import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class TextFieldPage extends StatefulWidget {
  const TextFieldPage({super.key});

  @override
  State<TextFieldPage> createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  String? errorText;

  final emptyTextEditingController = TextEditingController();
  final defaultTextEditingController = TextEditingController.fromValue(TextEditingValue(text: 'Default'));
  final textEditingController = TextEditingController.fromValue(TextEditingValue(text: 'Type...'));

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(child: ThemeModeSegmentedButton()),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            vertical: sbbDefaultSpacing * .5,
            horizontal: sbbDefaultSpacing * .5,
          ).copyWith(bottom: sbbDefaultSpacing * 3),
          sliver: SliverList.list(
            children: [
              SBBListHeader('Listed'),
              SBBContentBox(
                child: Column(
                  children: SBBListItem.divideListItems(
                    context: context,
                    items: [
                      SBBTextField(labelText: 'Empty', controller: emptyTextEditingController, hintText: 'Hint'),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 100),
                        child: SBBTextInput(
                          decoration: SBBInputDecoration(
                            labelText: 'Label',
                            leadingIconData: SBBIcons.unicorn_small,
                            trailing: Container(height: 50, width: 10, color: SBBColors.green),
                            errorText: 'Hello',
                            placeholderText: 'Placeholder',
                          ),
                          controller: emptyTextEditingController,
                          expands: true,
                          maxLines: null,
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 100),
                        child: TextField(
                          decoration: InputDecoration(labelText: 'Label'),
                          controller: emptyTextEditingController,
                          expands: true,
                          maxLines: null,
                        ),
                      ),
                      SBBTextInput(
                        decoration: SBBInputDecoration(
                          labelText: 'Label',
                          leadingIconData: SBBIcons.unicorn_small,
                        ),
                        controller: defaultTextEditingController,
                      ),
                      const SBBTextInput(
                        decoration: SBBInputDecoration(
                          labelText: 'With Placeholder',
                          placeholderText: 'Placeholder',
                        ),
                      ),
                      SBBTextInput(
                        decoration: SBBInputDecoration(
                          labelText: 'With leading and trailing icon',
                          leadingIconData: SBBIcons.unicorn_small,
                          trailing: Container(height: 20, width: 200, color: SBBColors.green),
                        ),
                      ),
                      // TODO: Move to separate Textarea page
                      SBBTextInput(
                        decoration: SBBInputDecoration(
                          leadingIconData: SBBIcons.unicorn_small,
                          labelText: 'Multiline',
                          errorText: 'Error Text',
                        ),
                        maxLines: 3,
                        minLines: 1,
                        controller: TextEditingController()..value = const TextEditingValue(text: "I'm\nmulti\nline"),
                      ),
                      SBBTextInput(
                        decoration: SBBInputDecoration(
                          labelText: 'Display Error Message if input too long',
                          errorText: errorText,
                          leadingIconData: SBBIcons.unicorn_small,
                          trailingIconData: SBBIcons.circle_information_small_small,
                        ),
                        controller: textEditingController,
                        onChanged: (value) {
                          if (errorText == null && value.length > 10) {
                            setState(() {
                              errorText = 'Too Long!';
                            });
                          } else if (errorText != null && value.length <= 10) {
                            setState(() {
                              errorText = null;
                            });
                          }
                        },
                      ),
                      SBBTextInput(
                        decoration: SBBInputDecoration(labelText: 'Disabled'),
                        controller: TextEditingController()..value = const TextEditingValue(text: 'Value'),
                        enabled: false,
                      ),
                      SBBTextInput(
                        decoration: SBBInputDecoration(labelText: 'Last Element (no divider)'),
                        controller: TextEditingController()..value = const TextEditingValue(text: 'Value'),
                      ),
                    ],
                  ).toList(growable: false),
                ),
              ),
              SizedBox(height: sbbDefaultSpacing),
              SBBListHeader('Boxed'),
              SBBContentBox(
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: SBBTextFormField(
                    labelText: 'Label',
                    hintText: 'Minimum of 8 characters',
                    controller: TextEditingController(),
                    validator: (value) => (value?.length ?? 0) > 7 ? null : 'Minimum of 8 characters required',
                    isLastElement: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
