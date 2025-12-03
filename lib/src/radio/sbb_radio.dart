import 'dart:ui';

import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// The size of the radio button.
const double _kRadioSize = 20.0;

/// The size of the inner circle when selected.
const double _kInnerCircleSize = 8.0;

/// The border width of the radio button.
const double _kBorderWidth = 1.0;

/// The default padding around the radio to increase the tappable area.
const EdgeInsets _kDefaultPadding = EdgeInsets.all(8.0);

/// The SBB Radio.
///
/// Consider using [SBBRadioListItem] instead of this Widget.
///
/// This widget builds a [RawRadio] painted in an SBB style.
///
/// Used to select between a number of mutually exclusive values. When one radio
/// button in a group is selected, the other radio buttons in the group cease to
/// be selected. The values are of type `T`, the type parameter of the
/// [SBBRadio] class. Enums are commonly used for this purpose.
///
/// This widget typically has an [SBBRadioGroup] ancestor, which takes in a
/// [SBBRadioGroup.groupValue], and the [SBBRadio] under it with matching [value]
/// will be selected.
///
/// The radio button itself does not maintain any state. The selection is managed
/// by the [SBBRadioGroup] ancestor. When a radio button is tapped, the group's
/// [SBBRadioGroup.onChanged] callback is invoked with this radio's [value].
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// See also:
///
/// * [SBBRadioGroup], which manages the state for a group of radio buttons.
/// * [SBBRadioListItem], which builds this widget as a part of a List
///   Item so that you can give the radio a label, a leading icon and a
///   trailing Widget.
/// * [SBBSegmentedButton], a widget with semantics similar to [SBBRadio].
/// * [SBBSlider], for selecting a value in a range.
/// * [SBBCheckbox] and [SBBSwitch], for toggling a particular value on or off.
class SBBRadio<T> extends StatefulWidget {
  /// Creates an SBB Radio.
  ///
  /// This widget typically has an [SBBRadioGroup] ancestor. The radio
  /// does not maintain state; the [SBBRadioGroup] manages the selection state
  /// for all radios in its subtree of the same type.
  ///
  /// The [value] is required and identifies this radio button within its group.
  ///
  /// The [padding] parameter controls the space around the radio button to
  /// increase the tappable area. Defaults to 8px on all sides.
  ///
  /// The [toggleable] parameter, when true, allows the radio to be deselected
  /// by tapping it again when it's already selected. This will call
  /// [SBBRadioGroup.onChanged] with null.
  ///
  /// The [enabled] parameter controls whether the radio is interactive. If null,
  /// the radio is enabled if there is an [SBBRadioGroup] ancestor with a non-null
  /// [SBBRadioGroup.onChanged] callback.
  const SBBRadio({
    super.key,
    required this.value,
    this.padding,
    this.toggleable = false,
    this.focusNode,
    this.autofocus = false,
    this.enabled,
    this.semanticLabel,
  });

  /// The value represented by this radio button.
  final T value;

  /// Enlarges the hittable area around the [SBBRadio].
  ///
  /// Defaults to 8px on all sides.
  final EdgeInsetsGeometry? padding;

  /// Set to true if this radio button is allowed to be returned to an
  /// indeterminate state by selecting it again when selected.
  ///
  /// To indicate returning to an indeterminate state, [SBBRadioGroup.onChanged]
  /// will be called with null.
  ///
  /// Defaults to false.
  final bool toggleable;

  /// An optional focus node to use for this radio button.
  final FocusNode? focusNode;

  /// True if this widget will be selected as the initial focus when no other
  /// node in its scope is currently focused.
  ///
  /// Defaults to false.
  final bool autofocus;

  /// Whether this radio button is enabled.
  ///
  /// If null, the radio is enabled if there is an [SBBRadioGroup] ancestor with
  /// a non-null [SBBRadioGroup.onChanged] callback.
  final bool? enabled;

  /// The semantic label for the [SBBRadio] that will be announced by screen readers.
  ///
  /// This is announced by assistive technologies (e.g TalkBack/VoiceOver).
  ///
  /// This label does not show in the UI.
  final String? semanticLabel;

  @override
  State<SBBRadio<T>> createState() => _SBBRadioState<T>();
}

