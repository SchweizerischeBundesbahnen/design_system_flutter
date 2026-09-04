import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

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
    this.semanticLabel,
    this.style,
    this.showBadgeWhenPassed = true,
    this.badgeIcon = SBBIcons.tick_small,
    this.key,
  }) : assert(labelText == null || label == null, 'Cannot provide both labelText and label!');

  /// Creates an icon step with the given [icon].
  const factory SBBStepperItem.icon({
    required IconData icon,
    String? labelText,
    Widget? label,
    String? semanticLabel,
    bool showBadgeWhenPassed,
    IconData? badgeIcon,
    SBBStepperItemStyle? style,
    Key? key,
  }) = SBBStepperItemIcon;

  /// Creates a text step that displays the provided [text] inside the circle.
  const factory SBBStepperItem.text({
    required String text,
    String? labelText,
    Widget? label,
    String? semanticLabel,
    bool showBadgeWhenPassed,
    IconData? badgeIcon,
    SBBStepperItemStyle? style,
    Key? key,
  }) = SBBStepperItemText;

  /// Creates a numbered step that displays the step index (1-based) inside the circle.
  const factory SBBStepperItem.numbered({
    String? labelText,
    Widget? label,
    String? semanticLabel,
    bool showBadgeWhenPassed,
    IconData? badgeIcon,
    SBBStepperItemStyle? style,
    Key? key,
  }) = SBBStepperItemNumbered;

  final String? labelText;
  final Widget? label;

  /// The accessible name announced for this step.
  ///
  /// When provided, this replaces the step's visual content in the semantics
  /// tree: neither the circle's content (number, text or icon) nor the [label]
  /// widget is announced. When omitted, the active step falls back to
  /// [labelText] and, if that is null as well, to its visual content.
  ///
  /// See also:
  /// * [SBBStepper.semanticValueBuilder], which words the step's position.
  final String? semanticLabel;
  /// Customizes this step's appearance.
  ///
  /// Non-null properties of this style override the corresponding properties
  /// in [SBBStepperItemStyle] from the theme found in [SBBStepper.style] or
  /// the default theme. This allows for per-step styling without affecting
  /// other steps in the same stepper.
  final SBBStepperItemStyle? style;
  final bool showBadgeWhenPassed;
  final IconData? badgeIcon;

  /// Optional key applied to this step's internal circle widget.
  ///
  /// Useful in tests to find and tap a specific step via `find.byKey(key)`.
  final Key? key;

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
    super.semanticLabel,
    super.showBadgeWhenPassed,
    super.badgeIcon,
    super.style,
    super.key,
  }) : super._();

  final IconData icon;
}

/// A step that displays custom text inside the step circle.
class SBBStepperItemText extends SBBStepperItem {
  const SBBStepperItemText({
    required this.text,
    super.label,
    super.labelText,
    super.semanticLabel,
    super.showBadgeWhenPassed,
    super.badgeIcon,
    super.style,
    super.key,
  }) : super._();

  final String text;
}

/// A step that displays its (1-based) index number inside the step circle.
class SBBStepperItemNumbered extends SBBStepperItem {
  const SBBStepperItemNumbered({
    super.label,
    super.labelText,
    super.semanticLabel,
    super.showBadgeWhenPassed,
    super.badgeIcon,
    super.style,
    super.key,
  }) : super._();
}
