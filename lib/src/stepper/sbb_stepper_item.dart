import 'package:flutter/widgets.dart';

import '../../sbb_design_system_mobile.dart';

/// Represents a single step in an [SBBStepper].
///
/// Provide one of the concrete implementations: [SBBStepperItemIcon] to show
/// an icon in the step circle, [SBBStepperItemText] to show a custom text
/// string inside the circle, or [SBBStepperItemNumbered] to display the
/// step number automatically.
///
/// Note: [labelText] and [label] are mutually exclusive — provide only one of them.
sealed class SBBStepperItem {
  const SBBStepperItem._({
    this.labelText,
    this.label,
    this.style,
    this.showBadgeWhenPassed = true,
    this.badgeIcon = SBBIcons.tick_small,
  }) : assert(labelText == null || label == null, 'Cannot provide both labelText and label!');

  final String? labelText;
  final Widget? label;
  final SBBStepperItemStyle? style;
  final bool showBadgeWhenPassed;
  final IconData? badgeIcon;

  /// Creates an icon step with the given [icon].
  const factory SBBStepperItem.icon({
    required IconData icon,
    String? labelText,
    Widget? label,
    bool showBadgeWhenPassed,
    IconData? badgeIcon,
    SBBStepperItemStyle? style,
  }) = SBBStepperItemIcon;

  /// Creates a text step that displays the provided [text] inside the circle.
  const factory SBBStepperItem.text({
    required String text,
    String? labelText,
    Widget? label,
    bool showBadgeWhenPassed,
    IconData? badgeIcon,
    SBBStepperItemStyle? style,
  }) = SBBStepperItemText;

  /// Creates a numbered step that displays the step index (1-based) inside the circle.
  const factory SBBStepperItem.numbered({
    String? labelText,
    Widget? label,
    bool showBadgeWhenPassed,
    IconData? badgeIcon,
    SBBStepperItemStyle? style,
  }) = SBBStepperItemNumbered;

  @override
  bool operator ==(Object other) => identical(this, other) || runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// A step that displays an icon inside the step circle.
class SBBStepperItemIcon extends SBBStepperItem {
  const SBBStepperItemIcon({
    required this.icon,
    super.label,
    super.labelText,
    super.showBadgeWhenPassed,
    super.badgeIcon,
    super.style,
  }) : super._();

  final IconData icon;
}

/// A step that displays custom text inside the step circle.
class SBBStepperItemText extends SBBStepperItem {
  const SBBStepperItemText({
    required this.text,
    super.label,
    super.labelText,
    super.showBadgeWhenPassed,
    super.badgeIcon,
    super.style,
  }) : super._();

  final String text;
}

/// A step that displays its (1-based) index number inside the step circle.
class SBBStepperItemNumbered extends SBBStepperItem {
  const SBBStepperItemNumbered({
    super.label,
    super.labelText,
    super.showBadgeWhenPassed,
    super.badgeIcon,
    super.style,
  }) : super._();
}
