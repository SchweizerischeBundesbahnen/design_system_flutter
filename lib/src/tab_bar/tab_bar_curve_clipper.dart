import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'tab_bar_draw_data.dart';

class TabBarCurveClipper extends CustomClipper<Path> {
  TabBarCurveClipper(
    int from,
    int to,
    this.portrait,
    this.data,
    double animation,
    bool hover,
  )   : _left = math.min(from, to),
        _right = math.max(from, to),
        _fromLeft = from < to,
        _radius = (portrait ? 44.0 : 36.0) / 2.0 {
    _leftPercentage = from > to ? animation : (hover ? 1 : 1 - animation);
    _rightPercentage = from > to ? (hover ? 1 : 1 - animation) : animation;
  }

  final int _left;
  final int _right;
  final bool _fromLeft;
  late double _leftPercentage;
  late double _rightPercentage;
  final bool portrait;
  final TabBarDrawData data;

  final double _radius;

  @override
  Path getClip(Size size) {
    final hole = data.positions.values.elementAt(_left) + _radius;
    final nextHole = data.positions.values.elementAt(_right) + _radius;

    final leftShape = _HoleShape(
      hole,
      portrait,
      _leftPercentage,
    );
    final rightShape = _HoleShape(
      nextHole,
      portrait,
      _rightPercentage,
    );

    final isNeighbour = _right == _left + 1;
    final smallVersion = portrait && isNeighbour;

    var path;

    if (smallVersion) {
      if (_fromLeft) {
        path = Path()
        ..moveTo(rightShape.pCurveRight.dx, rightShape.pCurveRight.dy)
          ..quadraticBezierTo(rightShape.cRight.dx, rightShape.cRight.dy, rightShape.pRight.dx, rightShape.pRight.dy)
          ..quadraticBezierTo(rightShape.cBottomRight.dx, rightShape.cBottomRight.dy, rightShape.pBottom.dx, rightShape.pBottom.dy)
          ..quadraticBezierTo(rightShape.cBottomLeft.dx, rightShape.cBottomRight.dy, rightShape.pLeft.dx, rightShape.pLeft.dy)

          ..quadraticBezierTo(leftShape.cRight.dx, leftShape.cRight.dy, leftShape.pRight.dx, leftShape.pRight.dy)

          ..quadraticBezierTo(leftShape.cBottomRight.dx, leftShape.cBottomRight.dy, leftShape.pBottom.dx, leftShape.pBottom.dy)
          ..quadraticBezierTo(leftShape.cBottomLeft.dx, leftShape.cBottomLeft.dy, leftShape.pLeft.dx, leftShape.pLeft.dy)
          ..quadraticBezierTo(leftShape.cLeft.dx, leftShape.cLeft.dy, leftShape.pCurveLeft.dx, leftShape.pCurveLeft.dy)
          ..close();
      } else {
        path = Path()
          ..moveTo(leftShape.pCurveLeft.dx, leftShape.pCurveLeft.dy)
          ..quadraticBezierTo(leftShape.cLeft.dx, leftShape.cLeft.dy, leftShape.pLeft.dx, leftShape.pLeft.dy)
          ..quadraticBezierTo(leftShape.cBottomLeft.dx, leftShape.cBottomLeft.dy, leftShape.pBottom.dx, leftShape.pBottom.dy)
          ..quadraticBezierTo(leftShape.cBottomRight.dx, leftShape.cBottomRight.dy, leftShape.pRight.dx, leftShape.pRight.dy)

          ..quadraticBezierTo(rightShape.cLeft.dx, rightShape.cLeft.dy, rightShape.pLeft.dx, rightShape.pLeft.dy)

          ..quadraticBezierTo(rightShape.cBottomLeft.dx, rightShape.cBottomLeft.dy, rightShape.pBottom.dx, rightShape.pBottom.dy)
          ..quadraticBezierTo(rightShape.cBottomRight.dx, rightShape.cBottomRight.dy, rightShape.pRight.dx, rightShape.pRight.dy)
          ..quadraticBezierTo(rightShape.cRight.dx, rightShape.cRight.dy, rightShape.pCurveRight.dx, rightShape.pCurveRight.dy)
          ..close();
      }
    } else {
      path = Path()
        ..moveTo(leftShape.pCurveLeft.dx, leftShape.pCurveLeft.dy)
        ..quadraticBezierTo(leftShape.cLeft.dx, leftShape.cLeft.dy, leftShape.pLeft.dx, leftShape.pLeft.dy)
        ..quadraticBezierTo(leftShape.cBottomLeft.dx, leftShape.cBottomLeft.dy, leftShape.pBottom.dx, leftShape.pBottom.dy)
        ..quadraticBezierTo(leftShape.cBottomRight.dx, leftShape.cBottomRight.dy, leftShape.pRight.dx, leftShape.pRight.dy)
        ..quadraticBezierTo(leftShape.cRight.dx, leftShape.cRight.dy, leftShape.pCurveRight.dx, leftShape.pCurveRight.dy)

        ..lineTo(rightShape.pCurveLeft.dx, rightShape.pCurveLeft.dy)

        ..quadraticBezierTo(rightShape.cLeft.dx, rightShape.cLeft.dy, rightShape.pLeft.dx, rightShape.pLeft.dy)
        ..quadraticBezierTo(rightShape.cBottomLeft.dx, rightShape.cBottomLeft.dy, rightShape.pBottom.dx, rightShape.pBottom.dy)
        ..quadraticBezierTo(rightShape.cBottomRight.dx, rightShape.cBottomRight.dy, rightShape.pRight.dx, rightShape.pRight.dy)
        ..quadraticBezierTo(rightShape.cRight.dx, rightShape.cRight.dy, rightShape.pCurveRight.dx, rightShape.pCurveRight.dy)
        ..close();
    }

    return Path()
      ..addPath(path, Offset.zero)
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd
      ..close();
  }

