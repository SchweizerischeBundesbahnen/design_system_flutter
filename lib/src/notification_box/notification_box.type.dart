part of 'notification_box.dart';

enum SBBNotificationBoxType {
  alert(
    SBBColors.red,
    SBBColors.red,
    SBBColors.red,
    SBBIcons.circle_cross_small,
  ),
  warning(
    SBBColors.peach,
    SBBColors.black,
    SBBColors.peach,
    SBBIcons.circle_exclamation_point_small,
  ),
  success(
    SBBColors.green,
    SBBColors.green,
    SBBColors.green,
    SBBIcons.circle_tick_small,
  ),
  information(
    SBBColors.smoke,
    SBBColors.black,
    SBBColors.white,
    SBBIcons.circle_information_small,
  );

  const SBBNotificationBoxType(
    this.backgroundColor,
    this.iconColor,
    this.iconColorDark,
    this.icon,
  );

  final Color backgroundColor;
  final Color iconColor;
  final Color iconColorDark;
  final IconData icon;
}
