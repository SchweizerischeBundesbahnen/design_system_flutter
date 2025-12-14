import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/chip/chip.dart';

import '../../sbb_design_system_mobile.dart';

const EdgeInsets _badgeMargin = EdgeInsets.only(right: 4.0);
const Size _badgeSize = Size(24.0, 24.0);

/// The SBB Chip.
///
///  The widget itself does not hold selection state: when the chip.dart is tapped it
/// calls [onChanged] with the new value and relies on its parent to rebuild it
/// with an updated [selected] value.
///
/// Provide either [label] for custom content or [labelText] for simple text
/// content with the standard design. These parameters are mutually exclusive.
///
/// If [onChanged] is null the chip.dart is displayed as disabled and will not
/// respond to input gestures.
///
/// See also:
///
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=129-3181)
class SBBChip extends StatefulWidget {
  /// Creates an SBB Chip.
  ///
  /// The following arguments are required:
  ///
  /// * [onChanged] which is called when the chip.dart should toggle its [selected]
  ///   state. If null the chip.dart is disabled.
  /// * Either [label] or [labelText] must be provided. They are mutually
  ///   exclusive.
  ///
  /// [trailingText] and [trailing] are mutually exclusive — prefer [trailing] for
  /// custom trailing widgets, otherwise use [trailingText] to show the standard
  /// badge design.
  const SBBChip({
    super.key,
    required this.onChanged,
    this.selected = false,
    this.label,
    this.labelText,
    this.trailing,
    this.trailingText,
    this.style,
    this.focusNode,
  }) : assert(labelText == null || label == null, 'Cannot provide both labelText and label!'),
       assert(labelText != null || label != null, 'One of labelText or label must be set!'),
       assert(trailingText == null || trailing == null, 'Cannot provide both badgeText and trailing!');

  /// Called when [selected] should change.
  ///
  /// The chip.dart calls this callback with the new boolean value but does not
  /// change its own internal state. The parent should update the [selected]
  /// value and rebuild the chip.dart accordingly.
  ///
  /// If this callback is null, the chip.dart is displayed as disabled and will not
  /// respond to taps.
  final ValueChanged<bool>? onChanged;

  /// Whether this chip.dart is selected.
  ///
  /// If false, the [trailing] widget or a default badge with [trailingText] will
  /// be shown. If true, the [trailing] widget is shown if provided, otherwise
  /// a default badge with a [SBBIcons.cross_small] icon is shown.
  final bool selected;

  /// A custom widget displayed as the chip.dart's content.
  ///
  /// For simple text labels, prefer [labelText].
  ///
  /// Cannot be used together with [labelText].
  final Widget? label;

  /// Text string to display as the chip.dart's label using the standard design.
  ///
  /// The chip.dart will be styled according to the SBB design system.
  ///
  /// Cannot be used together with [label].
  final String? labelText;

  /// A custom widget displayed after the label.
  ///
  /// Use this for custom trailing widgets. This will override the default
  /// trailing widget regardless of [selected].
  ///
  /// Cannot be used together with [trailingText].
  final Widget? trailing;

  /// Text string to display within the chip.dart's trailing badge using the standard design.
  ///
  /// If this and [trailing] is null, the chip.dart will not display a trailing widget.
  ///
  /// Cannot be used together with [trailing].
  final String? trailingText;

  /// Customizes this chip appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBChipThemeData.style] of the theme found in [context].
  final SBBChipStyle? style;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  @override
  State<SBBChip> createState() => _SBBChipState();
}

class _SBBChipState extends State<SBBChip> {
  late WidgetStatesController _statesController;

  @override
  void initState() {
    super.initState();
    _statesController = WidgetStatesController();
    _updateStatesController();
  }

  @override
  void didUpdateWidget(SBBChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.onChanged != oldWidget.onChanged || widget.selected != oldWidget.selected) {
      _updateStatesController();
    }
  }

  void _updateStatesController() {
    _statesController.update(WidgetState.disabled, widget.onChanged == null);
    _statesController.update(WidgetState.selected, widget.selected);
  }

  @override
  void dispose() {
    _statesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeStyle = Theme.of(context).sbbChipTheme!.style!;
    final effectiveStyle = themeStyle.merge(widget.style);
    final states = _statesController.value;

    final borderColor = effectiveStyle.borderColor?.resolve(states) ?? SBBColors.granite;
    final backgroundColor = effectiveStyle.backgroundColor?.resolve(states) ?? SBBColors.white;
    final labelForegroundColor = effectiveStyle.labelForegroundColor?.resolve(states) ?? SBBColors.black;
    final trailingForegroundColor = effectiveStyle.trailingForegroundColor?.resolve(states) ?? SBBColors.white;
    final labelTextStyle = effectiveStyle.labelTextStyle?.resolve(states);
    final trailingTextStyle = effectiveStyle.trailingTextStyle?.resolve(states);
    final trailingBackgroundColor = effectiveStyle.trailingBackgroundColor?.resolve(states) ?? SBBColors.red;

    return Material(
      color: backgroundColor,
      shape: StadiumBorder(side: BorderSide(color: borderColor)),
      child: InkWell(
        customBorder: StadiumBorder(),
        onTap: widget.onChanged != null ? () => widget.onChanged?.call(!widget.selected) : null,
        statesController: _statesController,
        focusNode: widget.focusNode,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultTextStyle.merge(
              style: labelTextStyle?.copyWith(color: labelForegroundColor),
              child: _label(labelTextStyle),
            ),
            DefaultTextStyle.merge(
              style: trailingTextStyle?.copyWith(color: trailingForegroundColor),
              child: IconTheme.merge(
                data: IconThemeData(color: trailingForegroundColor),
                child: AnimatedSwitcher(
                  duration: Durations.short3,
                  child: _trailing(trailingBackgroundColor, trailingTextStyle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(TextStyle? labelTextStyle) => widget.label ?? _defaultLabel(labelTextStyle);

  Widget _trailing(Color trailingBackgroundColor, TextStyle? trailingTextStyle) {
    return widget.trailing ??
        (widget.selected
            ? _defaultSelected(trailingBackgroundColor)
            : _defaultUnselected(trailingBackgroundColor, trailingTextStyle));
  }

  Widget _defaultLabel(TextStyle? labelTextStyle) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: 12.0,
        ),
        child: Text(widget.labelText!, overflow: TextOverflow.ellipsis, style: labelTextStyle, maxLines: 1),
      ),
    );
  }

  Widget _defaultUnselected(Color trailingBackgroundColor, TextStyle? badgeTextStyle) {
    if (widget.trailingText == null) return SizedBox.shrink();

    return _badgeCircle(
      key: ValueKey(widget.trailingText),
      child: Center(
        child: Baseline(
          baseline: badgeTextStyle?.fontSize ?? 14.0,
          baselineType: TextBaseline.ideographic,
          child: Text(widget.trailingText ?? '', maxLines: 1),
        ),
      ),
      color: trailingBackgroundColor,
    );
  }

  Widget _defaultSelected(Color trailingBackgroundColor) {
    return _badgeCircle(
      key: ValueKey(SBBIcons.cross_small),
      child: Icon(SBBIcons.cross_small),
      color: trailingBackgroundColor,
    );
  }

  Widget _badgeCircle({
    required Key key,
    required Widget child,
    required Color color,
  }) {
    return Container(
      key: key,
      margin: _badgeMargin,
      constraints: BoxConstraints.tight(_badgeSize),
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: child,
    );
  }
}
