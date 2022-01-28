import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class RadiobuttonPage extends StatefulWidget {
  @override
  _RadiobuttonPageState createState() => _RadiobuttonPageState();
}

class _RadiobuttonPageState extends State<RadiobuttonPage> {
  int? _groupValue = 1;
  int? _listItemGroupValue;

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: <Widget>[
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('RadioButton'),
        SBBGroup(
          padding: const EdgeInsets.all(sbbDefaultSpacing / 2),
          child: Row(
            children: [
              SBBRadioButton<int>(
                groupValue: _groupValue,
                onChanged: (newValue) {
                  setState(() {
                    _groupValue = newValue;
                  });
                },
                value: 1,
              ),
              SBBRadioButton<int>(
                groupValue: _groupValue,
                onChanged: null,
                value: 2,
              ),
              SBBRadioButton<int>(
                groupValue: _groupValue,
                onChanged: (newValue) {
                  setState(() {
                    _groupValue = newValue;
                  });
                },
                value: 2,
              ),
            ],
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing),
        SBBListHeader('RadioButtonListItem'),
        SBBGroup(
          child: Column(
            children: [
              SBBRadioButtonListItem<int>(
                value: 1,
                groupValue: _listItemGroupValue,
                onChanged: (newValue) {
                  setState(() {
                    _listItemGroupValue = newValue;
                  });
                },
                label: 'Label',
              ),
              SBBRadioButtonListItem<int>(
                value: 2,
                groupValue: _listItemGroupValue,
                onChanged: (newValue) {
                  setState(() {
                    _listItemGroupValue = newValue;
                  });
                },
                label: 'Call to Action',
                trailingIcon: SBBIcons.circle_information_small_small,
                onCallToAction: () => sbbToast.show(message: 'Call to Action'),
              ),
              SBBRadioButtonListItem<int>(
                value: 3,
                groupValue: _listItemGroupValue,
                onChanged: (newValue) {
                  setState(() {
                    _listItemGroupValue = newValue;
                  });
                },
                label: 'Icon',
                leadingIcon: SBBIcons.alarm_clock_small,
              ),
              SBBRadioButtonListItem<int>(
                value: 4,
                groupValue: _listItemGroupValue,
                onChanged: (newValue) {
                  setState(() {
                    _listItemGroupValue = newValue;
                  });
                },
                label: 'Icon, Call to Action',
                leadingIcon: SBBIcons.alarm_clock_small,
                trailingIcon: SBBIcons.circle_information_small_small,
                onCallToAction: () => sbbToast.show(message: 'Call to Action'),
              ),
              SBBRadioButtonListItem<int>(
                value: 4,
                groupValue: _listItemGroupValue,
                onChanged: null,
                label: 'Disabled, Icon, Call to Action',
                leadingIcon: SBBIcons.alarm_clock_small,
                trailingIcon: SBBIcons.circle_information_small_small,
                onCallToAction: () => sbbToast.show(message: 'Call to Action'),
              ),
              SBBRadioButtonListItem<int>.custom(
                value: 5,
                groupValue: _listItemGroupValue,
                onChanged: (newValue) {
                  setState(() {
                    _listItemGroupValue = newValue;
                  });
                },
                label: 'Custom trailing Widget',
                trailingWidget: Padding(
                  padding: const EdgeInsets.only(right: sbbDefaultSpacing),
                  child: Text('CHF 0.99'),
                ),
              ),
              SBBRadioButtonListItem<int>(
                value: 6,
                groupValue: _listItemGroupValue,
                onChanged: (newValue) {
                  setState(() {
                    _listItemGroupValue = newValue;
                  });
                },
                label: 'Multiline Label with\nSecondary Label',
                allowMultilineLabel: true,
                secondaryLabel: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut convallis leo et metus semper hendrerit. Duis nec nunc a ligula cursus vulputate. Donec sed elit ultricies, euismod erat et, eleifend augue.',
                isLastElement: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
