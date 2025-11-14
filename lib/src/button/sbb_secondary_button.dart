import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'default_button_label.dart';

/// The secondary variant of the SBB Button.
///
/// Use [label] for custom content or [labelText] for the standard design.
/// Only one of them can be set.
///
/// If [isLoading] is true and [label] is null, a themed [SBBLoadingIndicator] will be displayed
/// as label within the button. The [onPressed] and [onLongPress] callbacks will be ignored.
///
/// Either [isLoading] must be true, or one of [label] or [labelText] must not be null.
///
/// If both [onPressed] and [onLongPress] callbacks are null, the button will be disabled.
///
/// For specifications see [Figma](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=7-12)
class SBBSecondaryButton extends StatelessWidget {
  const SBBSecondaryButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.label,
    this.labelText,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
    this.isLoading = false,
  }) : assert(!(labelText != null && label != null), 'Cannot provide both labelText and label!'),
       assert(
         !(labelText == null && label == null && !isLoading),
         'One of labelText, label must be set or isLoading must be true!',
       );

  /// Custom widget to display as the button's label.
  ///
  /// Only one of [label] or [labelText] can be set.
  final Widget? label;

  /// Text string to display as the button's label using the standard design.
  ///
  /// Only one of [label] or [labelText] can be set.
  final String? labelText;

  /// Whether the button is in a loading state.
  ///
  /// If true, displays a [SBBLoadingIndicator] as the label and ignores the [onPressed] callback.
  ///
  /// If true, the button will appear disabled.
  ///
  /// Defaults to false.
  final bool isLoading;

  /// Called when the button is tapped.
  ///
  /// If this callback and [onLongPress] are null, then the button will be disabled.
  ///
  /// If null, the button will be disabled. If [isLoading] is true, this callback is ignored.
  final VoidCallback? onPressed;

  /// Called when the button is long-pressed.
  ///
  /// If this callback and [onPressed] are null, then the button will be disabled.
  ///
  /// If [isLoading] is true, this callback is ignored.
  final VoidCallback? onLongPress;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses
  /// focus.
  final ValueChanged<bool>? onFocusChange;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      onLongPress: isLoading ? null : onLongPress,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      autofocus: autofocus,
      child: label ?? _defaultLabel(context),
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
