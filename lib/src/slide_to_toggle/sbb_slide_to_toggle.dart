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
/// The component passes state changes to the callback [onChanged]. The parent widget
/// is responsible for updating the [value] and [isLoading] property to reflect the change.
/// Use [triggerMode] to define when the [onChanged] callback is triggered.
///
/// The [threshold] parameter determines how far the user must drag the toggle to
/// complete the state change. A threshold of 0.8 means the toggle must be dragged
/// 80% across the track to change state.
///
/// Use [SBBSlideToToggle] for the standard size, or [SBBSlideToToggleSmall] for a
/// reduced-size variant.
///
/// ## Sample code
///
/// ```dart
/// // Default Slide-To-Toggle
/// SBBSlideToToggle(
///   value: defaultValue,
///   onChanged: (state) => setState(() => defaultValue = state),
///   onToggleDecoration: SBBSlideToggleDecoration(
///     toggleLabelText: 'Stop',
///     helpLabelText: 'Drag to the left to stop',
///   ),
///   offToggleDecoration: SBBSlideToggleDecoration(
///     toggleLabelText: 'Start',
///     helpLabelText: 'Drag to the right to start',
///   ),
/// )
///
/// // Small variant with icons
/// SBBSlideToToggleSmall(
///   value: smallValue,
///   onChanged: (state) => setState(() => smallValue = state),
///   onToggleDecoration: SBBSlideToggleDecoration(
///     toggleIconData: SBBIcons.arrow_left_small,
///     helpLabelText: 'Drag to the left to stop',
///   ),
///   offToggleDecoration: SBBSlideToggleDecoration(
///     toggleIconData: SBBIcons.arrow_right_small,
///     helpLabelText: 'Drag to the right to start',
///   ),
/// )
/// ```
///
/// See also:
///
/// * [SBBSlideToToggleStyle], for customizing the appearance.
/// * [SBBSlideToggleDecoration], for configuring toggle and track content.
/// * [SBBSlideToToggleSmall], for a reduced-size variant.
/// * [SBBSlideToToggleTriggerMode], defines when the [onChanged] callback is triggered.
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=6666-1023)
class SBBSlideToToggle extends StatefulWidget {
  /// Creates an SBB Slide-To-Toggle.
  const SBBSlideToToggle({
    super.key,
    required this.value,
    required this.onChanged,
    required this.onToggleDecoration,
    required this.offToggleDecoration,
    this.isLoading = false,
    this.triggerMode = .onThresholdReached,
    this.threshold = 0.8,
    this.style,
  }) : assert(threshold >= 0 && threshold <= 1, 'threshold must be between 0 and 1.');

  /// State value of the Slide-To-Toggle
  final SBBSlideToToggleState value;

  /// Called when the user toggles the Slide-To-Toggle.
  ///
  /// The component passes the new value to the callback. The parent widget
  /// is responsible for updating the [value] and [isLoading] property to reflect the change.
  ///
  /// If this callback is null, the component will be displayed as disabled and will
  /// not respond to user gestures.
  final ValueChanged<SBBSlideToToggleState>? onChanged;

  /// Customizes this Slide-To-Toggle appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBSlideToToggleThemeData.style] of the theme found in [context].
  final SBBSlideToToggleStyle? style;

  /// Configuration for the toggle and track when in [SBBSlideToToggleState.on].
  ///
  /// This includes the toggle content (label text, icon, or custom widget)
  /// and the help text displayed in the track.
  final SBBSlideToggleDecoration onToggleDecoration;

  /// Configuration for the toggle and track when in [SBBSlideToToggleState.off].
  ///
  /// This includes the toggle content (label text, icon, or custom widget)
  /// and the help text displayed in the track.
  final SBBSlideToggleDecoration offToggleDecoration;

  /// The normalized drag threshold for state changes, between 0.0 and 1.0.
  ///
  /// Determines how far across the track (0.0 to 1.0) the user must drag
  /// the toggle to complete a state change. A value of 0.9 means 90% drag distance.
  final double threshold;

  /// Defines when the [onChanged] callback is triggered.
  final SBBSlideToToggleTriggerMode triggerMode;

  /// Whether to show a loading indicator instead of the toggle widget.
  ///
  /// If true, the toggle cannot be dragged and appears grayed out.
  final bool isLoading;

