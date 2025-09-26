part of 'sbb_status.dart';

enum SBBStatusType {
  alert(SBBColors.error, SBBColors.errorDark, SBBColors.white, SBBColors.white, SBBIcons.circle_cross_small),
  warning(
    SBBColors.warning,
    SBBColors.warningDark,
    SBBColors.black,
    SBBColors.white,
    SBBIcons.circle_exclamation_point_small,
  ),
  success(SBBColors.success, SBBColors.successDark, SBBColors.white, SBBColors.white, SBBIcons.circle_tick_small),
  information(
    SBBColors.smoke,
    SBBColors.anthracite,
    SBBColors.white,
    SBBColors.white,
    SBBIcons.circle_information_small,
  );

  const SBBStatusType(this.backgroundColor, this.backgroundColorDark, this.iconColor, this.iconColorDark, this.icon);

  final Color backgroundColor;
  final Color backgroundColorDark;
  final Color iconColor;
  final Color iconColorDark;
  final IconData icon;
}
