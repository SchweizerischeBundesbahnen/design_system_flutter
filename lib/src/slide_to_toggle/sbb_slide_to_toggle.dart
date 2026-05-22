import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// TODO:
enum SBBSlideToToggleState { off, on }

/// The SBB Slide-To-Toggle.
///
/// TODO
///
/// See also:
///
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=6666-1023)
class SBBSlideToToggle extends StatelessWidget {
  /// Creates an SBB Slide-To-Toggle.
  ///
  /// TODO: Docs, maybe asserts
  const SBBSlideToToggle({
    super.key,
    required this.onActivate,
    required this.onDeactivate,
    required this.onToggleDecoration,
    required this.offToggleDecoration,
    this.initialState = .off,
    this.enabled = true,
    this.threshold = 0.9,
    this.style,
  }) : assert(threshold >= 0 && threshold <= 1, 'threshold must be between 0 and 1.');

  /// Customizes this Slide-To-Toggle appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBSlideToToggleThemeData.style] of the theme found in [context].
  final SBBSlideToToggleStyle? style;

  final bool enabled;

  // TODO: Add callback as well?
  final SBBSlideToggleDecoration onToggleDecoration;
  final SBBSlideToggleDecoration offToggleDecoration;

  // TODO:
  final double threshold;
  final Future<void> Function() onActivate;
  final Future<void> Function() onDeactivate;
  final SBBSlideToToggleState initialState;

  @override
  Widget build(BuildContext context) {
    return _BaseSBBSlideToToggle(
      onActivate: onActivate,
      onDeactivate: onDeactivate,
      onToggleDecoration: onToggleDecoration,
      offToggleDecoration: offToggleDecoration,
      initialState: initialState,
      enabled: enabled,
      threshold: threshold,
      style: style,
    );
  }
}

/// The SBB Slide-To-Toggle with reduced toggle size.
class SBBSlideToToggleSmall extends SBBSlideToToggle {
  const SBBSlideToToggleSmall({
    super.key,
    required super.onActivate,
    required super.onDeactivate,
    required super.onToggleDecoration,
    required super.offToggleDecoration,
    super.initialState = .off,
    super.enabled = true,
    super.threshold = 0.9,
    super.style,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseSBBSlideToToggle(
      isSmall: true,
      onActivate: onActivate,
      onDeactivate: onDeactivate,
      onToggleDecoration: onToggleDecoration,
      offToggleDecoration: offToggleDecoration,
      initialState: initialState,
      enabled: enabled,
      threshold: threshold,
      style: style,
    );
  }
}

class _BaseSBBSlideToToggle extends StatefulWidget {
  const _BaseSBBSlideToToggle({
    required this.onActivate,
    required this.onDeactivate,
    required this.onToggleDecoration,
    required this.offToggleDecoration,
    this.initialState = .off,
    this.enabled = true,
    this.threshold = 0.9,
    this.style,
    this.isSmall = false,
  }) : assert(threshold >= 0 && threshold <= 1, 'threshold must be between 0 and 1.');

  final SBBSlideToToggleStyle? style;
  final bool enabled;
  final SBBSlideToggleDecoration onToggleDecoration;
  final SBBSlideToggleDecoration offToggleDecoration;
  final double threshold;
  final Future<void> Function() onActivate;
  final Future<void> Function() onDeactivate;
  final SBBSlideToToggleState initialState;
  final bool isSmall;

  @override
  State<_BaseSBBSlideToToggle> createState() => _SBBSlideToToggleState();
}

class _SBBSlideToToggleState extends State<_BaseSBBSlideToToggle> with SingleTickerProviderStateMixin {
  static const Duration _snapDuration = Duration(milliseconds: 200);
  static const Duration _bounceDuration = Duration(milliseconds: 320);

  late WidgetStatesController _statesController;
  late SBBSlideToToggleState _state;

  bool _loading = false;
  bool _isDragging = false;
  double _position = 0;
  double _trackSpan = 0;

  late final AnimationController _positionController;
  Animation<double>? _positionAnimation;

  @override
  void initState() {
    super.initState();
    _statesController = WidgetStatesController();
    _updateStatesController();

    _state = widget.initialState;
    _position = _targetPositionFor(_state);
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
  }

  void _updateStatesController() {
    _statesController.update(WidgetState.disabled, !widget.enabled);
  }

