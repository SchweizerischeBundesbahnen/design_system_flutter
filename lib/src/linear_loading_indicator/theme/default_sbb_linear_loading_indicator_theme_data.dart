import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The default linear loading indicator theme specified using design system values.
class DefaultSBBLinearLoadingIndicatorThemeData extends SBBLinearLoadingIndicatorThemeData {
  DefaultSBBLinearLoadingIndicatorThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBLinearLoadingIndicatorStyle(
          color: baseStyle.colorScheme.primary,
        ),
      );
}
