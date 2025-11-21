import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

const _kBorderWidth = 1.0;
const _kInnerEdgeLength = SBBCheckbox.width - 2 * _kBorderWidth;
const _kCheckboxRadius = _kInnerEdgeLength / 3.0;

/// The SBB Checkbox. Use according to documentation.
///
/// Consider using [SBBCheckboxListItem] instead of this Widget.
///
/// The [SBBCheckbox] is very similar in its behavior to the Material [Checkbox]:
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
/// * [SBBRadio], for selecting among a set of explicit values.
/// * [SBBSegmentedButton], for selecting among a set of explicit values.
/// * [SBBSlider], for selecting a value in a range.
/// * <https://digital.sbb.ch/de/design-system/mobile/components/checkbox/>
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
  /// The value of [tristate] must not be null.
  const SBBCheckbox({
    super.key,
    required this.value,
    this.tristate = false,
    required this.onChanged,
    this.padding = const EdgeInsets.all(sbbDefaultSpacing * 0.5),
    this.semanticLabel,
  }) : assert(tristate || value != null);

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
  /// [SBBCheckbox] displays a dash when its value is null.
  ///
  /// When a tri-state activated checkbox is tapped, its [onChanged]
  /// callback will be applied to:
  /// * true if the current value is false
  /// * to null if value is true
  /// * and to false if value is null
  ///
  /// In other words: the value of the [SBBCheckbox] will cycle through:
  /// false => true => null => false.
  ///
  /// If tristate is false (the default), [value] must not be null.
  final bool tristate;

  /// The padding between the hit test area of the [SBBCheckbox] and the
  /// rounded shape with the visual check mark.
  ///
  /// By increasing this padding, the area receiving tap events for the
  /// [SBBCheckbox] increases.
  ///
  /// Defaults to [sbbDefaultSpacing] * 0.5.
  final EdgeInsetsGeometry padding;

  /// The side length of a [SBBCheckbox] widget
  /// with [padding] equal to [EdgeInsets.zero].
  static const double width = 20.0;

  /// The semantic label for the [SBBCheckbox] that will be announced by screen readers.
  ///
  /// This is announced by assistive technologies (e.g TalkBack/VoiceOver).
  ///
  /// This label does not show in the UI.
  final String? semanticLabel;

  @override
  State<SBBCheckbox> createState() => _SBBCheckboxState();
}

class _SBBCheckboxState extends State<SBBCheckbox> with TickerProviderStateMixin, ToggleableStateMixin {
  final _SBBCheckboxPainter _painter = _SBBCheckboxPainter();
  bool? _previousValue;

  @override
  void initState() {
    super.initState();
    _previousValue = widget.value;
  }

  @override
  void didUpdateWidget(SBBCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousValue = oldWidget.value;
      animateToValue();
    }
  }

  @override
  void dispose() {
    _painter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size resolvedSize = _addPaddingToDefaultWidth(widget.padding);

    final style = SBBControlStyles.of(context).checkbox!;
    Color? resolvedBackgroundColor = _resolveBackgroundColor(style);
    Color resolvedCheckColor = _resolveTickColor(style);
    Color resolvedBorderColor = _resolveBorderColor(style);

    return Material(
      color: resolvedBackgroundColor,
      borderRadius: BorderRadius.circular(_kCheckboxRadius),
      child: Semantics(
        label: widget.semanticLabel,
        checked: widget.value ?? false,
        mixed: widget.tristate ? widget.value == null : null,
        child: SizedBox.fromSize(
          size: resolvedSize,
          child: buildToggleable(
            mouseCursor: WidgetStateMouseCursor.clickable,
            size: resolvedSize,
            painter:
                _painter
                  ..position = position
                  ..reaction = reaction
                  ..value = value
                  ..previousValue = _previousValue
                  ..checkColor = resolvedCheckColor
                  ..boxBorderColor = resolvedBorderColor,
          ),
        ),
      ),
    );
  }

  @override
  ValueChanged<bool?>? get onChanged => widget.onChanged;

  @override
  bool get tristate => widget.tristate;

  @override
  bool? get value => widget.value;

  Size _addPaddingToDefaultWidth(EdgeInsetsGeometry resolvedPadding) => Size(
    SBBCheckbox.width + resolvedPadding.horizontal,
    SBBCheckbox.width + resolvedPadding.vertical,
  );

  Color? _resolveBackgroundColor(SBBControlStyle style) =>
      isInteractive ? style.basic?.backgroundColor : style.basic?.backgroundColorDisabled;

  Color _resolveTickColor(SBBControlStyle style) => isInteractive ? style.color! : style.colorDisabled!;

  Color _resolveBorderColor(SBBControlStyle style) {
    return isInteractive ? style.basic!.borderColor! : style.basic!.borderColorDisabled!;
  }
}

/// The [_SBBCheckboxPainter] is responsible for drawing the dash, check and the rounded box
/// surrounding the two.
///
/// It draws the check as two rounded overlapped rectangles, that are rotated by 45 degrees.
///
/// The important points are marked as x and y below. They are interpolated with time to create the
/// animation (x in the horizontal direction - y in the vertical direction).
///
///          |----|
///          |    |
///          |    |
///          |    |
///          |    |
///     |----y    |  // y moves up
///     |         |
///     |         |
///     x---------|
///     -->         // x moves to the right
///
/// The painter is a simplified version of the Material [_CheckboxPainter].
class _SBBCheckboxPainter extends ToggleablePainter {
  bool? get value => _value;
  bool? _value;

  set value(bool? value) {
    if (_value == value) {
      return;
    }
    _value = value;
    notifyListeners();
  }

