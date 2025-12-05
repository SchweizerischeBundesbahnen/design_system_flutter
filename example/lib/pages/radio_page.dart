import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

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
              SBBGroup(
                child: _pageEnabled
                    ? SBBRadioGroup<int>(
                        groupValue: _listItemGroupValue,
                        onChanged: _pageEnabled ? (newValue) => setState(() => _listItemGroupValue = newValue) : (_) {},
                        child: _listViewItems(sbbToast),
                      )
                    : _listViewItems(sbbToast), // TODO: temporary until SBBRadioListItem allows setting enabled
              ),
              const SizedBox(height: sbbDefaultSpacing),
              const SBBListHeader('Radio List Item - Boxed'),
              if (_pageEnabled)
                SBBRadioGroup(
                  groupValue: _listItemGroupValue,
                  onChanged: (newValue) => setState(() => _listItemGroupValue = newValue),
                  child: _boxedItems(sbbToast),
                ),
              // TODO: temporary until SBBRadioListItem also allows setting enabled
              if (!_pageEnabled) _boxedItems(sbbToast),
            ],
          ),
        ),
      ],
    );
  }

  Column _listViewItems(SBBToast sbbToast) {
    return Column(
      children: [
        SBBRadioListItem<int>(
          value: 1,
          label: 'Label',
        ),
        SBBRadioListItem<int>(
          value: 2,
          label: 'Leading Icon',
          leadingIcon: SBBIcons.alarm_clock_small,
        ),
        SBBRadioListItem<int>(
          value: 3,
          label: 'Leading and Trailing Icon',
          leadingIcon: SBBIcons.alarm_clock_small,
          trailingIcon: SBBIcons.dog_small,
        ),
        SBBRadioListItem<int>(
          value: 4,
          label: 'Button',
          trailingIcon: SBBIcons.circle_information_small_small,
          onCallToAction: () => sbbToast.show(title: 'Button'),
        ),
        SBBRadioListItem<int>.custom(
          value: 5,
          label: 'Custom trailing Widget',
          trailingWidget: const Padding(
            padding: EdgeInsetsDirectional.only(top: sbbDefaultSpacing * .75, end: sbbDefaultSpacing),
            child: Text('CHF 0.99'),
          ),
        ),
        SBBRadioListItem<int>(
          value: 6,
          label: 'Multiline Label with\nSecondary Label',
          allowMultilineLabel: true,
          secondaryLabel:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut convallis leo et metus semper hendrerit. Duis nec nunc a ligula cursus vulputate. Donec sed elit ultricies, euismod erat et, eleifend augue.',
        ),
        SBBRadioListItem<int>(
          value: 7,
          label: 'Loading',
          secondaryLabel: 'This will stop loading if selected.',
          isLoading: _listItemGroupValue != 7,
          isLastElement: true,
        ),
      ],
    );
  }

  Column _boxedItems(SBBToast sbbToast) {
    return Column(
      spacing: sbbDefaultSpacing * 0.5,
      children: [
        SBBGroup(
          child: SBBRadioListItem<int>.boxed(
            value: 1,
            label: 'Label',
          ),
        ),
        SBBGroup(
          child: SBBRadioListItem<int>.boxed(
            value: 2,
            label: 'Leading Icon',
            leadingIcon: SBBIcons.alarm_clock_small,
          ),
        ),
        SBBGroup(
          child: SBBRadioListItem<int>.boxed(
            value: 3,
            label: 'Leading and Trailing Icon',
            leadingIcon: SBBIcons.alarm_clock_small,
            trailingIcon: SBBIcons.dog_small,
          ),
        ),
        SBBGroup(
          child: SBBRadioListItem<int>.boxed(
            value: 4,
            label: 'Button',
            trailingIcon: SBBIcons.circle_information_small_small,
            onCallToAction: () => sbbToast.show(title: 'Button'),
          ),
        ),
        SBBGroup(
          child: SBBRadioListItem<int>.custom(
            value: 5,
            label: 'Custom trailing Widget',
            trailingWidget: const Padding(
              padding: EdgeInsetsDirectional.only(top: sbbDefaultSpacing * .75, end: sbbDefaultSpacing),
              child: Text('CHF 0.99'),
            ),
            isLastElement: false,
          ),
        ),
        SBBGroup(
          child: SBBRadioListItem<int>.boxed(
            value: 6,
            label: 'Multiline Label with\nSecondary Label',
            allowMultilineLabel: true,
            secondaryLabel:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut convallis leo et metus semper hendrerit. Duis nec nunc a ligula cursus vulputate. Donec sed elit ultricies, euismod erat et, eleifend augue.',
          ),
        ),
        SBBGroup(
          child: SBBRadioListItem<int>.boxed(
            value: 7,
            label: 'Loading',
            secondaryLabel: 'This will not stop.',
            isLoading: true,
          ),
        ),
      ],
    );
  }
}
