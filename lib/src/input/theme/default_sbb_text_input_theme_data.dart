import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile_v5/sbb_design_system_mobile_v5.dart';

/// The default text input theme is specified using the
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=309-2236)
class DefaultSBBTextInputThemeData extends SBBTextInputThemeData {
  DefaultSBBTextInputThemeData(SBBBaseStyle baseStyle)
    : super(
        inputTextStyle: baseStyle.textTheme.defaultTextStyle,
        inputForegroundColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
          WidgetState.disabled: baseStyle.colorScheme.textSecondary,
          WidgetState.error: baseStyle.colorScheme.error,
          WidgetState.any: baseStyle.colorScheme.textPrimary,
        }),
        enableClearButton: true,
      );
}
