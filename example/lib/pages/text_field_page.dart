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
                      SBBTextField(labelText: 'Empty', controller: emptyTextEditingController),
                      SBBTextInput(labelText: 'Empty', controller: emptyTextEditingController),
                      SBBTextInput(
                        labelText: 'Label',
                        controller: defaultTextEditingController,
                        icon: SBBIcons.unicorn_small,
                      ),
                      const SBBTextInput(labelText: 'With Placeholder', hintText: 'Placeholder'),
                      SBBTextInput(
                        labelText: 'With leading and trailing icon',
                        icon: SBBIcons.unicorn_small,
                        suffixIcon: InkWell(
                          onTap: () {
                            print('hello');
                          },
                          child: Container(height: 50, width: 200, color: SBBColors.green),
                        ),
                      ),
                      // TODO: Move to separate Textarea page
                      SBBTextInput(
                        icon: SBBIcons.unicorn_small,
                        labelText: 'Multiline',
                        maxLines: 3,
                        controller: TextEditingController()..value = const TextEditingValue(text: "I'm\nmulti\nline"),
                        errorText: 'Hello',
                      ),
                      SBBTextInput(
                        labelText: 'Error Message if input too long',
                        controller: textEditingController,
                        errorText: errorText,
                        icon: SBBIcons.unicorn_small,
                        suffixIcon: Icon(SBBIcons.circle_information_small_small),
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
                          // setState(() {
                          //   if (value.length > 10) {
                          //     errorText = 'Too Long!';
                          //   } else {
                          //     errorText = null;
                          //   }
                          // });
                        },
                      ),
                      SBBTextInput(
                        labelText: 'Disabled',
                        controller: TextEditingController()..value = const TextEditingValue(text: 'Value'),
                        enabled: false,
                      ),
                      SBBTextInput(
                        labelText: 'Last Element (Without Divider)',
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
