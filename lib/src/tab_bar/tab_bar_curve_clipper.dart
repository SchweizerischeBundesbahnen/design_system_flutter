import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'tab_bar_draw_data.dart';

class TabBarCurveClipper extends CustomClipper<Path> {
  TabBarCurveClipper(
    this.position,
    this.previousPosition,
    this.selected,
    this.portrait,
    this.data,
    this.animation,
    this.selectedOverride,
  ) : _radius = (portrait ? 44.0 : 36.0) / 2.0;

  final double position;
  final double previousPosition;
  final int selected;
  final bool portrait;
  final TabBarDrawData data;
  final double animation;
  final int? selectedOverride;

  final double _radius;

  @override
  Path getClip(Size size) {
    final pos = position.toInt();
    final next = selectedOverride ?? math.min(pos + 1, data.positions.length - 1);

    final translateFrom = math.min(pos, next);
    final translateTo = math.max(pos, next);

    final hole = data.positions.values.elementAt(translateFrom) + _radius;
    final nextHole = data.positions.values.elementAt(translateTo) + _radius;
    final isNeighbour = translateTo == translateFrom + 1;

    final nextPercent = pos < next ? position % 1 : 1 - (position % 1);
    final percent = 1 - nextPercent;

    final shape1 = _HoleShape(
      hole,
      portrait,
      translateFrom == selectedOverride ? animation : percent,
    );
    final shape2 = _HoleShape(
      nextHole,
      portrait,
      translateTo == selectedOverride ? animation : nextPercent,
    );

    final path = Path()
      ..moveTo(shape1.pCurveLeft.dx, shape1.pCurveLeft.dy)
      ..quadraticBezierTo(shape1.cLeft.dx, shape1.cLeft.dy, shape1.pLeft.dx, shape1.pLeft.dy)
      ..cubicTo(shape1.cBottomLeft.dx, shape1.cBottomLeft.dy, shape1.cBottomRight.dx, shape1.cBottomRight.dy, shape1.pRight.dx, shape1.pRight.dy);

    if (portrait && (nextPercent > 0.0 || selectedOverride != null) && isNeighbour && data.paddingBetween < 64.0) {
      final c = Tween(begin: shape1.pRight.dx, end: shape2.pLeft.dx).transform(nextPercent);
      path.quadraticBezierTo(c, 0.0, shape2.pLeft.dx, shape2.pLeft.dy);
    } else {
      path
        ..quadraticBezierTo(shape1.cRight.dx, shape1.cRight.dy, shape1.pCurveRight.dx, shape1.pCurveRight.dy)
        ..moveTo(shape2.pCurveLeft.dx, shape2.pCurveLeft.dy)
        ..quadraticBezierTo(shape2.cLeft.dx, shape2.cLeft.dy, shape2.pLeft.dx, shape2.pLeft.dy);
    }

    path
      ..cubicTo(shape2.cBottomLeft.dx, shape2.cBottomLeft.dy, shape2.cBottomRight.dx, shape2.cBottomRight.dy, shape2.pRight.dx, shape2.pRight.dy)
      ..quadraticBezierTo(shape2.cRight.dx, shape2.cRight.dy, shape2.pCurveRight.dx, shape2.pCurveRight.dy);

    return Path()
      ..addPath(path, Offset.zero)
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd
      ..close();
  }

  @override
  bool shouldReclip(TabBarCurveClipper oldClipper) =>
      oldClipper.position != position ||
      oldClipper.previousPosition != previousPosition ||
      oldClipper.selected != selected ||
      oldClipper.portrait != portrait ||
      oldClipper.animation != animation ||
      oldClipper.selectedOverride != selectedOverride ||
      oldClipper.data != data;
}

class _HoleShape {
  _HoleShape(double pos, bool portrait, this.percent) {
    final radius = (portrait ? 44.0 : 36.0) / 2.0;
    final space = portrait ? 6.0 : 4.0;
    final bottomPadding = portrait ? 16.0 : 6.0;

    const top = 0.0;
    center = radius + space;
    final bottom = center + radius + bottomPadding;

    final right = pos + center;
    final left = pos - center;

    _offset = const Offset(32.0, top);
    _controlOffset = const Offset(16.0, top);
    _pTopCenter = Offset(pos, top);
    _pTopLeft = Offset(left, top);
    _pTopRight = Offset(right, top);
    _pCurveRight = _pTopRight + _offset;
    _pCurveLeft = _pTopLeft - _offset;
    _pCenterLeft = Offset(left, center);
    _pCenterRight = Offset(right, center);
    _pBottomLeft = Offset(left, bottom);
    _pBottomRight = Offset(right, bottom);
  }

  final double percent;
  late double center;

  late Offset _offset;
  late Offset _controlOffset;
  late Offset _pTopCenter;
  late Offset _pTopLeft;
  late Offset _pTopRight;
  late Offset _pCurveLeft;
  late Offset _pCurveRight;
  late Offset _pCenterLeft;
  late Offset _pCenterRight;
  late Offset _pBottomLeft;
  late Offset _pBottomRight;

  Offset get pCurveRight => _pCurveRight;

  Offset get pCurveLeft => _pCurveLeft;

  Offset get pRight => Tween(begin: _pTopRight, end: _pCenterRight).transform(percent);

  Offset get pLeft => Tween(begin: _pTopLeft, end: _pCenterLeft).transform(percent);

  Offset get cRight => Tween(begin: _pTopRight + _controlOffset, end: _pTopRight).transform(percent);

  Offset get cLeft => Tween(begin: _pTopLeft - _controlOffset, end: _pTopLeft).transform(percent);

  Offset get cBottomRight => Tween(begin: _pTopCenter, end: _pBottomRight).transform(percent);

  Offset get cBottomLeft => Tween(begin: _pTopCenter, end: _pBottomLeft).transform(percent);
}
