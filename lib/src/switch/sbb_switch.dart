import 'dart:ui';

import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// The SBB Switch.
///
/// A toggle switch that allows users to switch between two states: on or off.
///
/// The [SBBSwitch] is a stateless widget that does not maintain any internal state.
/// Instead, when the user toggles the switch, the widget calls the [onChanged] callback.
/// The parent widget should listen for the [onChanged] callback and rebuild the switch
/// with a new [value] to reflect the change in state.
///
/// If the [onChanged] callback is null, the switch will be displayed as disabled
/// and will not respond to user gestures.
///
/// ## Sample code
///
/// ### Basic usage
/// ```dart
/// bool _isEnabled = false;
///
/// SBBSwitch(
///   value: _isEnabled,
///   onChanged: (bool newValue) {
///     setState(() {
///       _isEnabled = newValue;
///     });
///   },
/// )
/// ```
///
/// ### With custom styling
/// ```dart
/// SBBSwitch(
///   value: _isEnabled,
///   onChanged: (bool newValue) {
///     setState(() {
///       _isEnabled = newValue;
///     });
///   },
///   style: SBBSwitchStyle(
///     trackColor: WidgetStateProperty.fromMap({
///       WidgetState.selected: Colors.blue,
///       WidgetState.any: Colors.grey,
///     }),
///   ),
/// )
/// ```
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// See also:
///
/// * [SBBSwitchListItem], which builds this widget as part of a list item
///   with a label, subtitle, leading icon, and optional trailing widget.
/// * [SBBCheckbox], a widget with similar toggle semantics but different appearance.
/// * [SBBRadio], for selecting among a set of explicit values.
/// * [SBBSegmentedButton], for selecting among multiple options with button-like appearance.
/// * [SBBSwitchThemeData], for setting the [SBBSwitchStyle] for all switches within the current theme.
/// * [Figma Design Specs](https://digital.sbb.ch/en/design-system/mobile/components/switch/)
class SBBSwitch extends StatefulWidget {
  /// Creates an SBB Switch.
  ///
  /// The [value] and [onChanged] arguments are required.
  ///
  /// The [value] must not be null, and it determines whether the switch is
  /// in the "on" (true) or "off" (false) state.
  ///
  /// The [onChanged] callback is called when the user toggles the switch.
  /// If [onChanged] is null, the switch will be disabled and displayed with reduced opacity colors.
  const SBBSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.style,
  });

  /// When [value] is true, the switch appears with the knob
  /// positioned to the right and the track colored with the active color.
  ///
  /// When [value] is false, the switch appears with the knob
  /// positioned to the left and the track colored with the inactive color.
  final bool value;

  /// Called when the user toggles the switch.
  ///
  /// The switch passes the new boolean value to the callback. The parent widget
  /// is responsible for updating the [value] property to reflect the change.
  ///
  /// If this callback is null, the switch will be displayed as disabled and will
  /// not respond to user gestures. Use null to disable the switch when a certain
  /// condition is met (e.g., when loading data or when the user lacks permissions).
  final ValueChanged<bool>? onChanged;

  /// Customizes the appearance of this switch.
  ///
  /// Non-null properties of this style override the corresponding properties
  /// in the [SBBSwitchThemeData.style] from the theme found in [context].
  final SBBSwitchStyle? style;

  @override
  State<SBBSwitch> createState() => _SBBSwitchState();
}

class _SBBSwitchState extends State<SBBSwitch> with TickerProviderStateMixin, ToggleableStateMixin {
  final _SBBSwitchPainter _painter = _SBBSwitchPainter();

  bool _needsPositionAnimation = false;

