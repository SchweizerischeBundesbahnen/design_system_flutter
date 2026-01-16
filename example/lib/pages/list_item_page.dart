import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class ListItemPage extends StatelessWidget {
  const ListItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: [
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        SBBContentBox(
          child: Column(
            children: <Widget>[
              SBBListItem(
                title: 'Default',
                onPressed: () => sbbToast.show(title: 'ListItem Default'),
              ),
              SBBListItem(
                title: 'Subtitle',
                subtitle: 'This is the Subtitle',
                onPressed: () => sbbToast.show(title: 'ListItem with Subtitle'),
              ),
              SBBListItem(
                title: 'Icon',
                leadingIcon: SBBIcons.clock_small,
                onPressed: () => sbbToast.show(title: 'ListItem with Icon'),
              ),
              SBBListItem(
                title: 'Trailing Icon',
                trailingIcon: SBBIcons.chevron_small_right_small,
                onPressed: () => sbbToast.show(title: 'ListItem with Icon'),
              ),
              SBBListItem.button(
                title: 'Button',
                onPressed: () => sbbToast.show(title: 'ListItem with Button'),
                buttonIcon: SBBIcons.chevron_small_right_small,
                onPressedButton: () => sbbToast.show(title: 'Button'),
              ),
              SBBListItem.button(
                title: 'Subtitle, Button',
                subtitle: 'This is the Subtitle',
                buttonIcon: SBBIcons.chevron_small_right_small,
                onPressedButton: () => sbbToast.show(title: 'Button'),
                onPressed: () => sbbToast.show(title: 'ListItem with Subtitle and Button'),
              ),
              SBBListItem.button(
                title: 'Icon, Button',
                leadingIcon: SBBIcons.clock_small,
                buttonIcon: SBBIcons.chevron_small_right_small,
                onPressedButton: () => sbbToast.show(title: 'Button'),
                onPressed: () => sbbToast.show(title: 'ListItem with Icon and Button'),
              ),
              SBBListItem(
                title: 'Icon, Subtitle',
                leadingIcon: SBBIcons.clock_small,
                subtitle: 'This is the Subtitle',
                onPressed: () => sbbToast.show(title: 'ListItem with Icon and Subtitle'),
              ),
              SBBListItem.button(
                title: 'Icon, Subtitle, Button',
                subtitle: 'This is the Subtitle',
                leadingIcon: SBBIcons.clock_small,
                buttonIcon: SBBIcons.chevron_small_right_small,
                onPressedButton: () => sbbToast.show(title: 'Button'),
                onPressed: () => sbbToast.show(title: 'ListItem with Icon, Subtitle and Button'),
              ),
              SBBListItem.button(
                title: 'Disabled, Icon, Subtitle, Button',
                subtitle: 'This is the Subtitle',
                isLastElement: true,
                leadingIcon: SBBIcons.clock_small,
                onPressed: null,
                buttonIcon: SBBIcons.chevron_small_right_small,
                onPressedButton: () => sbbToast.show(title: 'Button'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
