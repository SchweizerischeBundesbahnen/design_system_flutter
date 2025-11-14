import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/button/default_button_label.dart';

import '../../sbb_design_system_mobile.dart';
import '../sbb_internal.dart';

/// The tertiary variant of the SBB Button.
///
/// Use [label] for custom content or [labelText] for the standard design.
/// Only one of them can be set.
///
/// To display a leading icon within the button, either use [iconData] for the standard designed icon or
/// [icon] for completely customizing the leading Widget. Only one of them can be set.
///
/// If [isLoading] is true and [labelText] is null, the [SBBLoadingIndicator] will be displayed
/// as leading Widget within the button. The [onPressed] callback will be ignored and the [iconData] will not be displayed.
///
/// Either [isLoading] must be true, or one of [labelText] or [labelText] must not be null.
///
/// If [onPressed] callback is null, the button will be disabled.
///
/// For specifications see [Figma](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=7-12)
///
/// See also
/// * [SBBTertiaryButtonSmall] for a small sized variant of this Widget with reduced height.
class SBBTertiaryButton extends StatelessWidget {
  const SBBTertiaryButton({
    super.key,
    this.label,
    this.labelText,
    this.icon,
    this.iconData,
    this.isLoading = false,
    required this.onPressed,
    this.focusNode,
  }) : assert(!(labelText != null && label != null), 'Cannot provide both labelText and label!'),
       assert(!(iconData != null && icon != null), 'Cannot provide both iconData and icon!'),
       assert(
         !(labelText == null && label == null && !isLoading && icon == null && iconData == null),
         'One of labelText, label, icon, iconData must be set or isLoading must be true!',
       );

  /// Custom widget to display as the button's label.
  ///
  /// Only one of [label] or [labelText] can be set.
  final Widget? label;

  /// Text string to display as the button's label using the standard design.
  ///
  /// Only one of [label] or [labelText] can be set.
  final String? labelText;

  /// Leading widget displayed within the button.
  ///
  /// Only one of [icon] or [iconData] can be set.
  final Widget? icon;

  /// Leading standard designed icon displayed within the button.
  ///
  /// Only one of [icon] or [iconData] can be set.
  final IconData? iconData;

  /// Whether the button is in a loading state.
  ///
  /// When true, displays a [SBBLoadingIndicator] as the leading widget and ignores the [onPressed] callback.
  /// Defaults to false.
  final bool isLoading;

  /// Callback function that is called when the button is pressed.
  ///
  /// If null, the button will be disabled. If [isLoading] is true, this callback is ignored.
  final VoidCallback? onPressed;

  /// An optional focus node to control the button's focus state.
  ///
  /// If not provided, a focus node will be created automatically.
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return _BaseTertiaryButton(
      label: label,
      labelText: labelText,
      icon: icon,
      iconData: iconData,
      isLoading: isLoading,
      onPressed: onPressed,
      focusNode: focusNode,
    );
  }
}

/// The **small** tertiary variant of the SBB Button.
///
/// Use [label] for custom content or [labelText] for the standard design.
/// Only one of them can be set.
///
/// To display a leading icon within the button, either use [iconData] for the standard designed icon or
/// [icon] for completely customizing the leading Widget. Only one of them can be set.
/// The icon and label are spaced by 4px;
///
/// If [isLoading] is true and [labelText] is null, the [SBBLoadingIndicator] will be displayed
/// as leading Widget within the button. The [onPressed] callback will be ignored and the [iconData] will not be displayed.
///
/// Either [isLoading] must be true, or one of [labelText] or [labelText] must not be null.
///
/// If [onPressed] callback is null, the button will be disabled.
///
/// For specifications see [Figma](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=7-12)
///
/// See also
/// * [SBBTertiaryButton] for a standard sized variant of this Widget.
class SBBTertiaryButtonSmall extends StatelessWidget {
  const SBBTertiaryButtonSmall({
    super.key,
    this.label,
    this.labelText,
    this.icon,
    this.iconData,
    this.isLoading = false,
    required this.onPressed,
    this.focusNode,
  }) : assert(!(labelText != null && label != null), 'Cannot provide both labelText and label!'),
       assert(!(iconData != null && icon != null), 'Cannot provide both iconData and icon!'),
       assert(
         !(labelText == null && label == null && !isLoading && icon == null && iconData == null),
         'One of labelText, label, icon, iconData must be set or isLoading must be true!',
       );

