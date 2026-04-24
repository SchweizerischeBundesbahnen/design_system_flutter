import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/segmented_button/theme/default_sbb_segmented_button_theme_data.dart';

import '../../sbb_design_system_mobile.dart';

/// The SBB Segmented Button.
///
/// Displays multiple segments representing mutually exclusive options. The user
/// can tap a segment to select it, triggering the [onSelectionChanged] callback.
///
/// This widget does not maintain any state itself. The selection state is managed
/// by the parent widget. When a segment is tapped, [onSelectionChanged] is invoked
/// with the corresponding segment value, and the parent must update [selected]
/// to reflect the new selection.
///
/// Provide [segments] with descriptions of each option, and set [selected] to the
/// currently active segment value. Use [style] to customize appearance.
///
/// Use according to the [design documentation](https://digital.sbb.ch/de/design-system/mobile/components/segmented-button/).
///
/// See also:
///
/// * [SBBSegmentedButtonFilled], for a style variant optimized on top of filled backgrounds.
/// * [SBBRadioListItem] and [SBBRadio], widgets with similar semantics.
/// * [SBBSlider], for selecting a value in a range.
/// * [SBBCheckboxListItem], [SBBCheckbox] and [SBBSwitch], for toggling values.
class SBBSegmentedButton<T> extends StatefulWidget {
  SBBSegmentedButton({
    super.key,
    required this.segments,
    required this.selected,
    required this.onSelectionChanged,
    this.style,
    this.leadingHorizontalGapWidth,
  }) : assert(segments.isNotEmpty, 'At least one segment must be provided.'),
       assert(segments.any((s) => s.value == selected), 'Selected must match one of the values of segments!');

  /// Descriptions of the segments in the button.
  final List<SBBButtonSegment<T>> segments;

  /// The currently selected segment value.
  ///
  /// This must be one of the values from [segments]. Update this property
  /// when [onSelectionChanged] is called to reflect the new selection.
  final T selected;

  /// Called when the user taps a different segment.
  ///
  /// The callback is invoked with the value of the tapped segment.
  /// The parent widget is responsible for updating [selected] to reflect
  /// the new selection.
  final ValueChanged<T> onSelectionChanged;

  /// Customizes this button's appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBSegmentedButtonThemeData.style].
  final SBBSegmentedButtonStyle? style;

  /// Horizontal gap width between the leading widget and the label.
  ///
  /// Overrides the value in [SBBSegmentedButtonThemeData.leadingHorizontalGapWidth].
  ///
  /// Defaults to 4.0.
  final double? leadingHorizontalGapWidth;

  @override
  State<SBBSegmentedButton<T>> createState() => _SBBSegmentedButtonState<T>();
}

class _SBBSegmentedButtonState<T> extends State<SBBSegmentedButton<T>> {
  int get _selectedIndex => widget.segments.indexWhere((segment) => segment.value == widget.selected);

  SBBSegmentedButtonStyle get effectiveStyle {
    final themeData = Theme.of(context).sbbSegmentedButtonTheme;
    final themeStyle = themeData?.style;
    return widget.style?.merge(themeStyle) ?? themeStyle ?? const SBBSegmentedButtonStyle();
  }

