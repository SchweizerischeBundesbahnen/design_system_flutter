import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class SBBCheckboxListItem extends SBBListItemV5 {
  SBBCheckboxListItem({
    super.key,
    Widget? leading,
    IconData? leadingIconData,
    super.title,
    super.titleText,
    super.subtitle,
    super.subtitleText,
    super.trailing,
    super.trailingIconData,
    super.onLongPress,
    super.enabled = true,
    super.isLoading = false,
    super.links,
    super.focusNode,
    super.autofocus = false,
    super.enableFeedback = true,
    super.padding,
    super.trailingHorizontalGapWidth,
    super.leadingHorizontalGapWidth,
    super.subtitleVerticalGapHeight,
    double leadingCheckboxGapWidth = 8.0,
    SBBListItemV5Style? listItemStyle,
    required bool? value,
    bool tristate = false,
    required ValueChanged<bool?>? onChanged,
    SBBCheckboxStyle? checkboxStyle,
    String? checkboxSemanticLabel,
  }) : super(
         onTap: onChanged != null && enabled
             ? () => onChanged.call(
                 value == null
                     ? false
                     : value
                     ? tristate
                           ? null
                           : false
                     : true,
               )
             : null,
         leading: Builder(
           builder: (BuildContext context) {
             Widget? leadingWidget = leading;
             if (leadingWidget == null && leadingIconData != null) {
               leadingWidget = Icon(leadingIconData);
             }

             Widget child = SBBCheckbox(
               value: value,
               tristate: tristate,
               onChanged: onChanged,
               style: (checkboxStyle ?? SBBCheckboxStyle()).copyWith(tapTargetPadding: EdgeInsets.zero),
               semanticLabel: checkboxSemanticLabel,
             );

             if (leadingWidget != null) {
               child = Row(
                 mainAxisSize: MainAxisSize.min,
                 spacing: leadingCheckboxGapWidth,
                 children: [child, leadingWidget],
               );
             }
             return child;
           },
         ),
       );
}
