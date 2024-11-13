import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// The SBB LoadingIndicator. Use according to documentation.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/loading_indicator>
class SBBLoadingIndicator extends StatelessWidget {
  /// Creates a 'default' sized loading indicator in [SBBColors.red].
  const SBBLoadingIndicator({Key? key}) : this.medium(key: key);

  /// Creates a custom loading indicator.
  const SBBLoadingIndicator.custom({
    Key? key,
    required this.squareWidth,
    required this.squareHeight,
    required this.squareSpacing,
    required this.translationZ,
    required this.rotationY,
    required this.padding,
    required this.color,
  }) : super(key: key);

  /// A tiny loading indicator.
  const SBBLoadingIndicator.tiny({Key? key, Color color = SBBColors.red})
      : this.custom(
          key: key,
          squareWidth: 8,
          squareHeight: 6.0,
          squareSpacing: 2.0,
          translationZ: 0.01,
          rotationY: -1.2,
          padding: 8.0,
          color: color,
        );

  /// A tiny loading indicator in [SBBColors.cloud].
  const SBBLoadingIndicator.tinyCloud({Key? key})
      : this.tiny(
          key: key,
          color: SBBColors.cloud,
        );

  /// A tiny loading indicator in [SBBColors.smoke].
  const SBBLoadingIndicator.tinySmoke({Key? key})
      : this.tiny(
          key: key,
          color: SBBColors.smoke,
        );

  /// A tiny loading indicator in [SBBColors.cement].
  const SBBLoadingIndicator.tinyCement({Key? key})
      : this.tiny(
          key: key,
          color: SBBColors.cement,
        );

  /// A medium loading indicator in [SBBColors.red].
  const SBBLoadingIndicator.medium({Key? key, Color color = SBBColors.red})
      : this.custom(
          key: key,
          squareWidth: 29.0,
          squareHeight: 18.0,
          squareSpacing: 4.5,
          translationZ: 0.0035,
          rotationY: -1.3,
          padding: 32.0,
          color: color,
        );

  /// A medium loading indicator in [SBBColors.cloud].
  const SBBLoadingIndicator.mediumCloud({Key? key})
      : this.medium(
          key: key,
          color: SBBColors.cloud,
        );

  /// The width of a 'window' before transformation.
  final double squareWidth;

  /// The height of a 'window' before transformation.
  final double squareHeight;

  // The distance between two 'windows' before transformation.
  final double squareSpacing;

  // Translation of z axis. Scales the loading indicator (in combination with
  // rotation).
  final double translationZ;

  // Rotation around (center right, see [FractionalOffset]) y axis. Gives the
  // impression of perspective.
  final double rotationY;

  /// The top/bottom padding of the whole loading indicator.
  final double padding;

  /// The color of the loading indicator, before alpha is applied.
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding, bottom: padding),
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, translationZ)
          ..rotateY(rotationY),
        alignment: FractionalOffset.centerRight,
        child: LoadingAnimation(
          squareWidth: squareWidth,
          squareHeight: squareHeight,
          squareSpacing: squareSpacing,
          color: color,
        ),
      ),
    );
  }
}

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({
    required this.squareWidth,
    required this.squareHeight,
    required this.squareSpacing,
    required this.color,
  });

  final double squareWidth;
  final double squareHeight;
  final double squareSpacing;
  final Color color;

  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _loadingSquareOne;
  late Animation<double> _loadingSquareTwo;
  late Animation<double> _loadingSquareThree;
  late Animation<double> _loadingSquareFour;
  late Animation<double> _loadingSquareFive;
  late Animation<Offset> _container;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 230),
      vsync: this,
    )..repeat();
    _loadingSquareOne = Tween(begin: 0.5, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
    _loadingSquareTwo = Tween(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
    _loadingSquareThree = Tween(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
    _loadingSquareFour = Tween(begin: 0.25, end: 0.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
    _loadingSquareFive = Tween(begin: 0.0, end: 0.25).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
    _container =
        Tween<Offset>(begin: Offset.zero, end: const Offset(-0.2, 0.0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _container,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Square(
                opacity: _loadingSquareOne.value,
                width: widget.squareWidth,
                height: widget.squareHeight,
                spacing: widget.squareSpacing,
                color: widget.color,
              ),
              _Square(
                opacity: _loadingSquareTwo.value,
                width: widget.squareWidth,
                height: widget.squareHeight,
                spacing: widget.squareSpacing,
                color: widget.color,
              ),
              _Square(
                opacity: _loadingSquareThree.value,
                width: widget.squareWidth,
                height: widget.squareHeight,
                spacing: widget.squareSpacing,
                color: widget.color,
              ),
              _Square(
                opacity: _loadingSquareFour.value,
                width: widget.squareWidth,
                height: widget.squareHeight,
                spacing: widget.squareSpacing,
                color: widget.color,
              ),
              _Square(
                opacity: _loadingSquareFive.value,
                width: widget.squareWidth,
                height: widget.squareHeight,
                spacing: widget.squareSpacing,
                color: widget.color,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Square extends StatelessWidget {
  const _Square({
    Key? key,
    this.width = 29,
    this.height = 18,
    this.spacing = 4.5,
    this.opacity = 1,
    this.color = SBBColors.red,
  }) : super(key: key);

  final double width;
  final double height;
  final double spacing;
  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        margin: EdgeInsetsDirectional.only(end: spacing),
        width: width,
        height: height,
        color: color,
      ),
    );
  }
}
