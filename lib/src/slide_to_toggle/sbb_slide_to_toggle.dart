import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/shared/utils.dart';

/// The SBB Slide-To-Toggle.
///
/// A gesture-controlled toggle widget that requires the user to swipe across a track
/// to change its state.
///
/// The widget transitions between [SBBSlideToToggleState.off] and [SBBSlideToToggleState.on]
/// states based on user interaction. Use [onToggleDecoration] to configure the appearance
/// and behavior when in the on state, and [offToggleDecoration] for the off state.
///
/// The [threshold] parameter determines how far the user must drag the toggle to
/// complete the state change. A threshold of 0.9 means the toggle must be dragged
/// 90% across the track to change state.
///
/// Use [SBBSlideToToggle] for the standard size, or [SBBSlideToToggleSmall] for a
/// reduced-size variant.
///
/// ## Sample code
///
/// ```dart
/// // Basic slide-to-toggle
/// SBBSlideToToggle(
///   onToggleDecoration: SBBSlideToggleDecoration(
///     toggleLabelText: 'Stop',
///     helpLabelText: 'Drag to the left to stop',
///     onToggle: () async {
///       // Handle state change to off
///     },
///   ),
///   offToggleDecoration: SBBSlideToggleDecoration(
///     toggleLabelText: 'Start',
///     helpLabelText: 'Drag to the right to start',
///     onToggle: () async {
///       // Handle state change to on
///     },
///   ),
/// )
///
/// // Small variant with icons
/// SBBSlideToToggleSmall(
///   onToggleDecoration: SBBSlideToggleDecoration(
///     toggleIconData: SBBIcons.arrow_left_small,
///     helpLabelText: 'Drag to the left to stop',
///     onToggle: () async {},
///   ),
///   offToggleDecoration: SBBSlideToggleDecoration(
///     toggleIconData: SBBIcons.arrow_right_small,
///     helpLabelText: 'Drag to the right to start',
///     onToggle: () async {},
///   ),
/// )
/// ```
///
/// See also:
///
/// * [SBBSlideToToggleStyle], for customizing the appearance.
/// * [SBBSlideToggleDecoration], for configuring toggle and track content.
/// * [SBBSlideToToggleSmall], for a reduced-size variant.
/// * [SBBSlideToToggleController], to controll the components state programmatically.
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=6666-1023)
class SBBSlideToToggle extends StatelessWidget {
  /// Creates an SBB Slide-To-Toggle.
  const SBBSlideToToggle({
    super.key,
    required this.onToggleDecoration,
    required this.offToggleDecoration,
    this.controller,
    this.enabled = true,
    this.threshold = 0.8,
    this.style,
  }) : assert(threshold >= 0 && threshold <= 1, 'threshold must be between 0 and 1.');

  /// Customizes this Slide-To-Toggle appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBSlideToToggleThemeData.style] of the theme found in [context].
  final SBBSlideToToggleStyle? style;

  /// Whether this Slide-To-Toggle is interactive.
  ///
  /// When disabled, the toggle cannot be dragged and appears grayed out.
  final bool enabled;

  /// Configuration for the toggle and track when in the on state.
  ///
  /// This includes the toggle content (label text, icon, or custom widget),
  /// help text displayed in the track, and the callback invoked when
  /// transitioning to the on state.
  final SBBSlideToggleDecoration onToggleDecoration;

  /// Configuration for the toggle and track when in the off state.
  ///
  /// This includes the toggle content (label text, icon, or custom widget),
  /// help text displayed in the track, and the callback invoked when
  /// transitioning to the off state.
  final SBBSlideToggleDecoration offToggleDecoration;

  /// The normalized drag threshold for state changes, between 0.0 and 1.0.
  ///
  /// Determines how far across the track (0.0 to 1.0) the user must drag
  /// the toggle to complete a state change. A value of 0.9 means 90% drag distance.
  final double threshold;

  /// An optional controller to programmatically change state of the [SBBSlideToToggle].
  ///
  /// The controller also controls the initial state with defaults to [SBBSlideToToggleState.off].
  ///
  /// If not provided, an internal controller is created automatically.
  final SBBSlideToToggleController? controller;