  @override
  void dispose() {
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

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: SBBSlideToToggleStyle.borderWidth),
        borderRadius: .circular(_toggleSize),
      ),
      padding: const EdgeInsets.all(4.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          _trackSpan = constraints.maxWidth - _toggleSize;
          return SizedBox(
            height: _toggleSize,
            width: double.infinity,
            child: Stack(
              children: [
                _slideTrack(effectiveStyle),
                _toggle(style: effectiveStyle),
              ],
            ),
          );
        },
      ),
    );
  }

  SBBSlideToggleDecoration get _toggleDecoration =>
      _state == .on ? widget.onToggleDecoration : widget.offToggleDecoration;

  double get _toggleSize => widget.isSmall ? SBBSlideToToggleStyle.toggleSizeSmall : SBBSlideToToggleStyle.toggleSize;

  bool get _isInteractive => widget.enabled && !_loading;

  Widget _slideTrack(SBBSlideToToggleStyle style) {
    final states = _statesController.value;
    final backgroundColor = style.backgroundColor?.resolve(states) ?? SBBColors.white;

    final helpOpacity = ((_state == .off ? 1 : 0) - _position).abs();

    return Positioned.fill(
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: SBBSlideToToggleStyle.borderShape,
        ),
        child: _loading
            ? SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: SBBSpacing.xSmall).copyWith(
                  right: SBBSpacing.medium + (_state == .on ? _toggleSize : 0.0),
                  left: SBBSpacing.medium + (_state == .off ? _toggleSize : 0.0),
                ),
                child: Center(
                  child: Opacity(
                    opacity: helpOpacity,
                    child: _addDefaultAncestorWithResolved(
                      foregroundColor: style.helpForegroundColor?.resolve(_statesController.value),
                      textStyle: style.helpTextStyle,
                      child: _resolveHelpWidget(),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _resolveHelpWidget() {
    final helpText = _toggleDecoration.helpLabelText;
    if (helpText != null) {
      return Text(
        helpText,
        textAlign: _state == .on ? .start : .end,
      );
    }

    return _toggleDecoration.helpLabel ?? SizedBox.shrink();
  }

  Widget _toggle({required SBBSlideToToggleStyle style}) {
    final states = _statesController.value;
    final loadingIndicatorColor = style.loadingIndicatorColor?.resolve(states);
    final toggleBackgroundColor = style.toggleBackgroundColor?.resolve(states);
    final dragOverlayColor = style.toggleOverlayColor?.resolve({...states, WidgetState.pressed});

    return Positioned(
      left: _trackSpan * _position,
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
                        : _addDefaultAncestorWithResolved(
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
      return FittedBox(
        fit: .scaleDown,
        child: Text(
          labelText,
          textAlign: .center,
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
      //return CupertinoActivityIndicator(color: color);
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

  static Widget _addDefaultAncestorWithResolved({
    required Widget child,
    required Color? foregroundColor,
    TextStyle? textStyle,
  }) {
    final resolvedTextStyle = textStyle?.copyWith(color: foregroundColor) ?? TextStyle(color: foregroundColor);
    return DefaultTextStyle.merge(
      style: resolvedTextStyle,
      child: IconTheme.merge(
        data: IconThemeData(color: foregroundColor),
        child: child,
      ),
    );
  }

  void _animateBounceBack() => _animateTo(_state == .on ? 1 : 0, duration: _bounceDuration, curve: Curves.bounceOut);

  Future<void> _commitActivate() => _commitToggleChange(nextState: .on, action: widget.onActivate);

  Future<void> _commitDeactivate() => _commitToggleChange(nextState: .off, action: widget.onDeactivate);

  Future<void> _commitToggleChange({
    required SBBSlideToToggleState nextState,
    required Future<void> Function() action,
  }) async {
    if (_loading || nextState == _state) return;

    _setLoading(true);
    _animateTo(_targetPositionFor(nextState));

    try {
      await action();
      if (!mounted) return;

      setState(() => _state = nextState);
    } catch (_) {
      if (!mounted) return;
      // TODO: rethrow?
      _animateTo(_targetPositionFor(_state));
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _statesController.update(.disabled, loading);
    setState(() {
      _loading = loading;
      if (loading) _isDragging = false;
    });
  }

  void _onDragStart(DragStartDetails d) {
    if (!_isInteractive) return;
    _positionController.stop();
    setState(() => _isDragging = true);
  }

  void _onDragUpdate(DragUpdateDetails d) {
    if (!_isInteractive || _trackSpan <= 0) return;

    setState(() {
      _position = (_position + d.delta.dx / _trackSpan).clamp(0.0, 1.0).toDouble();
    });
  }

  void _onDragEnd(DragEndDetails d) {
    if (!_isInteractive) return;

    setState(() => _isDragging = false);

    if (_state == .off && _position >= widget.threshold) {
      _commitActivate();
    } else if (_state == .on && _position <= (1 - widget.threshold)) {
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
