import 'package:flutter/services.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

const defaultForegroundColor = SBBColors.white;

class DefaultSBBHeaderThemeData extends SBBHeaderThemeData {
  DefaultSBBHeaderThemeData({required SBBBaseStyle baseStyle})
    : super(
        style: SBBHeaderStyle(
          backgroundColor: baseStyle.primaryColor,
          foregroundColor: SBBColors.white,
          titleTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.largeLight, color: SBBColors.white),
          centerTitle: true,
          toolbarTextStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight, color: SBBColors.white),
          clipBehavior: null,
          titleSpacing: null,
          actionsPadding: null,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      );
}
