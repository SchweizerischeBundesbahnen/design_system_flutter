import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// The SBB Status.
///
/// A Widget to display important, non-dismissible information to the user.
///
/// Provide either [label] for custom content or [labelText] for text-only
/// content with standard styling. For a custom trailing widget, use [icon] instead of the
/// default [iconData]. These parameters are mutually exclusive.
///
/// Use the factory constructors to create specific status types:
/// * [SBBStatus.alert] for error or alert states
/// * [SBBStatus.warning] for warning states
/// * [SBBStatus.success] for success states
/// * [SBBStatus.information] for informational states
///
/// ## Sample code
///
/// ```dart
/// // Simple text status
/// SBBStatus.alert(labelText: 'Connection failed')
///
/// // Custom styled status with custom content
/// SBBStatus.success(
///   label: Row(
///     children: <Widget>[
///       Text('Upload complete'),
///       SizedBox(width: 4),
///       Icon(Icons.check),
///     ],
///   ),
///   style: SBBStatusStyle(
///     backgroundColor: Colors.green,
///   ),
/// )
/// ```
///
/// See also:
///
/// * [SBBStatusStyle], for customizing the appearance.
/// * [SBBStatusThemeData], for setting the style for all status indicators within the current Theme.
/// * [SBBNotificationBox] for a dismissible way to display information to the user.
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=321-7778)
sealed class SBBStatus extends StatelessWidget {
  const SBBStatus._({
    super.key,
    this.label,
    this.labelText,
    this.icon,
    this.iconData,
    this.style,
    this.semanticLabel,
  }) : assert(labelText == null || label == null, 'Cannot provide both labelText and label!'),
       assert(iconData == null || icon == null, 'Cannot provide both icon and iconData!');

  /// Creates an alert status indicator.
  ///
  /// The default icon is [SBBIcons.circle_cross_small].
  const factory SBBStatus.alert({
    Key? key,
    Widget? label,
    String? labelText,
    Widget? icon,
    IconData? iconData,
    SBBStatusStyle? style,
    String? semanticLabel,
  }) = _SBBStatusAlert;

  /// Creates a warning status indicator.
  ///
  /// The default icon is [SBBIcons.circle_exclamation_point_small].
  const factory SBBStatus.warning({
    Key? key,
    Widget? label,
    String? labelText,
    Widget? icon,
    IconData? iconData,
    SBBStatusStyle? style,
    String? semanticLabel,
  }) = _SBBStatusWarning;

  /// Creates a success status indicator.
  ///
  /// The default icon is [SBBIcons.circle_tick_small].
  const factory SBBStatus.success({
    Key? key,
    Widget? label,
    String? labelText,
    Widget? icon,
    IconData? iconData,
    SBBStatusStyle? style,
    String? semanticLabel,
  }) = _SBBStatusSuccess;

  /// Creates an information status indicator.
  ///
  /// The default icon is [SBBIcons.circle_information_small].
  const factory SBBStatus.information({
    Key? key,
    Widget? label,
    String? labelText,
    Widget? icon,
    IconData? iconData,
    SBBStatusStyle? style,
    String? semanticLabel,
  }) = _SBBStatusInformation;

  /// A custom widget displayed as the status label content.
  ///
  /// For simple text labels, use [labelText] instead.
  ///
  /// Cannot be used together with [labelText].
  final Widget? label;

  /// Text string to display as the status label using the standard design.
  ///
  /// The label will be styled according to the design specifications with a
  /// maximum of two lines and ellipsis overflow.
  ///
  /// Cannot be used together with [label].
  final String? labelText;

  /// A custom widget displayed as the status icon.
  ///
  /// For simple icon changes, use [iconData] instead.
  ///
  /// Cannot be used together with [iconData].
  final Widget? icon;

  /// Icon to display instead of the default icon for this status type.
  ///
  /// Cannot be used together with [icon].
  final IconData? iconData;

  /// Customizes this status appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in the theme and default styles.
  final SBBStatusStyle? style;

