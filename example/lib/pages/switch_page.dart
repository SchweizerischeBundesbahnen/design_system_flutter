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
                  children: [
                    SBBSwitchListItem(
                      value: _value2,
                      title: 'Default',
                      onChanged: _isEnabled ? (value) => setState(() => _value2 = value) : null,
                    ),
                    SBBSwitchListItem(
                      value: _value3,
                      title: 'Icon',
                      leadingIcon: SBBIcons.dog_small,
                      onChanged: _isEnabled ? (value) => setState(() => _value3 = value) : null,
                    ),
                    SBBSwitchListItem(
                      value: _value4,
                      title: 'Very Looooooooooooooooooooooong Multiline Label With Subtitle',
                      allowMultilineLabel: true,
                      subtitle: 'Subtitle',
                      onChanged: _isEnabled ? (value) => setState(() => _value4 = value) : null,
                    ),
                    SBBSwitchListItem(
                      value: _value5,
                      title: 'With Link',
                      onChanged: _isEnabled ? (value) => setState(() => _value5 = value) : null,
                      links: [
                        SBBSwitchListItemLink(
                          text: 'Link Text',
                          onPressed: () => sbbToast.show(title: 'Link'),
                        ),
                      ],
                    ),
                    SBBSwitchListItem(
                      value: _value6,
                      title: 'With 3 Links',
                      onChanged: _isEnabled ? (value) => setState(() => _value6 = value) : null,
                      links: [
                        SBBSwitchListItemLink(
                          text: 'Toggleable Link Text 1',
                          onPressed: _isEnabled ? () => sbbToast.show(title: 'Link 1') : null,
                        ),
                        SBBSwitchListItemLink(
                          text: 'Link Text 2',
                          onPressed: () => sbbToast.show(title: 'Link 2'),
                        ),
                        SBBSwitchListItemLink(
                          text: 'Link Text 3',
                          onPressed: () => sbbToast.show(title: 'Link 3'),
                        ),
                      ],
                    ),
                    SBBSwitchListItem.custom(
                      value: _value7,
                      title: 'Custom LinkWidget',
                      onChanged: _isEnabled ? (value) => setState(() => _value7 = value) : null,
                      // linksWidgets: [
                      //   SBBCheckboxListItem(
                      //     value: _listItemValue,
                      //     label: 'Text',
                      //     allowMultilineLabel: true,
                      //     secondaryLabel:
                      //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla.',
                      //     onChanged: _isEnabled ? (value) => setState(() => _listItemValue = value) : null,
                      //   ),
                      // ],
                    ),
                    SBBSwitchListItem(
                      value: _value8,
                      title: 'Loading',
                      subtitle: 'This will stop loading if selected',
                      onChanged: _isEnabled ? (value) => setState(() => _value8 = value) : null,
                      isLastElement: true,
                      isLoading: !_value8,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: sbbDefaultSpacing * 2),
              const SBBListHeader('SwitchItem - Boxed'),
              SBBContentBox(
                child: SBBSwitchListItem.boxed(
                  value: _value2,
                  title: 'Default',
                  onChanged: _isEnabled ? (value) => setState(() => _value2 = value) : null,
                ),
              ),
              const SizedBox(height: sbbDefaultSpacing * .5),
              SBBContentBox(
                child: SBBSwitchListItem.boxed(
                  value: _value3,
                  title: 'Icon',
                  leadingIcon: SBBIcons.dog_small,
                  onChanged: _isEnabled ? (value) => setState(() => _value3 = value) : null,
                ),
              ),
              const SizedBox(height: sbbDefaultSpacing * .5),
              SBBContentBox(
                child: SBBSwitchListItem.boxed(
                  value: _value4,
                  title: 'Very Looooooooooooooooooooooong Multiline Label With Subtitle',
                  allowMultilineLabel: true,
                  subtitle: 'Subtitle',
                  onChanged: _isEnabled ? (value) => setState(() => _value4 = value) : null,
                ),
              ),
              const SizedBox(height: sbbDefaultSpacing * .5),
              SBBContentBox(
                child: SBBSwitchListItem.boxed(
                  value: _value5,
                  title: 'With Link',
                  onChanged: _isEnabled ? (value) => setState(() => _value5 = value) : null,
                  links: [
                    SBBSwitchListItemLink(
                      text: 'Link Text',
                      onPressed: () => sbbToast.show(title: 'Link'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: sbbDefaultSpacing * .5),
              SBBContentBox(
                child: SBBSwitchListItem.boxed(
                  value: _value6,
                  title: 'With 3 Links',
                  onChanged: _isEnabled ? (value) => setState(() => _value6 = value) : null,
                  links: [
                    SBBSwitchListItemLink(
                      text: 'Toggleable Link Text 1',
                      onPressed: _isEnabled ? () => sbbToast.show(title: 'Link 1') : null,
                    ),
                    SBBSwitchListItemLink(
                      text: 'Link Text 2',
                      onPressed: () => sbbToast.show(title: 'Link 2'),
                    ),
                    SBBSwitchListItemLink(
                      text: 'Link Text 3',
                      onPressed: () => sbbToast.show(title: 'Link 3'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: sbbDefaultSpacing * .5),
              SBBContentBox(
                child: SBBSwitchListItem.custom(
                  value: _value7,
                  title: 'Custom LinkWidget',
                  onChanged: _isEnabled ? (value) => setState(() => _value7 = value) : null,
                  // linksWidgets: [
                  //   SBBCheckboxListItem(
                  //     value: _listItemValue,
                  //     label: 'Text',
                  //     allowMultilineLabel: true,
                  //     secondaryLabel:
                  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla.',
                  //     isLastElement: true,
                  //     onChanged: _isEnabled ? (value) => setState(() => _listItemValue = value) : null,
                  //   ),
                  // ],
                  isLastElement: true,
                ),
              ),
              const SizedBox(height: sbbDefaultSpacing * .5),
              SBBContentBox(
                child: SBBSwitchListItem(
                  value: _value8,
                  title: 'Loading',
                  subtitle: 'This will not stop.',
                  onChanged: _isEnabled ? (value) => setState(() => _value8 = value) : null,
                  isLastElement: true,
                  isLoading: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
