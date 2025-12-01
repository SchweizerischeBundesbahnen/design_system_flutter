import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

part 'sbb_status.type.dart';

/// The SBB Status.
///
/// A Widget that displays a status indicator with an icon and optional text to
/// display important information.
///
/// Use the factory constructors to create specific status types:
/// * [SBBStatus.alert] for error or alert states
/// * [SBBStatus.warning] for warning states
/// * [SBBStatus.success] for success states
/// * [SBBStatus.information] for informational states
///
/// See also:
/// * [SBBStatusStyle] used to style this Widget.
/// * [SBBStatusThemeData] used to style this Widget across the entire theme.
/// * [Figma](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=321-7778)
sealed class SBBStatus extends StatelessWidget {
  const SBBStatus._({super.key, this.text, this.style});

  /// Creates an alert status indicator.
  ///
  /// Alert statuses are typically used to indicate errors or critical issues.
  const factory SBBStatus.alert({Key? key, String? text, SBBStatusStyle? style}) = _SBBStatusAlert;

  /// Creates a warning status indicator.
  ///
  /// Warning statuses are typically used to indicate potential issues or cautions.
  const factory SBBStatus.warning({Key? key, String? text, SBBStatusStyle? style}) = _SBBStatusWarning;

  /// Creates a success status indicator.
  ///
  /// Success statuses are typically used to indicate successful operations.
  const factory SBBStatus.success({Key? key, String? text, SBBStatusStyle? style}) = _SBBStatusSuccess;

  /// Creates an information status indicator.
  ///
  /// Information statuses are typically used to display general information.
  const factory SBBStatus.information({Key? key, String? text, SBBStatusStyle? style}) = _SBBStatusInformation;

  /// The text to display next to the status icon.
  ///
  /// If null, only the icon is displayed.
  final String? text;

  /// Optional style override for this specific status instance.
  ///
  /// If null, the style is resolved from [SBBStatusThemeData] or defaults.
  final SBBStatusStyle? style;

  /// Returns the themed style for this status type.
  ///
  /// This method is overridden by each subtype to return the appropriate
  /// style from the theme data.
  SBBStatusStyle? _getThemedStyle(BuildContext context);

  /// Returns the icon for this status type.
  IconData _getIcon();

  @override
  Widget build(BuildContext context) {
    final SBBStatusStyle themedStyle = _getThemedStyle(context)!;

    final SBBStatusStyle effectiveStyle = themedStyle.merge(style);

    final Color resolvedForegroundColor = effectiveStyle.foregroundColor!;
    final Color resolvedBackgroundColor = effectiveStyle.backgroundColor!;
    final Color resolvedIconColor = effectiveStyle.iconColor ?? resolvedForegroundColor;
    final Color? resolvedBorderColor = effectiveStyle.borderColor;
    final double resolvedAlphaValue = effectiveStyle.alphaValue ?? _defaultAlphaValue;
    final TextStyle? resolvedTextStyle = effectiveStyle.textStyle;

    return DefaultTextStyle.merge(
      style: resolvedTextStyle?.copyWith(color: resolvedForegroundColor),
      child: IconTheme.merge(
        data: IconThemeData(color: resolvedForegroundColor),
        child: Semantics(
          container: true,
          child: IntrinsicHeight(
            child: DecoratedBox(
              decoration: ShapeDecoration(
                shape: SBBStatusStyle.border.copyWith(
                  side: resolvedBorderColor != null ? BorderSide(color: resolvedBorderColor) : BorderSide.none,
                ),
                color: resolvedBackgroundColor.withValues(alpha: resolvedAlphaValue),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: ShapeDecoration(
                      color: resolvedBackgroundColor,
                      shape: SBBStatusStyle.border.copyWith(
                        borderRadius: text != null
                            ? BorderRadius.only(
                                topLeft: SBBStatusStyle.borderRadius,
                                bottomLeft: SBBStatusStyle.borderRadius,
                              )
                            : null,
                      ),
                    ),
                    child: Icon(_getIcon(), color: resolvedIconColor),
                  ),
                  if (text != null)
                    Flexible(
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: SBBStatusStyle.border.copyWith(
                            side: resolvedBorderColor != null
                                ? BorderSide(color: resolvedBorderColor)
                                : BorderSide.none,
                            borderRadius: BorderRadius.only(
                              topRight: SBBStatusStyle.borderRadius,
                              bottomRight: SBBStatusStyle.borderRadius,
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        child: Text(text!, maxLines: 2, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double get _defaultAlphaValue => 0.05;
}

final class _SBBStatusAlert extends SBBStatus {
  const _SBBStatusAlert({super.key, super.text, super.style}) : super._();

  @override
  SBBStatusStyle? _getThemedStyle(BuildContext context) {
    return Theme.of(context).sbbStatusTheme?.alert;
  }

  @override
  IconData _getIcon() => SBBIcons.circle_cross_small;
}

final class _SBBStatusWarning extends SBBStatus {
  const _SBBStatusWarning({super.key, super.text, super.style}) : super._();

  @override
  SBBStatusStyle? _getThemedStyle(BuildContext context) {
    return Theme.of(context).sbbStatusTheme?.warning;
  }

  @override
  IconData _getIcon() => SBBIcons.circle_exclamation_point_small;
}

final class _SBBStatusSuccess extends SBBStatus {
  const _SBBStatusSuccess({super.key, super.text, super.style}) : super._();

  @override
  SBBStatusStyle? _getThemedStyle(BuildContext context) {
    return Theme.of(context).sbbStatusTheme?.success;
  }

  @override
  IconData _getIcon() => SBBIcons.circle_tick_small;
}

final class _SBBStatusInformation extends SBBStatus {
  const _SBBStatusInformation({super.key, super.text, super.style}) : super._();

  @override
  SBBStatusStyle? _getThemedStyle(BuildContext context) {
    return Theme.of(context).sbbStatusTheme?.information;
  }

  @override
  IconData _getIcon() => SBBIcons.circle_information_small;
}
