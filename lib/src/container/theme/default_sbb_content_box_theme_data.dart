import 'package:flutter/material.dart';

import '../../../sbb_design_system_mobile.dart';
import '../container.dart';

/// The default [SBBContentBoxThemeData] for the SBB design system.
///
/// This class provides the standard styling for [SBBContentBox] widgets based on the current
/// [SBBBaseStyle].
class DefaultSBBContentBoxTheme extends SBBContentBoxThemeData {
  /// Creates a [DefaultSBBContentBoxTheme] with standard SBB styling.
  DefaultSBBContentBoxTheme({required SBBBaseStyle baseStyle})
    : super(
        style: SBBContentBoxStyle(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          color: baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
          clipBehavior: Clip.hardEdge,
          isSemanticContainer: true,
        ),
      );
}
