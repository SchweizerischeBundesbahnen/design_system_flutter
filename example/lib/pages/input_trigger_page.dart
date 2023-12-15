import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class InputTriggerPage extends StatefulWidget {
  @override
  State<InputTriggerPage> createState() => _PickerPageState();
}

class _PickerPageState extends State<InputTriggerPage> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: sbbDefaultSpacing,
        horizontal: sbbDefaultSpacing * 0.5,
      ),
      child: Column(
        children: <Widget>[
          ThemeModeSegmentedButton(),
          const SizedBox(
            height: sbbDefaultSpacing,
          ),
          SBBGroup(
            child: Column(
              children: [
                SBBInputTrigger(
                  maxLines: 1,
                  value: inputValue,
                  labelText: labelValue,
                  hintText: hintValue,
                  errorText: errorValue,
                  onPressed: () {
                    showSBBModalSheet(
                      context: context,
                      title: 'Date',
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SBBDatePicker(onDateChanged: (DateTime date) {
                            setState(() {
                              selectedDate = date;
                              valueController.text = date.toIso8601String();
                            });
                          }),
                        ],
                      ),
                    );
                  },
                  prefixIcon: showPrefixIcon ? SBBIcons.dog_small : null,
                  suffixIcon: showSuffixIcon
                      ? SBBIcons.circle_information_small_small
                      : null,
                  onSuffixPressed: () {},
                  enabled: enabled,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: sbbDefaultSpacing,
          ),
          SBBGroup(
            child: Column(
              children: [
                SBBTextField(
                  controller: labelController,
                  labelText: 'Label',
                ),
                SBBTextField(
                  controller: hintController,
                  labelText: 'Hint',
                ),
                SBBTextField(
                  controller: valueController,
                  labelText: 'Value',
                ),
                SBBTextField(
                  controller: errorController,
                  labelText: 'Error',
                ),
                SBBSwitchListItem(
                  title: 'Enabled',
                  value: enabled,
                  onChanged: (enabled) {
                    setState(() {
                      this.enabled = enabled;
                    });
                  },
                ),
                SBBSwitchListItem(
                  title: 'Prefix Icon',
                  value: showPrefixIcon,
                  onChanged: (enabled) {
                    setState(() {
                      this.showPrefixIcon = enabled;
                    });
                  },
                ),
                SBBSwitchListItem(
                  title: 'Suffix Icon',
                  value: showSuffixIcon,
                  onChanged: (enabled) {
                    setState(() {
                      this.showSuffixIcon = enabled;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool enabled = true;
  bool showPrefixIcon = true;
  bool showSuffixIcon = true;
  String inputValue = '';
  String labelValue = '';
  String hintValue = '';
  String errorValue = '';
  final valueController = TextEditingController();
  final labelController = TextEditingController();
  final hintController = TextEditingController();
  final errorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    valueController.addListener(() {
      setState(() {
        inputValue = valueController.text;
      });
    });
    labelController.addListener(() {
      setState(() {
        labelValue = labelController.text;
      });
    });
    hintController.addListener(() {
      setState(() {
        hintValue = hintController.text;
      });
    });
    errorController.addListener(() {
      setState(() {
        errorValue = errorController.text;
      });
    });
  }
}
