import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// Represents a single step in an [SBBStepper].
///
/// Provide one of the concrete implementations: [SBBStepperItemIcon] to show
/// an icon in the step circle, [SBBStepperItemText] to show a custom text
/// string inside the circle, or [SBBStepperItemNumbered] to display the
/// step number automatically.
///
/// The [labelText] and [label] parameters are mutually exclusive.
///
/// Use [style] to customize the appearance of an individual step, which will
/// override the default theme's styling for that step only.
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
  ///
  /// The [icon] parameter is required and defines the icon to display.
  /// Use [labelText] or [label] to display text below the active step - they
  /// are mutually exclusive.
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
  /// Use [labelText] or [label] to display text below the active step - they are
  /// mutually exclusive.
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
  /// Use [labelText] or [label] to display text below the active step.
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
  /// When provided, this text is displayed centered below the step circle
  /// only when the step is the active step (selected). The text may be
  /// truncated with ellipsis if it exceeds available space.
  ///
  /// Mutually exclusive with [label]. Provide only one of these two properties.
  final String? labelText;

  /// Optional label widget displayed below this step when active.
  ///
  /// When provided, this widget is displayed centered below the step circle
  /// only when the step is the active step (selected). This allows for
  /// arbitrary widget customization in the label area, such as styled text,
  /// icons, or rich content.
  ///
  /// Mutually exclusive with [labelText]. Provide only one of these two properties.
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

  /// Whether to display a badge when this step has been passed.
  ///
  /// Defaults to true. When true and the step's index is less than the
  /// active step index, a small badge is displayed on top of the step circle
  /// showing [badgeIcon]. Set to false to hide the badge for this step.
  final bool showBadgeWhenPassed;
  /// The icon to display in the badge when this step has been passed.
  ///
  /// Defaults to [SBBIcons.tick_small]. This icon is displayed in a small
  /// badge that appears on top of the step circle when [showBadgeWhenPassed]
  /// is true and the step is marked as passed.
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
