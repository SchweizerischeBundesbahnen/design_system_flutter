part of 'sbb_status.dart';

enum SBBStatusType {
  alert(
    SBBColors.red,
    SBBColors.white,
    SBBIcons.circle_cross_small,
  ),
  warning(
    SBBColors.peach,
    SBBColors.black,
    SBBIcons.circle_exclamation_point_small,
  ),
  success(
    SBBColors.green,
    SBBColors.white,
    SBBIcons.circle_tick_small,
  ),
  information(
    SBBColors.smoke,
    SBBColors.white,
    SBBIcons.circle_information_small,
  );

  const SBBStatusType(this.backgroundColor, this.iconColor, this.icon);

  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
}
