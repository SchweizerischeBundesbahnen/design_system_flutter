import 'package:flutter/material.dart';

import 'sbb_picker_constants.dart';
import 'sbb_picker_item.dart';
import 'sbb_picker_scope.dart';

/// A mixin providing item-building and text-measurement helpers shared by
/// [SBBDatePicker], [SBBTimePicker] and [SBBDateTimePicker] state classes.
mixin TimeBasedPickerMixin<T extends StatefulWidget> on State<T> {
  /// Current item padding, adjusted dynamically to fit the available width.
  late double itemPadding;

  /// Measures the rendered size of [text] using the current picker style and
  /// text scaler from the ambient [SBBPickerScope].
  Size measureText(String text) {
    final scope = SBBPickerScope.maybeOf(context);
    final textStyle = scope?.pickerStyle?.textStyle;
    final textSpan = TextSpan(text: text, style: textStyle);
    final textDirection = Directionality.of(context);
    final painter = TextPainter(
      text: textSpan,
      maxLines: 1,
      textScaler: MediaQuery.of(context).textScaler,
      textDirection: textDirection,
    );
    painter.layout();
    return painter.size;
  }

  /// The minimum width of a two-digit time column label.
  double get timeItemTextMinWidth => measureText('33').width;

  /// Builds a single [SBBPickerItem] with the given label and layout properties.
  SBBPickerItem buildPickerItem({
    required bool isEnabled,
    required String label,
    AlignmentGeometry? alignment,
    double? textWidth,
    bool isFirstColumn = false,
    bool isLastColumn = false,
  }) {
    return SBBPickerItem.custom(
      isEnabled: isEnabled,
      widget: Container(
        alignment: alignment,
        padding: EdgeInsets.only(
          left: itemPadding + (isFirstColumn ? pickerWidgetHorizontalPadding : 0),
          right: itemPadding + (isLastColumn ? pickerWidgetHorizontalPadding : 0),
        ),
        child: SizedBox(
          width: textWidth,
          child: Text(label, textAlign: TextAlign.center, softWrap: false),
        ),
      ),
    );
  }

  /// Formats a number as a zero-padded two-digit string.
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }
}

