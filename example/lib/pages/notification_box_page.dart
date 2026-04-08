import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

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
      padding: const .all(SBBSpacing.medium),
      children: [
        const ThemeModeSegmentedButton(),
        const SizedBox(height: SBBSpacing.medium),
        const SBBListHeader('Alert'),
        SBBContentBox(
          padding: const .all(SBBSpacing.medium),
          child: Column(
            children: [
              SBBNotificationBox.alert(titleText: title, text: text, onTap: () {}),
              const SizedBox(height: SBBSpacing.medium),
              SBBNotificationBox.alert(text: text),
              const SizedBox(height: SBBSpacing.medium),
              SBBNotificationBox.alert(
                titleText: title,
                text: text,
                onTap: () {},
                isDismissible: false,
                trailingIconData: SBBIcons.arrows_circle_small,
              ),
              const SizedBox(height: SBBSpacing.medium),
              SBBNotificationBox.alert(
                text: text,
                onTap: () {},
                isDismissible: false,
                trailingIconData: SBBIcons.arrows_circle_small,
              ),
              const SizedBox(height: SBBSpacing.medium),
            ],
          ),
        ),
        const SBBListHeader('Warning'),
        SBBContentBox(
          padding: const .all(SBBSpacing.medium),
          child: Column(
            children: [
              SBBNotificationBox.warning(titleText: title, text: text, onTap: () {}),
              const SizedBox(height: SBBSpacing.medium),
              SBBNotificationBox.warning(text: text),
              const SizedBox(height: SBBSpacing.medium),
              SBBNotificationBox.warning(
                titleText: title,
                text: text,
                onTap: () {},
                isDismissible: false,
                trailingIconData: SBBIcons.arrows_circle_small,
              ),
              const SizedBox(height: SBBSpacing.medium),
              SBBNotificationBox.warning(
                text: text,
                onTap: () {},
                isDismissible: false,
                trailingIconData: SBBIcons.arrows_circle_small,
              ),
            ],
          ),
        ),
        const SBBListHeader('Success'),
        SBBContentBox(
          padding: const .all(SBBSpacing.medium),
          child: Column(
            children: [
              SBBNotificationBox.success(titleText: title, text: text, onTap: () {}),
              const SizedBox(height: SBBSpacing.medium),
              SBBNotificationBox.success(text: text),
              const SizedBox(height: SBBSpacing.medium),
              SBBNotificationBox.success(
                titleText: title,
                text: text,
                onTap: () {},
                isDismissible: false,
                trailingIconData: SBBIcons.arrows_circle_small,
              ),
              const SizedBox(height: SBBSpacing.medium),
              SBBNotificationBox.success(
                text: text,
                onTap: () {},
                isDismissible: false,
                trailingIconData: SBBIcons.arrows_circle_small,
              ),
            ],
          ),
        ),
        const SBBListHeader('Information'),
        SBBContentBox(
          padding: const .all(SBBSpacing.medium),
          child: Column(
            children: [
              SBBNotificationBox.information(titleText: title, onTap: () {}, text: text),
              const SizedBox(height: SBBSpacing.medium),
              SBBNotificationBox.information(text: text),
              const SizedBox(height: SBBSpacing.medium),
              SBBNotificationBox.information(
                titleText: title,
                text: text,
                onTap: () {},
                isDismissible: false,
                trailingIconData: SBBIcons.arrows_circle_small,
              ),
              const SizedBox(height: SBBSpacing.medium),
              SBBNotificationBox.information(
                text: text,
                onTap: () {},
                isDismissible: false,
                trailingIconData: SBBIcons.arrows_circle_small,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
