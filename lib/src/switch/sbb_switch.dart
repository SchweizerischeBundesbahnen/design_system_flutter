import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../design_system_flutter.dart';

const _trackWidth = 50.0;
const _trackHeight = 31.0;
const _trackRadius = _trackHeight * 0.5;
const _trackInnerStart = _trackHeight * 0.5;
const _trackInnerEnd = _trackWidth - _trackInnerStart;
const _trackInnerLength = _trackInnerEnd - _trackInnerStart;
const _switchDisabledOpacity = 0.5;
const _thumbRadius = 27.0 * 0.5;
const _thumbPressedExtension = 7.0;
const _thumbBoxShadows = [
  BoxShadow(
    color: Color(0x14000000),
    offset: Offset(0, 4),
    blurRadius: 9.0,
    spreadRadius: 2.0,
  ),
  BoxShadow(
    color: Color(0x1A000000),
    offset: Offset(0, 4),
    blurRadius: 2.0,
  ),
  BoxShadow(
    color: Color(0x1C000000),
    offset: Offset(0, 0),
    blurRadius: 1.0,
    spreadRadius: 1.0,
  ),
  BoxShadow(
    color: Color(0x12000000),
    offset: Offset(0, 1),
    blurRadius: 1.0,
  ),
];

/// The SBB Switch.
/// Use according to [documentation](https://digital.sbb.ch/en/design-system/mobile/components/switch/)
///
/// See also:
///
/// * [SBBSwitchListItem], which builds this Widget as a part of a List Item
/// so that you can give the Switch a title, a subtitle, a leading icon and a
/// link Widget.
/// * [SBBCheckbox], a widget with semantics similar to [SBBSwitch].
/// * [SBBRadioButton] and [SBBSegmentedButton], for selecting among a set of
/// explicit values.
class SBBSwitch extends StatefulWidget {
  const SBBSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  State<SBBSwitch> createState() => _SBBSwitchState();
}

class _SBBSwitchState extends State<SBBSwitch> with TickerProviderStateMixin {
  late TapGestureRecognizer _tap;
  late HorizontalDragGestureRecognizer _drag;

  late AnimationController _positionController;
  late CurvedAnimation _position;

  late AnimationController _reactionController;
  late Animation<double> _reaction;

  bool get isEnabled => widget.onChanged != null;

  bool _needsPositionAnimation = false;

