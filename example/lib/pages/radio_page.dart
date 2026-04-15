import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

const loremIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    ' Curabitur finibus, nulla nec tempor ornare, purus orci dictum tortor, non tristique velit tellus eu ligula.';

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  RadioPageState createState() => RadioPageState();
}

class RadioPageState extends State<RadioPage> {
  int? _groupValue = 1;
  int? _listItemGroupValue;

  bool _pageEnabled = true;

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return DemoPageScaffold(
      componentConfig: Padding(
        padding: const .all(SBBSpacing.xSmall),
        child: SBBSegmentedButton(
          segments: [
            SBBButtonSegment(value: true, labelText: 'All enabled'),
            SBBButtonSegment(value: false, labelText: 'All Disabled'),
          ],
          selected: _pageEnabled,
          onSelectionChanged: (update) => setState(() => _pageEnabled = update),
        ),
      ),
      body: Column(
        children: [
          const SBBListHeader('Radio'),
          Padding(
            padding: const .symmetric(horizontal: SBBSpacing.xSmall),
            child: SBBRadioGroup<int>(
              groupValue: _groupValue,
              onChanged: (newValue) => setState(() => _groupValue = newValue),
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisSize: .min,
                    children: [
                      SBBRadio<int>(value: 1, enabled: _pageEnabled),
                      Text('Default'),
                    ],
                  ),
                  Row(
                    mainAxisSize: .min,
                    children: [
                      SBBRadio<int>(value: 2, enabled: _pageEnabled, toggleable: true),
                      Text('Toggleable'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
          SBBListHeader('Radio List Item - ListView'),
          SBBContentBox(
            child: SBBRadioGroup<int>(
              groupValue: _listItemGroupValue,
              onChanged: (newValue) => setState(() => _listItemGroupValue = newValue),
              child: Column(
                children: SBBListItem.divideListItems(
                  context: context,
                  items: [
                    SBBRadioListItem<int>(
                      value: 1,
                      titleText: 'Label',
                      enabled: _pageEnabled,
                    ),
                    SBBRadioListItem<int>(
                      value: 2,
                      titleText: 'Leading Icon',
                      leadingIconData: SBBIcons.alarm_clock_small,

                      enabled: _pageEnabled,
                    ),
                    SBBRadioListItem<int>(
                      value: 3,
                      titleText: 'Leading and Trailing Icon',
                      enabled: _pageEnabled,
                      leadingIconData: SBBIcons.alarm_clock_small,
                      trailingIconData: SBBIcons.dog_small,
                    ),
                    SBBRadioListItem<int>(
                      value: 4,
                      titleText: 'Button',
                      enabled: _pageEnabled,
                      padding: .fromLTRB(16.0, 0.0, 8.0, 0.0),
                      trailing: SBBTertiaryButtonSmall(
                        iconData: SBBIcons.circle_information_small_small,
                        onPressed: _pageEnabled ? () => sbbToast.show(titleText: 'Button pressed') : null,
                      ),
                    ),
                    SBBRadioListItem<int>(
                      value: 5,
                      titleText: 'Custom Trailing',
                      enabled: _pageEnabled,
                      trailing: Text('CHF 0.99'),
                    ),
                    SBBRadioListItem<int>(
                      value: 6,
                      title: Text('Multiline Label with\nSecondary Label'),
                      enabled: _pageEnabled,
                      subtitleText: loremIpsum,
                    ),
                    SBBRadioListItem<int>(
                      value: 7,
                      title: Text('Mit Links'),
                      enabled: _pageEnabled,
                      leadingIconData: SBBIcons.globe_small,
                      links: [
                        SBBListItem(
                          titleText: 'Link',
                          trailingIconData: SBBIcons.chevron_small_right_small,
                          onTap: () => sbbToast.show(titleText: 'Link'),
                        ),
                        SBBListItem(
                          titleText: 'Link 2',
                          trailingIconData: SBBIcons.chevron_small_right_small,
                          onTap: () => sbbToast.show(titleText: 'Link 2'),
                        ),
                      ],
                    ),
                    SBBRadioListItem<int>(
                      value: 8,
                      titleText: 'Loading',
                      enabled: _pageEnabled,
                      subtitleText: 'This will stop loading if selected.',
                      isLoading: _listItemGroupValue != 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: SBBSpacing.medium),
          const SBBListHeader('Radio List Item - Boxed'),
          Padding(
            padding: const .only(bottom: 64.0),
            child: SBBRadioGroup(
              groupValue: _listItemGroupValue,
              onChanged: (newValue) => setState(() => _listItemGroupValue = newValue),
              child: Column(
                spacing: SBBSpacing.xSmall,
                children: [
                  SBBRadioListItemBoxed<int>(
                    value: 1,
                    titleText: 'Label',
                  ),
                  SBBRadioListItemBoxed<int>(
                    value: 2,
                    titleText: 'Leading Icon',
                    leadingIconData: SBBIcons.alarm_clock_small,
                  ),
                  SBBRadioListItemBoxed<int>(
                    value: 3,
                    titleText: 'Leading and Trailing Icon',
                    leadingIconData: SBBIcons.alarm_clock_small,
                    trailingIconData: SBBIcons.dog_small,
                  ),
                  SBBRadioListItemBoxed<int>(
                    value: 4,
                    titleText: 'Button',
                    enabled: _pageEnabled,
                    padding: .fromLTRB(16.0, 0.0, 8.0, 0.0),
                    trailing: SBBTertiaryButtonSmall(
                      iconData: SBBIcons.circle_information_small_small,
                      onPressed: _pageEnabled ? () => sbbToast.show(titleText: 'Button pressed') : null,
                    ),
                  ),

                  SBBRadioListItemBoxed<int>(
                    value: 5,
                    titleText: 'Custom Trailing',
                    enabled: _pageEnabled,
                    trailing: Text('CHF 0.99'),
                  ),
                  SBBRadioListItemBoxed<int>(
                    value: 6,
                    title: Text('Multiline Label with\nSecondary Label'),
                    enabled: _pageEnabled,
                    subtitleText: loremIpsum,
                  ),
                  SBBRadioListItemBoxed<int>(
                    value: 7,
                    title: Text('Mit Links'),
                    leadingIconData: SBBIcons.globe_small,
                    enabled: _pageEnabled,
                    links: [
                      SBBListItem(
                        titleText: 'Link',
                        trailingIconData: SBBIcons.chevron_small_right_small,
                        onTap: () => sbbToast.show(titleText: 'Link'),
                      ),
                      SBBListItem(
                        titleText: 'Link 2',
                        trailingIconData: SBBIcons.chevron_small_right_small,
                        onTap: () => sbbToast.show(titleText: 'Link 2'),
                      ),
                    ],
                  ),
                  SBBRadioListItemBoxed<int>(
                    value: 8,
                    titleText: 'Loading',
                    subtitleText: 'This will not stop.',
                    isLoading: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
