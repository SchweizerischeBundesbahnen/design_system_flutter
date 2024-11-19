import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// The SBB Checkbox. Use according to documentation.
///
/// Consider using [SBBCheckboxListItem] instead of this Widget.
///
/// The checkbox itself does not maintain any state. Instead, when the state of
/// the checkbox changes, the widget calls the [onChanged] callback. Most
/// widgets that use a checkbox will listen for the [onChanged] callback and
/// rebuild the checkbox with a new [value] to update the visual appearance of
/// the checkbox.
///
/// The checkbox can optionally display three values - true, false, and null -
/// if [tristate] is true. When [value] is null a dash is displayed. By default
/// [tristate] is false and the checkbox's [value] must be true or false.
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// See also:
///
/// * [SBBCheckboxListItem], which builds this Widget as a part of a List Item
/// so that you can give the checkbox a label, a leading icon and a trailing
/// Widget.
/// * [SBBSwitch], a widget with semantics similar to [SBBCheckbox].
/// * [SBBRadioButton], for selecting among a set of explicit values.
/// * [SBBSegmentedButton], for selecting among a set of explicit values.
/// * [SBBSlider], for selecting a value in a range.
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/checkbox>
class SBBCheckbox extends StatefulWidget {
  /// Creates a SBB Checkbox.
  ///
  /// The checkbox itself does not maintain any state. Instead, when the state
  /// of the checkbox changes, the widget calls the [onChanged] callback. Most
  /// widgets that use a checkbox will listen for the [onChanged] callback and
  /// rebuild the checkbox with a new [value] to update the visual appearance of
  /// the checkbox.
  ///
  /// The following arguments are required:
  ///
  /// * [value], which determines whether the checkbox is checked. The [value]
  ///   can only be null if [tristate] is true.
  /// * [onChanged], which is called when the value of the checkbox should
  ///   change. It can be set to null to disable the checkbox.
  ///
  /// The values of [tristate] and [autofocus] must not be null.
  const SBBCheckbox({
    super.key,
    required this.value,
    this.tristate = false,
    required this.onChanged,
    this.padding,
  })  : assert(tristate || value != null);

  /// Whether this checkbox is checked.
  ///
  /// If [tristate] is false (the default), [value] must not be null.
  /// If [tristate] is true, SBBCheckbox displays a dash when [value] is null.
  final bool? value;

  /// Called when the value of the checkbox should change.
  ///
  /// The checkbox passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the checkbox with the new
  /// value.
  ///
  /// If this callback is null, the checkbox will be displayed as disabled
  /// and will not respond to input gestures.
  ///
  /// When the checkbox is tapped, if [tristate] is false (the default) then
  /// the [onChanged] callback will be applied to `!value`. If [tristate] is
  /// true this callback cycle from false to true to null.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// SBBCheckbox(
  ///   value: _throwShotAway,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _throwShotAway = newValue;
  ///     });
  ///   },
  /// )
  /// ```
  final ValueChanged<bool?>? onChanged;

  /// If true the checkbox's [value] can be true, false, or null.
  ///
  /// SBBCheckbox displays a dash when its value is null.
  ///
  /// When a tri-state checkbox ([tristate] is true) is tapped, its [onChanged]
  /// callback will be applied to true if the current value is false, to null if
  /// value is true, and to false if value is null (i.e. it cycles through false
  /// => true => null => false when tapped).
  ///
  /// If tristate is false (the default), [value] must not be null.
  final bool tristate;

  final EdgeInsetsGeometry? padding;

  @override
  SBBCheckboxState createState() => SBBCheckboxState();
}

