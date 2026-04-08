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
    int visibleItemCount = _defaultVisibleItemCount,
  }) : this.custom(
         key: key,
         visibleItemCount: visibleItemCount,
         child: SBBPickerScrollView(
           controller: controller ?? SBBPickerScrollController(initialItem: initialSelectedIndex),
           onSelectedItemChanged: onSelectedItemChanged,
           itemBuilder: itemBuilder,
           looping: looping,
           visibleItemCount: visibleItemCount,
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
    int visibleItemCount = _defaultVisibleItemCount,
  }) : this(
         key: key,
         controller: controller,
         initialSelectedIndex: initialSelectedIndex,
         onSelectedItemChanged: onSelectedItemChanged,
         itemBuilder: (context, index) {
           if (!looping && (index < 0 || index >= items.length)) {
             return null;
           }
           final item = items[index % items.length];
           final itemLabel = item.toString();
           return SBBPickerItem(itemLabel);
         },
         looping: false,
         visibleItemCount: visibleItemCount,
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
  const SBBPicker.custom({
    super.key,
    required this.child,
    this.visibleItemCount = _defaultVisibleItemCount,
  }) : assert(
         visibleItemCount > 0 && visibleItemCount % 2 == 1,
         'visibleItemCount must be a positive odd number, but was $visibleItemCount',
       );

  final Widget child;

  /// The number of visible items in the picker.
  ///
  /// Must be a positive odd number.
  ///
  /// Defaults to 7.
  final int visibleItemCount;

  @override
  State<SBBPicker> createState() => _SBBPickerState();
}

class _SBBPickerState extends _PickerClassState<SBBPicker> {
  @override
  int get _visibleItemCount => widget.visibleItemCount;

  get _widgetHeight => _scrollAreaHeight + SBBSpacing.xLarge;

  get _highlightedAreaHeight => _itemHeight + 4.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _widgetHeight,
      child: Stack(
        alignment: .center,
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
      margin: const .symmetric(horizontal: SBBSpacing.xSmall),
      decoration: BoxDecoration(
        color: highlightColor,
        borderRadius: const BorderRadius.all(Radius.circular(SBBSpacing.xSmall)),
      ),
    );
  }

  Shader _shaderCallback(BuildContext context, Rect bounds) {
    return LinearGradient(
      begin: .topCenter,
      end: .bottomCenter,
      stops: _gradientStops(),
      colors: _gradientColors(context),
    ).createShader(bounds);
  }

  List<double> _gradientStops() {
    // stops are values from 0.0 to 1.0 (fractions along the gradient)
    const start = 0.0;
    const center = 0.5;
    const end = 1.0;

    final n = _visibleItemCount;
    final itemHeight = _itemHeight / _scrollAreaHeight;
    final sideItemCount = n ~/ 2; // items on each side of the center item

    // highlighted area
    final highlightedAreaHeight = _highlightedAreaHeight / _scrollAreaHeight;
    final highlightStart = center - highlightedAreaHeight * 0.5;
    final highlightEnd = highlightStart + highlightedAreaHeight;

    // Build stops for the top half: start, then one stop per side item center,
    // then the highlight boundary.
    final topStops = <double>[start];
    for (var i = 0; i < sideItemCount; i++) {
      topStops.add(itemHeight * (i + 0.5));
    }
    topStops.add(highlightStart);
    topStops.add(highlightStart); // duplicate for hard transition

    // highlighted center
    final centerStops = <double>[highlightEnd, highlightEnd];

    // bottom half mirrors the top (excluding center duplicates)
    final bottomStops = topStops.reversed.map((s) => end - s).toList();

    return [...topStops, ...centerStops, ...bottomStops];
  }

  List<Color> _gradientColors(BuildContext context) {
    final n = _visibleItemCount;
    final sideItemCount = n ~/ 2; // items on each side of center

    // Build opacity values for top half: linear from 0.0 at the edge to 1.0
    // at the center (highlighted) item. Each side item gets a linearly
    // interpolated opacity value. The highlighted area itself gets opacity 1.0.
    //
    // stops built in _gradientStops: [start, centerOfItem0, ..., centerOfItem(n/2-1), highlightStart, highlightStart]
    // corresponding opacities:       [0.0,  opacity1,      ..., opacity(n/2),         1.0,            1.0           ]

    final topOpacities = <double>[0.0];
    for (var i = 0; i < sideItemCount; i++) {
      // linear interpolation: item closest to edge gets opacity near 0,
      // item closest to center gets opacity near 1.
      final opacity = (i + 1) / (sideItemCount + 1);
      topOpacities.add(opacity);
    }
    topOpacities.add(1.0); // highlightStart
    topOpacities.add(1.0); // highlightStart duplicate

    // highlighted area is fully opaque
    final centerOpacities = <double>[1.0, 1.0];

    // bottom half mirrors the top
    final bottomOpacities = topOpacities.reversed.toList();

    final opacities = [...topOpacities, ...centerOpacities, ...bottomOpacities];

    // get base color from theme
    final textColor = SBBControlStyles.of(context).picker!.textStyle!.color!;

    // return generated list of gradient color values
    return opacities.map((opacity) => textColor.withValues(alpha: opacity)).toList();
  }
}
