import 'dart:math' as math;

import 'package:flutter/animation.dart';

/// Internal class that encapsulates the coordinates of the relevant Offsets for the individual hole shapes.
///
/// The relevant points for drawing are:
/// * theoretical curve begin and end: [curveBegin] and [curveEnd]
///   (theoretical since for direct neighbor animation, the curve will not begin / end there)
/// * the inflection points (where curvature changes): [inflectionPointLeft] and [inflectionPointRight]
/// * the [rectangle] formed by the shape
/// * the control points of the cubic bezier curve in the top left and top right part of the curvature:
///   ** [bezierControlZeroTopLeft]
///   ** [bezierControlOneTopLeft]
///   ** [bezierControlZeroTopRight]
///   ** [bezierControlOneTopRight]
///
/// These are all calculated relative to the shape's origin (center top).
///
/// ==a=======o======e===
/// === \          /
/// ==== b        d
/// ===== \     /
/// ======  _c_
///
/// a: curveBegin, b: inflectionPointLeft, b: bottom, d: inflectionPointRight, e: curveEnd, o: origin
///
/// The following are the principles to draw this HoleShape with respect to time:
///
/// * the upper parts (between a & b and c & d) are drawn using CubicBezierCurves since small deviations are not visible
/// * the lower part (between b & c) is drawn using the arcToPoint method to minimize error (more visible with rounded icon)
/// * this hole shape does not know how to draw these, it simply calculates the needed Offsets
/// * the dy of both inflection points wrt the origin are given by [percentage] * [outerRadius]
/// * the dx of both inflection points wrt the origin are given by dx = [outerRadius] * sqrt([percentage] * (2 - [percentage])
/// * the calculation of the control points of the CubicBezierCurves are based on these:
///   ** https://www.researchgate.net/publication/265893293_Approximation_of_a_cubic_bezier_curve_by_circular_arcs_and_vice_versa
///   ** with corrections from this blog post:https://hansmuller-flex.blogspot.com/2011/10/more-about-approximating-circular-arcs.html?showComment=1498749617507#c2109832351939371205class
///   ** and correction of numerical stability of k2 to k2 = (4/3) * (a.dx * by - a.dy * b.dx) / (sqrt(2 * q1 * q2) + q2)
///      for small deviations
class TabBarHoleShape {
  TabBarHoleShape({
    required this.origin,
    required this.outerRadius,
    required this.percentage,
  })  : _fullBottom = origin + Offset(0.0, outerRadius * 2),
        _inflectionOffsetX = outerRadius * math.sqrt(percentage * (2 - percentage)),
        _inflectionOffsetY = outerRadius * percentage {
    _calculateBezierControlPoints();
  }

  final double percentage;
  final Offset origin;
  final double outerRadius;
  final double _inflectionOffsetX; // dx
  final double _inflectionOffsetY; // dy

  late final Offset _bezierControlZeroTopLeft;
  late final Offset _bezierControlOneTopLeft;
  late final Offset _bezierControlZeroTopRight;
  late final Offset _bezierControlOneTopRight;

  /// The bottom at [percentage] == 1.
  final Offset _fullBottom;

  /// the point where curvature begins to separate from the baseline
  Offset get curveBegin => origin - Offset(_inflectionOffsetX * 2, 0.0);

  /// the point where curvature ends and joins with baseline
  Offset get curveEnd => origin + Offset(_inflectionOffsetX * 2, 0.0);

  /// the point where curvature changes on the left
  Offset get inflectionPointLeft => origin + Offset(-_inflectionOffsetX, _inflectionOffsetY);

  /// the point where curvature changes on the right
  Offset get inflectionPointRight => origin + Offset(_inflectionOffsetX, _inflectionOffsetY);

  /// the bottom point of the hole shape
  Offset get bottom => Tween(begin: origin, end: _fullBottom).transform(percentage);

  /// the rectangle of the hole with respect to time
  Rect get rectangle => Rect.fromCircle(center: _center(), radius: outerRadius);

  Offset get bezierControlZeroTopLeft => _bezierControlZeroTopLeft;

  Offset get bezierControlOneTopLeft => _bezierControlOneTopLeft;

  Offset get bezierControlZeroTopRight => _bezierControlZeroTopRight;

  Offset get bezierControlOneTopRight => _bezierControlOneTopRight;

  Offset _center() => origin + Offset(0.0, -outerRadius + 2 * outerRadius * percentage);

  void _calculateBezierControlPoints() {
    _calculateBezierPointsTopLeft();
    _calculateBezierPointsTopRight();
  }

  void _calculateBezierPointsTopLeft() {
    final center = origin + Offset(-_inflectionOffsetX * 2, outerRadius);
    final start = curveBegin;
    final end = inflectionPointLeft;
    final (Offset zero, Offset one) = _calculateBezierControlPointsOfCircularArc(center, start, end);
    _bezierControlZeroTopLeft = zero;
    _bezierControlOneTopLeft = one;
  }

  void _calculateBezierPointsTopRight() {
    final center = origin + Offset(_inflectionOffsetX * 2, outerRadius);
    final start = inflectionPointRight;
    final end = curveEnd;
    final (Offset zero, Offset one) = _calculateBezierControlPointsOfCircularArc(center, start, end);
    _bezierControlZeroTopRight = zero;
    _bezierControlOneTopRight = one;
  }

  (Offset, Offset) _calculateBezierControlPointsOfCircularArc(Offset center, Offset start, Offset end) {
    // following the implementation of https://www.researchgate.net/publication/265893293_Approximation_of_a_cubic_bezier_curve_by_circular_arcs_and_vice_versa
    // with corrections from this blog post:https://hansmuller-flex.blogspot.com/2011/10/more-about-approximating-circular-arcs.html?showComment=1498749617507#c2109832351939371205class
    // and correction of numerical stability of k2
    final a = start - center;
    final b = end - center;
    final q1 = a.dx * a.dx + a.dy * a.dy;
    final q2 = q1 + a.dx * b.dx + a.dy * b.dy;
    final k2 = (4 / 3) * (a.dx * b.dy - a.dy * b.dx) / (math.sqrt(2 * q1 * q2) + q2);

    return (
      Offset(center.dx + a.dx - k2 * a.dy, center.dy + a.dy + k2 * a.dx),
      Offset(center.dx + b.dx + k2 * b.dy, center.dy + b.dy - k2 * b.dx)
    );
  }
}
