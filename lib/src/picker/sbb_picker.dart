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

// TODO: add themeData & style for more customization
// TODO: disabled color
// TODO: documentation and migration guide

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

  double get _widgetHeight => _scrollAreaHeight + SBBSpacing.medium;

  double get _highlightedAreaHeight => _itemHeight + SBBSpacing.xxSmall;

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
    // Stops are built for upper half of the scrollable area and mirrored for the bottom half.
    // All sizes are relative to the _scrollAreaHeight for gradient stop calculation
    const start = 0.0;
    const center = 0.5;
    const end = 1.0;

    final relativeItemHeight = _itemHeight / _scrollAreaHeight;
    // number of items on each side of the center item
    final sideItemCount = _visibleItemCount ~/ 2;

    // highlighted area
    final relativeHighlightedAreaHeight = _highlightedAreaHeight / _scrollAreaHeight;
    final highlightStart = center - relativeHighlightedAreaHeight * 0.5;

    // Build stops for the top half: start, then one stop per side item center,
    // then the highlight boundary.
    final List<double> topStops = [start];
    for (var i = 0; i < sideItemCount; i++) {
      topStops.add(relativeItemHeight * (i + 0.5));
    }

    // duplicate for hard transition
    topStops.add(highlightStart);
    topStops.add(highlightStart);

    // bottom half mirrors the top
    final bottomStops = topStops.reversed.map((s) => end - s).toList();

    return [...topStops, ...bottomStops];
  }

  List<Color> _gradientColors(BuildContext context) {
    /*
    Colors are based on the picker text style color with opacity values applied.

    Opacities are built for upper half of the scrollable area and mirrored for the bottom half.
    All sizes are relative to the _scrollAreaHeight for gradient stop calculation.

    The opacities exponentially decay from the highlighted area outward,
    meaning opacity drops very fast just outside the center and then
    stays nearly flat toward the edges. The highlighted area itself gets opacity 1.0.

    Built in _gradientStops: [start, centerOfItem0, ..., centerOfItem(n/2-1), highlightStart, highlightStart]
    Corresponding opacities: [0.0,   opacity1,      ..., opacity(n/2),        1.0,            1.0           ]
     */

    // number of items on each side of the center item
    final sideItemCount = _visibleItemCount ~/ 2;

    final topOpacities = <double>[0.0];
    for (var i = 0; i < sideItemCount; i++) {
      final x = (i + 1) / (sideItemCount + 1);
      final opacity = (exp(2 * x) - 1) / (exp(2) - 1);
      topOpacities.add(opacity);
    }
    topOpacities.add(1.0); // highlightStart
    topOpacities.add(1.0); // highlightStart duplicate

    // bottom half mirrors the top
    final bottomOpacities = topOpacities.reversed.toList();

    final opacities = [...topOpacities, ...bottomOpacities];

    // get base color from theme
    final textColor = SBBControlStyles.of(context).picker!.textStyle!.color!;

    // return generated list of gradient color values
    return opacities.map((opacity) => textColor.withValues(alpha: opacity)).toList();
  }
}
