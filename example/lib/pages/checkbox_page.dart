import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class CheckboxPage extends StatefulWidget {
  @override
  _CheckboxPageState createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  bool? _value1 = false;
  bool? _value2 = false;
  bool? _listItemValue1 = false;
  bool? _listItemValue2 = false;
  bool? _listItemValue3 = false;
  bool? _listItemValue4 = false;
  bool? _listItemValue5 = false;
  bool? _listItemValue6 = false;
  bool? _listItemValue7 = false;

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: <Widget>[
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Checkbox'),
        SBBGroup(
          padding: const EdgeInsets.all(sbbDefaultSpacing / 2),
          child: Row(
            children: [
              SBBCheckbox(
                onChanged: (bool? value) => setState(() => _value1 = value),
                value: _value1,
              ),
              SBBCheckbox(
                onChanged: null,
                value: _value1,
              ),
              SBBCheckbox(
                onChanged: (bool? value) => setState(() => _value2 = value),
                value: _value2,
                tristate: true,
              ),
              SBBCheckbox(
                onChanged: null,
                value: _value2,
                tristate: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('CheckboxListItem'),
        SBBGroup(
          child: Column(
            children: [
              SBBCheckboxListItem(
                value: _listItemValue1,
                label: 'Default',
                allowMultilineLabel: true,
                onChanged: (value) => setState(() => _listItemValue1 = value),
              ),
              SBBCheckboxListItem(
                value: _listItemValue2,
                label: 'Tristate',
                tristate: true,
                onChanged: (value) => setState(() => _listItemValue2 = value),
              ),
              SBBCheckboxListItem(
                value: _listItemValue3,
                label: 'Call to Action',
                onChanged: (value) => setState(() => _listItemValue3 = value),
                trailingIcon: SBBIcons.circle_information_small_small,
                onCallToAction: () => sbbToast.show(message: 'Call to Action'),
              ),
              SBBCheckboxListItem(
                value: _listItemValue4,
                label: 'Icon',
                onChanged: (value) => setState(() => _listItemValue4 = value),
                leadingIcon: SBBIcons.alarm_clock_small,
              ),
              SBBCheckboxListItem(
                value: _listItemValue5,
                label: 'Icon, Call to Action',
                onChanged: (value) => setState(() => _listItemValue5 = value),
                leadingIcon: SBBIcons.alarm_clock_small,
                trailingIcon: SBBIcons.circle_information_small_small,
                onCallToAction: () => sbbToast.show(message: 'Call to Action'),
              ),
              SBBCheckboxListItem(
                value: _listItemValue5,
                label: 'Disabled, Icon, Call to Action',
                onChanged: null,
                leadingIcon: SBBIcons.alarm_clock_small,
                trailingIcon: SBBIcons.circle_information_small_small,
                onCallToAction: () => sbbToast.show(message: 'Call to Action'),
              ),
              SBBCheckboxListItem.custom(
                value: _listItemValue6,
                label: 'Custom trailing Widget',
                onChanged: (value) => setState(() => _listItemValue6 = value),
                trailingWidget: const Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: sbbDefaultSpacing / 4 * 3,
                    end: sbbDefaultSpacing,
                  ),
                  child: Text('CHF 0.99'),
                ),
              ),
              SBBCheckboxListItem(
                value: _listItemValue7,
                label: 'Multiline Label with\nSecondary Label',
                allowMultilineLabel: true,
                secondaryLabel:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut convallis leo et metus semper hendrerit. Duis nec nunc a ligula cursus vulputate. Donec sed elit ultricies, euismod erat et, eleifend augue.',
                isLastElement: true,
                onChanged: (value) => setState(() => _listItemValue7 = value),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