  @override
  bool shouldReclip(TabBarCurveClipper oldClipper) =>
      oldClipper._left != _left ||
      oldClipper._right != _right ||
      oldClipper.portrait != portrait ||
      oldClipper.data != data ||
      oldClipper._leftPercentage != _leftPercentage ||
      oldClipper._rightPercentage != _rightPercentage;
}

class _HoleShape {
  _HoleShape(this.pos, bool portrait, this.percent) {
    final radius = (portrait ? 44.0 : 36.0) / 2.0;
    final tabTop = portrait ? 8.0 : 1.0;
    final space = portrait ? 4.0 : 2.0;

    const top = 0.0;
    final bottom = radius + radius;

    left = pos - radius - space;
    right = pos + radius + space;
    vCenter = radius + tabTop;

    _offset = const Offset(32.0, top);
    _controlOffset = const Offset(16.0, top);
    _pTopLeft = Offset(left, top);
    _pTopRight = Offset(right, top);
    _pTopCenter = Offset(pos, top);
    _pCurveLeft = _pTopLeft - _offset;
    _pCurveRight = _pTopRight + _offset;
    _pCenterLeft = Offset(left, vCenter);
    _pCenterRight = Offset(right, vCenter);
    _pBottomLeft = Offset(left + space, bottom + tabTop + space);
    _pBottomRight = Offset(right - space, bottom + tabTop + space);
    _pBottomCenter = Offset(pos, bottom + tabTop + space);
  }

  final double percent;
  final double pos;

  late double right;
  late double left;
  late double vCenter;
  late Offset _offset;
  late Offset _controlOffset;
  late Offset _pTopLeft;
  late Offset _pTopRight;
  late Offset _pTopCenter;
  late Offset _pCurveLeft;
  late Offset _pCurveRight;
  late Offset _pCenterLeft;
  late Offset _pCenterRight;
  late Offset _pBottomLeft;
  late Offset _pBottomRight;
  late Offset _pBottomCenter;

  Offset get pCurveLeft => _pCurveLeft;

  Offset get pCurveRight => _pCurveRight;

  Offset get pLeft => Tween(begin: _pTopLeft, end: _pCenterLeft).transform(percent);

  Offset get pRight => Tween(begin: _pTopRight, end: _pCenterRight).transform(percent);

  Offset get pCenterLeft => Tween(begin: _pCenterLeft - _controlOffset, end: _pCenterLeft).transform(percent);

  Offset get pCenterRight => Tween(begin: _pCenterRight + _controlOffset, end: _pCenterRight).transform(percent);

  Offset get cLeft => Tween(begin: _pTopLeft - _controlOffset, end: _pTopLeft).transform(percent);

  Offset get cRight => Tween(begin: _pTopRight + _controlOffset, end: _pTopRight).transform(percent);

  Offset get cBottomCenter => Tween(begin: _pTopCenter, end: _pBottomCenter).transform(percent);

  Offset get cBottomLeft => Tween(begin: _pTopCenter - _controlOffset, end: _pBottomLeft).transform(percent);

  Offset get cBottomRight => Tween(begin: _pTopCenter + _controlOffset, end: _pBottomRight).transform(percent);

  Offset get pBottom => Tween(begin: _pTopCenter, end: _pBottomCenter).transform(percent);
}