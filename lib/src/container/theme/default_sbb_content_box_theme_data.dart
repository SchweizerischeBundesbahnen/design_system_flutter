import '../../../sbb_design_system_mobile.dart';
import '../container.dart';

/// The default [SBBContentBoxThemeData] for the SBB design system.
///
/// This class provides the standard styling for [SBBContentBox] widgets based on the current
/// [SBBBaseStyle].
class DefaultSBBContentBoxThemeData extends SBBContentBoxThemeData {
  /// Creates a [DefaultSBBContentBoxThemeData] with standard SBB styling.
  DefaultSBBContentBoxThemeData({required SBBBaseStyle baseStyle})
    : super(
        style: SBBContentBoxStyle(
          margin: .zero,
          padding: .zero,
          color: baseStyle.themeValue(SBBColors.white, SBBColors.charcoal),
          clipBehavior: .hardEdge,
          isSemanticContainer: true,
        ),
      );
}
