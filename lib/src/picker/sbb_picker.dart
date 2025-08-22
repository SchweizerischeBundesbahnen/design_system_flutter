import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../../sbb_design_system_mobile.dart';

part 'sbb_date_input.dart';
part 'sbb_date_picker.dart';
part 'sbb_date_time_input.dart';
part 'sbb_date_time_picker.dart';
part 'sbb_picker_item.dart';
part 'sbb_picker_scroll_controller.dart';
part 'sbb_picker_scroll_view.dart';
part 'sbb_picker_utils.dart';
part 'sbb_time_input.dart';
part 'sbb_time_picker.dart';

/// SBB Picker. Use according to documentation.
///
/// See also:
///
/// * [SBBDatePicker], variant for date values.
/// * [SBBDateTimePicker], variant for date time values.
/// * [SBBTimePicker], variant for time values.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
class SBBPicker extends StatefulWidget {
  /// Constructs an [SBBPicker] where the picker items can be customized.
  ///
  /// [controller] cas be used for programmatically reading or changing the
  /// current picker index.
  ///
  /// [initialSelectedIndex] defaults to 0.
  ///
  /// [onSelectedItemChanged] is the callback called when the selected value
  /// changes.
  ///
  /// [itemBuilder] is the callback called when a picker item needs to be built.
  ///
  /// [looping] decides whether the list loops and can be scrolled infinitely.
  /// If set to true, scrolling past the end of the list will loop the list back
  /// to the beginning. If set to false, the list will stop scrolling when you
  /// reach the end or the beginning. Defaults to true.
  ///
  /// See also:
  ///
  /// * [SBBPicker.list], constructor for basic SBB Picker.
  SBBPicker({
    Key? key,
    SBBPickerScrollController? controller,
    int initialSelectedIndex = 0,
    required ValueChanged<int>? onSelectedItemChanged,
    required SBBPickerScrollViewItemBuilder itemBuilder,
    bool looping = true,
  }) : this.custom(
         key: key,
         child: SBBPickerScrollView(
           controller: controller ?? SBBPickerScrollController(initialItem: initialSelectedIndex),
           onSelectedItemChanged: onSelectedItemChanged,
           itemBuilder: itemBuilder,
           looping: looping,
         ),
       );

  /// Constructs a basic [SBBPicker].
  ///
  /// [controller] cas be used for programmatically reading or changing the
  /// current picker index.
  ///
  /// [initialSelectedIndex] defaults to 0.
  ///
  /// [onSelectedItemChanged] is the callback called when the selected value
  /// changes.
  ///
  /// [items] is the list of items representing the picker items to be shown
  /// with [toString()].
  ///
  /// [looping] decides whether the list loops and can be scrolled infinitely.
  /// If set to true, scrolling past the end of the list will loop the list back
  /// to the beginning. If set to false, the list will stop scrolling when you
  /// reach the end or the beginning. Defaults to true.
  SBBPicker.list({
    Key? key,
    SBBPickerScrollController? controller,
    int initialSelectedIndex = 0,
    required ValueChanged<int>? onSelectedItemChanged,
    required List items,
    bool looping = true,
  }) : this(
         key: key,
         controller: controller,
         initialSelectedIndex: initialSelectedIndex,
         onSelectedItemChanged: onSelectedItemChanged,
         itemBuilder: (BuildContext context, int index) {
           if (!looping && (index < 0 || index >= items.length)) {
             return null;
           }
           final item = items[index % items.length];
           final itemLabel = item.toString();
           return SBBPickerItem(itemLabel);
         },
         looping: false,
       );

  /// Constructs a fully customizable [SBBPicker]. This only builds the skeleton
  /// of the Picker where the [SBBPickerScrollView] is not included.
  /// This constructor should only be used when there is an absolute need for so
  /// much customization that the default constructor cannot provide like
  /// multiple columns of values.
  /// Otherwise it is highly recommended to check out the default constructor
  /// first where the picker items are customizable.
  ///
  /// [child] is the widget containing the actual contents. Make sure to include
  /// [SBBPickerScrollView] in the widget tree.
  ///
  /// See also:
  ///
  /// * [SBBPicker.new], default constructor for SBB Picker with limited
  ///   customization.
  /// * [SBBPicker.list], constructor for basic SBB Picker.
  const SBBPicker.custom({super.key, required this.child});

  static const _lightThemeGradientColorOpacities = [0.31, 0.61, 0.70];
  static const _darkThemeGradientColorOpacities = [0.38, 0.61, 0.76];

  final Widget child;

  @override
  State<SBBPicker> createState() => _SBBPickerState();
}

class _SBBPickerState extends _PickerClassState<SBBPicker> {
  get _widgetHeight => _scrollAreaHeight + sbbDefaultSpacing * 2;

  get _highlightedAreaHeight => _itemHeight + 4.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _widgetHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildHighlightedArea(context),
          ShaderMask(
            shaderCallback: (bounds) => _shaderCallback(context, bounds),
            child: SizedBox(height: _scrollAreaHeight, child: widget.child),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedArea(BuildContext context) {
    final highlightColor = SBBControlStyles.of(context).picker!.highlightColor;
    return Container(
      height: _highlightedAreaHeight,
      margin: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing * 0.5),
      decoration: BoxDecoration(
        color: highlightColor,
        borderRadius: const BorderRadius.all(Radius.circular(sbbDefaultSpacing * 0.5)),
      ),
    );
  }

  Shader _shaderCallback(BuildContext context, Rect bounds) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: _gradientStops(),
      colors: _gradientColors(context),
    ).createShader(bounds);
  }

  List<double> _gradientStops() {
    // stops are values from 0.0 to 1.0 (fractions along the gradient)
    const start = 0.0;
    const center = 0.5;
    const end = 1.0;

    // visible picker items
    final itemHeight = _itemHeight / _scrollAreaHeight;
    final endOfItem0 = itemHeight * 1;
    final centerOfItem1 = itemHeight * 1.5;
    final centerOfItem2 = itemHeight * 2.5;
    final centerOfItem4 = itemHeight * 4.5;
    final centerOfItem5 = itemHeight * 5.5;
    final startOfItem6 = itemHeight * 6.0;

    // highlighted area
    final highlightedAreaHeight = _highlightedAreaHeight / _scrollAreaHeight;
    final highlightStart = center - highlightedAreaHeight * 0.5;
    final highlightEnd = highlightStart + highlightedAreaHeight;

    return [
      start,
      endOfItem0,
      centerOfItem1,
      centerOfItem2,
      highlightStart,
      highlightStart,
      highlightEnd,
      highlightEnd,
      centerOfItem4,
      centerOfItem5,
      startOfItem6,
      end,
    ];
  }

  List<Color> _gradientColors(BuildContext context) {
    // generate list of opacity values to be used in gradient
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final themedOpacities =
        isLightTheme
            ? SBBPicker._lightThemeGradientColorOpacities
            : SBBPicker._darkThemeGradientColorOpacities;

    // start with opacity 0
    var opacities = [0.0];
    // add base values
    opacities.addAll(themedOpacities);
    // duplicate last base value
    opacities.add(opacities.last);
    // opacity 1 in highlighted area
    opacities.add(1.0);
    // mirrored values for second half
    opacities.addAll(opacities.reversed.toList());

    // get base color from theme
    final textColor = SBBControlStyles.of(context).picker!.textStyle!.color!;

    // return generated list of gradient color values
    return opacities.map((opacity) => textColor.withOpacity(opacity)).toList();
  }
}
