import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Configuration for one side of an [SBBSlideToToggle].
///
/// This object defines:
/// - the content shown inside the toggle (`toggle*` properties),
/// - the optional help content shown in the track (`help*` properties), and
/// - the asynchronous callback invoked when the user (or controller flow) toggles the state.
///
/// Exactly one of [toggleLabel], [toggleLabelText], or [toggleIconData] must be provided.
/// For helper content, use either [helpLabel] or [helpLabelText], but not both.
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
  ///
  /// While this callback is running, the toggle is temporarily disabled and shows
  /// a loading indicator. If the callback throws, the component animates back to
  /// its previous position/state. If you handle errors yourself, use [SBBSlideToToggleController]
  /// to change the state.
  final Future<void> Function() onToggle;

  /// Custom widget to display inside the toggle.
  ///
  /// Mutually exclusive with [toggleLabelText] and [toggleIconData]. Only one can be provided.
  final Widget? toggleLabel;

  /// Text to display inside the toggle.
  ///
  /// Mutually exclusive with [toggleLabel] and [toggleIconData]. Only one can be provided.
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SBBSlideToggleDecoration &&
          runtimeType == other.runtimeType &&
          onToggle == other.onToggle &&
          toggleLabel == other.toggleLabel &&
          toggleLabelText == other.toggleLabelText &&
          toggleIconData == other.toggleIconData &&
          helpLabel == other.helpLabel &&
          helpLabelText == other.helpLabelText;

  @override
  int get hashCode => Object.hash(onToggle, toggleLabel, toggleLabelText, toggleIconData, helpLabel, helpLabelText);
}
