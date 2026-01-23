import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// A convenience wrapper that combines [SBBListItem] with [SBBRadio] as the leading widget.
///
/// This widget automatically handles radio selection state changes via an ancestor [SBBRadioGroup]
/// and positions the radio button as the leading content of the list item. Additional leading
/// content can be provided via [leading] or [leadingIconData] and will be positioned after the
/// radio button.
///
///
/// ## Sample code
///
/// ```dart
/// SBBRadioGroup<String>(
///   groupValue: _selectedValue,
///   onChanged: (newValue) {
///     setState(() {
///       _selectedValue = newValue;
///     });
///   },
///   child: Column(
///     children: [
///       SBBRadioListItem(
///         value: 'option1',
///         titleText: 'Option 1',
///         subtitleText: 'Additional information',
///       ),
///       SBBRadioListItem(
///         value: 'option2',
///         titleText: 'Option 2',
///       ),
///     ],
///   ),
/// )
/// ```
///
/// See also:
///
///  * [SBBRadio], the radio widget used as leading content.
///  * [SBBRadioGroup], which manages the selection state for a group of radio items.
///  * [SBBListItem], the underlying list item widget.
///  * [SBBRadioListItemBoxed], a boxed variant of this widget.
class SBBRadioListItem<T> extends StatelessWidget {
  const SBBRadioListItem({
    super.key,
    this.leading,
    this.leadingIconData,
    this.title,
    this.titleText,
    this.subtitle,
    this.subtitleText,
    this.trailing,
    this.trailingIconData,
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
    this.leadingRadioGapWidth = 8.0,
    this.listItemStyle,
    required this.value,
    this.toggleable = false,
    this.radioStyle,
    this.radioSemanticLabel,
  });

  /// Additional leading widget displayed after the radio button.
  final Widget? leading;

  /// Icon data for additional leading icon displayed after the radio button.
  final IconData? leadingIconData;

  /// {@macro sbb_design_system.list_item.title}
  final Widget? title;

  /// {@macro sbb_design_system.list_item.titleText}
  final String? titleText;

  /// {@macro sbb_design_system.list_item.subtitle}
  final Widget? subtitle;

  /// {@macro sbb_design_system.list_item.subtitleText}
  final String? subtitleText;

  /// {@macro sbb_design_system.list_item.trailing}
  final Widget? trailing;

  /// {@macro sbb_design_system.list_item.trailingIconData}
  final IconData? trailingIconData;

  /// {@macro sbb_design_system.list_item.onLongPress}
  ///
  /// Within the [SBBRadioListItem], the [SBBListItem.onTap] calls the radio group's
  /// onChanged callback with this item's [value].
  final GestureLongPressCallback? onLongPress;

  /// {@macro sbb_design_system.list_item.enabled}
  ///
  /// If this is false, the radio button will also appear disabled.
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

  /// Horizontal gap width between the radio button and additional leading content.
  ///
  /// Defaults to 8.0.
  final double leadingRadioGapWidth;

  /// {@macro sbb_design_system.list_item.style}
  final SBBListItemStyle? listItemStyle;

  /// {@macro sbb_design_system.radio.value}
  final T value;

  /// {@macro sbb_design_system.radio.toggleable}
  final bool toggleable;

  /// {@macro sbb_design_system.radio.style}
  final SBBRadioStyle? radioStyle;

  /// {@macro sbb_design_system.radio.semanticLabel}
  final String? radioSemanticLabel;

  @override
  Widget build(BuildContext context) {
    final radioRegistry = RadioGroup.maybeOf<T>(context);
    final bool isInteractive = enabled && radioRegistry?.onChanged != null;

    Widget? leadingWidget = leading;
    if (leadingWidget == null && leadingIconData != null) {
      leadingWidget = Icon(leadingIconData);
    }

    Widget resolvedLeading = SBBRadio<T>(
      value: value,
      style: (radioStyle ?? const SBBRadioStyle()).copyWith(
        tapTargetPadding: EdgeInsets.zero,
      ),
      toggleable: toggleable,
      enabled: isInteractive,
      semanticLabel: radioSemanticLabel,
    );

    if (leadingWidget != null) {
      resolvedLeading = Row(
        mainAxisSize: MainAxisSize.min,
        spacing: leadingRadioGapWidth,
        children: [resolvedLeading, leadingWidget],
      );
    }

    return SBBListItem(
      leading: resolvedLeading,
      title: title,
      titleText: titleText,
      subtitle: subtitle,
      subtitleText: subtitleText,
      trailing: trailing,
      trailingIconData: trailingIconData,
      onTap: isInteractive ? () => radioRegistry!.onChanged(value) : null,
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

/// A boxed variant of [SBBRadioListItem] with rounded borders.
///
/// This widget extends [SBBRadioListItem] and wraps the list item in an [SBBContentBox].
///
/// All parameters and behavior are identical to [SBBRadioListItem].
///
/// See also:
///
///  * [SBBRadioListItem], for the standard variant without borders.
///  * [SBBListItemBoxed], the underlying boxed list item widget.
///  * [SBBContentBox], which provides the border and padding styling.
class SBBRadioListItemBoxed<T> extends SBBRadioListItem<T> {
  const SBBRadioListItemBoxed({
    super.key,
    required super.value,
    super.leading,
    super.leadingIconData,
    super.title,
    super.titleText,
    super.subtitle,
    super.subtitleText,
    super.trailing,
    super.trailingIconData,
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
    super.leadingRadioGapWidth,
    super.listItemStyle,
    super.radioStyle,
    super.radioSemanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SBBContentBox(child: super.build(context));
  }
}
