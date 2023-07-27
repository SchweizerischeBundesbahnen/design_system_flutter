import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:example/native_app.dart';
import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.all(sbbDefaultSpacing / 2),
          child: Row(
            children: [
              SBBSwitch(
                  value: _value1,
                  onChanged: (value) => setState(() => _value1 = value)),
              SBBSwitch(
                value: _value1,
                onChanged: null,
              ),
            ],
          ),
        ),
        const SBBListHeader('Switch-Item Liste'),
        SBBGroup(
            child: Column(
          children: [
            SBBSwitchListItem(
              value: _value2,
              label: 'Label',
              onChanged: (value) => setState(() => _value2 = value),
            ),
            SBBSwitchListItem(
              value: _value2,
              label: 'Label',
              onChanged: null,
            ),
            SBBSwitchListItem(
              value: _value3,
              label: 'Label',
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
              label: 'Label',
              onChanged: (value) => setState(() => _value5 = value),
              linkText: 'Text',
              onPressed: () =>
                  sbbToast.show(message: 'SBB Switch ListItem with link'),
              isLastElement: true,
            ),
          ],
        )),
        const SBBListHeader('Switch-Item Boxed'),
        SBBGroup(
          child: SBBSwitchListItem(
            value: _value6,
            label: 'Label',
            onChanged: (value) => setState(() => _value6 = value),
            isLastElement: true,
          ),
        ),
        const SBBListHeader('Switch-Item Boxed, mit Icon'),
        SBBGroup(
          child: SBBSwitchListItem(
            value: _value7,
            label: 'Label',
            leadingIcon: SBBIcons.dog_small,
            onChanged: (value) => setState(() => _value7 = value),
            isLastElement: true,
          ),
        ),
        const SBBListHeader('Switch-Item Boxed, mit Subtext'),
        SBBGroup(
          child: SBBSwitchListItem(
            value: _value8,
            label: 'Label',
            subText: 'subText',
            onChanged: (value) => setState(() => _value8 = value),
            isLastElement: true,
          ),
        ),
        const SBBListHeader('Switch-Item Boxed, mit Link'),
        SBBGroup(
          child: SBBSwitchListItem(
            value: _value9,
            label: 'Label',
            onChanged: (value) => setState(() => _value9 = value),
            linkText: 'Text',
            onPressed: () =>
                sbbToast.show(message: 'SBB Switch-Item Boxed, mit Link'),
            isLastElement: true,
          ),
        ),
      ],
    );
  }
}
