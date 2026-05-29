import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

const title = 'Title';
const text =
    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore '
    'magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, '
    'no sea takimata sanctus est Lorem ipsum dolor sit amet.';

void main() {
  testWidgets('alert notification box test', (WidgetTester tester) async {
    final widget = Column(
      spacing: SBBSpacing.medium,
      children: [
        SBBNotificationBox.alert(
          titleText: title,
          contentText: text,
          onTap: () {},
          isDismissable: true,
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
          isDismissable: true,
          trailingIconData: SBBIcons.chevron_small_right_small,
        ),
        SBBNotificationBox.alert(
          titleText: title,
          contentText: text,
          onTap: () {},
        ),
        SBBNotificationBox.alert(
          titleText: title,
          contentText: text,
          onTap: () {},
          showLeading: false,
        ),
        SBBNotificationBox.alert(
          title: Container(
            color: SBBColors.turquoise,
            child: Text('Custom'),
          ),
          content: Container(
            height: 125,
            color: SBBColors.turquoise,
            child: Center(child: Text('Content')),
          ),
          trailing: SBBTertiaryButtonSmall(iconData: SBBIcons.unicorn_small, onPressed: () {}),
          onTap: () {},
          isDismissable: true,
        ),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'notification_box_alert',
      find.byType(Column).first,
    );
  });

  testWidgets('alert notification box titleless test', (WidgetTester tester) async {
    final widget = Column(
      spacing: SBBSpacing.medium,
      children: [
        SBBNotificationBox.alert(contentText: text, isDismissable: true),
        SBBNotificationBox.alert(
          contentText: text,
          onTap: () {},
          trailingIconData: SBBIcons.chevron_small_right_small,
        ),
        SBBNotificationBox.alert(
          contentText: text,
          onTap: () {},
          isDismissable: true,
          trailingIconData: SBBIcons.chevron_small_right_small,
        ),
        SBBNotificationBox.alert(contentText: text, onTap: () {}),
        SBBNotificationBox.alert(
          contentText: text,
          onTap: () {},
          showLeading: false,
        ),
        SBBNotificationBox.alert(
          content: Container(
            height: 125,
            color: SBBColors.turquoise,
            child: Center(child: Text('Content')),
          ),
          onTap: () {},
          isDismissable: true,
          trailing: SBBTertiaryButtonSmall(iconData: SBBIcons.unicorn_small, onPressed: () {}),
        ),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'notification_box_alert_titleless',
      find.byType(Column).first,
    );
  });

  testWidgets('warning notification box test', (WidgetTester tester) async {
    final widget = Column(
      spacing: SBBSpacing.medium,
      children: [
        SBBNotificationBox.warning(
          titleText: title,
          contentText: text,
          onTap: () {},
          isDismissable: true,
        ),
        SBBNotificationBox.warning(
          titleText: title,
          contentText: text,
          onTap: () {},
          trailingIconData: SBBIcons.chevron_small_right_small,
        ),
        SBBNotificationBox.warning(
          titleText: title,
          contentText: text,
          onTap: () {},
          isDismissable: true,
          trailingIconData: SBBIcons.chevron_small_right_small,
        ),
        SBBNotificationBox.warning(
          titleText: title,
          contentText: text,
          onTap: () {},
        ),
        SBBNotificationBox.warning(
          titleText: title,
          contentText: text,
          onTap: () {},
          showLeading: false,
        ),
        SBBNotificationBox.warning(
          title: Container(
            color: SBBColors.turquoise,
            child: Text('Custom'),
          ),
          content: Container(
            height: 125,
            color: SBBColors.turquoise,
            child: Center(child: Text('Content')),
          ),
          trailing: SBBTertiaryButtonSmall(iconData: SBBIcons.unicorn_small, onPressed: () {}),
          onTap: () {},
          isDismissable: true,
        ),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'notification_box_warning',
      find.byType(Column).first,
    );
  });

  testWidgets('warning notification box titleless test', (WidgetTester tester) async {
    final widget = Column(
      spacing: SBBSpacing.medium,
      children: [
        SBBNotificationBox.warning(contentText: text, isDismissable: true),
        SBBNotificationBox.warning(
          contentText: text,
          onTap: () {},
          trailingIconData: SBBIcons.chevron_small_right_small,
        ),
        SBBNotificationBox.warning(
          contentText: text,
          onTap: () {},
          isDismissable: true,
          trailingIconData: SBBIcons.chevron_small_right_small,
        ),
        SBBNotificationBox.warning(contentText: text, onTap: () {}),
        SBBNotificationBox.warning(
          contentText: text,
          onTap: () {},
          showLeading: false,
        ),
        SBBNotificationBox.warning(
          content: Container(
            height: 125,
            color: SBBColors.turquoise,
            child: Center(child: Text('Content')),
          ),
          onTap: () {},
          isDismissable: true,
          trailing: SBBTertiaryButtonSmall(iconData: SBBIcons.unicorn_small, onPressed: () {}),
        ),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'notification_box_warning_titleless',
      find.byType(Column).first,
    );
  });

  testWidgets('information notification box test', (WidgetTester tester) async {
    final widget = Column(
      spacing: SBBSpacing.medium,
      children: [
        SBBNotificationBox.information(
          titleText: title,
          contentText: text,
          onTap: () {},
          isDismissable: true,
        ),
        SBBNotificationBox.information(
          titleText: title,
          contentText: text,
          onTap: () {},
          trailingIconData: SBBIcons.chevron_small_right_small,
        ),
        SBBNotificationBox.information(
          titleText: title,
          contentText: text,
          onTap: () {},
          isDismissable: true,
          trailingIconData: SBBIcons.chevron_small_right_small,
        ),
        SBBNotificationBox.information(
          titleText: title,
          contentText: text,
          onTap: () {},
        ),
        SBBNotificationBox.information(
          titleText: title,
          contentText: text,
          onTap: () {},
          showLeading: false,
        ),
        SBBNotificationBox.information(
          title: Container(
            color: SBBColors.turquoise,
            child: Text('Custom'),
          ),
          content: Container(
            height: 125,
            color: SBBColors.turquoise,
            child: Center(child: Text('Content')),
          ),
          trailing: SBBTertiaryButtonSmall(iconData: SBBIcons.unicorn_small, onPressed: () {}),
          onTap: () {},
          isDismissable: true,
        ),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'notification_box_information',
      find.byType(Column).first,
    );
  });

  testWidgets('information notification box titleless test', (WidgetTester tester) async {
    final widget = Column(
      spacing: SBBSpacing.medium,
      children: [
        SBBNotificationBox.information(contentText: text, isDismissable: true),
        SBBNotificationBox.information(
          contentText: text,
          onTap: () {},
          trailingIconData: SBBIcons.chevron_small_right_small,
        ),
        SBBNotificationBox.information(
          contentText: text,
          onTap: () {},
          isDismissable: true,
          trailingIconData: SBBIcons.chevron_small_right_small,
        ),
        SBBNotificationBox.information(contentText: text, onTap: () {}),
        SBBNotificationBox.information(
          contentText: text,
          onTap: () {},
          showLeading: false,
        ),
        SBBNotificationBox.information(
          content: Container(
            height: 125,
            color: SBBColors.turquoise,
            child: Center(child: Text('Content')),
          ),
          onTap: () {},
          isDismissable: true,
          trailing: SBBTertiaryButtonSmall(iconData: SBBIcons.unicorn_small, onPressed: () {}),
        ),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'notification_box_information_titleless',
      find.byType(Column).first,
    );
  });

  testWidgets('success notification box test', (WidgetTester tester) async {
    final widget = Column(
      spacing: SBBSpacing.medium,
      children: [
        SBBNotificationBox.success(
          titleText: title,
          contentText: text,
          onTap: () {},
          isDismissable: true,
        ),
        SBBNotificationBox.success(
          titleText: title,
          contentText: text,
          onTap: () {},
          trailingIconData: SBBIcons.chevron_small_right_small,
        ),
        SBBNotificationBox.success(
          titleText: title,
          contentText: text,
          onTap: () {},
          isDismissable: true,
          trailingIconData: SBBIcons.chevron_small_right_small,
        ),
        SBBNotificationBox.success(
          titleText: title,
          contentText: text,
          onTap: () {},
        ),
        SBBNotificationBox.success(
          titleText: title,
          contentText: text,
          onTap: () {},
          showLeading: false,
        ),
        SBBNotificationBox.success(
          title: Container(
            color: SBBColors.turquoise,
            child: Text('Custom'),
          ),
          content: Container(
            height: 125,
            color: SBBColors.turquoise,
            child: Center(child: Text('Content')),
          ),
          trailing: SBBTertiaryButtonSmall(iconData: SBBIcons.unicorn_small, onPressed: () {}),
          onTap: () {},
          isDismissable: true,
        ),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'notification_box_success',
      find.byType(Column).first,
    );
  });

  testWidgets('success notification box titleless test', (WidgetTester tester) async {
    final widget = Column(
      spacing: SBBSpacing.medium,
      children: [
        SBBNotificationBox.success(contentText: text, isDismissable: true),
        SBBNotificationBox.success(
          contentText: text,
          onTap: () {},
          trailingIconData: SBBIcons.chevron_small_right_small,
        ),
        SBBNotificationBox.success(
          contentText: text,
          onTap: () {},
          isDismissable: true,
          trailingIconData: SBBIcons.chevron_small_right_small,
        ),
        SBBNotificationBox.success(contentText: text, onTap: () {}),
        SBBNotificationBox.success(
          contentText: text,
          onTap: () {},
          showLeading: false,
        ),
        SBBNotificationBox.success(
          content: Container(
            height: 125,
            color: SBBColors.turquoise,
            child: Center(child: Text('Content')),
          ),
          onTap: () {},
          isDismissable: true,
          trailing: SBBTertiaryButtonSmall(iconData: SBBIcons.unicorn_small, onPressed: () {}),
        ),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'notification_box_success_titleless',
      find.byType(Column).first,
    );
  });
}
