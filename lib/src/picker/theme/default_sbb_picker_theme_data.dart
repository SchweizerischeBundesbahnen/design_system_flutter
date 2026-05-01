import 'package:sbb_design_system_mobile_v5/sbb_design_system_mobile_v5.dart';

/// The default [SBBPickerThemeData] as specified in the design system.
class DefaultSBBPickerThemeData extends SBBPickerThemeData {
  DefaultSBBPickerThemeData({
    required SBBBaseStyle baseStyle,
    required SBBInputDecorationThemeData inputDecorationTheme,
    required SBBDecoratedTextStyle? decoratedTextStyle,
    required SBBBottomSheetStyle? bottomSheetStyle,
  }) : super(
         pickerStyle: SBBPickerStyle(
           highlightBackgroundColor: baseStyle.themeValue(SBBColors.cloud, SBBColors.iron),
           foregroundColor: baseStyle.colorScheme.textPrimary,
           disabledForegroundColor: SBBColors.white.withValues(alpha: 0.4),
           textStyle: SBBTextStyles.xLargeLight.copyWith(
             fontFamily: SBBFontFamily.sbbFontRoman,
             height: 26.0 / SBBTextStyles.xLargeFontSize,
           ),
         ),
         triggerDecorationTheme: inputDecorationTheme,
         triggerStyle: decoratedTextStyle,
         sheetStyle: bottomSheetStyle,
       );
}
