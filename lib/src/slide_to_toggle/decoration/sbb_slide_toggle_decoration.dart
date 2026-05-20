import 'package:flutter/material.dart';

/// TODO: Document, better name? Add asserts
@immutable
class SBBSlideToggleDecoration {
  const SBBSlideToggleDecoration({
    this.toggleLabel,
    this.toggleLabelText,
    this.toggleIconData,
    this.helpLabel,
    this.helpLabelText,
  });

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

  /// TODO
  final Widget? helpLabel;

  /// TODO
  final String? helpLabelText;

  SBBSlideToggleDecoration copyWith({
    Widget? toggleLabel,
    String? toggleLabelText,
    IconData? toggleIconData,
    Widget? helpLabel,
    String? helpLabelText,
  }) {
    return SBBSlideToggleDecoration(
      toggleLabel: toggleLabel ?? this.toggleLabel,
      toggleLabelText: toggleLabelText ?? this.toggleLabelText,
      toggleIconData: toggleIconData ?? this.toggleIconData,
      helpLabel: helpLabel ?? this.helpLabel,
      helpLabelText: helpLabelText ?? this.helpLabelText,
    );
  }
}
