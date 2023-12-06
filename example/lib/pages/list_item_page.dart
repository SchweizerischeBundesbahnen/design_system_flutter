import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class ListItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: [
        ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        SBBGroup(
          child: Column(
            children: <Widget>[
              SBBListItem(
                title: 'Default',
                onPressed: () => sbbToast.show(message: 'ListItem Default'),
              ),
              SBBListItem(
                title: 'Subtitle',
                subtitle: 'This is the Subtitle',
                onPressed: () =>
                    sbbToast.show(message: 'ListItem with Subtitle'),
              ),
              SBBListItem(
                title: 'Icon',
                leadingIcon: SBBIconsSmall.clock_small,
                onPressed: () => sbbToast.show(message: 'ListItem with Icon'),
              ),
              SBBListItem(
                title: 'Trailing Icon',
                trailingIcon: SBBIconsSmall.chevron_small_right_small,
                onPressed: () => sbbToast.show(message: 'ListItem with Icon'),
              ),
              SBBListItem.button(
                title: 'Button',
                onPressed: () =>
                    sbbToast.show(message: 'ListItem with Button'),
                buttonIcon: SBBIconsSmall.chevron_small_right_small,
                onPressedButton: () => sbbToast.show(message: 'Button'),
              ),
              SBBListItem.button(
                title: 'Subtitle, Button',
                subtitle: 'This is the Subtitle',
                buttonIcon: SBBIconsSmall.chevron_small_right_small,
                onPressedButton: () => sbbToast.show(message: 'Button'),
                onPressed: () => sbbToast.show(
                    message: 'ListItem with Subtitle and Button'),
              ),
              SBBListItem.button(
                title: 'Icon, Button',
                leadingIcon: SBBIconsSmall.clock_small,
                buttonIcon: SBBIconsSmall.chevron_small_right_small,
                onPressedButton: () => sbbToast.show(message: 'Button'),
                onPressed: () => sbbToast.show(
                    message: 'ListItem with Icon and Button'),
              ),
              SBBListItem(
                title: 'Icon, Subtitle',
                leadingIcon: SBBIconsSmall.clock_small,
                subtitle: 'This is the Subtitle',
                onPressed: () =>
                    sbbToast.show(message: 'ListItem with Icon and Subtitle'),
              ),
              SBBListItem.button(
                title: 'Icon, Subtitle, Button',
                subtitle: 'This is the Subtitle',
                leadingIcon: SBBIconsSmall.clock_small,
                buttonIcon: SBBIconsSmall.chevron_small_right_small,
                onPressedButton: () => sbbToast.show(message: 'Button'),
                onPressed: () => sbbToast.show(
                    message: 'ListItem with Icon, Subtitle and Button'),
              ),
              SBBListItem.button(
                title: 'Disabled, Icon, Subtitle, Button',
                subtitle: 'This is the Subtitle',
                isLastElement: true,
                leadingIcon: SBBIconsSmall.clock_small,
                onPressed: null,
                buttonIcon: SBBIconsSmall.chevron_small_right_small,
                onPressedButton: () => sbbToast.show(message: 'Button'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
