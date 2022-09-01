import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class TextFieldPage extends StatelessWidget {
  const TextFieldPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            primary: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SBBWebText.headerOne(
                      'Textfields',
                      color: SBBColors.red,
                    ),
                    SizedBox(width: 250, child: SBBTextField()),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: SBBTextField(
                        labelText: 'Label, no Value',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: SBBTextField(
                        labelText: 'Label, Value',
                        controller: TextEditingController()
                          ..value = TextEditingValue(text: 'Value'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: SBBTextField(
                        labelText: 'Label, Hint, no Value',
                        hintText: 'Hint Value',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: SBBTextField(
                        labelText: 'With icon',
                        hintText: 'Hint',
                        controller: TextEditingController()
                          ..value = TextEditingValue(text: 'Icon'),
                        icon: SBBIcons.route_circle_start_small,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: SBBTextField(
                        labelText: 'With suffix icon',
                        hintText: 'Hint',
                        controller: TextEditingController()
                          ..value = TextEditingValue(text: 'Suffix Icon'),
                        suffixIcon: Icon(SBBIcons.route_circle_start_small),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: SBBTextField(
                        labelText: 'Multiline',
                        maxLines: 3,
                        controller: TextEditingController()
                          ..value = TextEditingValue(text: "I'm\nmulti\nline"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: SBBTextField(
                        labelText: 'Error Message',
                        controller: TextEditingController()
                          ..value = TextEditingValue(text: 'Value'),
                        errorText: 'Error',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: SBBTextField(
                        labelText: 'Disabled',
                        controller: TextEditingController()
                          ..value = TextEditingValue(text: 'Value'),
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: SBBTextField(
                        labelText: 'Password, obscure Text',
                        controller: TextEditingController()
                          ..value = TextEditingValue(text: 'password'),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: Form(
                        autovalidateMode: AutovalidateMode.always,
                        child: SBBTextFormField(
                          labelText: 'Label',
                          hintText: 'Minimum of 8 characters',
                          controller: TextEditingController(),
                          validator: (value) => (value?.length ?? 0) > 7
                              ? null
                              : 'Minimum of 8 characters required',
                        ),
                      ),
                    ),
                  ]),
            ),
          )),
    );
  }
}
