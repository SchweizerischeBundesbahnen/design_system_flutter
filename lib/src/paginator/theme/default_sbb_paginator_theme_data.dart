import 'package:flutter/widgets.dart';

import '../../../sbb_design_system_mobile.dart';

/// The default paginator theme is specified using the current implementation values.
class DefaultSBBPaginatorThemeData extends SBBPaginatorThemeData {
  DefaultSBBPaginatorThemeData(SBBBaseStyle baseStyle)
    : super(
        style: SBBPaginatorStyle(
          circleBorderColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.selected: baseStyle.themeValue(baseStyle.primaryColor, SBBColors.white),
            WidgetState.any: baseStyle.themeValue(SBBColors.granite, SBBColors.graphite),
          }),
          circleFillColor: WidgetStateProperty.fromMap(<WidgetStatesConstraint, Color?>{
            WidgetState.selected: baseStyle.themeValue(baseStyle.primaryColor, SBBColors.white),
            WidgetState.any: null,
          }),
          floatingBackgroundColor: baseStyle.themeValue(SBBColors.white, SBBColors.iron),
          floatingBoxShadow: [
            BoxShadow(
              color: SBBColors.black.withValues(alpha: 0.2),
              blurRadius: 8.0,
            ),
          ],
        ),
      );
}
