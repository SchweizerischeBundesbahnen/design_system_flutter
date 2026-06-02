import 'package:flutter/material.dart';

/// TODO: Document, better name?
@immutable
class SBBSlideToggleDecoration {
  const SBBSlideToggleDecoration({
    required this.onToggle,
    this.toggleLabel,
    this.toggleLabelText,
    this.toggleIconData,
    this.helpLabel,
    this.helpLabelText,
  }) : assert(
         toggleLabel != null || toggleLabelText != null || toggleIconData != null,
         'Either toggleLabel or toggleLabelText or toggleIconData must be provided',
       ),
       assert(helpLabel == null || helpLabelText == null, 'Only one of helpLabel or helpLabelText can be set');

  /// Callback when the slider is pulled to the other side
  /// TODO: Describe what happens with errors
  final Future<void> Function() onToggle;

  /// Custom widget to display inside the toggle.
  ///
  /// Mutually exclusive with [toggleLabelText] and [toggleIconData]. Only one can be provided.
  final Widget? toggleLabel;

  /// Text to display inside the toggle.
  ///
  /// Mutually exclusive with [label] and [toggleIconData]. Only one can be provided.
  final String? toggleLabelText;

  /// Icon to display inside toggle.
  ///
  /// Mutually exclusive with [toggleLabel] and [toggleLabelText]. Only one can be provided.
  final IconData? toggleIconData;

  /// Custom widget to be displayed as help text inside track.
  /// Will be faded out when the toggle is moved.
  ///
  /// Mutually exclusive with [helpLabelText]. Only one can be provided.
  final Widget? helpLabel;

  /// Help text to be displayed inside track.
  /// Will be faded out when the toggle is moved.
  ///
  /// Mutually exclusive with [helpLabel]. Only one can be provided.
  final String? helpLabelText;

  SBBSlideToggleDecoration copyWith({
    Future<void> Function()? onToggle,
    Widget? toggleLabel,
    String? toggleLabelText,
    IconData? toggleIconData,
    Widget? helpLabel,
    String? helpLabelText,
  }) {
    return SBBSlideToggleDecoration(
      onToggle: onToggle ?? this.onToggle,
      toggleLabel: toggleLabel ?? this.toggleLabel,
      toggleLabelText: toggleLabelText ?? this.toggleLabelText,
      toggleIconData: toggleIconData ?? this.toggleIconData,
      helpLabel: helpLabel ?? this.helpLabel,
      helpLabelText: helpLabelText ?? this.helpLabelText,
    );
  }
}