class SBBCheckboxState extends State<SBBCheckbox>
    with SingleTickerProviderStateMixin {
  static const _outerSquareSize = 20.0;
  static const _outerSquareBorderRadius = 6.0;

  static const _checkLongLineHeight = 2.2;
  static const _checkLongLineWidth = 7.8;
  static const _checkLongLineLeftMargin = 1.6;
  static const _checkShortLineHeight = 5.3;
  static const _checkShortLineWidth = 2.2;
  static const _checkBorderRadius = 0.3;
  static const _checkBottomPadding =
      2.192; // result of math.sqrt(math.pow(_checkShortHeight - _checkLongHeight, 2) / 2);
  static const _checkAnimationThreshold = 1.0 /
      (_checkLongLineWidth + _checkLongLineLeftMargin + _checkShortLineHeight) *
      _checkShortLineHeight;

  static const _tristateHeight = 3.0;
  static const _tristateWidth = 11.0;
  static const _tristateBorderRadius = 0.5;

  late Animation<double> _animation;
  late AnimationController _controller;

  double _checkShortLineAnimationValue = 0.0;
  double _checkLongLineAnimationValue = 0.0;
  double _tristateAnimationValue = 0.0;

  bool? oldValue;
  bool? currentValue;

  @override
  void initState() {
    oldValue = false;
    currentValue = widget.value;

    _controller = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      ),
    )..addListener(() => setState(() => _calculateAnimationValues()));
    if (widget.value != false) {
      _controller.value = _controller.upperBound;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(SBBCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      setState(() {
        oldValue = oldWidget.value;
        currentValue = widget.value;
      });
      if (widget.value == false) {
        _controller.value = 1.0;
        _controller.reverse();
      } else {
        _controller.value = 0.0;
        _controller.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).checkbox;
    final enabled = widget.onChanged != null;
    // TODO add semantics
    return Material(
      color: SBBColors.transparent,
      child: InkWell(
        splashFactory: InkRipple.splashFactory,
        customBorder: const CircleBorder(),
        splashColor: style?.basic?.backgroundColorHighlighted,
        focusColor: style?.basic?.backgroundColorHighlighted,
        highlightColor: SBBColors.transparent,
        hoverColor: SBBColors.transparent,
        onTap: enabled
            ? () {
                if (widget.value == true) {
                  widget.onChanged?.call(widget.tristate ? null : false);
                } else if (widget.value == false) {
                  widget.onChanged?.call(true);
                } else {
                  widget.onChanged?.call(false);
                }
              }
            : null,
        child: Center(
          child: Container(
            height: _outerSquareSize,
            width: _outerSquareSize,
            margin:
                widget.padding ?? const EdgeInsets.all(sbbDefaultSpacing / 2),
            decoration: outerBoxDecoration(context, enabled),
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: _checkBottomPadding),
                    child: Transform.rotate(
                      angle: -math.pi / 4,
                      child: SizedBox(
                        height: _checkShortLineHeight,
                        width: _checkLongLineWidth + _checkLongLineLeftMargin,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                height: _checkShortLineAnimationValue *
                                    _checkShortLineHeight,
                                width: _checkShortLineWidth,
                                decoration: tickBoxDecoration(context, enabled),
                              ),
                            ),
                            Positioned(
                              left: _checkLongLineLeftMargin,
                              bottom: 0,
                              child: Container(
                                height: _checkLongLineHeight,
                                width: _checkLongLineAnimationValue *
                                    _checkLongLineWidth,
                                decoration: tickBoxDecoration(context, enabled),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: _tristateHeight,
                    width: _tristateAnimationValue * _tristateWidth,
                    decoration: BoxDecoration(
                      color: enabled ? style?.color : style?.colorDisabled,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(_tristateBorderRadius),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration tickBoxDecoration(BuildContext context, bool enabled) {
    final style = SBBControlStyles.of(context).checkbox;
    return BoxDecoration(
      color: enabled ? style?.color : style?.colorDisabled,
      borderRadius: const BorderRadius.all(Radius.circular(_checkBorderRadius)),
    );
  }

  BoxDecoration outerBoxDecoration(BuildContext context, bool enabled) {
    final style = SBBControlStyles.of(context).checkbox;
    return BoxDecoration(
      color: enabled
          ? style?.basic?.backgroundColor
          : style?.basic?.backgroundColorDisabled,
      border: Border.fromBorderSide(
        BorderSide(
          color: (enabled
              ? style?.basic?.borderColor
              : style?.basic?.borderColorDisabled)!,
        ),
      ),
      borderRadius:
          const BorderRadius.all(Radius.circular(_outerSquareBorderRadius)),
    );
  }

  void _calculateAnimationValues() {
    var checkAnimationValue = 0.0;
    if (widget.tristate) {
      var animationValue1 = 0.0;
      var animationValue2 = 0.0;
      if (oldValue != false && currentValue != false) {
        animationValue1 = math.max(0, (1.0 - _animation.value) * 2.0 - 1.0);
        animationValue2 = math.max(0, (_animation.value - 0.5) * 2.0);
      } else {
        animationValue1 = _animation.value;
        animationValue2 = 0.0;
      }

      if (oldValue == true || (oldValue == false && currentValue == true)) {
        checkAnimationValue = animationValue1;
        _tristateAnimationValue = animationValue2;
      } else {
        _tristateAnimationValue = animationValue1;
        checkAnimationValue = animationValue2;
      }
    } else {
      checkAnimationValue = _animation.value;
    }

    _checkShortLineAnimationValue =
        math.min(1.0, checkAnimationValue / _checkAnimationThreshold);
    _checkLongLineAnimationValue = math.max(
        0.0,
        (checkAnimationValue - _checkAnimationThreshold) /
            (1.0 - _checkAnimationThreshold));
  }
}
