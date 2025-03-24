import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/tab_bar/clipper/tab_bar_hole_shape.dart';
import 'package:sbb_design_system_mobile/src/tab_bar/common/tab_bar_animation.dart';
import 'package:sbb_design_system_mobile/src/tab_bar/common/tab_bar_layout.dart';

final class TabBarCurveClipper extends CustomClipper<Path> {
  TabBarCurveClipper({
    required this.layout,
    required this.animation,
  }) : _holeShapes = _initAllHoleShapes(layout, animation);

  final TabBarLayout layout;
  final TabBarAnimation animation;
  final List<TabBarHoleShape> _holeShapes;

  @override
  Path getClip(Size size) {
    Path path = Path();

    if (!animation.isChanging) {
      path = _drawTimelessHole();
    } else if (_isTightNeighbor()) {
      path = _drawTightNeighboringHoles();
    } else {
      path = _drawSeparatedHoles();
    }

    return _cutoutFromFilledRectangle(path, size);
  }

  @override
  bool shouldReclip(TabBarCurveClipper oldClipper) => oldClipper.layout != layout || oldClipper.animation != animation;

  static List<TabBarHoleShape> _initAllHoleShapes(TabBarLayout layout, TabBarAnimation animation) {
    return layout.outerPositions.mapIndexed(
      (idx, value) {
        double percentage = 0;
        if (idx == animation.index) {
          percentage = animation.percentage;
        } else if (idx == animation.previousIndex) {
          percentage = animation.previousPercentage;
        }

        return TabBarHoleShape(
          origin: value + Offset(layout.outerRadius, 0.0),
          outerRadius: layout.outerRadius,
          percentage: percentage,
        );
      },
    ).toList();
  }

  bool _isTightNeighbor() => layout.isTightLayout && (animation.previousIndex - animation.index).abs() <= 1;

  Path _drawTightNeighboringHoles() {
    final leftShape = _holeShapes[animation.leftIndex];
    final rightShape = _holeShapes[animation.rightIndex];

    Path path = Path();
    path
      ..moveTo(leftShape.curveBegin.dx, leftShape.curveBegin.dy)
      ..cubicToFromOffsets(
          leftShape.bezierControlZeroTopLeft, leftShape.bezierControlOneTopLeft, leftShape.inflectionPointLeft)
      ..arcToPoint(leftShape.inflectionPointRight, radius: Radius.circular(layout.outerRadius), clockwise: false);
    if (animation.rightPercentage < 0.5) {
      path.cubicToFromOffsets(
        leftShape.bezierControlZeroTopRight,
        leftShape.bezierControlOneTopRight,
        rightShape.inflectionPointLeft,
      );
    } else {
      path.cubicToFromOffsets(
        rightShape.bezierControlZeroTopLeft,
        rightShape.bezierControlOneTopLeft,
        rightShape.inflectionPointLeft,
      );
    }
    path
      ..arcToPoint(rightShape.inflectionPointRight, radius: Radius.circular(layout.outerRadius), clockwise: false)
      ..cubicToFromOffsets(
          rightShape.bezierControlZeroTopRight, rightShape.bezierControlOneTopRight, rightShape.curveEnd)
      ..close();
    return path;
  }

  Path _drawSeparatedHoles() {
    final leftShape = _holeShapes[animation.leftIndex];
    final rightShape = _holeShapes[animation.rightIndex];

    return Path()
      ..addPath(_drawSingleShape(leftShape), Offset.zero)
      ..addPath(_drawSingleShape(rightShape), Offset.zero);
  }

  Path _drawTimelessHole() => _drawSingleShape(_holeShapes[animation.index]);

  Path _drawSingleShape(TabBarHoleShape shape) => Path()
    ..moveTo(shape.curveBegin.dx, shape.curveBegin.dy)
    ..cubicToFromOffsets(shape.bezierControlZeroTopLeft, shape.bezierControlOneTopLeft, shape.inflectionPointLeft)
    ..arcToPoint(shape.inflectionPointRight, radius: Radius.circular(layout.outerRadius), clockwise: false)
    ..cubicToFromOffsets(shape.bezierControlZeroTopRight, shape.bezierControlOneTopRight, shape.curveEnd)
    ..close();

  Path _cutoutFromFilledRectangle(Path path, Size size) => Path()
    ..addPath(path, Offset.zero)
    ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
    ..fillType = PathFillType.evenOdd
    ..close();
}

extension _PathExtension on Path {
  cubicToFromOffsets(Offset one, Offset two, Offset three) =>
      cubicTo(one.dx, one.dy, two.dx, two.dy, three.dx, three.dy);
}
