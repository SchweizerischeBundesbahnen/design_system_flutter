import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// Represents the curves that define the shape of a tab in an animated tab bar,
/// particularly for a "wave" or "liquid" like animation.
///
/// This class calculates and manages the control points for Bezier curves
/// that form the animated shape of a tab as it expands and contracts.
/// The curves dynamically adjust based on the animation progress and
/// the proximity of neighboring tabs.
class TabCurves {
  /// The horizontal center of the tab's animation space.
  final double midX;

  /// The maximum radius of the wave effect, defining the overall scale
  /// of the tab's animated deformation.
  final double waveRadius;

  final double _circleWaveRadius;
  final double _twoWaveRadius;
  final double _piHalf = pi * 0.5;

  /// Points of the Bezier curve at the start of the animation.
  late final List<Offset> _startP;

  /// Points of the Bezier curve at the end of the animation.
  late final List<Offset> _endP;

  /// The primary anchor points of the Bezier curve.
  ///
  /// These points define the overall shape and extent of the wave.
  Offset p0 = Offset.zero;
  Offset p1 = Offset.zero;
  Offset p2 = Offset.zero;
  Offset p3 = Offset.zero;
  Offset p4 = Offset.zero;

  /// Control points for the Bezier curves, used to define the curvature
  /// between the primary anchor points.
  ///
  /// The naming convention `cXY` indicates a control point for the curve
  /// segment between `pX` and `pY`. For example, `c01` is a control point
  /// influencing the curve from `p0` to `p1`.
  Offset c01 = Offset.zero;
  Offset c10 = Offset.zero;
  Offset c12 = Offset.zero;
  Offset c21 = Offset.zero;
  Offset c23 = Offset.zero;
  Offset c32 = Offset.zero;
  Offset c34 = Offset.zero;
  Offset c43 = Offset.zero;

  double _progress = 0.0;
  double _leftProgress = 0.0;
  double _rightProgress = 0.0;
  bool _tight = false;

  /// Indicates whether the tab's curves are "tight" due to proximity
  /// to neighboring animated tabs.
  ///
  /// When `true`, the curves will adjust to avoid overlapping or
  /// creating undesirable visual artifacts with adjacent tabs.
  bool get tight => _tight; // Getter for tight

  /// Creates a [TabCurves] instance.
  ///
  /// - [midX]: The x-coordinate of the center of the tab.
  /// - [waveRadius]: The radius that defines the maximum extent of the wave
  ///   deformation.
  TabCurves({
    required this.midX,
    required this.waveRadius,
  }) : _circleWaveRadius = 0.552284749831 * waveRadius,
       _twoWaveRadius = waveRadius.toDouble() * 2 {
    // Define the relative starting positions for the anchor points.
    final startPos = [
      const Offset(-2.0, 0.0),
      const Offset(-1.0, 0.0),
      const Offset(0.0, 0.0),
      const Offset(1.0, 0.0),
      const Offset(2.0, 0.0),
    ];

    // Calculate the absolute starting positions for the anchor points
    // based on `midX` and `waveRadius`.
    _startP = List.generate(
      5,
      (index) => Offset(
        midX + startPos[index].dx * waveRadius,
        startPos[index].dy * waveRadius,
      ),
    );

    final endPos = [
      const Offset(-2.0, 0.0),
      const Offset(-1.0, 1.0),
      const Offset(0.0, 2.0),
      const Offset(1.0, 1.0),
      const Offset(2.0, 0.0),
    ];

    // Calculate the absolute ending positions for the anchor points.
    _endP = List.generate(
      5,
      (index) => Offset(
        midX + endPos[index].dx * waveRadius,
        endPos[index].dy * waveRadius,
      ),
    );
  }

