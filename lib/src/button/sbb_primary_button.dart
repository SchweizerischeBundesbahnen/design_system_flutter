import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/button/default_button_label.dart';

import '../../sbb_design_system_mobile.dart';

/// The primary variant of the SBB Button.
///
/// Use [label] for custom content within the button or [labelText] for the standard design.
/// Only one of them can be set.
///
/// When [isLoading] is true, a loading indicator replaces the label and
/// the button appears disabled.
///
/// The button is disabled when both [onPressed] and [onLongPress] are null.
///
/// See also:
///
///  * [SBBSecondaryButton], for secondary actions.
///  * [SBBTertiaryButton], for less prominent actions.
///  * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=7-12)
class SBBPrimaryButton extends StatelessWidget {
  const SBBPrimaryButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.label,
    this.labelText,
    this.isLoading = false,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
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

  /// Text string to display as the button's label using the standard design.
  ///
  /// The button will be styled according to the SBB design system.
  ///
  /// Cannot be used together with [label].
  final String? labelText;

  /// Whether to show a loading indicator instead of the label.
  ///
  /// When true:
  ///  * A [SBBLoadingIndicator] replaces the button content
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
    // The button is surrounded by padding to allow the border to be drawn outside while maintaining correct distances
    // to other Widgets.
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        onLongPress: isLoading ? null : onLongPress,
        focusNode: focusNode,
        onFocusChange: onFocusChange,
        autofocus: autofocus,
        child: label ?? _defaultLabel(),
      ),
    );
  }

  Widget _defaultLabel() {
    final child =
        isLoading ? const SBBLoadingIndicator.tiny(color: SBBColors.white) : DefaultButtonLabel(label: labelText!);
    return Center(child: child);
  }
}
