import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// A convenience wrapper that combines [SBBListItemV5] with [SBBSwitch] as the trailing widget.
///
/// This widget automatically handles switch state changes and positions the switch
/// as the trailing content of the list item.
///
/// The same result can be achieved by manually placing an [SBBSwitch] in the
/// [SBBListItemV5.trailing] parameter.
///
/// ## Sample code
///
/// ```dart
/// SBBSwitchListItem(
///   value: _isEnabled,
///   onChanged: (newValue) {
///     setState(() {
///       _isEnabled = newValue;
///     });
///   },
///   titleText: 'Enable notifications',
///   subtitleText: 'Receive push notifications',
/// )
/// ```
///
/// See also:
///
///  * [SBBSwitch], the switch widget used as trailing content.
///  * [SBBListItemV5], the underlying list item widget.
///  * [SBBSwitchListItemBoxed], a boxed variant of this widget.
class SBBSwitchListItem extends StatelessWidget {
  const SBBSwitchListItem({
    super.key,
    this.leading,
    this.leadingIconData,
    this.title,
    this.titleText,
    this.subtitle,
    this.subtitleText,
    this.onLongPress,
    this.enabled = true,
    this.isLoading = false,
    this.links,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.padding,
    this.trailingHorizontalGapWidth,
    this.leadingHorizontalGapWidth,
    this.subtitleVerticalGapHeight,
    this.listItemStyle,
    required this.value,
    required this.onChanged,
    this.switchStyle,
    this.switchSemanticLabel,
  });

  /// Additional leading widget displayed before the title.
  final Widget? leading;

  /// Icon data for leading icon displayed before the title.
  final IconData? leadingIconData;

  /// {@macro sbb_design_system.list_item.title}
  final Widget? title;

  /// {@macro sbb_design_system.list_item.titleText}
  final String? titleText;

  /// {@macro sbb_design_system.list_item.subtitle}
  final Widget? subtitle;

  /// {@macro sbb_design_system.list_item.subtitleText}
  final String? subtitleText;

  /// {@macro sbb_design_system.list_item.onLongPress}
  ///
  /// Within the [SBBSwitchListItem], the [SBBListItemV5.onTap] calls the [onChanged] callback with the
  /// updated value.
  final GestureLongPressCallback? onLongPress;

  /// {@macro sbb_design_system.list_item.enabled}
  final bool enabled;

  /// {@macro sbb_design_system.list_item.isLoading}
  final bool isLoading;

  /// {@macro sbb_design_system.list_item.links}
  final Iterable<Widget>? links;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@macro flutter.material.ListTile.enableFeedback}
  final bool enableFeedback;

  /// {@macro sbb_design_system.list_item.padding}
  final EdgeInsetsGeometry? padding;

  /// {@macro sbb_design_system.list_item.trailingHorizontalGapWidth}
  final double? trailingHorizontalGapWidth;

  /// {@macro sbb_design_system.list_item.leadingHorizontalGapWidth}
  final double? leadingHorizontalGapWidth;

  /// {@macro sbb_design_system.list_item.subtitleVerticalGapHeight}
  final double? subtitleVerticalGapHeight;

  /// {@macro sbb_design_system.list_item.style}
  final SBBListItemV5Style? listItemStyle;

  /// {@macro sbb_design_system.switch.value}
  final bool value;

  /// {@macro sbb_design_system.switch.onChanged}
  ///
  /// Within the [SBBSwitchListItem], the [SBBListItemV5.onTap] calls the [onChanged] callback with the
  /// updated value.
  final ValueChanged<bool>? onChanged;

  /// {@macro sbb_design_system.switch.style}
  final SBBSwitchStyle? switchStyle;

  /// {@macro sbb_design_system.switch.semanticLabel}
  final String? switchSemanticLabel;

  @override
  Widget build(BuildContext context) {
    final trailing = SBBSwitch(
      value: value,
      onChanged: enabled ? onChanged : null,
      style: (switchStyle ?? const SBBSwitchStyle()).copyWith(
        tapTargetPadding: EdgeInsets.zero,
      ),
      semanticLabel: switchSemanticLabel,
    );

    return SBBListItemV5(
      leading: leading,
      leadingIconData: leadingIconData,
      title: title,
      titleText: titleText,
      subtitle: subtitle,
      subtitleText: subtitleText,
      trailing: trailing,
      onTap: onChanged != null && enabled ? () => onChanged!(!value) : null,
      onLongPress: onLongPress,
      enabled: enabled,
      isLoading: isLoading,
      links: links,
      focusNode: focusNode,
      autofocus: autofocus,
      enableFeedback: enableFeedback,
      padding: padding,
      trailingHorizontalGapWidth: trailingHorizontalGapWidth,
      leadingHorizontalGapWidth: leadingHorizontalGapWidth,
      subtitleVerticalGapHeight: subtitleVerticalGapHeight,
      style: listItemStyle,
    );
  }
}

/// A boxed variant of [SBBSwitchListItem] with rounded borders.
///
/// This widget extends [SBBSwitchListItem] and wraps the list item in an [SBBContentBox].
///
/// All parameters and behavior are identical to [SBBSwitchListItem].
///
/// ## Sample code
///
/// ```dart
/// SBBSwitchListItemBoxed(
///   value: _isEnabled,
///   onChanged: (newValue) {
///     setState(() {
///       _isEnabled = newValue;
///     });
///   },
///   titleText: 'Enable notifications',
///   subtitleText: 'This item has a border',
/// )
/// ```
///
/// See also:
///
///  * [SBBSwitchListItem], for the standard variant without borders.
///  * [SBBListItemV5Boxed], the underlying boxed list item widget.
///  * [SBBContentBox], which provides the border and padding styling.
class SBBSwitchListItemBoxed extends SBBSwitchListItem {
  const SBBSwitchListItemBoxed({
    super.key,
    super.leading,
    super.leadingIconData,
    super.title,
    super.titleText,
    super.subtitle,
    super.subtitleText,
    super.onLongPress,
    super.enabled,
    super.isLoading,
    super.links,
    super.focusNode,
    super.autofocus,
    super.enableFeedback,
    super.padding,
    super.trailingHorizontalGapWidth,
    super.leadingHorizontalGapWidth,
    super.subtitleVerticalGapHeight,
    super.listItemStyle,
    required super.value,
    required super.onChanged,
    super.switchStyle,
    super.switchSemanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SBBContentBox(child: super.build(context));
  }
}
