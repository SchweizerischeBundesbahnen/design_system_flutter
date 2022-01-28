import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class TextFieldPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ThemeModeSegmentedButton(),
        ),
        SBBGroup(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              SBBTextField(
                labelText: 'Label, no Value',
              ),
              SBBTextField(
                labelText: 'Label, Value',
                controller: TextEditingController()..value = TextEditingValue(text: 'Value'),
              ),
              SBBTextField(
                labelText: 'Label, Hint, no Value',
                hintText: 'Hint Value',
              ),
              SBBTextField(
                labelText: 'With icon',
                hintText: 'Hint',
                controller: TextEditingController()..value = TextEditingValue(text: 'Icon'),
                icon: SBBIcons.route_circle_start_small,
              ),
              SBBTextField(
                labelText: 'Multiline',
                maxLines: 3,
                controller: TextEditingController()..value = TextEditingValue(text: "I'm\nmulti\nline"),
              ),
              SBBTextField(
                labelText: 'Error Message',
                controller: TextEditingController()..value = TextEditingValue(text: 'Value'),
                errorText: 'Error',
              ),
              SBBTextField(
                labelText: 'Disabled',
                controller: TextEditingController()..value = TextEditingValue(text: 'Value'),
                enabled: false,
              ),
              SBBTextField(
                labelText: 'Last Element (Without Divider)',
                controller: TextEditingController()..value = TextEditingValue(text: 'Value'),
                isLastElement: true,
              ),
            ],
          ),
        ),
        SBBGroup(
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
