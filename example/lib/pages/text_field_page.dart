import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class TextFieldPage extends StatelessWidget {
  const TextFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: ThemeModeSegmentedButton(),
        ),
        SBBGroup(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              const SBBTextField(labelText: 'Label, no Value'),
              SBBTextField(
                labelText: 'Label, Value',
                controller:
                    TextEditingController()
                      ..value = const TextEditingValue(text: 'Value'),
              ),
              const SBBTextField(
                labelText: 'Label, Hint, no Value',
                hintText: 'Hint Value',
              ),
              SBBTextField(
                labelText: 'With icon',
                hintText: 'Hint',
                controller:
                    TextEditingController()
                      ..value = const TextEditingValue(text: 'Icon'),
                icon: SBBIcons.route_circle_start_small,
              ),
              SBBTextField(
                labelText: 'Multiline',
                maxLines: 3,
                controller:
                    TextEditingController()
                      ..value = const TextEditingValue(
                        text: "I'm\nmulti\nline",
                      ),
              ),
              SBBTextField(
                labelText: 'Error Message',
                controller:
                    TextEditingController()
                      ..value = const TextEditingValue(text: 'Value'),
                errorText: 'Error',
              ),
              SBBTextField(
                labelText: 'Disabled',
                controller:
                    TextEditingController()
                      ..value = const TextEditingValue(text: 'Value'),
                enabled: false,
              ),
              SBBTextField(
                labelText: 'Last Element (Without Divider)',
                controller:
                    TextEditingController()
                      ..value = const TextEditingValue(text: 'Value'),
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
                  validator:
                      (value) =>
                          (value?.length ?? 0) > 7
                              ? null
                              : 'Minimum of 8 characters required',
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
