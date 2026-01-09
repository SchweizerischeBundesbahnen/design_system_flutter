import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

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
  bool _listItemValue8 = false;

  int _enabledIndex = 0;

  bool get _isEnabled => _enabledIndex == 0;

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(
          child: Column(
            spacing: sbbDefaultSpacing,
            children: [
              ThemeModeSegmentedButton(),
              SBBSegmentedButton(
                values: ['All Enabled', 'All Disabled'],
                selectedStateIndex: _enabledIndex,
                selectedIndexChanged: (i) => setState(() => _enabledIndex = i),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
          sliver: SliverList.list(
            children: [
              const SBBListHeader('Checkbox'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: sbbDefaultSpacing * .5,
                  children: [
                    Row(
                      children: [
                        SBBCheckbox(
                          onChanged: _isEnabled ? (bool? value) => setState(() => _value1 = value) : null,
                          value: _value1,
                        ),
                        Text('Default'),
                      ],
                    ),
                    Row(
                      children: [
                        SBBCheckbox(
                          onChanged: _isEnabled ? (bool? value) => setState(() => _value2 = value) : null,
                          value: _value2,
                          tristate: true,
                        ),
                        Text('Tristate'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: sbbDefaultSpacing),
              const SBBListHeader('Checkbox Item - List'),
              SBBContentBox(
                child: Column(
                  children: SBBListItemV5.divideListItems(
                    context: context,
                    items: [
                      SBBCheckboxListItem(
                        value: _listItemValue1,
                        titleText: 'Label',
                        onChanged: _isEnabled ? (value) => setState(() => _listItemValue1 = value) : null,
                      ),
                      SBBCheckboxListItem(
                        value: _listItemValue2,
                        titleText: 'Tristate',
                        tristate: true,
                        onChanged: _isEnabled ? (value) => setState(() => _listItemValue2 = value) : null,
                      ),
                      SBBCheckboxListItem(
                        value: _listItemValue4,
                        titleText: 'Leading Icon',
                        onChanged: _isEnabled ? (value) => setState(() => _listItemValue4 = value) : null,
                        leadingIconData: SBBIcons.alarm_clock_small,
                      ),
                      SBBCheckboxListItem(
                        value: _listItemValue5,
                        titleText: 'Leading and Trailing Icon',
                        onChanged: _isEnabled ? (value) => setState(() => _listItemValue5 = value) : null,
                        leadingIconData: SBBIcons.alarm_clock_small,
                        trailingIconData: SBBIcons.dog_small,
                      ),
                      SBBCheckboxListItem(
                        value: _listItemValue3,
                        titleText: 'Button',
                        onChanged: _isEnabled ? (value) => setState(() => _listItemValue3 = value) : null,
                        padding: SBBListItemV5Style.defaultPadding.copyWith(right: 8),
                        trailing: SBBTertiaryButtonSmall(
                          iconData: SBBIcons.circle_information_small_small,
                          onPressed: _isEnabled ? () => sbbToast.show(title: 'Button pressed') : null,
                        ),
                      ),
                      SBBCheckboxListItem(
                        value: _listItemValue6,
                        titleText: 'Custom Trailing',
                        onChanged: _isEnabled ? (value) => setState(() => _listItemValue6 = value) : null,
                        trailing: Text('CHF 0.99'),
                      ),
                      SBBCheckboxListItem(
                        value: _listItemValue7,
                        title: Text('Multiline Label with\nSecondary Label'),
                        subtitleText:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut convallis leo et metus semper hendrerit. Duis nec nunc a ligula cursus vulputate. Donec sed elit ultricies, euismod erat et, eleifend augue.',
                        onChanged: _isEnabled ? (value) => setState(() => _listItemValue7 = value) : null,
                      ),
                      SBBCheckboxListItem(
                        value: _listItemValue8,
                        titleText: 'Loading',
                        subtitleText: 'This will stop loading if selected.',
                        onChanged: _isEnabled ? (value) => setState(() => _listItemValue8 = value!) : null,
                        isLoading: !_listItemValue8,
                      ),
                    ],
                  ).toList(growable: false),
                ),
              ),
              const SizedBox(height: sbbDefaultSpacing),
              const SBBListHeader('Checkbox Item - Boxed'),
              Padding(
                padding: const EdgeInsets.only(bottom: sbbDefaultSpacing * 4),
                child: Column(
                  spacing: sbbDefaultSpacing * 0.5,
                  children: [
                    SBBCheckboxListItemBoxed(
                      value: _listItemValue1,
                      titleText: 'Label',
                      onChanged: _isEnabled ? (value) => setState(() => _listItemValue1 = value) : null,
                    ),
                    SBBCheckboxListItemBoxed(
                      value: _listItemValue2,
                      titleText: 'Tristate',
                      tristate: true,
                      onChanged: _isEnabled ? (value) => setState(() => _listItemValue2 = value) : null,
                    ),
                    SBBCheckboxListItemBoxed(
                      value: _listItemValue4,
                      titleText: 'Leading Icon',
                      onChanged: _isEnabled ? (value) => setState(() => _listItemValue4 = value) : null,
                      leadingIconData: SBBIcons.alarm_clock_small,
                    ),
                    SBBCheckboxListItemBoxed(
                      value: _listItemValue5,
                      titleText: 'Leading and Trailing Icon',
                      onChanged: _isEnabled ? (value) => setState(() => _listItemValue5 = value) : null,
                      leadingIconData: SBBIcons.alarm_clock_small,
                      trailingIconData: SBBIcons.dog_small,
                    ),
                    SBBCheckboxListItemBoxed(
                      value: _listItemValue3,
                      titleText: 'Button',
                      onChanged: _isEnabled ? (value) => setState(() => _listItemValue3 = value) : null,
                      padding: SBBListItemV5Style.defaultPadding.copyWith(right: 8),
                      trailing: SBBTertiaryButtonSmall(
                        iconData: SBBIcons.circle_information_small_small,
                        onPressed: _isEnabled ? () => sbbToast.show(title: 'Button pressed') : null,
                      ),
                    ),
                    SBBCheckboxListItemBoxed(
                      value: _listItemValue6,
                      titleText: 'Custom Trailing',
                      onChanged: _isEnabled ? (value) => setState(() => _listItemValue6 = value) : null,
                      trailing: Text('CHF 0.99'),
                    ),
                    SBBContentBox(
                      child: SBBCheckboxListItemBoxed(
                        value: _listItemValue7,
                        title: Text('Multiline Label with\nSecondary Label'),
                        subtitleText:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut convallis leo et metus semper hendrerit. '
                            'Duis nec nunc a ligula cursus vulputate. Donec sed elit ultricies, euismod erat et, eleifend augue.',
                        onChanged: _isEnabled ? (value) => setState(() => _listItemValue7 = value) : null,
                      ),
                    ),
                    SBBCheckboxListItemBoxed(
                      value: _listItemValue8,
                      titleText: 'Loading',
                      subtitleText: 'This will not stop.',
                      onChanged: _isEnabled ? (value) => setState(() => _listItemValue8 = value!) : null,
                      isLoading: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
