import 'package:flutter/widgets.dart';

import '../../../sbb_design_system_mobile.dart';

/// The default list header theme is specified using the
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=282-933)
class DefaultSBBListHeaderThemeData extends SBBListHeaderThemeData {
  DefaultSBBListHeaderThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBListHeaderStyle(
          foregroundColor: baseStyle.themeValue(SBBColors.black, SBBColors.white),
          textStyle: baseStyle.themedTextStyle(textStyle: SBBTextStyles.smallLight),
          maxLines: null,
          textOverflow: TextOverflow.ellipsis,
          padding: const EdgeInsets.symmetric(
            horizontal: SBBSpacing.medium,
            vertical: SBBSpacing.xSmall,
          ),
        ),
      );
}
