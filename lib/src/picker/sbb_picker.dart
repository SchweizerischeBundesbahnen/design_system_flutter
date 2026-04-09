import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../../sbb_design_system_mobile.dart';

part 'input/sbb_date_input.dart';
part 'input/sbb_date_time_input.dart';
part 'input/sbb_time_input.dart';
part 'sbb_date_picker.dart';
part 'sbb_date_time_picker.dart';
part 'sbb_picker_item.dart';
part 'sbb_picker_scroll_controller.dart';
part 'sbb_picker_scroll_view.dart';
part 'sbb_picker_utils.dart';
part 'sbb_time_picker.dart';

// TODO: documentation and migration guide

/// The SBB Picker.
///
/// A picker widget that displays a scrollable list of items in a wheel-like
/// interface where users can select one item. The selected item is highlighted
/// in the center of the picker with a visual fade effect applied to items
/// further away.
///
/// The picker does not hold selection state itself. When an item is selected,
/// it calls [onSelectedItemChanged] with the new index and relies on its parent
/// to rebuild it with an updated selected value.
///
/// The picker supports looping mode where scrolling past the end of the list
/// wraps back to the beginning, or non-looping mode where scrolling stops at
/// the edges.
///
/// ## Setup with Scroll View
///
/// A typical [SBBPicker] is composed of two main parts:
/// * The outer [SBBPicker] widget which renders the highlight area and
///   applies the fade gradient effect
/// * An inner [SBBPickerScrollView] which manages the scrollable list of items
///
/// When using the default constructor or [SBBPicker.list], the scroll view is
/// created automatically. For advanced customization like multiple columns,
/// use [SBBPicker.custom] and provide your own [SBBPickerScrollView] as the
/// child widget.
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// See also:
///
/// * [SBBDatePicker], variant for date values.
/// * [SBBDateTimePicker], variant for date time values.
/// * [SBBTimePicker], variant for time values.
/// * [SBBPickerScrollView], the scrollable list widget used internally.
/// * [SBBPickerScrollController], for programmatic control of the picker.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/picker/>
class SBBPicker extends StatefulWidget {
  /// Constructs an [SBBPicker] where the picker items can be customized.
  ///
  /// [controller] can be used for programmatically reading or changing the
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
  /// * [SBBPicker.list], constructor for basic SBB Picker with a list of items.
  /// * [SBBPicker.custom], constructor for fully customizable picker.
  SBBPicker({
    Key? key,
    SBBPickerScrollController? controller,
    int initialSelectedIndex = 0,
    required ValueChanged<int>? onSelectedItemChanged,
    required SBBPickerScrollViewItemBuilder itemBuilder,
    bool looping = true,
    int visibleItemCount = _defaultVisibleItemCount,
    SBBPickerStyle? pickerStyle,
  }) : this.custom(
         key: key,
         visibleItemCount: visibleItemCount,
         pickerStyle: pickerStyle,
         child: SBBPickerScrollView(
           controller: controller,
           initialItem: initialSelectedIndex,
           onSelectedItemChanged: onSelectedItemChanged,
           itemBuilder: itemBuilder,
           looping: looping,
           visibleItemCount: visibleItemCount,
           pickerStyle: pickerStyle,
         ),
       );

  /// Constructs a basic [SBBPicker] with a list of items.
  ///
  /// [controller] can be used for programmatically reading or changing the
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
  ///
  /// See also:
  ///
  /// * [SBBPicker.new], default constructor for custom item building.
  /// * [SBBPicker.custom], constructor for fully customizable picker.
  SBBPicker.list({
    Key? key,
    SBBPickerScrollController? controller,
    int initialSelectedIndex = 0,
    required ValueChanged<int>? onSelectedItemChanged,
    required List items,
    bool looping = true,
    int visibleItemCount = _defaultVisibleItemCount,
    SBBPickerStyle? pickerStyle,
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
         pickerStyle: pickerStyle,
       );

  /// Constructs a fully customizable [SBBPicker].
  ///
  /// This constructor only builds the skeleton of the picker and should only
  /// be used when there is an absolute need for customization that the other
  /// constructors cannot provide, such as multiple columns of values.
  /// Otherwise, it is highly recommended to use the default constructor or
  /// [SBBPicker.list].
  const SBBPicker.custom({
    super.key,
    required this.child,
    this.visibleItemCount = _defaultVisibleItemCount,
    this.pickerStyle,
  }) : assert(
         visibleItemCount > 0 && visibleItemCount % 2 == 1,
         'visibleItemCount must be a positive odd number, but was $visibleItemCount',
       );

  /// The widget containing the actual picker contents.
  ///
  /// Make sure to include an [SBBPickerScrollView] in the widget tree of this
  /// child to provide the scrollable list of items.
  final Widget child;

  /// The number of visible items in the picker.
  ///
  /// Must be a positive odd number to ensure the center item is properly
  /// highlighted and items are symmetrically distributed on both sides.
  ///
  /// Defaults to 7.
  final int visibleItemCount;

  /// Customizes the visual appearance of the picker.
  ///
  /// Non-null properties override the corresponding properties in
  /// [SBBPickerThemeData.pickerStyle] from the current theme.
  final SBBPickerStyle? pickerStyle;

  @override
  State<SBBPicker> createState() => _SBBPickerState();
}

class _SBBPickerState extends _PickerClassState<SBBPicker> {
  @override
  int get _visibleItemCount => widget.visibleItemCount;

  @override
  SBBPickerStyle? _getEffectivePickerStyle(BuildContext context) {
    final themePickerStyle = Theme.of(context).sbbPickerTheme?.pickerStyle;
    return themePickerStyle?.merge(widget.pickerStyle) ?? widget.pickerStyle;
  }

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
          // widget.child,
          ShaderMask(
            shaderCallback: (bounds) => _shaderCallback(context, bounds),
            child: SizedBox(height: _scrollAreaHeight, child: widget.child),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedArea(BuildContext context) {
    final highlightColor = _getEffectivePickerStyle(context)?.highlightBackgroundColor;
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
    final pickerForegroundColor = _getEffectivePickerStyle(context)!.foregroundColor!;

    // return generated list of gradient color values
    return opacities.map((opacity) => pickerForegroundColor.withValues(alpha: opacity)).toList();
  }
}
