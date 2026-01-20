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

  final textEditingController = TextEditingController.fromValue(TextEditingValue(text: 'Type...'));

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(padding: EdgeInsets.all(16.0), child: ThemeModeSegmentedButton()),
        SBBContentBox(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: SBBListItem.divideListItems(
              context: context,
              items: [
                SBBTextInput(
                  labelText: 'Label, no Value',
                  suffixIcon: Icon(SBBIcons.circle_information_small_small),
                  // icon: SBBIcons.unicorn_small,
                ),
                SBBTextInput(
                  labelText: 'Label, Value',
                  controller: TextEditingController()..value = const TextEditingValue(text: 'Value'),
                  suffixIcon: Icon(SBBIcons.adult_kids_small),
                ),
                const SBBTextInput(labelText: 'Label, Hint, no Value'),
                SBBTextInput(
                  labelText: 'With icon',
                  // hintText: 'Hint',
                  // controller: TextEditingController()..value = const TextEditingValue(text: 'Icon'),
                  icon: SBBIcons.unicorn_small,
                ),
                SBBTextInput(
                  icon: SBBIcons.unicorn_small,
                  labelText: 'Multiline',
                  maxLines: 3,
                  controller: TextEditingController()..value = const TextEditingValue(text: "I'm\nmulti\nline"),
                  errorText: 'Hello',
                ),
                SBBTextInput(
                  labelText: 'Error Message',
                  controller: textEditingController,
                  errorText: errorText,
                  icon: SBBIcons.unicorn_small,
                  suffixIcon: Icon(SBBIcons.circle_information_small_small),
                  onChanged: (value) {
                    print(textEditingController.text);
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
        SBBContentBox(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                autovalidateMode: AutovalidateMode.always,
                child: SBBTextFormField(
                  labelText: 'Label',
                  hintText: 'Minimum of 8 characters',
                  controller: TextEditingController(),
                  validator: (value) => (value?.length ?? 0) > 7 ? null : 'Minimum of 8 characters required',
                  isLastElement: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
