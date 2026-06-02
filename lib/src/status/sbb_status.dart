import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/shared/debug.dart';
import 'package:sbb_design_system_mobile/src/shared/utils.dart';

/// The SBB Status.
///
/// A Widget to display important, non-dismissible information to the user.
///
/// Provide either [label] for custom content or [labelText] for text-only
/// content with standard styling. For a custom leading widget, use [icon] instead of the
/// default [iconData]. These parameters are mutually exclusive.
///
/// Use [state] to specify the status type, or use the factory constructors:
/// * [SBBStatus.alert] for error or alert states
/// * [SBBStatus.warning] for warning states
/// * [SBBStatus.success] for success states
/// * [SBBStatus.information] for informational states
///
/// ## Sample code
///
/// ```dart
/// // Simple text status
/// SBBStatus(state: SBBStatusState.alert, labelText: 'Connection failed')
///
/// // Using factory constructor
/// SBBStatus.alert(labelText: 'Connection failed')
///
/// // Custom styled status with custom content
/// SBBStatus.success(
///   label: Row(
///     children: [
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
/// * [SBBStatusState], defines the visual state of the status.
/// * [SBBNotificationBox] for a dismissible way to display information to the user.
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=321-7778)
class SBBStatus extends StatelessWidget {
  const SBBStatus({
    super.key,
    required this.state,
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
  factory SBBStatus.alert({
    Key? key,
    Widget? label,
    String? labelText,
    Widget? icon,
    IconData? iconData,
    SBBStatusStyle? style,
    String? semanticLabel,
  }) => SBBStatus(
    key: key,
    state: SBBStatusState.alert,
    label: label,
    labelText: labelText,
    icon: icon,
    iconData: iconData,
    style: style,
    semanticLabel: semanticLabel,
  );

  /// Creates a warning status indicator.
  ///
  /// The default icon is [SBBIcons.circle_exclamation_point_small].
  factory SBBStatus.warning({
    Key? key,
    Widget? label,
    String? labelText,
    Widget? icon,
    IconData? iconData,
    SBBStatusStyle? style,
    String? semanticLabel,
  }) => SBBStatus(
    key: key,
    state: SBBStatusState.warning,
    label: label,
    labelText: labelText,
    icon: icon,
    iconData: iconData,
    style: style,
    semanticLabel: semanticLabel,
  );

  /// Creates a success status indicator.
  ///
  /// The default icon is [SBBIcons.circle_tick_small].
  factory SBBStatus.success({
    Key? key,
    Widget? label,
    String? labelText,
    Widget? icon,
    IconData? iconData,
    SBBStatusStyle? style,
    String? semanticLabel,
  }) => SBBStatus(
    key: key,
    state: SBBStatusState.success,
    label: label,
    labelText: labelText,
    icon: icon,
    iconData: iconData,
    style: style,
    semanticLabel: semanticLabel,
  );

  /// Creates an information status indicator.
  ///
  /// The default icon is [SBBIcons.circle_information_small].
  factory SBBStatus.information({
    Key? key,
    Widget? label,
    String? labelText,
    Widget? icon,
    IconData? iconData,
    SBBStatusStyle? style,
    String? semanticLabel,
  }) => SBBStatus(
    key: key,
    state: SBBStatusState.information,
    label: label,
    labelText: labelText,
    icon: icon,
    iconData: iconData,
    style: style,
    semanticLabel: semanticLabel,
  );

  /// The state/type of this status indicator.
  final SBBStatusState state;

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
  /// If this and [iconData] is null, [SBBStatusStyle.iconData] is used.
  /// For simple icon changes, use [iconData] instead.
  ///
  /// Cannot be used together with [iconData].
  final Widget? icon;

  /// Icon to display instead of the default icon for this status type.
  ///
  /// If this and [icon] is null, [SBBStatusStyle.iconData] is used.
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

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasSBBBaseStyle(context));

    final themedStyle = _getThemedStyle(context);
    final effectiveStyle = themedStyle.merge(style);

    final resolvedForegroundColor = effectiveStyle.foregroundColor!;
    final resolvedBackgroundColor = effectiveStyle.backgroundColor!;
    final resolvedIconColor = effectiveStyle.iconColor ?? resolvedForegroundColor;
    final resolvedBorderColor = effectiveStyle.borderColor!;
    final resolvedAlphaValue = effectiveStyle.alphaValue!;
    final resolvedTextStyle = effectiveStyle.textStyle!;

    final resolvedIcon = addDefaultAncestorWithResolved(
      foregroundColor: resolvedIconColor,
      child: _resolveIcon(effectiveStyle),
    )!;

    final resolvedLabel = addDefaultAncestorWithResolved(
      foregroundColor: resolvedForegroundColor,
      child: _resolveLabel(),
    );

    return addDefaultAncestorWithResolved(
      textStyle: resolvedTextStyle,
      foregroundColor: resolvedForegroundColor,
      child: Semantics(
        container: true,
        label: semanticLabel,
        excludeSemantics: semanticLabel != null,
        child: ClipRRect(
          clipBehavior: .hardEdge,
          borderRadius: BorderRadius.all(SBBStatusStyle.borderRadius),
          child: DecoratedBox(
            decoration: ShapeDecoration(
              color: resolvedBackgroundColor.withValues(alpha: resolvedAlphaValue),
              shape: SBBStatusStyle.border.copyWith(side: BorderSide(color: resolvedBorderColor)),
            ),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: .min,
                children: [
                  resolvedIcon,
                  ?resolvedLabel,
                ],
              ),
            ),
          ),
        ),
      ),
    )!;
  }

  Widget _resolveIcon(SBBStatusStyle effectiveStyle) {
    if (icon != null) {
      return Container(
        color: effectiveStyle.backgroundColor,
        child: icon!,
      );
    }

    return Container(
      padding: const .all(4.0),
      color: effectiveStyle.backgroundColor,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(height: .infinity),
        child: Icon(iconData ?? effectiveStyle.iconData),
      ),
    );
  }

  Widget? _resolveLabel() {
    if (label != null) return label!;

    if (labelText != null) {
      return Flexible(
        child: Container(
          padding: const .symmetric(vertical: SBBSpacing.xxSmall, horizontal: SBBSpacing.xSmall),
          child: Text(
            labelText!,
            maxLines: 2,
            overflow: .ellipsis,
          ),
        ),
      );
    }

    return null;
  }

  SBBStatusStyle _getThemedStyle(BuildContext context) {
    final theme = Theme.of(context).sbbStatusTheme;
    return switch (state) {
      .alert => theme.alert!,
      .warning => theme.warning!,
      .success => theme.success!,
      .information => theme.information!,
    };
  }
}
