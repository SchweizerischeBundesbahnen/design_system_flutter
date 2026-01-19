import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key});

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;
  bool _value5 = false;
  bool _value6 = false;
  bool _value7 = false;
  bool _value8 = false;

  bool? _listItemValue = false;

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
          padding: EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * .5).copyWith(bottom: sbbDefaultSpacing * 2),
          sliver: SliverList.list(
            children: [
              const SBBListHeader('Switch'),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: sbbDefaultSpacing * .5),
                  child: SBBSwitch(
                    value: _value1,
                    onChanged: _isEnabled ? (value) => setState(() => _value1 = value) : null,
                  ),
                ),
              ),
              const SBBListHeader('SwitchItem - List'),
              SBBContentBox(
                child: Column(
                  children: SBBListItem.divideListItems(
                    context: context,
                    items: [
                      SBBSwitchListItem(
                        value: _value2,
                        titleText: 'Default',
                        onChanged: _isEnabled ? (value) => setState(() => _value2 = value) : null,
                      ),
                      SBBSwitchListItem(
                        value: _value3,
                        titleText: 'Icon',
                        leadingIconData: SBBIcons.dog_small,
                        onChanged: _isEnabled ? (value) => setState(() => _value3 = value) : null,
                      ),
                      SBBSwitchListItem(
                        value: _value4,
                        title: Text('Very Looooooooooooooooooooooong Multiline Label With Subtitle'),
                        subtitleText: 'Subtitle',
                        onChanged: _isEnabled ? (value) => setState(() => _value4 = value) : null,
                      ),
                      SBBSwitchListItem(
                        value: _value5,
                        titleText: 'With Link',
                        onChanged: _isEnabled ? (value) => setState(() => _value5 = value) : null,
                        links: [
                          SBBListItem(
                            titleText: 'Link Text',
                            onTap: () => sbbToast.show(title: 'Link'),
                            trailingIconData: SBBIcons.chevron_small_right_small,
                          ),
                        ],
                      ),
                      SBBSwitchListItem(
                        value: _value6,
                        titleText: 'With 3 Links',
                        onChanged: _isEnabled ? (value) => setState(() => _value6 = value) : null,
                        links: [
                          SBBListItem(
                            titleText: 'Toggleable Link',
                            onTap: _isEnabled ? () => sbbToast.show(title: 'Toggleable Link') : null,
                            trailingIconData: SBBIcons.chevron_small_right_small,
                          ),
                          SBBListItem(
                            titleText: 'Link Text 2',
                            onTap: () => sbbToast.show(title: 'Link 2'),
                            trailingIconData: SBBIcons.chevron_small_right_small,
                          ),
                          SBBListItem(
                            titleText: 'Link Text',
                            onTap: () => sbbToast.show(title: 'Link 3'),
                            trailingIconData: SBBIcons.chevron_small_right_small,
                          ),
                        ],
                      ),
                      SBBSwitchListItem(
                        value: _value7,
                        titleText: 'Custom Link',
                        onChanged: _isEnabled ? (value) => setState(() => _value7 = value) : null,
                        links: [
                          SBBCheckboxListItem(
                            value: _listItemValue,
                            titleText: 'Text',
                            subtitleText:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                'Quisque vulputate massa ut ex fringilla.',
                            onChanged: _isEnabled ? (value) => setState(() => _listItemValue = value) : null,
                          ),
                        ],
                      ),
                      SBBSwitchListItem(
                        value: _value8,
                        titleText: 'Loading',
                        subtitleText: 'This will stop loading if selected',
                        onChanged: _isEnabled ? (value) => setState(() => _value8 = value) : null,
                        isLoading: !_value8,
                      ),
                    ],
                  ).toList(growable: false),
                ),
              ),
              const SizedBox(height: sbbDefaultSpacing * 2),
              const SBBListHeader('SwitchItem - Boxed'),
              Column(
                spacing: sbbDefaultSpacing * .5,
                children: [
                  SBBSwitchListItemBoxed(
                    value: _value2,
                    titleText: 'Default',
                    onChanged: _isEnabled ? (value) => setState(() => _value2 = value) : null,
                  ),
                  SBBSwitchListItemBoxed(
                    value: _value3,
                    titleText: 'Icon',
                    leadingIconData: SBBIcons.dog_small,
                    onChanged: _isEnabled ? (value) => setState(() => _value3 = value) : null,
                  ),
                  SBBSwitchListItemBoxed(
                    value: _value4,
                    title: Text('Very Looooooooooooooooooooooong Multiline Label With Subtitle'),
                    subtitleText: 'Subtitle',
                    onChanged: _isEnabled ? (value) => setState(() => _value4 = value) : null,
                  ),
                  SBBSwitchListItemBoxed(
                    value: _value5,
                    titleText: 'With Link',
                    onChanged: _isEnabled ? (value) => setState(() => _value5 = value) : null,
                    links: [
                      SBBListItem(
                        titleText: 'Link Text',
                        onTap: () => sbbToast.show(title: 'Link'),
                        trailingIconData: SBBIcons.chevron_small_right_small,
                      ),
                    ],
                  ),
                  SBBSwitchListItemBoxed(
                    value: _value6,
                    titleText: 'With 3 Links',
                    onChanged: _isEnabled ? (value) => setState(() => _value6 = value) : null,
                    links: [
                      SBBListItem(
                        titleText: 'Toggleable Link',
                        onTap: _isEnabled ? () => sbbToast.show(title: 'Toggleable Link') : null,
                        trailingIconData: SBBIcons.chevron_small_right_small,
                      ),
                      SBBListItem(
                        titleText: 'Link Text 2',
                        onTap: () => sbbToast.show(title: 'Link 2'),
                        trailingIconData: SBBIcons.chevron_small_right_small,
                      ),
                      SBBListItem(
                        titleText: 'Link Text',
                        onTap: () => sbbToast.show(title: 'Link 3'),
                        trailingIconData: SBBIcons.chevron_small_right_small,
                      ),
                    ],
                  ),
                  SBBSwitchListItemBoxed(
                    value: _value7,
                    titleText: 'Custom Link',
                    onChanged: _isEnabled ? (value) => setState(() => _value7 = value) : null,
                    links: [
                      SBBCheckboxListItem(
                        value: _listItemValue,
                        titleText: 'Text',
                        subtitleText:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                            'Quisque vulputate massa ut ex fringilla.',
                        onChanged: _isEnabled ? (value) => setState(() => _listItemValue = value) : null,
                      ),
                    ],
                  ),
                  SBBSwitchListItemBoxed(
                    value: _value8,
                    titleText: 'Loading',
                    subtitleText: 'This will not stop.',
                    onChanged: _isEnabled ? (value) => setState(() => _value8 = value) : null,
                    isLoading: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
