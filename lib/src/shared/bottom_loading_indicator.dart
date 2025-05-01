import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

class BottomLoadingIndicator extends StatefulWidget {
  const BottomLoadingIndicator({
    super.key,
    this.circularBorderRadius = 0.0,
    this.height = 3.0,
    this.widthRatio = 0.3,
    this.duration = const Duration(seconds: 3),
  }) : assert(0.0 <= widthRatio && widthRatio <= 1.0);

  /// The BorderRadius to correct the clipping of the loading bar.
  ///
  /// If you use this [BottomLoadingIndicator] on a widget with rounded borders,
  /// make sure to set the [circularBorderRadius] equal to that rounding.
  ///
  /// This will round the bottomLeft and bottomRight corners of the [ClipRRect]
  /// to correctly clip the loading bar.
  ///
  /// Defaults to 0.
  final double circularBorderRadius;

  /// The height of the [BottomLoadingIndicator] in absolute pixels.
  ///
  /// Defaults to 3.
  final double height;

  /// The relative width of the [BottomLoadingIndicator] to its parent widget. Must be between 0.0 and 1.0.
  ///
  /// If the parent is 100px wide and the widthRatio is 0.2, the effective
  /// width of the [BottomLoadingIndicator] will be 20px.
  ///
  /// Defaults to 0.3.
  final double widthRatio;

  /// The duration of the animation of the [BottomLoadingIndicator].
  ///
  /// Defaults to 3 seconds.
  final Duration duration;

  @override
  State<BottomLoadingIndicator> createState() => _BottomLoadingIndicatorState();
}

class _BottomLoadingIndicatorState extends State<BottomLoadingIndicator> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  )..repeat();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-1, 0.0),
    end: const Offset(1, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = SBBBaseStyle.of(context).primaryColor!;

    return ClipRRect(
      borderRadius: _resolveBorderRadius(),
      child: SlideTransition(
        key: widget.key,
        transformHitTests: false,
        position: _offsetAnimation,
        // add a SizedBox with the height of the borderRadius to stop the ClipRRect from
        // clamping the values in borderRadius
        child: SizedBox(
          width: double.infinity,
          height: widget.circularBorderRadius > 0 ? widget.circularBorderRadius : widget.height,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              height: widget.height,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [SBBColors.white.withOpacity(0.0), color],
                    stops: [1.0 - widget.widthRatio, 1.0],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius _resolveBorderRadius() {
    return widget.circularBorderRadius > 0
        ? BorderRadius.only(
            bottomLeft: Radius.circular(widget.circularBorderRadius),
            bottomRight: Radius.circular(widget.circularBorderRadius),
          )
        : BorderRadius.zero;
  }
}