  @override
  Widget build(BuildContext context) {
    return _BaseSBBSlideToToggle(
      onToggleDecoration: onToggleDecoration,
      offToggleDecoration: offToggleDecoration,
      controller: controller,
      enabled: enabled,
      threshold: threshold,
      style: style,
    );
  }
}

/// The SBB Slide-To-Toggle with reduced toggle size.
///
/// This variant displays a smaller toggle button and is suitable for compact layouts
/// or when space is limited. It supports the same functionality and customization
/// options as [SBBSlideToToggle].
class SBBSlideToToggleSmall extends SBBSlideToToggle {
  /// Creates a small SBB Slide-To-Toggle.
  const SBBSlideToToggleSmall({
    super.key,
    required super.onToggleDecoration,
    required super.offToggleDecoration,
    super.controller,
    super.enabled = true,
    super.threshold = 0.8,
    super.style,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseSBBSlideToToggle(
      isSmall: true,
      onToggleDecoration: onToggleDecoration,
      offToggleDecoration: offToggleDecoration,
      controller: controller,
      enabled: enabled,
      threshold: threshold,
      style: style,
    );
  }
}

class _BaseSBBSlideToToggle extends StatefulWidget {
  const _BaseSBBSlideToToggle({
    required this.onToggleDecoration,
    required this.offToggleDecoration,
    this.controller,
    this.enabled = true,
    this.threshold = 0.8,
    this.style,
    this.isSmall = false,
  });

  final SBBSlideToToggleStyle? style;
  final bool enabled;
  final SBBSlideToggleDecoration onToggleDecoration;
  final SBBSlideToggleDecoration offToggleDecoration;
  final double threshold;
  final SBBSlideToToggleController? controller;
  final bool isSmall;

  @override
  State<_BaseSBBSlideToToggle> createState() => _SBBSlideToToggleState();
}

class _SBBSlideToToggleState extends State<_BaseSBBSlideToToggle> with SingleTickerProviderStateMixin {
  static const Duration _snapDuration = Duration(milliseconds: 200);
  static const Duration _bounceDuration = Duration(milliseconds: 320);
  static const EdgeInsets _containerPadding = EdgeInsets.all(4.0);

  SBBSlideToToggleController? _internalController;

  SBBSlideToToggleController get _effectiveController =>
      widget.controller ?? (_internalController ??= SBBSlideToToggleController());

  late WidgetStatesController _statesController;

  bool _loading = false;
  bool _isDragging = false;
  double _position = 0;

  late final AnimationController _positionController;
  Animation<double>? _positionAnimation;

  @override
  void initState() {
    super.initState();
    _statesController = WidgetStatesController();
    _updateStatesController();

    _effectiveController.addListener(_onControllerChanged);
    _position = _targetPositionFor(_currentState);
    _positionController = AnimationController(vsync: this, duration: _snapDuration)
      ..addListener(() {
        final value = _positionAnimation?.value;
        if (value == null) return;
        setState(() => _position = value);
      });
  }

  @override
  void didUpdateWidget(_BaseSBBSlideToToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      _updateStatesController();
    }

    if (widget.controller != oldWidget.controller) {
      final oldValue = (oldWidget.controller ?? _internalController)?.value;

      oldWidget.controller?.removeListener(_onControllerChanged);
      _internalController?.dispose();
      _internalController = null;

      _effectiveController.addListener(_onControllerChanged);

      if (oldValue != _effectiveController.value) _onControllerChanged();
    }
  }

  void _updateStatesController() {
    _statesController.update(WidgetState.disabled, !widget.enabled || _loading);
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_onControllerChanged);
    _internalController?.dispose();
    _statesController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeStyle = Theme.of(context).sbbSlideToToggleTheme!.style!;
    final effectiveStyle = themeStyle.merge(widget.style);