  @override
  void initState() {
    super.initState();

    _tap = TapGestureRecognizer()
      ..onTapDown = _handleTapDown
      ..onTapUp = _handleTapUp
      ..onTap = _handleTap
      ..onTapCancel = _handleTapCancel;
    _drag = HorizontalDragGestureRecognizer()
      ..onStart = _handleDragStart
      ..onUpdate = _handleDragUpdate
      ..onEnd = _handleDragEnd;

    _positionController = AnimationController(
      duration: kThemeAnimationDuration,
      value: widget.value ? 1.0 : 0.0,
      vsync: this,
    );
    _position = CurvedAnimation(
      parent: _positionController,
      curve: Curves.linear,
    );
    _reactionController = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: this,
    );
    _reaction = CurvedAnimation(
      parent: _reactionController,
      curve: Curves.ease,
    );
  }

  @override
  void didUpdateWidget(SBBSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_needsPositionAnimation || oldWidget.value != widget.value) {
      _resumePositionAnimation(isLinear: _needsPositionAnimation);
    }
  }

  void _resumePositionAnimation({bool isLinear = true}) {
    _needsPositionAnimation = false;
    _position
      ..curve = isLinear ? Curves.linear : Curves.ease
      ..reverseCurve = isLinear ? Curves.linear : Curves.ease.flipped;
    if (widget.value) {
      _positionController.forward();
    } else {
      _positionController.reverse();
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (isEnabled) {
      _needsPositionAnimation = false;
    }
    _reactionController.forward();
  }

  void _handleTap([Intent? _]) {
    if (isEnabled) {
      widget.onChanged!(!widget.value);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (isEnabled) {
      _needsPositionAnimation = false;
      _reactionController.reverse();
    }
  }

  void _handleTapCancel() {
    if (isEnabled) {
      _reactionController.reverse();
    }
  }

  void _handleDragStart(DragStartDetails details) {
    if (isEnabled) {
      _needsPositionAnimation = false;
      _reactionController.forward();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (isEnabled) {
      _position
        ..curve = Curves.linear
        ..reverseCurve = Curves.linear;
      final delta = details.primaryDelta! / _trackInnerLength;
      _positionController.value += delta;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    setState(() {
      _needsPositionAnimation = true;
    });
    if (_position.value >= 0.5 != widget.value) {
      widget.onChanged!(!widget.value);
    }
    _reactionController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).switchToggle!;

    final opacity = isEnabled ? 1.0 : _switchDisabledOpacity;
    final thumbColor =
        isEnabled ? style.thumbColor! : style.thumbColorDisabled!;
    final activeColor =
        isEnabled ? style.activeColor! : style.activeColorDisabled!;
    final trackColor =
        isEnabled ? style.trackColor! : style.trackColorDisabled!;
    if (_needsPositionAnimation) {
      _resumePositionAnimation();
    }
    return Opacity(
      opacity: opacity,
      child: _SBBSwitchRenderObjectWidget(
        value: widget.value,
        thumbColor: thumbColor,
        activeColor: activeColor,
        trackColor: trackColor,
        onChanged: widget.onChanged,
        state: this,
      ),
    );
  }

  @override
  void dispose() {
    _tap.dispose();
    _drag.dispose();
    _positionController.dispose();
    _reactionController.dispose();
    super.dispose();
  }
}

class _SBBSwitchRenderObjectWidget extends LeafRenderObjectWidget {
  const _SBBSwitchRenderObjectWidget({
    required this.value,
    required this.thumbColor,
    required this.activeColor,
    required this.trackColor,
    required this.onChanged,
    required this.state,
  });

  final bool value;
  final Color thumbColor;
  final Color activeColor;
  final Color trackColor;
  final ValueChanged<bool>? onChanged;
  final _SBBSwitchState state;

  @override
  _SBBRenderSwitch createRenderObject(BuildContext context) {
    return _SBBRenderSwitch(
      value: value,
      thumbColor: thumbColor,
      activeColor: activeColor,
      trackColor: trackColor,
      onChanged: onChanged,
      state: state,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _SBBRenderSwitch renderObject) {
    assert(renderObject._state == state);
    renderObject
      ..value = value
      ..thumbColor = thumbColor
      ..activeColor = activeColor
      ..trackColor = trackColor
      ..onChanged = onChanged;
  }
}

class _SBBRenderSwitch extends RenderConstrainedBox {
  _SBBRenderSwitch({
    required bool value,
    required Color thumbColor,
    required Color activeColor,
    required Color trackColor,
    ValueChanged<bool>? onChanged,
    required _SBBSwitchState state,
  })  : _value = value,
        _thumbColor = thumbColor,
        _activeColor = activeColor,
        _trackColor = trackColor,
        _onChanged = onChanged,
        _state = state,
        super(
          additionalConstraints: const BoxConstraints.tightFor(
            width: _trackWidth,
            height: _trackHeight,
          ),
        ) {
    state._position.addListener(markNeedsPaint);
    state._reaction.addListener(markNeedsPaint);
  }

  final _SBBSwitchState _state;

  bool get value => _value;
  bool _value;

  set value(bool value) {
    if (value == _value) {
      return;
    }
    _value = value;
    markNeedsSemanticsUpdate();
  }

  Color get thumbColor => _thumbColor;
  Color _thumbColor;

  set thumbColor(Color value) {
    if (value == _thumbColor) {
      return;
    }
    _thumbColor = value;
    markNeedsPaint();
  }

  Color get activeColor => _activeColor;
  Color _activeColor;

  set activeColor(Color value) {
    if (value == _activeColor) {
      return;
    }
    _activeColor = value;
    markNeedsPaint();
  }

  Color get trackColor => _trackColor;
  Color _trackColor;

  set trackColor(Color value) {
    if (value == _trackColor) {
      return;
    }
    _trackColor = value;
    markNeedsPaint();
  }

  ValueChanged<bool>? get onChanged => _onChanged;
  ValueChanged<bool>? _onChanged;

  set onChanged(ValueChanged<bool>? value) {
    if (value == _onChanged) {
      return;
    }
    final wasEnabled = isEnabled;
    _onChanged = value;
    if (wasEnabled != isEnabled) {
      markNeedsPaint();
      markNeedsSemanticsUpdate();
    }
  }

  bool get isEnabled => onChanged != null;

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent && isEnabled) {
      _state._drag.addPointer(event);
      _state._tap.addPointer(event);
    }
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);

    if (isEnabled) {
      config.onTap = _state._handleTap;
    }

    config.isEnabled = isEnabled;
    config.isToggled = _value;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    final currentValue = _state._position.value;
    final currentReactionValue = _state._reaction.value;

    final trackRRect = RRect.fromLTRBR(
      0.0,
      0.0,
      _trackWidth,
      _trackHeight,
      const Radius.circular(_trackRadius),
    );
    final currentTrackColor = Color.lerp(
      trackColor,
      activeColor,
      currentValue,
    )!;
    final trackPaint = Paint()..color = currentTrackColor;
    canvas.drawRRect(trackRRect, trackPaint);

    final currentThumbExtension = _thumbPressedExtension * currentReactionValue;
    final thumbLeft = lerpDouble(
      trackRRect.left + _trackInnerStart - _thumbRadius,
      trackRRect.left + _trackInnerEnd - _thumbRadius - currentThumbExtension,
      currentValue,
    )!;
    final thumbRight = lerpDouble(
      trackRRect.left + _trackInnerStart + _thumbRadius + currentThumbExtension,
      trackRRect.left + _trackInnerEnd + _thumbRadius,
      currentValue,
    )!;
    const thumbTop = _trackHeight * 0.5 - _thumbRadius;
    const thumbBottom = _trackHeight * 0.5 + _thumbRadius;

    final thumbRRect = RRect.fromLTRBR(
      thumbLeft,
      thumbTop,
      thumbRight,
      thumbBottom,
      Radius.circular(_thumbRadius),
    );

    for (final shadow in _thumbBoxShadows) {
      final shadowRRect = thumbRRect.shift(shadow.offset);
      final shadowPaint = shadow.toPaint();
      canvas.drawRRect(shadowRRect, shadowPaint);
    }

    final thumbPaint = Paint()..color = thumbColor;
    canvas.drawRRect(thumbRRect, thumbPaint);
  }
}
