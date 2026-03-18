import '../../../sbb_design_system_mobile.dart';

extension MergeBaseStyleExtension on SBBBaseStyle? {
  SBBBaseStyle merge(SBBBaseStyle? other) {
    if (this == null) return other ?? SBBBaseStyle();
    return this!.copyWith(
          primaryColor: this!.primaryColor ?? other?.primaryColor,
          primaryColorDark: this!.primaryColorDark ?? other?.primaryColorDark,
          primarySwatch: this!.primarySwatch ?? other?.primarySwatch,
          backgroundColor: this!.backgroundColor ?? other?.backgroundColor,
          errorColor: this!.errorColor ?? other?.errorColor,
          fontFamily: this!.defaultFontFamily ?? other?.defaultFontFamily,
          defaultTextColor: this!.defaultTextColor ?? other?.defaultTextColor,
          defaultTextStyle: this!.defaultTextStyle ?? other?.defaultTextStyle,
          dividerColor: this!.dividerColor ?? other?.dividerColor,
          iconColor: this!.iconColor ?? other?.iconColor,
          brightness: this!.brightness ?? other?.brightness,
          redTextTheme: this?.redTextTheme ?? other?.redTextTheme,
        )
        as SBBBaseStyle;
  }
}
