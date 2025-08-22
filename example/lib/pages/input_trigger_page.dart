import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class InputTriggerPage extends StatefulWidget {
  const InputTriggerPage({super.key});

  @override
  State<InputTriggerPage> createState() => _PickerPageState();
}

class _PickerPageState extends State<InputTriggerPage> {
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: sbbDefaultSpacing,
        horizontal: sbbDefaultSpacing * 0.5,
      ),
      child: Column(
        children: <Widget>[
          const ThemeModeSegmentedButton(),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Demo'),
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
                    SBBToast.of(context).show(title: 'onPressed');
                  },
                  prefixIcon: showPrefixIcon ? SBBIcons.dog_small : null,
                  suffixIcon:
                      showSuffixIcon
                          ? SBBIcons.circle_information_small_small
                          : null,
                  onSuffixPressed: () {
                    SBBToast.of(context).show(title: 'onSuffixPressed');
                  },
                  enabled: enabled,
                  isLastElement: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Change properties'),
          SBBGroup(
            child: Column(
              children: [
                SBBTextField(controller: labelController, labelText: 'Label'),
                SBBTextField(controller: hintController, labelText: 'Hint'),
                SBBTextField(controller: valueController, labelText: 'Value'),
                SBBTextField(controller: errorController, labelText: 'Error'),
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
                      showPrefixIcon = enabled;
                    });
                  },
                ),
                SBBSwitchListItem(
                  title: 'Suffix Icon',
                  value: showSuffixIcon,
                  onChanged: (enabled) {
                    setState(() {
                      showSuffixIcon = enabled;
                    });
                  },
                  isLastElement: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
