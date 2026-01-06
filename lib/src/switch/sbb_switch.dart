import 'dart:ui';

import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

const _switchDisabledOpacity = 0.5;

/// The SBB Switch.
/// Use according to [documentation](https://digital.sbb.ch/en/design-system/mobile/components/switch/)
///
/// See also:
///
/// * [SBBSwitchListItem], which builds this Widget as a part of a List Item
/// so that you can give the Switch a title, a subtitle, a leading icon and a
/// link Widget.
/// * [SBBCheckbox], a widget with semantics similar to [SBBSwitch].
/// * [SBBRadio] and [SBBSegmentedButton], for selecting among a set of
/// explicit values.
class SBBSwitch extends StatefulWidget {
  const SBBSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  State<SBBSwitch> createState() => _SBBSwitchState();
}

class _SBBSwitchState extends State<SBBSwitch> with TickerProviderStateMixin, ToggleableStateMixin {
  final _SBBSwitchPainter _painter = _SBBSwitchPainter();

  bool _needsPositionAnimation = false;

  @override
  void initState() {
    super.initState();
  }

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

    final style = Theme.of(context).sbbSwitchTheme!.style!;

    // Colors need to be resolved in selected and non selected states separately
    // so that they can be lerped between.
    final Set<WidgetState> activeStates = states..add(WidgetState.selected);
    final Set<WidgetState> inactiveStates = states..remove(WidgetState.selected);

    final Color activeTrackColor = style.trackColor?.resolve(activeStates) ?? SBBColors.red;
    final Color inactiveTrackColor = style.trackColor?.resolve(inactiveStates) ?? SBBColors.granite;

    final Color activeKnobBackgroundColor = style.knobBackgroundColor?.resolve(activeStates) ?? SBBColors.white;
    final Color inactiveKnobBackgroundColor = style.knobBackgroundColor?.resolve(inactiveStates) ?? SBBColors.white;

    final Color activeKnobBorderColor = style.knobBorderColor?.resolve(activeStates) ?? SBBColors.red;
    final Color inactiveKnobBorderColor = style.knobBorderColor?.resolve(inactiveStates) ?? SBBColors.granite;

    final Color activeKnobForegroundColor = style.knobForegroundColor?.resolve(activeStates) ?? SBBColors.red;
    final Color inactiveKnobForegroundColor = style.knobForegroundColor?.resolve(inactiveStates) ?? SBBColors.white;

    // TODO: add customizable padding
    final effectiveSwitchSize = SBBSwitchStyle.switchSize;

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

    // Calculate thumb position and size
    final currentKnobExtensions = SBBSwitchStyle.knobPressedExtension * currentReactionValue;
    final knobLeft = lerpDouble(
      SBBSwitchStyle.trackInnerStart - SBBSwitchStyle.knobRadius,
      SBBSwitchStyle.trackInnerEnd - SBBSwitchStyle.knobRadius - currentKnobExtensions,
      currentValue,
    )!;
    final knobRight = lerpDouble(
      SBBSwitchStyle.trackInnerStart + SBBSwitchStyle.knobRadius + currentKnobExtensions,
      SBBSwitchStyle.trackInnerEnd + SBBSwitchStyle.knobRadius,
      currentValue,
    )!;
    final knobTop = switchMidpoint.dy - SBBSwitchStyle.knobRadius;
    final knobBottom = switchMidpoint.dy + SBBSwitchStyle.knobRadius;

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
