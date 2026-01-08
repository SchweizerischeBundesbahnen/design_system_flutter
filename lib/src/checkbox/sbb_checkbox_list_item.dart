import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// A convenience wrapper that combines [SBBListItemV5] with [SBBCheckbox] as the leading widget.
///
/// This widget automatically handles checkbox state changes and positions the checkbox
/// as the leading content of the list item. Additional leading content can be provided
/// via [leading] or [leadingIconData] and will be positioned after the checkbox.
///
/// The same result can be achieved by manually placing an [SBBCheckbox] in the
/// [SBBListItemV5.leading] parameter.
///
/// ## Sample code
///
/// ```dart
/// SBBCheckboxListItem(
///   value: _isChecked,
///   onChanged: (newValue) {
///     setState(() {
///       _isChecked = newValue ?? false;
///     });
///   },
///   titleText: 'Checkbox Item',
///   subtitleText: 'Additional information',
/// )
/// ```
///
/// See also:
///
///  * [SBBCheckbox], the checkbox widget used as leading content.
///  * [SBBListItemV5], the underlying list item widget.
class SBBCheckboxListItem extends StatelessWidget {
  const SBBCheckboxListItem({
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
    this.leadingCheckboxGapWidth = 8.0,
    this.listItemStyle,
    required this.value,
    this.tristate = false,
    required this.onChanged,
    this.checkboxStyle,
    this.checkboxSemanticLabel,
  });

  /// Additional leading widget displayed after the checkbox.
  final Widget? leading;

  /// Icon data for additional leading icon displayed after the checkbox.
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
  /// Within the [SBBCheckboxListItem], the [SBBListItemV5.onTap] calls the [onChanged] callback with the
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

  /// Horizontal gap width between the checkbox and additional leading content.
  ///
  /// Defaults to 8.0.
  final double leadingCheckboxGapWidth;

  /// {@macro sbb_design_system.list_item.style}
  final SBBListItemV5Style? listItemStyle;

  /// {@macro sbb_design_system.checkbox.value}
  final bool? value;

  /// {@macro sbb_design_system.checkbox.tristate}
  final bool tristate;

  /// {@macro sbb_design_system.checkbox.onChanged}
  ///
  /// Within the [SBBCheckboxListItem], the [SBBListItemV5.onTap] calls the [onChanged] callback with the
  /// updated value.
  final ValueChanged<bool?>? onChanged;

  /// {@macro sbb_design_system.checkbox.style}
  final SBBCheckboxStyle? checkboxStyle;

  /// {@macro sbb_design_system.checkbox.semanticLabel}
  final String? checkboxSemanticLabel;

  @override
  Widget build(BuildContext context) {
    Widget? leadingWidget = leading;
    if (leadingWidget == null && leadingIconData != null) {
      leadingWidget = Icon(leadingIconData);
    }

    Widget checkboxLeading = SBBCheckbox(
      value: value,
      tristate: tristate,
      onChanged: onChanged,
      style: (checkboxStyle ?? const SBBCheckboxStyle()).copyWith(
        tapTargetPadding: EdgeInsets.zero,
      ),
      semanticLabel: checkboxSemanticLabel,
    );

    if (leadingWidget != null) {
      checkboxLeading = Row(
        mainAxisSize: MainAxisSize.min,
        spacing: leadingCheckboxGapWidth,
        children: [checkboxLeading, leadingWidget],
      );
    }

    return SBBListItemV5(
      leading: checkboxLeading,
      title: title,
      titleText: titleText,
      subtitle: subtitle,
      subtitleText: subtitleText,
      trailing: trailing,
      trailingIconData: trailingIconData,
      onTap: onChanged != null && enabled ? () => _callOnChanged(onChanged!) : null,
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

  void _callOnChanged(ValueChanged<bool?> onChanged) {
    if (value == null) {
      onChanged(false);
    } else if (value!) {
      onChanged(tristate ? null : false);
    } else {
      onChanged(true);
    }
  }
}

/// A boxed variant of [SBBCheckboxListItem] with border and padding.
///
/// This widget extends [SBBCheckboxListItem] and wraps the list item in an [SBBContentBox]
/// to provide a contained appearance with rounded borders and background.
///
/// All parameters and behavior are identical to [SBBCheckboxListItem].
///
/// ## Sample code
///
/// ```dart
/// SBBCheckboxListItemBoxed(
///   value: _isChecked,
///   onChanged: (newValue) {
///     setState(() {
///       _isChecked = newValue ?? false;
///     });
///   },
///   titleText: 'Boxed Checkbox Item',
///   subtitleText: 'This item has a border',
/// )
/// ```
///
/// See also:
///
///  * [SBBCheckboxListItem], for the standard variant without borders.
///  * [SBBListItemV5Boxed], the underlying boxed list item widget.
///  * [SBBContentBox], which provides the border and padding styling.
class SBBCheckboxListItemBoxed extends SBBCheckboxListItem {
  const SBBCheckboxListItemBoxed({
    super.key,
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
    super.leadingCheckboxGapWidth,
    super.listItemStyle,
    required super.value,
    super.tristate,
    required super.onChanged,
    super.checkboxStyle,
    super.checkboxSemanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SBBContentBox(child: super.build(context));
  }
}
