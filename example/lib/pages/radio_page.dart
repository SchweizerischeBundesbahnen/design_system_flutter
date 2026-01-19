import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

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

  int _enabledIndex = 0;

  bool get _pageEnabled => _enabledIndex == 0;

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
            children: <Widget>[
              const SBBListHeader('Radio'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5),
                child: SBBRadioGroup<int>(
                  groupValue: _groupValue,
                  onChanged: (newValue) => setState(() => _groupValue = newValue),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SBBRadio<int>(
                            value: 1,
                            enabled: _pageEnabled,
                          ),
                          Text('Default'),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SBBRadio<int>(
                            value: 2,
                            enabled: _pageEnabled,
                            toggleable: true,
                          ),
                          Text('Toggleable'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: sbbDefaultSpacing),
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
                          padding: SBBListItemStyle.defaultPadding.copyWith(right: 8),
                          trailing: SBBTertiaryButtonSmall(
                            iconData: SBBIcons.circle_information_small_small,
                            onPressed: _pageEnabled ? () => sbbToast.show(title: 'Button pressed') : null,
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
                              titleText: "Link",
                              trailingIconData: SBBIcons.chevron_small_right_small,
                              onTap: () => sbbToast.show(title: 'Link'),
                            ),
                            SBBListItem(
                              titleText: "Link 2",
                              trailingIconData: SBBIcons.chevron_small_right_small,
                              onTap: () => sbbToast.show(title: 'Link 2'),
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
                    ).toList(growable: false),
                  ),
                ),
              ),
              const SizedBox(height: sbbDefaultSpacing),
              const SBBListHeader('Radio List Item - Boxed'),
              Padding(
                padding: const EdgeInsets.only(bottom: sbbDefaultSpacing * 4),
                child: SBBRadioGroup(
                  groupValue: _listItemGroupValue,
                  onChanged: (newValue) => setState(() => _listItemGroupValue = newValue),
                  child: Column(
                    spacing: sbbDefaultSpacing * 0.5,
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
                        padding: SBBListItemStyle.defaultPadding.copyWith(right: 8),
                        trailing: SBBTertiaryButtonSmall(
                          iconData: SBBIcons.circle_information_small_small,
                          onPressed: _pageEnabled ? () => sbbToast.show(title: 'Button pressed') : null,
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
                            titleText: "Link",
                            trailingIconData: SBBIcons.chevron_small_right_small,
                            onTap: () => sbbToast.show(title: 'Link'),
                          ),
                          SBBListItem(
                            titleText: "Link 2",
                            trailingIconData: SBBIcons.chevron_small_right_small,
                            onTap: () => sbbToast.show(title: 'Link 2'),
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
        ),
      ],
    );
  }
}
