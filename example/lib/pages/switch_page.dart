import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  bool _value9 = false;
  bool _value10 = false;

  bool? _listItemValue = false;

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return ListView(
      padding: EdgeInsets.all(sbbDefaultSpacing),
      children: [
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Switch'),
        SBBGroup(
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: Row(
            children: [
              SBBSwitch(
                value: _value1,
                onChanged: (value) => setState(() => _value1 = value),
              ),
              const SizedBox(
                width: sbbDefaultSpacing,
              ),
              SBBSwitch(
                value: _value1,
                onChanged: null,
              ),
            ],
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('SwitchListItem'),
        SBBGroup(
          child: SBBSwitchListItem(
            value: _value2,
            title: 'Default',
            onChanged: (value) => setState(() => _value2 = value),
            isLastElement: true,
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBGroup(
          child: SBBSwitchListItem(
            value: _value3,
            title: 'Icon',
            leadingIcon: SBBIcons.dog_small,
            onChanged: (value) => setState(() => _value3 = value),
            isLastElement: true,
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBGroup(
          child: SBBSwitchListItem(
            value: _value4,
            title: 'Label',
            subtitle: 'Subtitle',
            onChanged: (value) => setState(() => _value4 = value),
            isLastElement: true,
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBGroup(
          child: SBBSwitchListItem(
            value: _value5,
            title: 'With Link',
            onChanged: (value) => setState(() => _value5 = value),
            links: [
              SBBSwitchListItemLink(
                text: 'Link Text',
                onPressed: () => sbbToast.show(
                  message: 'Link',
                ),
              )
            ],
            isLastElement: true,
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBGroup(
          child: Column(
            children: [
              SBBSwitchListItem(
                value: _value6,
                title: 'With 3 Links',
                onChanged: (value) => setState(() => _value6 = value),
                links: [
                  SBBSwitchListItemLink(
                    text: 'Link Text 1',
                    onPressed: () => sbbToast.show(
                      message: 'Link 1',
                    ),
                  ),
                  SBBSwitchListItemLink(
                    text: 'Link Text 2',
                    onPressed: () => sbbToast.show(
                      message: 'Link 2',
                    ),
                  ),
                  SBBSwitchListItemLink(
                    text: 'Link Text 3',
                    onPressed: () => sbbToast.show(
                      message: 'Link 3',
                    ),
                  ),
                ],
                isLastElement: true,
              ),
            ],
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBGroup(
          child: SBBSwitchListItem(
            value: _value7,
            title: 'Disabled, Link enabled',
            onChanged: null,
            links: [
              SBBSwitchListItemLink(
                text: 'Link still enabled',
                onPressed: () => sbbToast.show(
                  message: 'Link still enabled',
                ),
              )
            ],
            isLastElement: true,
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBGroup(
          child: SBBSwitchListItem(
            value: _value8,
            title: 'Only Link disabled',
            onChanged: (value) => setState(() => _value8 = value),
            links: [
              SBBSwitchListItemLink(
                text: 'Link disabled',
                onPressed: null,
              ),
            ],
            isLastElement: true,
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBGroup(
          child: SBBSwitchListItem(
            value: _value9,
            title: 'Only Link disabled',
            onChanged: null,
            links: [
              SBBSwitchListItemLink(
                text: 'Link disabled',
                onPressed: null,
              ),
            ],
            isLastElement: true,
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBGroup(
          child: SBBSwitchListItem.custom(
            value: _value10,
            title: 'Custom LinkWidget',
            onChanged: (value) => setState(() => _value10 = value),
            linksWidgets: [
              SBBCheckboxListItem(
                value: _listItemValue,
                label: 'Text',
                allowMultilineLabel: true,
                secondaryLabel:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla.',
                isLastElement: true,
                onChanged: (value) => setState(() => _listItemValue = value),
              )
            ],
            isLastElement: true,
          ),
        ),
      ],
    );
  }
}