  Set<WidgetState> get _states => {};

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: DefaultSBBSegmentedButtonThemeData.defaultButtonHeight),
      child: Stack(
        children: [
          _backgroundLayer(),
          _indicatorLayer(),
          _foregroundLayer(),
        ],
      ),
    );
  }

  Widget _backgroundLayer() {
    final style = effectiveStyle;
    final backgroundColor = style.backgroundColor?.resolve(_states) ?? SBBColors.milk;
    final borderColor = style.borderColor?.resolve(_states);

    final List<Widget> children = [];
    for (var i = 0; i < widget.segments.length; i++) {
      final segment = widget.segments[i];
      children.add(
        Expanded(
          child: Material(
            color: SBBColors.transparent,
            child: InkWell(
              customBorder: SBBSegmentedButtonStyle.shape,
              onTap: segment.value != widget.selected ? () => widget.onSelectionChanged(segment.value) : null,
            ),
          ),
        ),
      );
    }
    return ExcludeSemantics(
      child: Container(
        margin: const .all(1.0),
        decoration: ShapeDecoration(
          shape: _shapeWithBorder(borderColor),
          color: backgroundColor,
        ),
        child: Row(children: children),
      ),
    );
  }

  Widget _indicatorLayer() {
    final style = effectiveStyle;
    final selectedStates = {..._states, WidgetState.selected};
    final backgroundColor = style.backgroundColor?.resolve(selectedStates) ?? SBBColors.milk;
    final borderColor = style.borderColor?.resolve(selectedStates);

    final buttonCount = widget.segments.length;
    final alignmentX = buttonCount <= 1 ? 0.0 : -1 + 2 * _selectedIndex / (buttonCount - 1);

    return ExcludeSemantics(
      child: AnimatedAlign(
        alignment: Alignment(alignmentX, 0),
        duration: kThemeAnimationDuration,
        curve: Curves.easeInOut,
        child: FractionallySizedBox(
          widthFactor: 1.0 / buttonCount,
          child: Container(
            decoration: ShapeDecoration(
              shape: _shapeWithBorder(borderColor),
            ),
            child: Material(
              shape: SBBSegmentedButtonStyle.shape,
              color: backgroundColor,
              child: InkWell(
                customBorder: SBBSegmentedButtonStyle.shape,
                onTap: () => widget.onSelectionChanged(widget.selected),
              ),
            ),
          ),
        ),
      ),
    );
  }

  StadiumBorder _shapeWithBorder(Color? borderColor) {
    return SBBSegmentedButtonStyle.shape.copyWith(
      side: borderColor != null ? BorderSide(color: borderColor) : BorderSide.none,
    );
  }

  Widget _foregroundLayer() {
    final loc = Localizations.of(context, MaterialLocalizations);
    return IgnorePointer(
      child: Row(
        children: widget.segments.mapIndexed((i, segment) {
          final selected = segment.value == widget.selected;
          return Expanded(
            child: Semantics(
              focusable: true,
              selected: selected,
              button: !selected,
              hint: loc.tabLabel(tabIndex: i + 1, tabCount: widget.segments.length),
              child: Container(
                padding: const .symmetric(horizontal: 4),
                alignment: .center,
                child: _buildSegmentContent(segment, selected),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSegmentContent(SBBButtonSegment<T> segment, bool selected) {
    Widget? leading = segment.leading;
    if (leading == null && segment.leadingIconData != null) {
      leading = Icon(segment.leadingIconData);
    }

    Widget? label = segment.label;
    if (label == null && segment.labelText != null) {
      label = Text(segment.labelText!, overflow: .ellipsis, maxLines: 1);
    }

    // add styling and foregroundColor
    final themeData = Theme.of(context).sbbSegmentedButtonTheme;
    final style = effectiveStyle;
    final effectiveSegmentStyle = style.segmentStyle?.merge(segment.style) ?? segment.style;
    final states = {..._states, if (selected) WidgetState.selected};
    final foregroundColor = effectiveSegmentStyle?.foregroundColor?.resolve(states) ?? SBBColors.green;
    final resolvedTextStyle = effectiveSegmentStyle?.textStyle?.resolve(states);
    final effectiveLeadingGapWidth =
        widget.leadingHorizontalGapWidth ?? themeData?.leadingHorizontalGapWidth ?? SBBSpacing.xxSmall;

    leading = _addDefaultAncestorWithResolved(
      child: leading,
      foregroundColor: foregroundColor,
      textStyle: resolvedTextStyle,
    );

    label = _addDefaultAncestorWithResolved(
      child: label,
      foregroundColor: foregroundColor,
      textStyle: resolvedTextStyle,
    );

    Widget child;
    if (label != null && leading != null) {
      child = Row(
        mainAxisSize: .min,
        spacing: effectiveLeadingGapWidth,
        children: [
          leading,
          Flexible(child: label),
        ],
      );
    } else {
      child = label ?? leading!; // asserted that one of it is non null
    }

    return child;
  }

  Widget? _addDefaultAncestorWithResolved({
    Widget? child,
    required Color? foregroundColor,
    TextStyle? textStyle,
  }) {
    if (child == null) return null;

    final resolvedTextStyle = textStyle?.copyWith(color: foregroundColor) ?? TextStyle(color: foregroundColor);

    child = DefaultTextStyle.merge(
      style: resolvedTextStyle,
      child: IconTheme.merge(
        data: IconThemeData(color: foregroundColor),
        child: child,
      ),
    );
    return child;
  }
}

/// Creates the filled style variant of [SBBSegmentedButton].
///
/// Semantics and behavior are identical to [SBBSegmentedButton]; the only
/// difference is that the segmented button styling is adjusted to work on colored background.
///
/// Use [SBBSegmentedButtonThemeData.filledStyle] to override the styling for all filled variants
/// in the current Theme context.
class SBBSegmentedButtonFilled<T> extends SBBSegmentedButton<T> {
  SBBSegmentedButtonFilled({
    super.key,
    required super.segments,
    required super.selected,
    required super.onSelectionChanged,
    super.style,
  });

  @override
  State<SBBSegmentedButton<T>> createState() => _SBBSegmentedButtonStateBoxed();
}

class _SBBSegmentedButtonStateBoxed<T> extends _SBBSegmentedButtonState<T> {
  @override
  SBBSegmentedButtonStyle get effectiveStyle {
    final themeData = Theme.of(context).sbbSegmentedButtonTheme;
    final themeStyle = themeData?.filledStyle;
    return widget.style?.merge(themeStyle) ?? themeStyle ?? const SBBSegmentedButtonStyle();
  }
}
