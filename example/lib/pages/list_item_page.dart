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
                title: 'Icon',
                leadingIcon: SBBIcons.clock_small,
                onPressed: () => sbbToast.show(message: 'ListItem with Icon'),
              ),
              SBBListItem(
                title: 'Call to Action',
                trailingIcon: SBBIcons.chevron_small_right_small,
                onCallToAction: () => sbbToast.show(message: 'Call to Action'),
                onPressed: () =>
                    sbbToast.show(message: 'ListItem with Call to Action'),
              ),
              SBBListItem(
                title: 'Subtitle',
                subtitle: 'This is the Subtitle',
                onPressed: () =>
                    sbbToast.show(message: 'ListItem with Subtitle'),
              ),
              SBBListItem(
                title: 'Subtitle, Call to Action',
                subtitle: 'This is the Subtitle',
                trailingIcon: SBBIcons.chevron_small_right_small,
                onCallToAction: () => sbbToast.show(message: 'Call to Action'),
                onPressed: () => sbbToast.show(
                    message: 'ListItem with Subtitle and Call to Action'),
              ),
              SBBListItem(
                title: 'Icon, Call to Action',
                leadingIcon: SBBIcons.clock_small,
                trailingIcon: SBBIcons.chevron_small_right_small,
                onCallToAction: () => sbbToast.show(message: 'Call to Action'),
                onPressed: () => sbbToast.show(
                    message: 'ListItem with Icon and Call to Action'),
              ),
              SBBListItem(
                title: 'Icon, Subtitle',
                leadingIcon: SBBIcons.clock_small,
                subtitle: 'This is the Subtitle',
                onPressed: () =>
                    sbbToast.show(message: 'ListItem with Icon and Subtitle'),
              ),
              SBBListItem(
                title: 'Icon, Subtitle, Call to Action',
                subtitle: 'This is the Subtitle',
                isLastElement: true,
                leadingIcon: SBBIcons.clock_small,
                trailingIcon: SBBIcons.chevron_small_right_small,
                onCallToAction: () => sbbToast.show(message: 'Call to Action'),
                onPressed: () => sbbToast.show(
                    message: 'ListItem with Icon, Subtitle and Call to Action'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
