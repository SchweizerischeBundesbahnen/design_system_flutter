import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Represents a single step in an [SBBStepper].
///
/// Provide one of the concrete implementations: [SBBStepperItemIcon] to show
/// an icon in the step circle, [SBBStepperItemText] to show a custom text
/// string inside the circle, or [SBBStepperItemNumbered] to display the
/// step number automatically.
///
/// See also:
/// * [SBBStepper] to arrange multiple steps.
/// * [SBBStepperItemStyle], the customizable style properties for a step.
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

  /// Creates a step that displays an icon inside the step circle.
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

  /// Creates a step that displays custom text inside the step circle.
  ///
  /// The [text] parameter is required and defines the text to display.
  /// This is useful for custom labels like letters, abbreviations, or short
  /// descriptive text. For sequential numbering, use [SBBStepperItem.numbered]
  /// instead.
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
  ///
  /// The step number is automatically determined by the position within
  /// [SBBStepper.steps], so there are no required parameters other than those
  /// inherited from [SBBStepperItem].
  /// Set [semanticLabel] to provide an accessible name to screen readers.
  /// When a step is passed, a badge with [badgeIcon] can be displayed if
  /// [showBadgeWhenPassed] is true (default).
  const factory SBBStepperItem.numbered({
    String? labelText,
    Widget? label,
    String? semanticLabel,
    bool showBadgeWhenPassed,
    IconData? badgeIcon,
    SBBStepperItemStyle? style,
    Key? key,
  }) = SBBStepperItemNumbered;

  /// Optional label text displayed below this step when active.
  ///
  /// Mutually exclusive with [label]. Provide only one of these two properties.
  final String? labelText;

  /// Optional label widget displayed below this step when active.
  ///
  /// Mutually exclusive with [labelText]. Provide only one of these two properties.
  final Widget? label;

  /// The accessible name announced for this step.
  ///
  /// See also:
  /// * [SBBStepper.semanticValueBuilder], which words the step's position.
  final String? semanticLabel;

  /// Customizes this step's appearance.
  ///
  /// Non-null properties of this style override the corresponding properties
  /// in [SBBStepperItemStyle] from the theme found in [SBBStepper.style] or
  /// the default theme.
  final SBBStepperItemStyle? style;

  /// Whether to display a badge when this step has been passed.
  final bool showBadgeWhenPassed;

  /// The icon to display in a badge.
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
///
/// See also:
/// * [SBBStepperItem.icon], the factory constructor for this class.
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

  /// The icon displayed inside the step circle.
  final IconData icon;
}

/// A step that displays custom text inside the step circle.
///
/// For sequential numbering, prefer [SBBStepperItemNumbered] instead.
///
/// See also:
/// * [SBBStepperItem.text], the factory constructor for this class.
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

  /// The text displayed inside the step circle.
  final String text;
}

/// A step that displays its (1-based) index number inside the step circle.
///
/// See also:
/// * [SBBStepperItem.numbered], the factory constructor for this class.
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
