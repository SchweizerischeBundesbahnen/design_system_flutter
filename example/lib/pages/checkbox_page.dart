import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

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

  bool _isEnabled = true;

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return DemoPageScaffold(
      componentConfig: Padding(
        padding: .all(SBBSpacing.xSmall),
        child: SBBSegmentedButton(
          segments: [
            SBBButtonSegment(value: true, labelText: 'All enabled'),
            SBBButtonSegment(value: false, labelText: 'All Disabled'),
          ],
          selected: _isEnabled,
          onSelectionChanged: (update) => setState(() => _isEnabled = update),
        ),
      ),
      body: Column(
        children: [
          const SBBListHeader('Checkbox'),
          Padding(
            padding: const .symmetric(horizontal: SBBSpacing.xSmall),
            child: Column(
              crossAxisAlignment: .start,
              spacing: SBBSpacing.xSmall,
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
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Checkbox Item - List'),
          SBBContentBox(
            child: Column(
              children: SBBListItem.divideListItems(
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
                    padding: .fromLTRB(16.0, 0.0, 8.0, 0.0),
                    trailing: SBBTertiaryButtonSmall(
                      iconData: SBBIcons.circle_information_small_small,
                      onPressed: _isEnabled ? () => sbbToast.show(titleText: 'Button pressed') : null,
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
              ),
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Checkbox Item - Boxed'),
          Padding(
            padding: const .only(bottom: 64.0),
            child: Column(
              spacing: SBBSpacing.xSmall,
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
                  padding: .fromLTRB(16.0, 0.0, 8.0, 0.0),
                  trailing: SBBTertiaryButtonSmall(
                    iconData: SBBIcons.circle_information_small_small,
                    onPressed: _isEnabled ? () => sbbToast.show(titleText: 'Button pressed') : null,
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
    );
  }
}