  @override
  State<SBBSlideToToggle> createState() => _SBBSlideToToggleState();
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
    required super.value,
    required super.onChanged,
    required super.onToggleDecoration,
    required super.offToggleDecoration,
    super.triggerMode,
    super.threshold,
    super.style,
    super.isLoading,
  });
}

class _SBBSlideToToggleState extends State<SBBSlideToToggle> with SingleTickerProviderStateMixin {
  static const Duration _snapDuration = Duration(milliseconds: 200);
  static const Duration _bounceDuration = Duration(milliseconds: 320);
  static const EdgeInsets _containerPadding = EdgeInsets.all(4.0);

  late WidgetStatesController _statesController;

  bool _isDragging = false;
  double _position = 0;

  late final AnimationController _positionController;
  Animation<double>? _positionAnimation;

  @override
  void initState() {
    super.initState();
    _statesController = WidgetStatesController();
    _updateStatesController();

    _position = _targetPositionFor(widget.value);
    _positionController = AnimationController(vsync: this, duration: _snapDuration)
      ..addListener(() {
        final value = _positionAnimation?.value;
        if (value == null) return;
        setState(() => _position = value);
      });
  }

  @override
  void didUpdateWidget(SBBSlideToToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.onChanged != oldWidget.onChanged) {
      _updateStatesController();
    }

    if (oldWidget.value != widget.value) {
      _animateTo(_targetPositionFor(widget.value));
    }
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
    final resolvedPadding = (style.helpWidgetPadding ?? EdgeInsets.zero).resolve(.ltr);
    final adjustedPadding = resolvedPadding.copyWith(
      right: resolvedPadding.right + (state == .on ? _toggleSize : 0.0),
      left: resolvedPadding.left + (state == .off ? _toggleSize : 0.0),
    );

    return ClipRect(
      clipper: _HelpWidgetClipper(position: _position, toggleSize: _toggleSize, state: state),
      child: Align(
        alignment: state == .off ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: adjustedPadding,
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
        maxLines: _isSmall ? 1 : 3,
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
                    child: widget.isLoading
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
        size: _isSmall ? 24.0 : 36.0,
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
      widget.value == .on ? widget.onToggleDecoration : widget.offToggleDecoration;

  double get _toggleSize => _isSmall ? SBBSlideToToggleStyle.toggleSizeSmall : SBBSlideToToggleStyle.toggleSize;

  bool get _isInteractive => widget.onChanged != null && !widget.isLoading;

  bool get _isSmall => widget is SBBSlideToToggleSmall;

  void _updateStatesController() {
    _statesController.update(WidgetState.disabled, !_isInteractive);
  }

  double _helpOpacityFor(SBBSlideToToggleState state) {
    final transition = (_position * 2).clamp(0.0, 1.0);
    return state == .off ? 1 - transition : transition;
  }

  double _targetPositionFor(SBBSlideToToggleState state) => state == .on ? 1 : 0;

  void _animateTo(double target, {Duration duration = _snapDuration, Curve curve = Curves.easeOut}) {
    _positionController.stop();

    _positionAnimation = Tween<double>(begin: _position, end: target).animate(
      CurvedAnimation(parent: _positionController, curve: curve),
    );

    _positionController
      ..duration = duration
      ..value = 0
      ..forward();
  }

  void _animateBounceBack() =>
      _animateTo(_targetPositionFor(widget.value), duration: _bounceDuration, curve: Curves.bounceOut);

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

    if (widget.triggerMode == .onThresholdReached && thresholdReached) {
      setState(() => _isDragging = false);
      widget.onChanged?.call(widget.value == .off ? .on : .off);
    }
  }

  void _onDragEnd(DragEndDetails d) {
    if (!_isInteractive) return;

    setState(() => _isDragging = false);
    if (thresholdReached) {
      widget.onChanged?.call(widget.value == .off ? .on : .off);
    } else {
      _animateBounceBack();
    }
  }

  void _onDragCancel() {
    if (!_isDragging) return;
    setState(() => _isDragging = false);
  }

  bool get thresholdReached {
    if (widget.value == .off && _position >= widget.threshold) return true;
    if (widget.value == .on && _position <= (1 - widget.threshold)) return true;
    return false;
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
