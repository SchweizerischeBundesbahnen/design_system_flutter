import 'package:design_system_flutter/design_system_flutter.dart';
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
  bool _value11 = false;
  bool _value12 = false;
  bool _value13 = false;

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
        const SBBListHeader('Switch ListItem'),
        SBBGroup(
            child: Column(
          children: [
            SBBSwitchListItem(
              value: _value2,
              label: 'Default',
              onChanged: (value) => setState(() => _value2 = value),
            ),
            SBBSwitchListItem(
              value: _value2,
              label: 'Disabled',
              onChanged: null,
            ),
            SBBSwitchListItem(
              value: _value3,
              label: 'Icon',
              leadingIcon: SBBIcons.dog_small,
              onChanged: (value) => setState(() => _value3 = value),
            ),
            SBBSwitchListItem(
              value: _value4,
              label: 'Label',
              subText: 'subText',
              onChanged: (value) => setState(() => _value4 = value),
            ),
            SBBSwitchListItem(
              value: _value5,
              label: 'Multiline Label mit\nLong SubText',
              allowMultilineLabel: true,
              subText:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla.',
              onChanged: (value) => setState(() => _value5 = value),
            ),
            SBBSwitchListItem(
              value: _value6,
              label: 'Mit Link',
              onChanged: (value) => setState(() => _value6 = value),
              links: [
                SBBSwitchLink(
                  text: 'Link Text',
                  onPressed: () => sbbToast.show(
                    message: 'SBB Switch-Item Boxed, mit Link',
                  ),
                )
              ],
              isLastElement: true,
            ),
          ],
        )),
        const SBBListHeader('Switch ListItem Boxed'),
        SBBGroup(
          child: SBBSwitchListItem(
            value: _value7,
            label: 'Default',
            onChanged: (value) => setState(() => _value7 = value),
            isLastElement: true,
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBGroup(
          child: SBBSwitchListItem(
            value: _value8,
            label: 'Icon',
            leadingIcon: SBBIcons.dog_small,
            onChanged: (value) => setState(() => _value8 = value),
            isLastElement: true,
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBGroup(
          child: SBBSwitchListItem(
            value: _value9,
            label: 'Label',
            subText: 'subText',
            onChanged: (value) => setState(() => _value9 = value),
            isLastElement: true,
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBGroup(
          child: SBBSwitchListItem(
            value: _value10,
            label: 'Mit Link',
            onChanged: (value) => setState(() => _value10 = value),
            links: [
              SBBSwitchLink(
                text: 'Link Text',
                onPressed: () => sbbToast.show(
                  message: 'SBB Switch-Item Boxed, mit Link',
                ),
              )
            ],
            isLastElement: true,
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBGroup(
          child: SBBSwitchListItem(
            value: _value11,
            label: 'Switch ist deaktiviert',
            onChanged: null,
            links: [
              SBBSwitchLink(
                text: 'Link ist deaktiviert',
                onPressed: () => sbbToast.show(
                  message: 'SBB Switch-Item Boxed, mit Link',
                ),
              )
            ],
            isLastElement: true,
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBGroup(
          child: SBBSwitchListItem(
            value: _value12,
            label: 'Label',
            onChanged: (value) => setState(() => _value12 = value),
            links: [
              SBBSwitchLink(
                text: 'Nur Link ist deaktiviert',
                onPressed: null,
              ),
            ],
            isLastElement: true,
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        SBBGroup(
          child: SBBSwitchListItem.custom(
            value: _value13,
            label: 'Custom LinkWidget',
            onChanged: (value) => setState(() => _value13 = value),
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
