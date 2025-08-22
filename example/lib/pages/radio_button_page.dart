import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class RadiobuttonPage extends StatefulWidget {
  const RadiobuttonPage({super.key});

  @override
  RadiobuttonPageState createState() => RadiobuttonPageState();
}

class RadiobuttonPageState extends State<RadiobuttonPage> {
  int? _groupValue = 1;
  int? _listItemGroupValue;

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
        const SBBListHeader('RadioButton'),
        Padding(
          padding: const EdgeInsets.all(sbbDefaultSpacing * .5),
          child: Row(
            children: [
              SBBRadio<int>(
                groupValue: _groupValue,
                onChanged: (newValue) => setState(() => _groupValue = newValue),
                value: 1,
              ),
              SBBRadio<int>(
                groupValue: _groupValue,
                onChanged: null, // disabled
                value: 2,
              ),
              SBBRadio<int>(
                groupValue: _groupValue,
                onChanged: (newValue) => setState(() => _groupValue = newValue),
                value: 2,
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
        SBBListHeader('RadioButton Item - List'),
        SBBGroup(
          child: Column(
            children: [
              SBBRadioListItem<int>(
                value: 1,
                groupValue: _listItemGroupValue,
                onChanged:
                    _isEnabled
                        ? (newValue) =>
                            setState(() => _listItemGroupValue = newValue)
                        : null,
                label: 'Label',
              ),
              SBBRadioListItem<int>(
                value: 2,
                groupValue: _listItemGroupValue,
                onChanged:
                    _isEnabled
                        ? (newValue) =>
                            setState(() => _listItemGroupValue = newValue)
                        : null,
                label: 'Leading Icon',
                leadingIcon: SBBIcons.alarm_clock_small,
              ),
              SBBRadioListItem<int>(
                value: 3,
                groupValue: _listItemGroupValue,
                onChanged:
                    _isEnabled
                        ? (newValue) =>
                            setState(() => _listItemGroupValue = newValue)
                        : null,
                label: 'Leading and Trailing Icon',
                leadingIcon: SBBIcons.alarm_clock_small,
                trailingIcon: SBBIcons.dog_small,
              ),
              SBBRadioListItem<int>(
                value: 4,
                groupValue: _listItemGroupValue,
                onChanged:
                    _isEnabled
                        ? (newValue) =>
                            setState(() => _listItemGroupValue = newValue)
                        : null,
                label: 'Button',
                trailingIcon: SBBIcons.circle_information_small_small,
                onCallToAction: () => sbbToast.show(title: 'Button'),
              ),
              SBBRadioListItem<int>.custom(
                value: 5,
                groupValue: _listItemGroupValue,
                onChanged:
                    _isEnabled
                        ? (newValue) =>
                            setState(() => _listItemGroupValue = newValue)
                        : null,
                label: 'Custom trailing Widget',
                trailingWidget: const Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: sbbDefaultSpacing * .75,
                    end: sbbDefaultSpacing,
                  ),
                  child: Text('CHF 0.99'),
                ),
              ),
              SBBRadioListItem<int>(
                value: 6,
                groupValue: _listItemGroupValue,
                onChanged:
                    _isEnabled
                        ? (newValue) =>
                            setState(() => _listItemGroupValue = newValue)
                        : null,
                label: 'Multiline Label with\nSecondary Label',
                allowMultilineLabel: true,
                secondaryLabel:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut convallis leo et metus semper hendrerit. Duis nec nunc a ligula cursus vulputate. Donec sed elit ultricies, euismod erat et, eleifend augue.',
              ),
              SBBRadioListItem<int>(
                value: 7,
                groupValue: _listItemGroupValue,
                onChanged:
                    _isEnabled
                        ? (newValue) =>
                            setState(() => _listItemGroupValue = newValue)
                        : null,
                label: 'Loading',
                secondaryLabel: 'This will stop loading if selected.',
                isLoading: _listItemGroupValue != 7,
                isLastElement: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('RadioButton Item - Boxed'),
        Column(
          // spacing: sbbDefaultSpacing * 0.5,  add once support for Flutter SDK 3.24.5 removed
          // and remove SizedBoxes below
          children: [
            SBBGroup(
              child: SBBRadioListItem<int>.boxed(
                value: 1,
                groupValue: _listItemGroupValue,
                onChanged:
                    _isEnabled
                        ? (newValue) =>
                            setState(() => _listItemGroupValue = newValue)
                        : null,
                label: 'Label',
              ),
            ),
            SizedBox(height: sbbDefaultSpacing * .5),
            SBBGroup(
              child: SBBRadioListItem<int>.boxed(
                value: 2,
                groupValue: _listItemGroupValue,
                onChanged:
                    _isEnabled
                        ? (newValue) =>
                            setState(() => _listItemGroupValue = newValue)
                        : null,
                label: 'Leading Icon',
                leadingIcon: SBBIcons.alarm_clock_small,
              ),
            ),
            SizedBox(height: sbbDefaultSpacing * .5),
            SBBGroup(
              child: SBBRadioListItem<int>.boxed(
                value: 3,
                groupValue: _listItemGroupValue,
                onChanged:
                    _isEnabled
                        ? (newValue) =>
                            setState(() => _listItemGroupValue = newValue)
                        : null,
                label: 'Leading and Trailing Icon',
                leadingIcon: SBBIcons.alarm_clock_small,
                trailingIcon: SBBIcons.dog_small,
              ),
            ),
            SizedBox(height: sbbDefaultSpacing * .5),
            SBBGroup(
              child: SBBRadioListItem<int>.boxed(
                value: 4,
                groupValue: _listItemGroupValue,
                onChanged:
                    _isEnabled
                        ? (newValue) =>
                            setState(() => _listItemGroupValue = newValue)
                        : null,
                label: 'Button',
                trailingIcon: SBBIcons.circle_information_small_small,
                onCallToAction: () => sbbToast.show(title: 'Button'),
              ),
            ),
            SizedBox(height: sbbDefaultSpacing * .5),
            SBBGroup(
              child: SBBRadioListItem<int>.custom(
                value: 5,
                groupValue: _listItemGroupValue,
                onChanged:
                    _isEnabled
                        ? (newValue) =>
                            setState(() => _listItemGroupValue = newValue)
                        : null,
                label: 'Custom trailing Widget',
                trailingWidget: const Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: sbbDefaultSpacing * .75,
                    end: sbbDefaultSpacing,
                  ),
                  child: Text('CHF 0.99'),
                ),
                isLastElement: false,
              ),
            ),
            SizedBox(height: sbbDefaultSpacing * .5),
            SBBGroup(
              child: SBBRadioListItem<int>.boxed(
                value: 6,
                groupValue: _listItemGroupValue,
                onChanged:
                    _isEnabled
                        ? (newValue) =>
                            setState(() => _listItemGroupValue = newValue)
                        : null,
                label: 'Multiline Label with\nSecondary Label',
                allowMultilineLabel: true,
                secondaryLabel:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut convallis leo et metus semper hendrerit. Duis nec nunc a ligula cursus vulputate. Donec sed elit ultricies, euismod erat et, eleifend augue.',
              ),
            ),
            SizedBox(height: sbbDefaultSpacing * .5),
            SBBGroup(
              child: SBBRadioListItem<int>.boxed(
                value: 7,
                groupValue: _listItemGroupValue,
                onChanged:
                    _isEnabled
                        ? (newValue) =>
                            setState(() => _listItemGroupValue = newValue)
                        : null,
                label: 'Loading',
                secondaryLabel: 'This will not stop.',
                isLoading: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
