import '../../../sbb_design_system_mobile.dart';

/// The default list header theme is specified using the
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=282-933)
class DefaultSBBListHeaderThemeData extends SBBListHeaderThemeData {
  DefaultSBBListHeaderThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBListHeaderStyle(
          foregroundColor: baseStyle.colorScheme.defaultTextColor,
          textStyle: baseStyle.themedTextStyle(textStyle: baseStyle.textTheme.smallLight),
          maxLines: null,
          textOverflow: .ellipsis,
          padding: const .symmetric(
            horizontal: SBBSpacing.medium,
            vertical: SBBSpacing.xSmall,
          ),
        ),
      );
}