  /// Provides a textual description of the widget for assistive technologies.
  ///
  /// If this is non null, semantics of [label] or [labelText] are ignored.
  final String? semanticLabel;

  SBBStatusStyle? _getThemedStyle(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final SBBStatusStyle themedStyle = _getThemedStyle(context)!;
    final SBBStatusStyle effectiveStyle = themedStyle.merge(style);

    final Color resolvedForegroundColor = effectiveStyle.foregroundColor!;
    final Color resolvedBackgroundColor = effectiveStyle.backgroundColor!;
    final Color resolvedIconColor = effectiveStyle.iconColor ?? resolvedForegroundColor;
    final Color resolvedBorderColor = effectiveStyle.borderColor!;
    final double resolvedAlphaValue = effectiveStyle.alphaValue ?? _defaultAlphaValue;
    final TextStyle resolvedTextStyle = effectiveStyle.textStyle!;

    return DefaultTextStyle.merge(
      style: resolvedTextStyle.copyWith(color: resolvedForegroundColor),
      child: IconTheme.merge(
        data: IconThemeData(color: resolvedForegroundColor),
        child: Semantics(
          container: true,
          label: semanticLabel,
          excludeSemantics: semanticLabel != null,
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.all(SBBStatusStyle.borderRadius),
            child: DecoratedBox(
              decoration: ShapeDecoration(
                color: resolvedBackgroundColor.withValues(alpha: resolvedAlphaValue),
                shape: SBBStatusStyle.border.copyWith(side: BorderSide(color: resolvedBorderColor)),
              ),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _icon(resolvedBackgroundColor, resolvedIconColor),
                    if (label != null || labelText != null) _label(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _icon(Color backgroundColor, Color iconColor) {
    if (icon != null) {
      return Container(
        color: backgroundColor,
        child: icon!,
      );
    }

    return Container(
      padding: const EdgeInsets.all(4.0),
      color: backgroundColor,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(height: double.infinity),
        child: Icon(iconData, color: iconColor),
      ),
    );
  }

  Widget _label() {
    if (label != null) return label!;

    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Text(
          labelText!,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  double get _defaultAlphaValue => 0.05;
}

final class _SBBStatusAlert extends SBBStatus {
  const _SBBStatusAlert({
    super.key,
    super.label,
    super.labelText,
    super.icon,
    IconData? iconData,
    super.style,
    super.semanticLabel,
  }) : super._(iconData: icon == null && iconData == null ? SBBIcons.circle_cross_small : iconData);

  @override
  SBBStatusStyle? _getThemedStyle(BuildContext context) {
    return Theme.of(context).sbbStatusTheme?.alert;
  }
}

final class _SBBStatusWarning extends SBBStatus {
  const _SBBStatusWarning({
    super.key,
    super.label,
    super.labelText,
    super.icon,
    IconData? iconData,
    super.style,
    super.semanticLabel,
  }) : super._(iconData: icon == null && iconData == null ? SBBIcons.circle_exclamation_point_small : iconData);

  @override
  SBBStatusStyle? _getThemedStyle(BuildContext context) {
    return Theme.of(context).sbbStatusTheme?.warning;
  }
}

final class _SBBStatusSuccess extends SBBStatus {
  const _SBBStatusSuccess({
    super.key,
    super.label,
    super.labelText,
    super.icon,
    IconData? iconData,
    super.style,
    super.semanticLabel,
  }) : super._(iconData: icon == null && iconData == null ? SBBIcons.circle_tick_small : iconData);

  @override
  SBBStatusStyle? _getThemedStyle(BuildContext context) {
    return Theme.of(context).sbbStatusTheme?.success;
  }
}

final class _SBBStatusInformation extends SBBStatus {
  const _SBBStatusInformation({
    super.key,
    super.label,
    super.labelText,
    super.icon,
    IconData? iconData,
    super.style,
    super.semanticLabel,
  }) : super._(iconData: icon == null && iconData == null ? SBBIcons.circle_information_small : iconData);

  @override
  SBBStatusStyle? _getThemedStyle(BuildContext context) {
    return Theme.of(context).sbbStatusTheme?.information;
  }
}
