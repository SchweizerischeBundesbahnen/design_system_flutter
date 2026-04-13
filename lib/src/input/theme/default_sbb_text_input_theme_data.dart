import 'package:flutter/widgets.dart';

import '../../../sbb_design_system_mobile.dart';

/// The default text input theme is specified using the
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=309-2236)
class DefaultSBBTextInputThemeData extends SBBTextInputThemeData {
  DefaultSBBTextInputThemeData(SBBBaseStyle baseStyle)
    : super(
        inputTextStyle: baseStyle.textTheme.defaultTextStyle,
        inputForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.disabled: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
          WidgetState.error: baseStyle.themeValue(SBBColors.error, SBBColors.errorDark),
          WidgetState.any: baseStyle.colorScheme.defaultTextColor,
        }),
        enableClearButton: true,
      );
}
