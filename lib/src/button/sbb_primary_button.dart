import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/button/default_button_label.dart';

import '../../sbb_design_system_mobile.dart';

/// The primary variant of the SBB Button.
///
/// Use [label] for custom content or [labelText] for the standard design.
/// Only one of them can be set.
///
/// If [isLoading] is true and [label] is null, the [SBBLoadingIndicator] will be displayed
/// as leading Widget within the button. The [onPressed] callback will be ignored.
///
/// Either [isLoading] must be true, or one of [label] or [labelText] must not be null.
///
/// If [onPressed] callback is null, the button will be disabled.
///
/// For specifications see [Figma](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=7-12)
class SBBPrimaryButton extends StatelessWidget {
  const SBBPrimaryButton({
    super.key,
    this.label,
    this.labelText,
    this.isLoading = false,
    required this.onPressed,
    this.focusNode,
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
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      focusNode: focusNode,
      child: label ?? _defaultLabel(),
    );
  }

  Widget _defaultLabel() {
    final child = isLoading ? const SBBLoadingIndicator.tinyCloud() : DefaultButtonLabel(label: labelText!);
    return Center(child: child);
  }
}