    final states = _statesController.value;
    final borderColor = effectiveStyle.borderColor?.resolve(states) ?? SBBColors.granite;
    final backgroundColor = effectiveStyle.backgroundColor?.resolve(states) ?? SBBColors.white;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: SBBSlideToToggleStyle.borderWidth),
        borderRadius: .circular(_toggleSize),
      ),
      padding: _containerPadding,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: SBBSlideToToggleStyle.borderShape,
        ),
        child: SizedBox(
          height: _toggleSize,
          width: double.infinity,
          child: Stack(
            children: [
              _helpWidget(state: .on, style: effectiveStyle),
              _helpWidget(state: .off, style: effectiveStyle),
              _toggle(effectiveStyle),
            ],
          ),
        ),
      ),
    );
  }

  Widget _helpWidget({required SBBSlideToToggleState state, required SBBSlideToToggleStyle style}) {
    return ClipRect(
      clipper: _HelpWidgetClipper(
        position: _position,
        toggleSize: _toggleSize,
        state: state,
      ),
      child: Align(
        alignment: state == .off ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: SBBSpacing.xSmall).copyWith(
            right: SBBSpacing.medium + (state == .on ? _toggleSize : 0.0),
            left: SBBSpacing.medium + (state == .off ? _toggleSize : 0.0),
          ),
          child: Opacity(
            opacity: _helpOpacityFor(state),
            child: addDefaultAncestorWithResolved(
              foregroundColor: style.helpForegroundColor?.resolve(_statesController.value),
              textStyle: style.helpTextStyle,
              child: _resolveHelpWidget(state: state),
            ),
          ),
        ),
      ),
    );
  }

  Widget _resolveHelpWidget({required SBBSlideToToggleState state}) {
    final decoration = state == .on ? widget.onToggleDecoration : widget.offToggleDecoration;
    final helpText = decoration.helpLabelText;
    if (helpText != null) {
      return Text(
        helpText,
        textAlign: state == .on ? .start : .end,
        overflow: .ellipsis,
        maxLines: widget.isSmall ? 1 : 3,
      );
    }

    return decoration.helpLabel ?? SizedBox.shrink();
  }

  Widget _toggle(SBBSlideToToggleStyle style) {
    final states = _statesController.value;
    final loadingIndicatorColor = style.loadingIndicatorColor?.resolve(states);
    final toggleBackgroundColor = style.toggleBackgroundColor?.resolve(states);
    final dragOverlayColor = style.toggleOverlayColor?.resolve({...states, WidgetState.pressed});

    return Align(
      alignment: AlignmentGeometry.xy(_position * 2 - 1, 0.5),
      child: GestureDetector(
        behavior: .translucent,
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        onHorizontalDragCancel: _onDragCancel,
        child: Material(
          color: toggleBackgroundColor,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkResponse(
            onTap: _isInteractive ? () {} : null,
            radius: _toggleSize / 2,
            overlayColor: style.toggleOverlayColor,
            child: SizedBox(
              width: _toggleSize,
              height: _toggleSize,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // background to keep pressed color while dragging
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _isDragging ? 1 : 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: dragOverlayColor,
                      ),
                    ),
                  ),
                  // toggle child
                  Center(
                    child: _loading
                        ? _loadingIndicator(color: loadingIndicatorColor)
                        : addDefaultAncestorWithResolved(
                            foregroundColor: style.toggleForegroundColor?.resolve(_statesController.value),
                            textStyle: style.toggleTextStyle,
                            child: _resolveToggleWidget(),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _resolveToggleWidget() {
    final labelText = _toggleDecoration.toggleLabelText;
    if (labelText != null) {
      return Padding(
        padding: const .all(SBBSpacing.xxSmall),
        child: FittedBox(
          fit: .scaleDown,
          child: Text(
            labelText,
            textAlign: .center,
          ),
        ),
      );
    }

    final iconData = _toggleDecoration.toggleIconData;
    if (iconData != null) {
      return Icon(
        iconData,
        size: widget.isSmall ? 24.0 : 36.0,
      );
    }

    return _toggleDecoration.toggleLabel ?? SizedBox.shrink();
  }

  Widget _loadingIndicator({Color? color}) {
    if (Platform.isIOS) {
      return CupertinoActivityIndicator(color: color);
    }
    return Padding(
      padding: const .all(10.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: 2.0,
        ),
      ),
    );
  }

  SBBSlideToggleDecoration get _toggleDecoration =>
      _currentState == .on ? widget.onToggleDecoration : widget.offToggleDecoration;

  SBBSlideToToggleState get _currentState => _effectiveController.value;

  double get _toggleSize => widget.isSmall ? SBBSlideToToggleStyle.toggleSizeSmall : SBBSlideToToggleStyle.toggleSize;

  bool get _isInteractive => widget.enabled && !_loading;

  double _helpOpacityFor(SBBSlideToToggleState state) {
    final transition = (_position * 2).clamp(0.0, 1.0);
    return state == .off ? 1 - transition : transition;
  }

  double _targetPositionFor(SBBSlideToToggleState state) => state == .on ? 1 : 0;

  void _startAnimation({required Animation<double> animation, required Duration duration}) {
    _positionController.stop();
    _positionController.duration = duration;
    _positionAnimation = animation;
    _positionController
      ..value = 0
      ..forward();
  }

  void _animateTo(double target, {Duration duration = _snapDuration, Curve curve = Curves.easeOut}) {
    _startAnimation(
      duration: duration,
      animation: Tween<double>(begin: _position, end: target).animate(
        CurvedAnimation(parent: _positionController, curve: curve),
      ),
    );
  }

  void _animateBounceBack() =>
      _animateTo(_currentState == .on ? 1 : 0, duration: _bounceDuration, curve: Curves.bounceOut);

  Future<void> _commitActivate() => _commitToggleChange(nextState: .on, action: widget.onToggleDecoration.onToggle);

  Future<void> _commitDeactivate() => _commitToggleChange(nextState: .off, action: widget.offToggleDecoration.onToggle);

  Future<void> _commitToggleChange({
    required SBBSlideToToggleState nextState,
    required Future<void> Function() action,
  }) async {
    if (_loading || nextState == _currentState) return;

    _setLoading(true);
    _animateTo(_targetPositionFor(nextState));

    try {
      await action();
      if (!mounted) return;

      _effectiveController.changeTo(state: nextState);
    } catch (_) {
      if (!mounted) return;
      _animateTo(_targetPositionFor(_currentState));
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    setState(() {
      _loading = loading;
      if (loading) _isDragging = false;
    });
    _updateStatesController();
  }

  void _onControllerChanged() {
    if (!mounted || _loading || _isDragging) return;

    final target = _targetPositionFor(_currentState);
    if ((_position - target).abs() < 0.0001) {
      setState(() {});
      return;
    }

    _animateTo(target);
  }

  void _onDragStart(DragStartDetails d) {
    if (!_isInteractive) return;
    _positionController.stop();
    setState(() => _isDragging = true);
  }

  void _onDragUpdate(DragUpdateDetails d) {
    final size = context.size;

    if (!_isInteractive || size == null) return;

    final width = size.width - _toggleSize - _containerPadding.horizontal;
    setState(() {
      _position = (_position + d.delta.dx / width).clamp(0.0, 1.0).toDouble();
    });
  }

  void _onDragEnd(DragEndDetails d) {
    if (!_isInteractive) return;

    setState(() => _isDragging = false);

    if (_currentState == .off && _position >= widget.threshold) {
      _commitActivate();
    } else if (_currentState == .on && _position <= (1 - widget.threshold)) {
      _commitDeactivate();
    } else {
      _animateBounceBack();
    }
  }

  void _onDragCancel() {
    if (!_isDragging) return;
    setState(() => _isDragging = false);
  }
}

/// Used to clip help widget so it doesn't go over toggle. Long help widgets would otherwise overlap while sliding.
class _HelpWidgetClipper extends CustomClipper<Rect> {
  const _HelpWidgetClipper({
    required this.state,
    required this.position,
    required this.toggleSize,
  });

  final SBBSlideToToggleState state;
  final double position;
  final double toggleSize;

  @override
  Rect getClip(Size size) {
    final clampedPosition = position.clamp(0.0, 1.0);
    final centerX = (clampedPosition * (size.width - toggleSize)) + (toggleSize / 2);

    if (state == .on) {
      return Rect.fromLTWH(0, 0, centerX, size.height);
    }
    return Rect.fromLTWH(centerX, 0, size.width - centerX, size.height);
  }

  @override
  bool shouldReclip(covariant _HelpWidgetClipper oldClipper) =>
      oldClipper.position != position || oldClipper.toggleSize != toggleSize || oldClipper.state != state;
}