  /// Updates the position of the curve's control points based on the
  /// current animation progress and the state of neighboring tabs.
  ///
  /// This method should be called on every animation frame to ensure the
  /// curves are correctly rendered.
  ///
  /// - [progress]: The current animation progress for this tab, typically
  ///   ranging from 0.0 (start) to 1.0 (end of animation).
  /// - [leftProgress]: The animation progress of the tab to the immediate left.
  ///   Used to calculate "tightness" and adjust curves to avoid overlaps.
  /// - [leftMidX]: The x-coordinate of the center of the tab to the immediate left.
  ///   Used for tightness calculations.
  /// - [rightProgress]: The animation progress of the tab to the immediate right.
  ///   Used to calculate "tightness" and adjust curves.
  /// - [rightMidX]: The x-coordinate of the center of the tab to the immediate right.
  ///   Used for tightness calculations.
  void setProgress(
    double progress,
    double leftProgress,
    double leftMidX,
    double rightProgress,
    double rightMidX,
  ) {
    _leftProgress = leftProgress;
    _rightProgress = rightProgress;
    _progress = progress;
    if (progress == 0.0) return;

    p0 = Offset(
      _startP[0].dx + progress * (_endP[0].dx - _startP[0].dx),
      _startP[0].dy,
    );

    p4 = Offset(
      _startP[4].dx + progress * (_endP[4].dx - _startP[4].dx),
      _startP[4].dy,
    );

    final leftWaveEnd = leftMidX + _twoWaveRadius;
    final beforeRightWave = rightMidX - _twoWaveRadius;

    // Determine if the curves are "tight" due to proximity to other tabs.
    // This happens if p0 (leftmost point) is too close to the right side of the left tab
    // or if p4 (rightmost point) is too close to the left side of the right tab.
    _tight =
        (leftMidX != 0 && p0.dx < leftWaveEnd) ||
        (rightMidX != 0 && p4.dx > beforeRightWave);

    // Calculate the vertical movement for p2 (center point of the wave).
    p2 = Offset(
      _startP[2].dx,
      _startP[2].dy + progress * (_endP[2].dy - _startP[2].dy),
    );

    // Adjust p2's horizontal position if "tight" to avoid collision.
    if (_tight) {
      if (leftProgress > progress) {
        p2 = Offset(
          p2.dx - (leftProgress - progress) * (_startP[2].dx - leftWaveEnd),
          p2.dy,
        );
      }

      if (rightProgress > progress) {
        p2 = Offset(
          p2.dx +
              (rightProgress - progress) * (beforeRightWave - _startP[2].dx),
          p2.dy,
        );
      }
    }

    // Calculate p1 and p3. Their behavior changes significantly when "tight".
    if (_tight) {
      // When tight, p1 and p3 are influenced by the neighboring tab's position.
      final p3LeftX = leftMidX + waveRadius;
      final p2LeftY = leftProgress * _twoWaveRadius;
      final p1RightX = rightMidX - waveRadius;
      final p2RightY = rightProgress * _twoWaveRadius;

      // Calculate relative progress to smooth the transition when becoming tight
      final leftProgressRelative = leftProgress / (leftProgress + progress);
      final rightProgressRelative = rightProgress / (rightProgress + progress);
      final p1X = _startP[1].dx + progress * (_endP[1].dx - _startP[1].dx);

      p1 = Offset(
        p1X - leftProgressRelative * (p1X - p3LeftX),
        p2LeftY + (p2.dy - p2LeftY) * 0.5,
      );

      final p3X = _startP[3].dx + progress * (_endP[3].dx - _startP[3].dx);

      p3 = Offset(
        p3X - rightProgressRelative * (p3X - p1RightX),
        p2RightY + (p2.dy - p2RightY) * 0.5,
      );
    } else {
      // When not tight, p1 and p3 move linearly with the animation progress.
      p1 = Offset(
        _startP[1].dx + progress * (_endP[1].dx - _startP[1].dx),
        _startP[1].dy + progress * (_endP[1].dy - _startP[1].dy),
      );

      p3 = Offset(
        _startP[3].dx + progress * (_endP[3].dx - _startP[3].dx),
        _startP[3].dy + progress * (_endP[3].dy - _startP[3].dy),
      );
    }

    // Calculate initial control points for the outermost segments.
    c01 = Offset(p0.dx + _circleWaveRadius, p0.dy);
    c43 = Offset(p4.dx - _circleWaveRadius, p4.dy);

    // Calculate control points for the middle segments.
    c21 = Offset(p2.dx - _circleWaveRadius, p2.dy);
    c23 = Offset(p2.dx + _circleWaveRadius, p2.dy);

    // Adjust control points for p1 and p3 based on "tightness" and progress.
    if (_tight) {
      // When tight, the control points are adjusted using trigonometric functions
      // to create a smoother, more constrained curve.
      final deltaLeft = progress - leftProgress;
      final alphaLeft = (1.0 - deltaLeft) * _piHalf;
      final deltaRight = rightProgress - progress;
      final alphaRight = (1.0 - deltaRight) * _piHalf;

      final rLeft = _circleWaveRadius * cos(alphaLeft).abs();
      final rRight = _circleWaveRadius * cos(alphaRight).abs();

      final cosLeft = cos(alphaLeft) * rLeft;
      final sinLeft = sin(alphaLeft) * rLeft;
      final cosRight = cos(alphaRight) * rRight;
      final sinRight = sin(alphaRight) * rRight;

      c10 = Offset(p1.dx - sinLeft, p1.dy - cosLeft);
      c12 = Offset(p1.dx + sinLeft, p1.dy + cosLeft);
      c32 = Offset(p3.dx - sinRight, p3.dy - cosRight);
      c34 = Offset(p3.dx + sinRight, p3.dy + cosRight);
    } else {
      // When not tight, control points are calculated based on a simpler
      // trigonometric function, creating a more open wave shape.
      final alpha = (1.0 - progress) * _piHalf;
      final r = _circleWaveRadius * cos(alpha).abs();
      final cosVal = cos(alpha) * r;
      final sinVal = sin(alpha) * r;

      c10 = Offset(p1.dx - sinVal, p1.dy - cosVal);
      c12 = Offset(p1.dx + sinVal, p1.dy + cosVal);
      c32 = Offset(p3.dx - sinVal, p3.dy + cosVal);
      c34 = Offset(p3.dx + sinVal, p3.dy - cosVal);
    }
  }

  /// Draws the calculated Bezier curves onto the provided [wavePath].
  ///
  /// This method should be called within a custom painter's `paint` method
  /// to render the tab's animated shape.
  ///
  /// - [wavePath]: The `ui.Path` object to which the curves will be added.
  void draw(ui.Path wavePath) {
    if (_progress == 0.0) {
      // If no progress, draw a simple horizontal line at the top.
      wavePath.lineTo(midX.toDouble(), 0.0);
    } else {
      // Draw the Bezier curves based on the calculated control points.
      // The outermost segments are only drawn if not "tight" or if the
      // corresponding neighboring tab is not active.
      if (!_tight || _leftProgress == 0.0) {
        wavePath.lineTo(p0.dx, p0.dy);
        wavePath.cubicTo(c01.dx, c01.dy, c10.dx, c10.dy, p1.dx, p1.dy);
      }
      wavePath.cubicTo(c12.dx, c12.dy, c21.dx, c21.dy, p2.dx, p2.dy);
      wavePath.cubicTo(c23.dx, c23.dy, c32.dx, c32.dy, p3.dx, p3.dy);
      if (!_tight || _rightProgress == 0.0) {
        wavePath.cubicTo(c34.dx, c34.dy, c43.dx, c43.dy, p4.dx, p4.dy);
      }
    }
  }
}
