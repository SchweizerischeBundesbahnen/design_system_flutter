import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/button/default_button_label.dart';

import '../../sbb_design_system_mobile.dart';
import '../sbb_internal.dart';

/// The tertiary variant of the SBB Button.
///
/// Provide either [label] for a custom content or [labelText] for text-only
/// content with standard styling. These parameters are mutually exclusive.
///
/// An optional leading icon can be added using [iconData] for standard icons
/// or [icon] for custom widgets. These parameters are mutually exclusive.
///
/// When [isLoading] is true, a loading indicator replaces the button content
/// and the button appears disabled.
///
/// The button is disabled when both [onPressed] and [onLongPress] are null.
///
/// See also:
///
///  * [SBBTertiaryButtonSmall], for a compact variant with reduced height.
///  * [SBBPrimaryButton], for the main action.
///  * [SBBSecondaryButton], for secondary actions.
///  * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=7-12)
class SBBTertiaryButton extends StatelessWidget {
  const SBBTertiaryButton({
    super.key,
    this.label,
    this.labelText,
    this.icon,
    this.iconData,
    this.isLoading = false,
    required this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
  }) : assert(!(labelText != null && label != null), 'Cannot provide both labelText and label!'),
       assert(!(iconData != null && icon != null), 'Cannot provide both iconData and icon!'),
       assert(
         !(labelText == null && label == null && !isLoading && icon == null && iconData == null),
         'One of labelText, label, icon, iconData must be set or isLoading must be true!',
       );

  /// A custom widget displayed as the button's content.
  ///
  /// For simple text labels, use [labelText] instead.
  ///
  /// Cannot be used together with [labelText].
  final Widget? label;

  /// The text displayed in the button.
  ///
  /// The text will be styled according to the SBB design system.
  ///
  /// Cannot be used together with [label].
  final String? labelText;

  /// A custom widget displayed before the label.
  ///
  /// Use this for custom icon layouts. For standard SBB icons, use
  /// [iconData] instead.
  ///
  /// Cannot be used together with [iconData].
  final Widget? icon;

  /// An icon displayed before the label.
  ///
  /// The icon will be sized and styled according to the SBB design system.
  ///
  /// Cannot be used together with [icon].
  final IconData? iconData;

  /// Whether to show a loading indicator instead of the button content.
  ///
  /// When true:
  ///  * A [SBBLoadingIndicator] replaces the leading icon and label
  ///  * The button becomes disabled ([onPressed] and [onLongPress] are ignored)
  ///  * The label remains visible if provided
  ///
  /// Defaults to false.
  final bool isLoading;

  /// Called when the button is tapped.
  ///
  /// The button is disabled when both this and [onLongPress] are null.
  ///
  /// Ignored when [isLoading] is true.
  final VoidCallback? onPressed;

  /// Called when the button is long-pressed.
  ///
  /// The button is disabled when both this and [onPressed] are null.
  ///
  /// Ignored when [isLoading] is true.
  final VoidCallback? onLongPress;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// Called when the focus state of the button changes.
  ///
  /// Receives true when the button gains focus and false when it loses focus.
  final ValueChanged<bool>? onFocusChange;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return _BaseTertiaryButton(
      label: label,
      labelText: labelText,
      icon: icon,
      iconData: iconData,
      isLoading: isLoading,
      onPressed: onPressed,
      onLongPress: onLongPress,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      autofocus: autofocus,
    );
  }
}

/// The tertiary variant of the SBB Button with reduced height.
///
/// Provide either [label] for a custom content or [labelText] for text-only
/// content with standard styling. These parameters are mutually exclusive.
///
/// An optional leading icon can be added using [iconData] for standard icons
/// or [icon] for custom widgets. These parameters are mutually exclusive.
///
/// When [isLoading] is true, a loading indicator replaces the button content
/// and the button appears disabled.
///
/// The button is disabled when both [onPressed] and [onLongPress] are null.
///
/// See also:
///
///  * [SBBTertiaryButton], for the standard height variant.
///  * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=7-12)
class SBBTertiaryButtonSmall extends StatelessWidget {
  const SBBTertiaryButtonSmall({
    super.key,
    this.label,
    this.labelText,
    this.icon,
    this.iconData,
    this.isLoading = false,
    required this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
  }) : assert(!(labelText != null && label != null), 'Cannot provide both labelText and label!'),
       assert(!(iconData != null && icon != null), 'Cannot provide both iconData and icon!'),
       assert(
         !(labelText == null && label == null && !isLoading && icon == null && iconData == null),
         'One of labelText, label, icon, iconData must be set or isLoading must be true!',
       );

  /// A custom widget displayed as the button's content.
  ///
  /// For simple text labels, use [labelText] instead.
  ///
  /// Cannot be used together with [labelText].
  final Widget? label;

  /// The text displayed in the button.
  ///
  /// The text will be styled according to the SBB design system.
  ///
  /// Cannot be used together with [label].
  final String? labelText;

  /// A custom widget displayed before the label.
  ///
  /// Use this for custom icon layouts. For standard SBB icons, use
  /// [iconData] instead.
  ///
  /// Cannot be used together with [iconData].
  final Widget? icon;

  /// An icon displayed before the label.
  ///
  /// The icon will be sized and styled according to the SBB design system.
  ///
  /// Cannot be used together with [icon].
  final IconData? iconData;

  /// Whether to show a loading indicator instead of the button content.
  ///
  /// When true:
  ///  * A [SBBLoadingIndicator] replaces the leading icon and label
  ///  * The button becomes disabled ([onPressed] and [onLongPress] are ignored)
  ///  * The label remains visible if provided
  ///
  /// Defaults to false.
  final bool isLoading;

  /// Called when the button is tapped.
  ///
  /// The button is disabled when both this and [onLongPress] are null.
  ///
  /// Ignored when [isLoading] is true.
  final VoidCallback? onPressed;

  /// Called when the button is long-pressed.
  ///
  /// The button is disabled when both this and [onPressed] are null.
  ///
  /// Ignored when [isLoading] is true.
  final VoidCallback? onLongPress;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// Called when the focus state of the button changes.
  ///
  /// Receives true when the button gains focus and false when it loses focus.
  final ValueChanged<bool>? onFocusChange;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

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
      onLongPress: onLongPress,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      autofocus: autofocus,
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
    this.onLongPress,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
  });

  final ButtonStyle? style;

  final Widget? label;
  final String? labelText;
  final Widget? icon;
  final IconData? iconData;
  final bool isLoading;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;
  final bool autofocus;

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

    final onlyLeading = (loading == null && leading != null && label == null);
    final resolvedButton = onlyLeading ? _iconButton(child!, context) : _textButton(child!);

    return resolvedButton;
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

  Widget _textButton(Widget child) => TextButton(
    style: style,
    onPressed: isLoading ? null : onPressed,
    onLongPress: isLoading ? null : onLongPress,
    focusNode: focusNode,
    onFocusChange: onFocusChange,
    autofocus: autofocus,
    child: child,
  );

  Widget _iconButton(Widget child, BuildContext context) {
    return IconButton.outlined(
      onPressed: isLoading ? null : onPressed,
      onLongPress: isLoading ? null : onLongPress,
      focusNode: focusNode,
      autofocus: autofocus,
      icon: child,
    );
  }
}