  /// Custom widget to display as the button's label.
  ///
  /// Only one of [label] or [labelText] can be set.
  final Widget? label;

  /// Text string to display as the button's label using the standard design.
  ///
  /// Only one of [label] or [labelText] can be set.
  final String? labelText;

  /// Leading widget displayed within the button.
  ///
  /// Only one of [icon] or [iconData] can be set.
  final Widget? icon;

  /// Leading standard designed icon displayed within the button.
  ///
  /// Only one of [icon] or [iconData] can be set.
  final IconData? iconData;

  /// Whether the button is in a loading state.
  ///
  /// When true, displays a [SBBLoadingIndicator] as the leading widget and ignores the [onPressed] callback.
  /// Defaults to false.
  final bool isLoading;

  /// Callback function that is called when the button is pressed.
  ///
  /// If null, the button will be disabled. If [isLoading] is true, this callback is ignored.
  final VoidCallback? onPressed;

  /// An optional focus node to control the button's focus state.
  ///
  /// If not provided, a focus node will be created automatically.
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return _BaseTertiaryButton(
      style: _reducedHeightStyle(context),
      label: label,
      labelText: labelText,
      icon: icon,
      iconData: iconData,
      isLoading: isLoading,
      onPressed: onPressed,
      focusNode: focusNode,
    );
  }

  ButtonStyle? _reducedHeightStyle(BuildContext context) {
    final buttonStyle = SBBButtonStyles.of(context);

    return buttonStyle.tertiarySmallStyle?.overrideButtonStyle(
      Theme.of(context).textButtonTheme.style?.copyWith(
        fixedSize: SBBTheme.allStates(const Size.fromHeight(SBBInternal.defaultButtonHeightSmall)),
        minimumSize: SBBTheme.allStates(const Size(0, SBBInternal.defaultButtonHeightSmall)),
      ),
    );
  }
}

/// Base class for building both the small and the normal variant of SBBTertiaryButton.
class _BaseTertiaryButton extends StatelessWidget {
  const _BaseTertiaryButton({
    this.style,
    this.label,
    this.labelText,
    this.icon,
    this.iconData,
    this.isLoading = false,
    required this.onPressed,
    this.focusNode,
  });

  final ButtonStyle? style;

  final Widget? label;
  final String? labelText;
  final Widget? icon;
  final IconData? iconData;
  final bool isLoading;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final leading = _resolvedLeading();
    final label = _resolvedLabel();
    final loading = _resolvedLoading(context);

    Widget? child;
    if (leading != null && label != null) {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 4.0,
        children: [leading, label],
      );
    } else if (leading != null) {
      child = leading;
    } else if (label != null) {
      child = label;
    }

    if (loading != null) {
      child = loading;
    }

    return TextButton(
      style: style,
      onPressed: isLoading ? null : onPressed,
      focusNode: focusNode,
      child: child!,
    );
  }

  Widget? _resolvedLeading() {
    if (icon == null && iconData == null) return null;
    return icon ?? Icon(iconData, size: sbbIconSizeSmall);
  }

  Widget? _resolvedLabel() {
    if (label == null && labelText == null) return null;
    return label ?? DefaultButtonLabel(label: labelText!);
  }

  Widget? _resolvedLoading(BuildContext context) {
    if (!isLoading) return null;
    final sbbBaseStyle = SBBBaseStyle.of(context);
    return sbbBaseStyle.themeValue(const SBBLoadingIndicator.tinySmoke(), const SBBLoadingIndicator.tinyCement());
  }
}
