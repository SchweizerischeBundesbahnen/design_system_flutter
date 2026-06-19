import 'package:flutter/services.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

const defaultForegroundColor = SBBColors.white;

class DefaultSBBHeaderThemeData extends SBBHeaderThemeData {
  DefaultSBBHeaderThemeData({required SBBBaseStyle baseStyle})
    : super(
        style: SBBHeaderStyle(
          backgroundColor: baseStyle.colorScheme.primary,
          foregroundColor: SBBColors.white,
          titleTextStyle: baseStyle.textTheme.largeLight,
          centerTitle: true,
          toolbarTextStyle: baseStyle.textTheme.smallLight,
          clipBehavior: null,
          titleSpacing: null,
          actionsPadding: null,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      );
}
