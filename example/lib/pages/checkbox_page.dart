import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  CheckboxPageState createState() => CheckboxPageState();
}

class CheckboxPageState extends State<CheckboxPage> {
  bool? _value1 = false;
  bool? _value2 = false;
  bool? _listItemValue1 = false;
  bool? _listItemValue2 = false;
  bool? _listItemValue3 = false;
  bool? _listItemValue4 = false;
  bool? _listItemValue5 = false;
  bool? _listItemValue6 = false;
  bool? _listItemValue7 = false;

  int _enabledIndex = 0;

  bool get _isEnabled => _enabledIndex == 0;

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: <Widget>[
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Checkbox'),
        Padding(
          padding: const EdgeInsets.all(sbbDefaultSpacing * .5),
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
        const SizedBox(height: sbbDefaultSpacing * 2),
        SBBSegmentedButton(
          values: ['All Enabled', 'All Disabled'],
          selectedStateIndex: _enabledIndex,
          selectedIndexChanged: (i) => setState(() => _enabledIndex = i),
        ),
        const SBBListHeader('Checkbox Item - List'),
        SBBGroup(
          child: Column(
            children: [
              SBBCheckboxListItem(
                value: _listItemValue1,
                label: 'Label',
                allowMultilineLabel: true,
                onChanged: _isEnabled ? (value) => setState(() => _listItemValue1 = value) : null,
              ),
              SBBCheckboxListItem(
                value: _listItemValue2,
                label: 'Tristate',
                tristate: true,
                onChanged: _isEnabled ? (value) => setState(() => _listItemValue2 = value) : null,
              ),
              SBBCheckboxListItem(
                value: _listItemValue4,
                label: 'Leading Icon',
                onChanged: _isEnabled ? (value) => setState(() => _listItemValue4 = value) : null,
                leadingIcon: SBBIcons.alarm_clock_small,
              ),
              SBBCheckboxListItem(
                value: _listItemValue5,
                label: 'Leading and Trailing Icon',
                onChanged: _isEnabled ? (value) => setState(() => _listItemValue5 = value) : null,
                leadingIcon: SBBIcons.alarm_clock_small,
                trailingIcon: SBBIcons.dog_small,
              ),
              SBBCheckboxListItem(
                value: _listItemValue3,
                label: 'Button',
                onChanged: _isEnabled ? (value) => setState(() => _listItemValue3 = value) : null,
                trailingIcon: SBBIcons.circle_information_small_small,
                onCallToAction: () => sbbToast.show(message: 'Button pressed'),
              ),
              SBBCheckboxListItem.custom(
                value: _listItemValue6,
                label: 'Custom trailing Widget',
                onChanged: _isEnabled ? (value) => setState(() => _listItemValue6 = value) : null,
                trailingWidget: Padding(
                  padding: EdgeInsetsDirectional.only(
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
                onChanged: _isEnabled ? (value) => setState(() => _listItemValue7 = value) : null,
              ),
            ],
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Checkbox Item - Boxed'),
        Column(
          spacing: sbbDefaultSpacing * 0.5,
          children: [
            SBBCheckboxListItem.boxed(
              value: _listItemValue1,
              label: 'Label',
              allowMultilineLabel: true,
              onChanged: _isEnabled ? (value) => setState(() => _listItemValue1 = value) : null,
            ),
            SBBCheckboxListItem.boxed(
              value: _listItemValue2,
              label: 'Tristate',
              tristate: true,
              onChanged: _isEnabled ? (value) => setState(() => _listItemValue2 = value) : null,
            ),
            SBBCheckboxListItem.boxed(
              value: _listItemValue4,
              label: 'Leading Icon',
              onChanged: _isEnabled ? (value) => setState(() => _listItemValue4 = value) : null,
              leadingIcon: SBBIcons.alarm_clock_small,
            ),
            SBBCheckboxListItem.boxed(
              value: _listItemValue5,
              label: 'Leading and Trailing Icon',
              onChanged: _isEnabled ? (value) => setState(() => _listItemValue5 = value) : null,
              leadingIcon: SBBIcons.alarm_clock_small,
              trailingIcon: SBBIcons.dog_small,
            ),
            SBBCheckboxListItem.boxed(
              value: _listItemValue3,
              label: 'Button',
              onChanged: _isEnabled ? (value) => setState(() => _listItemValue3 = value) : null,
              trailingIcon: SBBIcons.circle_information_small_small,
              onCallToAction: () => sbbToast.show(message: 'Button pressed'),
            ),
            SBBCheckboxListItem.custom(
              value: _listItemValue6,
              label: 'Custom trailing Widget',
              onChanged: _isEnabled ? (value) => setState(() => _listItemValue6 = value) : null,
              trailingWidget: Padding(
                padding: EdgeInsetsDirectional.only(
                  top: sbbDefaultSpacing / 4 * 3,
                  end: sbbDefaultSpacing,
                ),
                child: Text(
                  'CHF 0.99',
                  style: TextStyle(color: _isEnabled ? SBBColors.black : SBBColors.granite),
                ),
              ),
              isBoxed: true,
            ),
            SBBCheckboxListItem.boxed(
              value: _listItemValue7,
              label: 'Multiline Label with\nSecondary Label',
              allowMultilineLabel: true,
              secondaryLabel:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut convallis leo et metus semper hendrerit. '
                  'Duis nec nunc a ligula cursus vulputate. Donec sed elit ultricies, euismod erat et, eleifend augue.',
              isLastElement: true,
              onChanged: _isEnabled ? (value) => setState(() => _listItemValue7 = value) : null,
            ),
          ],
        ),
      ],
    );
  }
}
