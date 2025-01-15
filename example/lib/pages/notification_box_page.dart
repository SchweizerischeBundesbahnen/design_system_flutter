import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

const title = 'Title';
const text =
    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magn…';

class NotificationBoxPage extends StatefulWidget {
  const NotificationBoxPage({super.key});

  @override
  State<NotificationBoxPage> createState() => _NotificationBoxPage();
}

class _NotificationBoxPage extends State<NotificationBoxPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: [
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Alert'),
        SBBGroup(
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: Column(
            children: [
              SBBNotificationBox.alert(
                title: title,
                text: text,
                onTap: () {},
              ),
              const SizedBox(height: sbbDefaultSpacing),
              SBBNotificationBox.alert(
                text: text,
              ),
              const SizedBox(height: sbbDefaultSpacing),
              SBBNotificationBox.alert(
                title: title,
                text: text,
                onTap: () {},
                hasIcon: false,
                isCloseable: false,
                detailsIcon: SBBIcons.arrows_circle_small,
              ),
              const SizedBox(height: sbbDefaultSpacing),
              SBBNotificationBox.alert(
                text: text,
                onTap: () {},
                hasIcon: false,
                isCloseable: false,
                detailsIcon: SBBIcons.arrows_circle_small,
              ),
              const SizedBox(height: sbbDefaultSpacing),
            ],
          ),
        ),
        const SBBListHeader('Warning'),
        SBBGroup(
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: Column(
            children: [
              SBBNotificationBox.warning(
                title: title,
                text: text,
                onTap: () {},
              ),
              const SizedBox(height: sbbDefaultSpacing),
              SBBNotificationBox.warning(
                text: text,
              ),
              const SizedBox(height: sbbDefaultSpacing),
              SBBNotificationBox.warning(
                title: title,
                text: text,
                onTap: () {},
                hasIcon: false,
                isCloseable: false,
                detailsIcon: SBBIcons.arrows_circle_small,
              ),
              const SizedBox(height: sbbDefaultSpacing),
              SBBNotificationBox.warning(
                text: text,
                onTap: () {},
                hasIcon: false,
                isCloseable: false,
                detailsIcon: SBBIcons.arrows_circle_small,
              ),
            ],
          ),
        ),
        const SBBListHeader('Success'),
        SBBGroup(
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: Column(
            children: [
              SBBNotificationBox.success(
                title: title,
                text: text,
                onTap: () {},
              ),
              const SizedBox(height: sbbDefaultSpacing),
              SBBNotificationBox.success(
                text: text,
              ),
              const SizedBox(height: sbbDefaultSpacing),
              SBBNotificationBox.success(
                title: title,
                text: text,
                onTap: () {},
                hasIcon: false,
                isCloseable: false,
                detailsIcon: SBBIcons.arrows_circle_small,
              ),
              const SizedBox(height: sbbDefaultSpacing),
              SBBNotificationBox.success(
                text: text,
                onTap: () {},
                hasIcon: false,
                isCloseable: false,
                detailsIcon: SBBIcons.arrows_circle_small,
              ),
            ],
          ),
        ),
        const SBBListHeader('Information'),
        SBBGroup(
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: Column(
            children: [
              SBBNotificationBox.information(
                title: title,
                onTap: () {},
                text: text,
              ),
              const SizedBox(height: sbbDefaultSpacing),
              SBBNotificationBox.information(
                text: text,
              ),
              const SizedBox(height: sbbDefaultSpacing),
              SBBNotificationBox.information(
                title: title,
                text: text,
                onTap: () {},
                hasIcon: false,
                isCloseable: false,
                detailsIcon: SBBIcons.arrows_circle_small,
              ),
              const SizedBox(height: sbbDefaultSpacing),
              SBBNotificationBox.information(
                text: text,
                onTap: () {},
                hasIcon: false,
                isCloseable: false,
                detailsIcon: SBBIcons.arrows_circle_small,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
