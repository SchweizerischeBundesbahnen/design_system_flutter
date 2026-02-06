import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import '../sbb_internal.dart';

// TODO: add SBBSegmentedButtonStyle with inner style
// TODO: add SBBSegmentedButtonThemeData
// TODO: improve docs
// TODO: add migration guideline & readme

/// The SBB Segmented-Button.
/// Use according to [documentation](https://digital.sbb.ch/de/design-system/mobile/components/segmented-button/).
///
/// See also:
///
/// * [SBBRadioListItem] and [SBBRadio], a widget with semantics
/// similar to [SBBSegmentedButton].
/// * [SBBSlider], for selecting a value in a range.
/// * [SBBCheckboxListItem], [SBBCheckbox] and [SBBSwitch], for toggling a
/// particular value on or off.
class SBBSegmentedButton<T> extends StatefulWidget {
  const SBBSegmentedButton({
    super.key,
    required this.segments,
    required this.selected,
    required this.onSelectionChanged,
  }) : assert(segments.length > 0, 'At least one segment must be provided.');

  /// Descriptions of the segments in the button.
  final List<SBBButtonSegment<T>> segments;

  /// The currently selected value.
  final T selected;

  /// The function that is called when the selection changes.
  final ValueChanged<T> onSelectionChanged;

  @override
  SegmentedButtonState<T> createState() => SegmentedButtonState<T>();
}

class SegmentedButtonState<T> extends State<SBBSegmentedButton<T>> {
  static const _borderRadius = BorderRadius.all(Radius.circular(22));

  int get _selectedIndex => widget.segments.indexWhere((segment) => segment.value == widget.selected);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SBBInternal.defaultSegmentedButtonHeight,
      child: Stack(
        children: [
          _buildBackgroundLayer(),
          _buildIndicatorLayer(),
          _buildForegroundLayer(),
        ],
      ),
    );
  }

  Widget _buildBackgroundLayer() {
    final List<Widget> children = [];
    for (var i = 0; i < widget.segments.length; i++) {
      final segment = widget.segments[i];
      children.add(
        Expanded(
          child: Material(
            color: SBBColors.transparent,
            child: InkWell(
              customBorder: const RoundedRectangleBorder(borderRadius: _borderRadius),
              onTap: segment.value != widget.selected ? () => widget.onSelectionChanged(segment.value) : null,
            ),
          ),
        ),
      );
    }
    return ExcludeSemantics(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: SBBColors.milk, // style?.defaultStyle?.backgroundColor,
              border: Border.all(color: SBBColors.green),
              borderRadius: _borderRadius,
            ),
          ),
          Row(children: children),
        ],
      ),
    );
  }

  Widget _buildIndicatorLayer() {
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
            decoration: BoxDecoration(
              borderRadius: _borderRadius,
              border: Border.all(color: SBBColors.green),
            ),
            child: Material(
              borderRadius: _borderRadius,
              color: SBBColors.green,
              child: InkWell(
                borderRadius: _borderRadius,
                onTap: () => widget.onSelectionChanged(widget.selected),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForegroundLayer() {
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
                padding: const EdgeInsets.symmetric(horizontal: 4),
                alignment: Alignment.center,
                child: _buildSegmentContent(segment, selected),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSegmentContent(SBBButtonSegment<T> segment, bool selected) {
    final effectiveStyle = segment.style;

    // If custom label is provided, use it
    if (segment.label != null) {
      if (segment.leading != null) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            segment.leading!,
            const SizedBox(width: 4.0),
            Flexible(child: segment.label!),
          ],
        );
      }
      return segment.label!;
    }

    // If labelText is provided, render with style
    if (segment.labelText != null) {
      final textWidget = Text(
        segment.labelText!,
        maxLines: 1,
        // style: effectiveStyle.getTextStyle(selected),
      );

      if (segment.leadingIconData != null) {
        return Semantics(
          label: segment.labelText,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(segment.leadingIconData),
              const SizedBox(width: 4.0),
              Flexible(child: ExcludeSemantics(child: textWidget)),
            ],
          ),
        );
      }

      return textWidget;
    }

    // If only leadingIconData is provided
    if (segment.leadingIconData != null) {
      return Semantics(
        label: segment.value.toString(),
        child: Icon(segment.leadingIconData),
      );
    }

    // If only leading is provided
    if (segment.leading != null) {
      return segment.leading!;
    }

    // Fallback
    return const SizedBox.shrink();
  }
}