  @override
  void didUpdateWidget(SBBSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      if (position.value == 0.0 || position.value == 1.0) {
        updateCurve();
      }
      animateToValue();
    }
  }

  @override
  void dispose() {
    _painter.dispose();
    super.dispose();
  }

  void updateCurve() {
    position
      ..curve = Curves.easeIn
      ..reverseCurve = Curves.easeOut;
  }

  void _handleDragStart(DragStartDetails details) {
    if (isInteractive) {
      reactionController.forward();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (isInteractive) {
      position
        ..curve = Curves.linear
        ..reverseCurve = null;
      final double delta = details.primaryDelta! / SBBSwitchStyle.trackInnerLength;
      positionController.value += delta;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (position.value >= 0.5 != widget.value) {
      widget.onChanged?.call(!widget.value);
      setState(() {
        _needsPositionAnimation = true;
      });
    } else {
      animateToValue();
    }
    reactionController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    if (_needsPositionAnimation) {
      _needsPositionAnimation = false;
      animateToValue();
    }

    final SBBSwitchStyle? effectiveStyle = _getEffectiveStyle(context);

    // Colors need to be resolved in selected and non selected states separately
    // so that they can be lerped between.
    final Set<WidgetState> activeStates = states..add(WidgetState.selected);
    final Set<WidgetState> inactiveStates = states..remove(WidgetState.selected);

    final Color activeTrackColor = effectiveStyle?.trackColor?.resolve(activeStates) ?? SBBColors.red;
    final Color inactiveTrackColor = effectiveStyle?.trackColor?.resolve(inactiveStates) ?? SBBColors.granite;

    final Color activeKnobBackgroundColor =
        effectiveStyle?.knobBackgroundColor?.resolve(activeStates) ?? SBBColors.white;
    final Color inactiveKnobBackgroundColor =
        effectiveStyle?.knobBackgroundColor?.resolve(inactiveStates) ?? SBBColors.white;

    final Color activeKnobBorderColor = effectiveStyle?.knobBorderColor?.resolve(activeStates) ?? SBBColors.red;
    final Color inactiveKnobBorderColor = effectiveStyle?.knobBorderColor?.resolve(inactiveStates) ?? SBBColors.granite;

    final Color activeKnobForegroundColor = effectiveStyle?.knobForegroundColor?.resolve(activeStates) ?? SBBColors.red;
    final Color inactiveKnobForegroundColor =
        effectiveStyle?.knobForegroundColor?.resolve(inactiveStates) ?? SBBColors.white;

    final effectiveMargin = effectiveStyle?.tapTargetPadding ?? const EdgeInsets.symmetric(vertical: 4.0);
    final effectiveSwitchSize = effectiveMargin.inflateSize(SBBSwitchStyle.switchSize);

    return Semantics(
      toggled: widget.value,
      child: GestureDetector(
        excludeFromSemantics: true,
        onHorizontalDragStart: _handleDragStart,
        onHorizontalDragUpdate: _handleDragUpdate,
        onHorizontalDragEnd: _handleDragEnd,
        child: buildToggleable(
          size: effectiveSwitchSize,
          painter: _painter
            ..position = position
            ..positionController = positionController
            ..reaction = reaction
            ..downPosition = downPosition
            ..activeColor = activeTrackColor
            ..inactiveColor = inactiveTrackColor
            ..activeKnobBackgroundColor = activeKnobBackgroundColor
            ..inactiveKnobBackgroundColor = inactiveKnobBackgroundColor
            ..activeKnobBorderColor = activeKnobBorderColor
            ..inactiveKnobBorderColor = inactiveKnobBorderColor
            ..activeKnobForegroundColor = activeKnobForegroundColor
            ..inactiveKnobForegroundColor = inactiveKnobForegroundColor,
        ),
      ),
    );
  }

  SBBSwitchStyle? _getEffectiveStyle(BuildContext context) {
    final SBBSwitchStyle? themeStyle = Theme.of(context).sbbSwitchTheme?.style;
    return themeStyle?.merge(widget.style) ?? widget.style;
  }

  void _handleChanged(bool? value) {
    assert(value != null);
    assert(widget.onChanged != null);
    widget.onChanged?.call(value!);
  }

  @override
  ValueChanged<bool?>? get onChanged => widget.onChanged != null ? _handleChanged : null;

  @override
  bool get tristate => false;

  @override
  bool? get value => widget.value;
}

class _SBBSwitchPainter extends ToggleablePainter {
  AnimationController get positionController => _positionController!;
  AnimationController? _positionController;

  set positionController(AnimationController? value) {
    assert(value != null);
    if (value == _positionController) {
      return;
    }
    _positionController = value;
    _colorAnimation?.dispose();
    _colorAnimation = CurvedAnimation(
      parent: positionController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
    notifyListeners();
  }

  CurvedAnimation? _colorAnimation;

  Color get activeKnobBackgroundColor => _activeKnobBackgroundColor!;
  Color? _activeKnobBackgroundColor;

  set activeKnobBackgroundColor(Color value) {
    if (value == _activeKnobBackgroundColor) return;
    _activeKnobBackgroundColor = value;
    notifyListeners();
  }

  Color get inactiveKnobBackgroundColor => _inactiveKnobBackgroundColor!;
  Color? _inactiveKnobBackgroundColor;

  set inactiveKnobBackgroundColor(Color value) {
    if (value == _inactiveKnobBackgroundColor) return;
    _inactiveKnobBackgroundColor = value;
    notifyListeners();
  }

  Color get activeKnobBorderColor => _activeKnobBorderColor!;
  Color? _activeKnobBorderColor;

  set activeKnobBorderColor(Color value) {
    if (value == _activeKnobBorderColor) return;
    _activeKnobBorderColor = value;
    notifyListeners();
  }

  Color get inactiveKnobBorderColor => _inactiveKnobBorderColor!;
  Color? _inactiveKnobBorderColor;

  set inactiveKnobBorderColor(Color value) {
    if (value == _inactiveKnobBorderColor) return;
    _inactiveKnobBorderColor = value;
    notifyListeners();
  }

  Color get activeKnobForegroundColor => _activeKnobForegroundColor!;
  Color? _activeKnobForegroundColor;

  set activeKnobForegroundColor(Color value) {
    if (value == _activeKnobForegroundColor) return;
    _activeKnobForegroundColor = value;
    notifyListeners();
  }

  Color get inactiveKnobForegroundColor => _inactiveKnobForegroundColor!;
  Color? _inactiveKnobForegroundColor;

  set inactiveKnobForegroundColor(Color value) {
    if (value == _inactiveKnobForegroundColor) return;
    _inactiveKnobForegroundColor = value;
    notifyListeners();
  }

  Color get currentKnobBackgroundColor => Color.lerp(
    inactiveKnobBackgroundColor,
    activeKnobBackgroundColor,
    _colorAnimation!.value,
  )!;

  Color get currentTrackColor => Color.lerp(inactiveColor, activeColor, _colorAnimation!.value)!;

  Color get currentKnobBorderColor =>
      Color.lerp(inactiveKnobBorderColor, activeKnobBorderColor, _colorAnimation!.value)!;

  Color get currentKnobForegroundColor =>
      Color.lerp(inactiveKnobForegroundColor, activeKnobForegroundColor, _colorAnimation!.value)!;

  @override
  void paint(Canvas canvas, Size size) {
    final currentValue = position.value;
    final currentReactionValue = reaction.value;
    final switchMidpoint = size.center(Offset.zero);

    // Draw track
    final trackRect = Rect.fromCenter(
      center: switchMidpoint,
      width: SBBSwitchStyle.trackWidth,
      height: SBBSwitchStyle.trackHeight,
    );
    final trackRRect = RRect.fromRectAndRadius(trackRect, Radius.circular(trackRect.shortestSide / 2));
    final trackPaint = Paint()..color = currentTrackColor;
    canvas.drawRRect(trackRRect, trackPaint);

    // Calculate knob position and size
    final currentKnobExtensions = SBBSwitchStyle.knobPressedExtension * currentReactionValue;
    final knobLeft =
        trackRRect.left +
        lerpDouble(
          SBBSwitchStyle.trackInnerStart - SBBSwitchStyle.knobRadius,
          SBBSwitchStyle.trackInnerEnd - SBBSwitchStyle.knobRadius - currentKnobExtensions,
          currentValue,
        )!;
    final knobRight =
        trackRRect.left +
        lerpDouble(
          SBBSwitchStyle.trackInnerStart + SBBSwitchStyle.knobRadius + currentKnobExtensions,
          SBBSwitchStyle.trackInnerEnd + SBBSwitchStyle.knobRadius,
          currentValue,
        )!;
    final knobTop = trackRRect.center.dy - SBBSwitchStyle.knobRadius;
    final knobBottom = trackRRect.center.dy + SBBSwitchStyle.knobRadius;

    final thumbRRect = RRect.fromLTRBR(
      knobLeft,
      knobTop,
      knobRight,
      knobBottom,
      Radius.circular(SBBSwitchStyle.knobRadius),
    );

    // Draw shadows
    for (final shadow in SBBSwitchStyle.knobBoxShadows) {
      final shadowRRect = thumbRRect.shift(shadow.offset);
      final shadowPaint = shadow.toPaint();
      canvas.drawRRect(shadowRRect, shadowPaint);
    }

    // Draw thumb background
    final thumbPaint = Paint()..color = currentKnobBackgroundColor;
    canvas.drawRRect(thumbRRect, thumbPaint);

    // Draw thumb border
    final thumbStrokePaint = Paint()
      ..color = currentKnobBorderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = SBBSwitchStyle.knobBorderWidth;
    canvas.drawRRect(thumbRRect, thumbStrokePaint);

    // Draw tick icon
    _drawTick(canvas, thumbRRect, currentKnobForegroundColor, _colorAnimation!.value);
  }

  void _drawTick(Canvas canvas, RRect thumbRRect, Color color, double value) {
    final icon = SBBIcons.tick_small;
    final iconSize = Size.square(sbbIconSizeSmall);
    final iconPosition = thumbRRect.center - iconSize.center(Offset.zero);

    final painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontFamily: icon.fontFamily,
        color: color,
        fontSize: iconSize.height,
      ),
    );
    painter.layout();
    painter.paint(canvas, iconPosition);
  }

  @override
  void dispose() {
    _colorAnimation?.dispose();
    super.dispose();
  }
}