  bool? get previousValue => _previousValue;
  bool? _previousValue;

  set previousValue(bool? value) {
    if (_previousValue == value) {
      return;
    }
    _previousValue = value;
    notifyListeners();
  }

  Color get checkColor => _checkColor!;
  Color? _checkColor;

  set checkColor(Color newValue) {
    if (newValue == _checkColor) {
      return;
    }
    _checkColor = newValue;
    notifyListeners();
  }

  Color get boxBorderColor => _boxBorderColor!;
  Color? _boxBorderColor;

  set boxBorderColor(Color newValue) {
    if (newValue == _boxBorderColor) {
      return;
    }
    _boxBorderColor = newValue;
    notifyListeners();
  }

  double get _edgeHalf => _kInnerEdgeLength * 0.5;

  Radius get _markRadius => Radius.circular(0.02 * _kInnerEdgeLength);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset origin = size / 2.0 - const Size.square(_kInnerEdgeLength) / 2.0 as Offset;
    final double tNormalized = switch (position.status) {
      AnimationStatus.forward || AnimationStatus.completed => position.value,
      AnimationStatus.reverse || AnimationStatus.dismissed => 1.0 - position.value,
    };

    final Paint checkPaint = _createCheckPaint();
    final Paint boxBorderPaint = _createBoxPaint();

    _drawOuterRoundedBox(canvas, origin, boxBorderPaint);

    // Four cases: false to null, false to true, null to false, true to false
    if (previousValue == false || value == false) {
      final double t = value == false ? 1.0 - tNormalized : tNormalized;
      if (previousValue == null || value == null) {
        _drawDash(canvas, origin, t, checkPaint);
      } else {
        _drawCheck(canvas, origin, t, checkPaint);
      }
    } else {
      // Two cases: null to true, true to null
      if (tNormalized <= 0.5) {
        final double tShrink = 1.0 - tNormalized * 2.0;
        if (previousValue ?? false) {
          _drawCheck(canvas, origin, tShrink, checkPaint);
        } else {
          _drawDash(canvas, origin, tShrink, checkPaint);
        }
      } else {
        final double tExpand = (tNormalized - 0.5) * 2.0;
        if (value ?? false) {
          _drawCheck(canvas, origin, tExpand, checkPaint);
        } else {
          _drawDash(canvas, origin, tExpand, checkPaint);
        }
      }
    }
  }

  Paint _createCheckPaint() => Paint()..color = checkColor;

  Paint _createBoxPaint() {
    return Paint()
      ..color = boxBorderColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
  }

  void _drawCheck(Canvas canvas, Offset origin, double t, Paint paint) {
    // Animate the check mark as two overlapped rounded rectangles
    assert(t >= 0.0 && t <= 1.0);

    _rotateCanvasBy45Degrees(canvas, origin);
    if (t < 0.5) {
      _drawCheckShortSide(canvas, origin, 2 * t, paint);
    } else {
      _drawCheckShortSide(canvas, origin, 1.0, paint);
      _drawCheckLongSide(canvas, origin, (t - 0.5) * 2, paint);
    }
  }

  void _rotateCanvasBy45Degrees(Canvas canvas, Offset origin) {
    canvas.translate(origin.dx + _edgeHalf, origin.dy + _edgeHalf);
    canvas.rotate(math.pi / 4);
    canvas.translate(-(_edgeHalf + origin.dx), -(_edgeHalf + origin.dy));
  }

  void _drawCheckShortSide(Canvas canvas, Offset origin, double t, Paint paint) {
    const xStart = 0.3 * _kInnerEdgeLength;
    const xEnd = 0.6 * _kInnerEdgeLength;
    final double xAtT = lerpDouble(xStart, xEnd, t)!;

    final start = Offset(xStart, 0.6 * _kInnerEdgeLength) + origin;
    final end = Offset(xAtT, 0.7 * _kInnerEdgeLength) + origin;

    final rect = RRect.fromRectAndRadius(Rect.fromPoints(start, end), _markRadius);
    canvas.drawRRect(rect, paint);
  }

  void _drawCheckLongSide(Canvas canvas, Offset origin, double t, Paint paint) {
    const yStart = _kInnerEdgeLength * 0.7;
    const yEnd = 0.2 * _kInnerEdgeLength;
    final double yAtT = lerpDouble(yStart, yEnd, t)!;

    final start = Offset(0.5 * _kInnerEdgeLength, yAtT) + origin;
    final end = Offset(0.6 * _kInnerEdgeLength, yStart) + origin;

    final rect = RRect.fromRectAndRadius(Rect.fromPoints(start, end), _markRadius);
    canvas.drawRRect(rect, paint);
  }

  void _drawDash(Canvas canvas, Offset origin, double t, Paint paint) {
    // Animate the horizontal rounded rectangle from the mid point outwards.
    assert(t >= 0.0 && t <= 1.0);

    const double height = _kInnerEdgeLength * 0.15;
    final Offset center = Offset(_edgeHalf, _edgeHalf) + origin;

    final double drawWidth = lerpDouble(0, 0.6 * _kInnerEdgeLength, t)!;

    final Rect rect = Rect.fromCenter(center: center, width: drawWidth, height: height);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, _markRadius), paint);
  }

  void _drawOuterRoundedBox(Canvas canvas, Offset origin, Paint paint) {
    final Offset center = Offset(_edgeHalf + origin.dx, _edgeHalf + origin.dy);
    final Rect rect = Rect.fromCenter(
      center: center,
      width: _kInnerEdgeLength + _kBorderWidth,
      height: _kInnerEdgeLength + _kBorderWidth,
    );

    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(_kCheckboxRadius)), paint);
  }
}
