import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/picker/sbb_picker_constants.dart';

/// Represents an item in the [SBBPickerScrollView] that is used by [SBBPicker].
class SBBPickerItem {
  /// Constructs an [SBBPickerItem] with a [label] and an optional [isEnabled]
  /// flag.
  ///
  /// [label] is the text that will be displayed for the item.
  ///
  /// [isEnabled] flag determines whether the item is enabled or disabled.
  SBBPickerItem(String label, {bool isEnabled = true})
    : this.custom(
        isEnabled: isEnabled,
        widget: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: pickerWidgetHorizontalPadding + pickerItemMinPadding,
          ),
          child: Text(label, softWrap: false),
        ),
      );

  /// Constructs a custom [SBBPickerItem] with a widget.
  ///
  /// The [isEnabled] flag determines whether the item is enabled or disabled.
  ///
  /// The [widget] is the custom widget to be displayed for the item. The
  /// default TextStyle is defined by [SBBPickerStyle.textStyle].
  SBBPickerItem.custom({this.isEnabled = true, required this.widget});

  final bool isEnabled;
  final Widget widget;
}
