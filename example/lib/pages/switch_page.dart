import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:example/native_app.dart';
import 'package:flutter/material.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key});

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  bool? _value1 = false;

  @override
  Widget build(BuildContext context) {
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
                  onChanged: (bool? value) => setState(() => _value1 = value)),
              SBBSwitch(
                value: _value1,
                onChanged: null,
              ),
            ],
          ),
        ),
        const SBBListHeader('Switch-Item Liste'),
        const SBBListHeader('Switch-Item Liste, mit Icon'),
        const SBBListHeader('Switch-Item Liste, mit Subtext'),
        const SBBListHeader('Switch-Item Liste, mit Link'),
        const SBBListHeader('Switch-Item Boxed'),
        const SBBListHeader('Switch-Item Boxed, mit Icon'),
        const SBBListHeader('Switch-Item Boxed, mit Subtext'),
        const SBBListHeader('Switch-Item Boxed, mit Link'),
      ],
    );
  }
}
