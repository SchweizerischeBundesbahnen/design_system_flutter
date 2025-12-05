import 'dart:ui';

import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

const EdgeInsets _defaultPadding = EdgeInsets.all(8.0);

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
    this.style,
    this.toggleable = false,
    this.focusNode,
    this.autofocus = false,
    this.enabled,
    this.semanticLabel,
  });

  /// The value represented by this radio button.
  final T value;

  /// Customizes this radio appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBRadioThemeData.style] of the theme found in [context].
  final SBBRadioStyle? style;

  /// Set to true if this radio button is allowed to be returned to an
  /// indeterminate state by selecting it again when selected.
  ///
  /// To indicate returning to an indeterminate state, [SBBRadioGroup.onChanged]
  /// will be called with null.
  ///
  /// Defaults to false.
  final bool toggleable;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether this radio is enabled.
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

class _SBBRadioState<T> extends State<SBBRadio<T>> {
  FocusNode? _focusNode;
  RadioGroupRegistry<T>? _registry;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _registry = RadioGroup.maybeOf<T>(context);
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    final bool effectiveEnabled = widget.enabled ?? (_registry?.onChanged != null);
    final SBBRadioStyle? themeStyle = Theme.of(context).sbbRadioTheme?.style;
    final EdgeInsetsGeometry effectivePadding =
        widget.style?.tapTargetPadding ?? themeStyle?.tapTargetPadding ?? _defaultPadding;

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
          return _SBBRadioPaint(
            toggleableState: state,
            style: widget.style,
            padding: effectivePadding,
          );
        },
      ),
    );
  }
}

/// The [_SBBRadioPaint] widget is responsible for resolving the effective style
/// and rendering the radio button with animation.
///
/// It's a stateful widget that manages the animation controller and painter.
class _SBBRadioPaint extends StatefulWidget {
  const _SBBRadioPaint({
    required this.toggleableState,
    required this.padding,
    this.style,
  });

  final ToggleableStateMixin toggleableState;
  final SBBRadioStyle? style;
  final EdgeInsetsGeometry padding;

  @override
  State<_SBBRadioPaint> createState() => _SBBRadioPaintState();
}

class _SBBRadioPaintState extends State<_SBBRadioPaint> {
  final _SBBRadioPainter _painter = _SBBRadioPainter();

  @override
  void dispose() {
    _painter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SBBRadioStyle? themeStyle = Theme.of(context).sbbRadioTheme?.style;

    // Compute active and inactive state so that colors can be determined and painter can lerp between them
    final Set<WidgetState> activeStates = {...widget.toggleableState.states, WidgetState.selected};
    final Set<WidgetState> inactiveStates = {...widget.toggleableState.states}..remove(WidgetState.selected);

    final Color activeFillColor = _resolveColor(
      widget.style?.fillColor,
      themeStyle?.fillColor,
      activeStates,
    );
    final Color inactiveFillColor = _resolveColor(
      widget.style?.fillColor,
      themeStyle?.fillColor,
      inactiveStates,
    );

    final Color activeBorderColor = _resolveColor(
      widget.style?.borderColor,
      themeStyle?.borderColor,
      activeStates,
    );
    final Color inactiveBorderColor = _resolveColor(
      widget.style?.borderColor,
      themeStyle?.borderColor,
      inactiveStates,
    );

    final Color activeInnerCircleColor = _resolveColor(
      widget.style?.innerCircleColor,
      themeStyle?.innerCircleColor,
      activeStates,
    );
    final Color inactiveInnerCircleColor = _resolveColor(
      widget.style?.innerCircleColor,
      themeStyle?.innerCircleColor,
      inactiveStates,
    );

    final Size effectiveSize = widget.padding.inflateSize(const Size.square(SBBRadioStyle.radioRadius * 2));

    return CustomPaint(
      size: effectiveSize,
      painter: _painter
        ..position = widget.toggleableState.position
        ..reaction = widget.toggleableState.reaction
        ..isFocused = widget.toggleableState.states.contains(WidgetState.focused)
        ..isHovered = widget.toggleableState.states.contains(WidgetState.hovered)
        ..activeColor = activeInnerCircleColor
        ..inactiveColor = inactiveInnerCircleColor
        ..activeFillColor = activeFillColor
        ..inactiveFillColor = inactiveFillColor
        ..activeBorderColor = activeBorderColor
        ..inactiveBorderColor = inactiveBorderColor,
    );
  }

  Color _resolveColor(
    WidgetStateProperty<Color?>? widgetColor,
    WidgetStateProperty<Color?>? themeColor,
    Set<WidgetState> states,
  ) {
    final WidgetStateProperty<Color?>? effectiveProperty = widgetColor ?? themeColor;
    return effectiveProperty?.resolve(states) ?? SBBColors.red;
  }
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
class _SBBRadioPainter extends ToggleablePainter {
  Color get activeFillColor => _activeFillColor!;
  Color? _activeFillColor;

  set activeFillColor(Color newValue) {
    if (newValue == _activeFillColor) return;
    _activeFillColor = newValue;
    notifyListeners();
  }

  Color get activeBorderColor => _activeBorderColor!;
  Color? _activeBorderColor;

  set activeBorderColor(Color newValue) {
    if (newValue == _activeBorderColor) return;
    _activeBorderColor = newValue;
    notifyListeners();
  }

  Color get inactiveFillColor => _inactiveFillColor!;
  Color? _inactiveFillColor;

  set inactiveFillColor(Color newValue) {
    if (newValue == _inactiveFillColor) return;
    _inactiveFillColor = newValue;
    notifyListeners();
  }

  Color get inactiveBorderColor => _inactiveBorderColor!;
  Color? _inactiveBorderColor;

  set inactiveBorderColor(Color newValue) {
    if (newValue == _inactiveBorderColor) return;
    _inactiveBorderColor = newValue;
    notifyListeners();
  }

  Color get _currentActiveColor => Color.lerp(inactiveColor, activeColor, position.value)!;

  Color get _currentFillColor => Color.lerp(inactiveFillColor, activeFillColor, position.value)!;

  Color get _currentBorderColor => Color.lerp(inactiveBorderColor, activeBorderColor, position.value)!;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);

    final Paint fillPaint = _createFillPaint();
    final Paint borderPaint = _createBorderPaint();
    final Paint innerCirclePaint = _createInnerCirclePaint();

    // fill
    canvas.drawCircle(center, SBBRadioStyle.radioRadius, fillPaint);
    // border
    canvas.drawCircle(center, SBBRadioStyle.radioRadius - SBBRadioStyle.borderWidth / 2.0, borderPaint);

    if (!position.isDismissed) {
      final double t = position.value;
      final double radius = lerpDouble(0.0, SBBRadioStyle.innerCircleRadius, t)!;
      if (radius > 0) {
        canvas.drawCircle(center, radius, innerCirclePaint);
      }
    }
  }

  Paint _createFillPaint() {
    return Paint()
      ..color = _currentFillColor
      ..style = PaintingStyle.fill;
  }

  Paint _createBorderPaint() {
    return Paint()
      ..color = _currentBorderColor
      ..strokeWidth = SBBRadioStyle.borderWidth
      ..style = PaintingStyle.stroke;
  }

  Paint _createInnerCirclePaint() {
    return Paint()
      ..color = _currentActiveColor
      ..style = PaintingStyle.fill;
  }
}
