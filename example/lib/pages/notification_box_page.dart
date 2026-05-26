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
                  contentText: text,
                  onTap: () {},
                  onDismissed: () {},
                ),
                SBBNotificationBox.alert(
                  titleText: title,
                  contentText: text,
                  onTap: () {},
                  trailingIconData: SBBIcons.chevron_small_right_small,
                ),
                SBBNotificationBox.alert(
                  titleText: title,
                  contentText: text,
                  onTap: () {},
                  onDismissed: () {},
                  trailingIconData: SBBIcons.chevron_small_right_small,
                ),
                SBBNotificationBox.alert(
                  titleText: title,
                  contentText: text,
                  onTap: () {},
                ),
                SBBNotificationBox.alert(contentText: text, onDismissed: () {}),
                SBBNotificationBox.alert(
                  contentText: text,
                  onTap: () {},
                  trailingIconData: SBBIcons.chevron_small_right_small,
                ),
                SBBNotificationBox.alert(
                  contentText: text,
                  onTap: () {},
                  onDismissed: () {},
                  trailingIconData: SBBIcons.chevron_small_right_small,
                ),
                SBBNotificationBox.alert(contentText: text, onTap: () {}),
                SBBNotificationBox.alert(
                  title: Container(
                    color: SBBColors.turquoise,
                    child: Text('Custom'),
                  ),
                  content: Container(
                    height: 100,
                    color: SBBColors.turquoise,
                    child: Center(child: Text('Content')),
                  ),
                  trailing: SBBTertiaryButtonSmall(iconData: SBBIcons.unicorn_small, onPressed: () {}),
                  onTap: () {},
                  onDismissed: () {},
                ),
                SBBNotificationBox.alert(
                  content: Container(
                    height: 100,
                    color: SBBColors.turquoise,
                    child: Center(child: Text('Content')),
                  ),
                  onTap: () {},
                  onDismissed: () {},
                  trailing: SBBTertiaryButtonSmall(iconData: SBBIcons.unicorn_small, onPressed: () {}),
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
                SBBNotificationBox.warning(titleText: title, contentText: text, onTap: () {}, onDismissed: () {}),
                SBBNotificationBox.warning(contentText: text, onDismissed: () {}),
                SBBNotificationBox.warning(
                  titleText: title,
                  contentText: text,
                  onTap: () {},
                  trailingIconData: SBBIcons.chevron_small_right_small,
                ),
                SBBNotificationBox.warning(
                  contentText: text,
                  onTap: () {},
                  trailingIconData: SBBIcons.chevron_small_right_small,
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
                SBBNotificationBox.success(titleText: title, contentText: text, onTap: () {}, onDismissed: () {}),
                SBBNotificationBox.success(contentText: text, onDismissed: () {}),
                SBBNotificationBox.success(
                  titleText: title,
                  contentText: text,
                  onTap: () {},
                  trailingIconData: SBBIcons.chevron_small_right_small,
                ),
                SBBNotificationBox.success(
                  contentText: text,
                  onTap: () {},
                  trailingIconData: SBBIcons.chevron_small_right_small,
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
                SBBNotificationBox.information(titleText: title, onTap: () {}, contentText: text, onDismissed: () {}),
                SBBNotificationBox.information(contentText: text, onDismissed: () {}),
                SBBNotificationBox.information(
                  titleText: title,
                  contentText: text,
                  onTap: () {},
                  trailingIconData: SBBIcons.chevron_small_right_small,
                ),
                SBBNotificationBox.information(
                  contentText: text,
                  onTap: () {},
                  trailingIconData: SBBIcons.chevron_small_right_small,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
