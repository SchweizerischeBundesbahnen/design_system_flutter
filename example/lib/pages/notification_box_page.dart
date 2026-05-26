import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

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
    return DemoPageScaffold(
      body: Column(
        children: [
          const SBBListHeader('Alert'),
          SBBContentBox(
            padding: const .all(SBBSpacing.medium),
            child: Column(
              spacing: SBBSpacing.medium,
              children: [
                SBBNotificationBox.alert(
                  titleText: title,
                  text: text,
                  onTap: () {},
                  onDismissed: () {},
                ),
                SBBNotificationBox.alert(text: text, onDismissed: () {}),
                SBBNotificationBox.alert(
                  titleText: title,
                  text: text,
                  onTap: () {},
                  trailingIconData: SBBIcons.arrows_circle_small,
                ),
                SBBNotificationBox.alert(
                  text: text,
                  onTap: () {},
                  trailingIconData: SBBIcons.arrows_circle_small,
                ),
              ],
            ),
          ),
          const SBBListHeader('Warning'),
          SBBContentBox(
            padding: const .all(SBBSpacing.medium),
            child: Column(
              spacing: SBBSpacing.medium,
              children: [
                SBBNotificationBox.warning(titleText: title, text: text, onTap: () {}, onDismissed: () {}),
                SBBNotificationBox.warning(text: text, onDismissed: () {}),
                SBBNotificationBox.warning(
                  titleText: title,
                  text: text,
                  onTap: () {},
                  trailingIconData: SBBIcons.arrows_circle_small,
                ),
                SBBNotificationBox.warning(
                  text: text,
                  onTap: () {},
                  trailingIconData: SBBIcons.arrows_circle_small,
                ),
              ],
            ),
          ),
          const SBBListHeader('Success'),
          SBBContentBox(
            padding: const .all(SBBSpacing.medium),
            child: Column(
              spacing: SBBSpacing.medium,
              children: [
                SBBNotificationBox.success(titleText: title, text: text, onTap: () {}, onDismissed: () {}),
                SBBNotificationBox.success(text: text, onDismissed: () {}),
                SBBNotificationBox.success(
                  titleText: title,
                  text: text,
                  onTap: () {},
                  trailingIconData: SBBIcons.arrows_circle_small,
                ),
                SBBNotificationBox.success(
                  text: text,
                  onTap: () {},
                  trailingIconData: SBBIcons.arrows_circle_small,
                ),
              ],
            ),
          ),
          const SBBListHeader('Information'),
          SBBContentBox(
            padding: const .all(SBBSpacing.medium),
            child: Column(
              spacing: SBBSpacing.medium,
              children: [
                SBBNotificationBox.information(titleText: title, onTap: () {}, text: text, onDismissed: () {}),
                SBBNotificationBox.information(text: text, onDismissed: () {}),
                SBBNotificationBox.information(
                  titleText: title,
                  text: text,
                  onTap: () {},
                  trailingIconData: SBBIcons.arrows_circle_small,
                ),
                SBBNotificationBox.information(
                  text: text,
                  onTap: () {},
                  trailingIconData: SBBIcons.arrows_circle_small,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
