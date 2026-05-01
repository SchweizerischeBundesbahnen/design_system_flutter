import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// The SBB Slide-To-Toggle.
///
/// TODO
///
/// See also:
///
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=6666-1023)
class SBBSlideToToggle extends StatefulWidget {
  /// Creates an SBB Slide-To-Toggle.
  ///
  /// TODO: Docs, maybe asserts
  const SBBSlideToToggle({
    super.key,
    required this.onActivate,
    required this.onDeactivate,
    this.initialActive = false,
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

  // TODO:
  final double threshold;
  final Future<void> Function() onActivate;
  final Future<void> Function() onDeactivate;
  final bool initialActive;

  @override
  State<SBBSlideToToggle> createState() => _SBBSlideToToggleState();
}

class _SBBSlideToToggleState extends State<SBBSlideToToggle> with SingleTickerProviderStateMixin {
  static const Duration _snapDuration = Duration(milliseconds: 200);
  static const Duration _bounceDuration = Duration(milliseconds: 320);

  late WidgetStatesController _statesController;

  bool _active = false;
  bool _loading = false;
  double _position = 0; // 0..1 toggle position
  double _trackSpan = 0;

  late final AnimationController _positionController;
  Animation<double>? _positionAnimation;

  @override
  void initState() {
    super.initState();
    _statesController = WidgetStatesController();
    _updateStatesController();

    _active = widget.initialActive;
    _position = _targetPositionFor(_active);
    _positionController = AnimationController(vsync: this, duration: _snapDuration)
      ..addListener(() {
        final value = _positionAnimation?.value;
        if (value == null) return;
        setState(() {
          _position = value;
        });
      });
  }

  @override
  void didUpdateWidget(SBBSlideToToggle oldWidget) {
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

    final toggleTextStyle = effectiveStyle.toggleTextStyle?.resolve(states);
    final borderColor = effectiveStyle.borderColor?.resolve(states) ?? SBBColors.granite;
    final backgroundColor = effectiveStyle.backgroundColor?.resolve(states) ?? SBBColors.white;
    final toggleBackgroundColor = effectiveStyle.toggleBackgroundColor?.resolve(states) ?? SBBColors.white; // TODO:

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: SBBSlideToToggleStyle.borderWidth),
        borderRadius: .circular(_toggleSize),
      ),
      padding: const EdgeInsets.all(4.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          _trackSpan = constraints.maxWidth - _toggleSize;
          final toggleLeft = _trackSpan * _position;

          return SizedBox(
            height: _toggleSize,
            width: double.infinity,
            child: Stack(
              children: [
                _buildTrack(backgroundColor),
                _buildToggle(
                  toggleLeft: toggleLeft,
                  toggleBackgroundColor: toggleBackgroundColor,
                  toggleTextStyle: toggleTextStyle,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  double get _toggleSize => SBBSlideToToggleStyle.toggleSize;

  bool get _isInteractive => widget.enabled && !_loading;

  Widget _buildTrack(Color backgroundColor) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: SBBSlideToToggleStyle.borderShape,
        ),
      ),
    );
  }

  Widget _buildToggle({
    required double toggleLeft,
    required Color toggleBackgroundColor,
    required TextStyle? toggleTextStyle,
  }) {
    return Positioned(
      left: toggleLeft,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: Container(
          width: _toggleSize,
          height: _toggleSize,
          decoration: BoxDecoration(
            color: toggleBackgroundColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: _loading
              ? _loadingIndicator()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  // TODO: fit text to toggle
                  child: Text(
                    _active ? 'Slide to stop' : 'Slide to start',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: toggleTextStyle,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    // TODO: handle iOS / Android indicators
    return const CircularProgressIndicator(color: SBBColors.white);
  }

  double _targetPositionFor(bool isActive) => isActive ? 1 : 0;

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
        CurvedAnimation(
          parent: _positionController,
          curve: curve,
        ),
      ),
    );
  }

  void _animateBounceBack(double target) {
    _animateTo(target, duration: _bounceDuration, curve: Curves.bounceOut);
  }

  Future<void> _commitActivate() => _commitToggleChange(nextActive: true, action: widget.onActivate);

  Future<void> _commitDeactivate() => _commitToggleChange(nextActive: false, action: widget.onDeactivate);

  Future<void> _commitToggleChange({required bool nextActive, required Future<void> Function() action}) async {
    if (_loading) return;
    setState(() => _loading = true);
    _animateTo(_targetPositionFor(nextActive));

    try {
      await action();
      if (!mounted) return;

      setState(() {
        _active = nextActive;
        _loading = false;
        _position = _targetPositionFor(nextActive);
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _active = !nextActive;
      });
      _animateTo(_targetPositionFor(_active));
    }
  }

  void _onDragStart(DragStartDetails d) {
    if (!_isInteractive) return;
    _positionController.stop();
  }

  void _onDragUpdate(DragUpdateDetails d) {
    if (!_isInteractive) return;
    if (_trackSpan <= 0) return;

    setState(() {
      _position = (_position + d.delta.dx / _trackSpan).clamp(0.0, 1.0).toDouble();
    });
  }

  void _onDragEnd(DragEndDetails d) {
    if (!_isInteractive) return;

    if (!_active) {
      if (_position >= widget.threshold) {
        _commitActivate();
      } else {
        _animateBounceBack(0);
      }
    } else {
      if (_position <= (1 - widget.threshold)) {
        _commitDeactivate();
      } else {
        _animateBounceBack(1);
      }
    }
  }
}
