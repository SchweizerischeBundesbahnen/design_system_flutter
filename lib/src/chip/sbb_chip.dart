import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

const EdgeInsets _badgeMargin = EdgeInsets.only(right: 4.0);
const Size _badgeSize = Size(24.0, 24.0);

/// TODO: create SBBChipThemeData and SBBChipStyle with WidgetStateProperties
/// TODO: SBBChipStyle should contain: borderColor, backgroundColor, labelForegroundColor, trailingForegroundColor, labelTextStyle, trailingTextStyle, trailingBackgroundColor, overlayColor, geometries as getter
/// TODO: convert to stateful widget with WidgetStatesController for resolving all colors from style
/// TODO: handle didUpdateWidget correct (selected) changed or (onChanged == null) with WidgetStatesController

/// The SBB Chip.
///
///  The widget itself does not hold selection state: when the chip is tapped it
/// calls [onChanged] with the new value and relies on its parent to rebuild it
/// with an updated [selected] value.
///
/// Provide either [label] for custom content or [labelText] for simple text
/// content with the standard design. These parameters are mutually exclusive.
///
/// If [onChanged] is null the chip is displayed as disabled and will not
/// respond to input gestures.
///
/// See also:
///
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=129-3181)
class SBBChip extends StatelessWidget {
  /// Creates an SBB Chip.
  ///
  /// The following arguments are required:
  ///
  /// * [onChanged] which is called when the chip should toggle its [selected]
  ///   state. If null the chip is disabled.
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
  }) : assert(labelText == null || label == null, 'Cannot provide both labelText and label!'),
       assert(labelText != null || label != null, 'One of labelText or label must be set!'),
       assert(trailingText == null || trailing == null, 'Cannot provide both badgeText and trailing!');

  /// Called when [selected] should change.
  ///
  /// The chip calls this callback with the new boolean value but does not
  /// change its own internal state. The parent should update the [selected]
  /// value and rebuild the chip accordingly.
  ///
  /// If this callback is null, the chip is displayed as disabled and will not
  /// respond to taps.
  final ValueChanged<bool>? onChanged;

  /// Whether this chip is selected.
  ///
  /// If false, the [trailing] widget or a default badge with [trailingText] will
  /// be shown. If true, the [trailing] widget is shown if provided, otherwise
  /// a default badge with a [SBBIcons.cross_small] icon is shown.
  final bool selected;

  /// A custom widget displayed as the chip's content.
  ///
  /// For simple text labels, prefer [labelText].
  ///
  /// Cannot be used together with [labelText].
  final Widget? label;

  /// Text string to display as the chip's label using the standard design.
  ///
  /// The chip will be styled according to the SBB design system.
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

  /// Text string to display within the chip's trailing badge using the standard design.
  ///
  /// If this and [trailing] is null, the chip will not display a trailing widget.
  ///
  /// Cannot be used together with [trailing].
  final String? trailingText;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).chip!;
    return Material(
      shape: StadiumBorder(side: BorderSide(color: _disabled ? style.disabledBorderColor! : style.borderColor!)),
      child: InkWell(
        customBorder: StadiumBorder(),
        onTap: onChanged != null ? () => onChanged?.call(!selected) : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            label ?? _defaultLabel(style),
            AnimatedSwitcher(
              duration: Durations.short3,
              child: trailing ?? (selected ? _defaultSelected(style) : _defaultUnselected(style)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _defaultLabel(SBBChipStyle style) {
    final labelTextStyle = _disabled ? style.labelTextStyle!.textStyleDisabled : style.labelTextStyle!.textStyle;
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: 12.0,
        ),
        child: Text(labelText!, overflow: TextOverflow.ellipsis, style: labelTextStyle, maxLines: 1),
      ),
    );
  }

  Widget _defaultUnselected(SBBChipStyle style) {
    final badgeTextStyle = _disabled ? style.badgeTextStyle!.textStyleDisabled : style.badgeTextStyle!.textStyle;
    if (trailingText == null) return SizedBox.shrink();

    return _badgeCircle(
      key: ValueKey(trailingText),
      child: Center(
        child: Baseline(
          baseline: badgeTextStyle!.fontSize!,
          baselineType: TextBaseline.ideographic,
          child: Text(trailingText ?? '', style: badgeTextStyle, maxLines: 1),
        ),
      ),
      color: _disabled ? style.disabledBadgeColor! : style.badgeColor!,
    );
  }

  Widget _defaultSelected(SBBChipStyle style) {
    return _badgeCircle(
      key: ValueKey(SBBIcons.cross_small),
      child: Icon(
        SBBIcons.cross_small,
        color: _disabled ? style.disabledUnselectButtonIconColor! : style.unselectButtonIconColor!,
      ),
      color: _disabled ? style.disabledUnselectButtonColor! : style.unselectButtonColor!,
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

  bool get _disabled => onChanged == null;
}
