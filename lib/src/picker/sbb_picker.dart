import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'sbb_picker_constants.dart';
import 'sbb_picker_scope.dart';

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
    int visibleItemCount = pickerDefaultVisibleItemCount,
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
           pickerStyle: pickerStyle,
         ),
       );

  /// Constructs a basic [SBBPicker] with a list of items.
  ///
  /// [controller] can be used for programmatically reading or changing the
  /// current picker index.
  ///
  /// [onSelectedItemChanged] is the callback called when the selected value
  /// changes.
  ///
  /// [items] is the list of items representing the picker items to be shown
  /// with `toString()`. Cannot be empty.
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
    int visibleItemCount = pickerDefaultVisibleItemCount,
    SBBPickerStyle? pickerStyle,
  }) : this(
         key: key,
         controller: controller,
         initialSelectedIndex: initialSelectedIndex,
         onSelectedItemChanged: onSelectedItemChanged,
         itemBuilder: (context, index) {
           assert(items.isNotEmpty, 'Items cannot be empty');
           if ((!looping && (index < 0 || index >= items.length))) {
             return null;
           }
           final item = items[index % items.length];
           return SBBPickerItem(item.toString());
         },
         looping: false,
         visibleItemCount: visibleItemCount,
         pickerStyle: pickerStyle,
       );

  /// Constructs a fully customizable [SBBPicker].
  ///
  /// [child] is the widget containing the actual picker contents. Make sure to
  /// include an [SBBPickerScrollView] in the widget tree of this child.
  ///
  /// This constructor only builds the skeleton of the picker and should only
  /// be used when there is an absolute need for customization that the other
  /// constructors cannot provide, such as multiple columns of values.
  /// Otherwise, it is highly recommended to use the default constructor or
  /// [SBBPicker.list].
  const SBBPicker.custom({
    super.key,
    required this.child,
    this.visibleItemCount = pickerDefaultVisibleItemCount,
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
  final int visibleItemCount;

  /// Customizes the visual appearance of the picker.
  ///
  /// Non-null properties override the corresponding properties in
  /// [SBBPickerThemeData.pickerStyle] from the current theme.
  final SBBPickerStyle? pickerStyle;

  @override
  State<SBBPicker> createState() => _SBBPickerState();
}

class _SBBPickerState extends State<SBBPicker> {
  SBBPickerStyle? _effectivePickerStyle(BuildContext context) {
    final themePickerStyle = Theme.of(context).sbbPickerTheme?.pickerStyle;
    return themePickerStyle?.merge(widget.pickerStyle) ?? widget.pickerStyle;
  }

  // These depend on itemHeight which comes from SBBPickerScope — read inside build.
  double _widgetHeight(double itemHeight) => itemHeight * widget.visibleItemCount + SBBSpacing.medium;

  double _highlightedAreaHeight(double itemHeight) => itemHeight + SBBSpacing.xxSmall;

  double _scrollAreaHeight(double itemHeight) => itemHeight * widget.visibleItemCount;

  @override
  Widget build(BuildContext context) {
    return SBBPickerScopeHost(
      visibleItemCount: widget.visibleItemCount,
      pickerStyle: _effectivePickerStyle(context),
      child: Builder(
        builder: (context) {
          // Read itemHeight from the scope just established above.
          final itemHeight = SBBPickerScope.of(context).itemHeight;
          final widgetHeight = _widgetHeight(itemHeight);
          final highlightedAreaHeight = _highlightedAreaHeight(itemHeight);
          final scrollAreaHeight = _scrollAreaHeight(itemHeight);

          return SizedBox(
            height: widgetHeight,
            child: Stack(
              alignment: .center,
              children: [
                _buildHighlightedArea(context, highlightedAreaHeight),
                ShaderMask(
                  shaderCallback: (bounds) => _shaderCallback(context, bounds, itemHeight, scrollAreaHeight),
                  child: SizedBox(height: scrollAreaHeight, child: widget.child),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHighlightedArea(BuildContext context, double highlightedAreaHeight) {
    final highlightColor = SBBPickerScope.of(context).pickerStyle?.highlightBackgroundColor;
    return Container(
      height: highlightedAreaHeight,
      margin: const EdgeInsets.symmetric(horizontal: SBBSpacing.xSmall),
      decoration: BoxDecoration(
        color: highlightColor,
        borderRadius: const BorderRadius.all(.circular(SBBSpacing.xSmall)),
      ),
    );
  }

  Shader _shaderCallback(BuildContext context, Rect bounds, double itemHeight, double scrollAreaHeight) {
    return LinearGradient(
      begin: .topCenter,
      end: .bottomCenter,
      stops: _gradientStops(itemHeight, scrollAreaHeight),
      colors: _gradientColors(context),
    ).createShader(bounds);
  }

  List<double> _gradientStops(double itemHeight, double scrollAreaHeight) {
    // Stops are built for upper half of the scrollable area and mirrored for the bottom half.
    // All sizes are relative to the scrollAreaHeight for gradient stop calculation
    const start = 0.0;
    const center = 0.5;
    const end = 1.0;

    final relativeItemHeight = itemHeight / scrollAreaHeight;

    // highlighted area
    final highlightedAreaHeight = _highlightedAreaHeight(itemHeight);
    final relativeHighlightedAreaHeight = highlightedAreaHeight / scrollAreaHeight;
    final highlightStart = center - relativeHighlightedAreaHeight * 0.5;

    final List<double> topStops = [start, relativeItemHeight, ...List.filled(3, highlightStart)];

    // bottom half mirrors the top
    final bottomStops = topStops.reversed.map((s) => end - s).toList();

    return [...topStops, ...bottomStops];
  }

  List<Color> _gradientColors(BuildContext context) {
    /*
    Colors are based on the picker text style color with opacity values applied.

    Opacities are built for upper half of the scrollable area and mirrored for the bottom half.
    All sizes are relative to the _scrollAreaHeight for gradient stop calculation.

    Build stops for the top half:
    -----
    | 0th ITEM    <--- 0 to 0.5
    |
    | 1st ITEM    <--- 0.7 (soft transition)
    |
    | 2nd ITEM    <--- 0.7
    | ...
    | nth ITEM    <--- 0.7
    |
    | CENTER ITEM <--- 1.0 (hard transition)

     */
    final topOpacities = <double>[0.0, 0.5, .7];

    topOpacities.add(1.0); // highlightStart
    topOpacities.add(1.0); // highlightStart

    // bottom half mirrors the top
    final bottomOpacities = topOpacities.reversed.toList();

    final opacities = [...topOpacities, ...bottomOpacities];

    // get base color from theme
    final pickerForegroundColor = SBBPickerScope.of(context).pickerStyle!.foregroundColor!;

    // return generated list of gradient color values
    return opacities.map((opacity) => pickerForegroundColor.withValues(alpha: opacity)).toList();
  }
}
