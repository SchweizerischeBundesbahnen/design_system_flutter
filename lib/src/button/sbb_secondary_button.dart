import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'default_button_label.dart';

/// The secondary variant of the SBB Button.
///
/// Provide either [label] for custom button content or [labelText] for text-only
/// content with standard styling. These parameters are mutually exclusive.
///
/// When [isLoading] is true, a loading indicator replaces the label and
/// the button appears disabled.
///
/// The button is disabled when both [onPressed] and [onLongPress] are null.
///
/// See also:
///
///  * [SBBPrimaryButton], for the main action.
///  * [SBBTertiaryButton], for less prominent actions.
///  * [SBBSecondaryButtonThemeData], for setting the [SBBButtonStyle] for all buttons within the current Theme.
///  * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=7-12)
class SBBSecondaryButton extends StatelessWidget {
  const SBBSecondaryButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.label,
    this.labelText,
    this.focusNode,
    this.autofocus = false,
    this.isLoading = false,
    this.semanticLabel,
  }) : assert(!(labelText != null && label != null), 'Cannot provide both labelText and label!'),
       assert(
         !(labelText == null && label == null && !isLoading),
         'One of labelText, label must be set or isLoading must be true!',
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

  /// Whether to show a loading indicator instead of the label.
  ///
  /// When true:
  ///  * A themed [SBBLoadingIndicator] replaces the button content
  ///  * The button becomes disabled ([onPressed] and [onLongPress] are ignored)
  ///
  /// Defaults to false.
  final bool isLoading;

  /// Called when the button is tapped.
  ///
  /// The button is disabled when both this and [onLongPress] are null.
  ///
  /// Ignored when [isLoading] is true.
  final VoidCallback? onPressed;

  /// Called when the button is long pressed.
  ///
  /// The button is disabled when both this and [onPressed] are null.
  ///
  /// Ignored when [isLoading] is true.
  final VoidCallback? onLongPress;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Provides a textual description of the widget for assistive technologies.
  ///
  /// If this is non null, semantics of [label] or [labelText] are ignored.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      enabled: !isLoading && (onPressed != null || onLongPress != null),
      button: true,
      label: semanticLabel,
      excludeSemantics: semanticLabel != null,
      // The button is surrounded by padding to allow the border to be drawn outside while
      // maintaining correct distances to other Widgets.
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          onLongPress: isLoading ? null : onLongPress,
          focusNode: focusNode,
          autofocus: autofocus,
          child: label ?? _defaultLabel(context),
        ),
      ),
    );
  }

  Widget _defaultLabel(BuildContext context) {
    final style = SBBBaseStyle.of(context);
    final themedLoadingIndicator = style.themeValue(
      const SBBLoadingIndicator.tinySmoke(),
      const SBBLoadingIndicator.tinyCement(),
    );

    final child = isLoading ? themedLoadingIndicator : DefaultButtonLabel(label: labelText!);
    return Center(child: child);
  }
}