class _SBBRadioState<T> extends State<SBBRadio<T>> with TickerProviderStateMixin, ToggleableStateMixin {
  final _SBBRadioPainter _painter = _SBBRadioPainter();
  FocusNode? _focusNode;
  RadioGroupRegistry<T>? _registry;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _registry = RadioGroup.maybeOf<T>(context);
    animateToValue();
  }

  @override
  void didUpdateWidget(SBBRadio<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      animateToValue();
    }
  }

  @override
  void dispose() {
    _painter.dispose();
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    final bool isDark = SBBBaseStyle.of(context).brightness == Brightness.dark;
    final bool effectiveEnabled = widget.enabled ?? (_registry?.onChanged != null);

    // Resolve colors based on state
    final Color fillColor = isDark ? SBBColors.charcoal : SBBColors.white;
    final Color borderColor = isDark ? SBBColors.graphite : SBBColors.granite;
    final Color innerCircleColor;
    if (effectiveEnabled) {
      innerCircleColor = SBBControlStyles.of(context).radioButton?.color ?? SBBColors.red;
    } else {
      innerCircleColor = isDark ? SBBColors.graphite : SBBColors.granite;
    }

    final EdgeInsetsGeometry effectivePadding = widget.padding ?? _kDefaultPadding;
    final Size effectiveSize = effectivePadding.inflateSize(const Size.square(_kRadioSize));

    return Semantics(
      label: widget.semanticLabel,
      child: RawRadio<T>(
        value: widget.value,
        mouseCursor: WidgetStateMouseCursor.clickable,
        toggleable: widget.toggleable,
        focusNode: _effectiveFocusNode,
        autofocus: widget.autofocus,
        groupRegistry: _registry,
        enabled: effectiveEnabled,
        builder: (BuildContext context, ToggleableStateMixin state) {
          return buildToggleable(
            mouseCursor: WidgetStateMouseCursor.clickable,
            size: effectiveSize,
            painter: _painter
              ..position = position
              ..reaction = reaction
              ..value = value
              ..isFocused = states.contains(WidgetState.focused)
              ..isHovered = states.contains(WidgetState.hovered)
              ..fillColor = fillColor
              ..borderColor = borderColor
              ..innerCircleColor = innerCircleColor,
          );
        },
      ),
    );
  }

  @override
  ValueChanged<bool?>? get onChanged {
    // The RawRadio handles calling the registry's onChanged
    return null;
  }

  @override
  bool get tristate => widget.toggleable;

  @override
  bool? get value => widget.value == _registry?.groupValue;
}

/// The [_SBBRadioPainter] is responsible for drawing the radio button with
/// custom SBB styling.
///
/// The radio consists of:
/// * An outer circle (20x20 px) with a 1px border
/// * An inner circle (8x8 px) that appears when selected
/// * A fill color for the outer circle background
///
/// The inner circle animates from the center, growing from 0 to 8x8 px during
/// the selection animation. The animation is controlled by the [position]
/// property inherited from [ToggleablePainter].
///
/// Colors:
/// * Fill color: white (light mode) / charcoal (dark mode)
/// * Border color: granite (light mode) / graphite (dark mode)
/// * Inner circle: primary color when enabled, granite/graphite when disabled
class _SBBRadioPainter extends ToggleablePainter {
  bool? get value => _value;
  bool? _value;

  set value(bool? value) {
    if (_value == value) {
      return;
    }
    _value = value;
    notifyListeners();
  }

  Color get fillColor => _fillColor!;
  Color? _fillColor;

  set fillColor(Color newValue) {
    if (newValue == _fillColor) return;
    _fillColor = newValue;
    notifyListeners();
  }

  Color get borderColor => _borderColor!;
  Color? _borderColor;

  set borderColor(Color newValue) {
    if (newValue == _borderColor) return;
    _borderColor = newValue;
    notifyListeners();
  }

  Color get innerCircleColor => _innerCircleColor!;
  Color? _innerCircleColor;

  set innerCircleColor(Color newValue) {
    if (newValue == _innerCircleColor) return;
    _innerCircleColor = newValue;
    notifyListeners();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);

    final Paint fillPaint = _createFillPaint();
    final Paint borderPaint = _createBorderPaint();
    final Paint innerCirclePaint = _createInnerCirclePaint();

    // fill
    canvas.drawCircle(center, _kRadioSize / 2.0, fillPaint);
    // border
    canvas.drawCircle(center, _kRadioSize / 2.0 - _kBorderWidth / 2.0, borderPaint);

    // inner circle
    if (value ?? false) {
      final double t = position.value;
      final double radius = lerpDouble(0.0, _kInnerCircleSize / 2.0, t)!;
      if (radius > 0) {
        canvas.drawCircle(center, radius, innerCirclePaint);
      }
    }
  }

  Paint _createFillPaint() {
    return Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
  }

  Paint _createBorderPaint() {
    return Paint()
      ..color = borderColor
      ..strokeWidth = _kBorderWidth
      ..style = PaintingStyle.stroke;
  }

  Paint _createInnerCirclePaint() {
    return Paint()
      ..color = innerCircleColor
      ..style = PaintingStyle.fill;
  }
}
