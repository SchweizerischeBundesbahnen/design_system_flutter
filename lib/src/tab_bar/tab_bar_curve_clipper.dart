import 'dart:math' as math;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class TabBarCurveClipper extends CustomClipper<Path> {
  TabBarCurveClipper(
    int from,
    int to,
    this.portrait,
    double animation,
    bool hover,
    this.positions,
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
  final bool portrait;
  final List<Offset> positions;
  final double _radius;

  late double _leftPercentage;
  late double _rightPercentage;

  @override
  Path getClip(Size size) {
    final hole = _getHolePosition(_left);
    final nextHole = _getHolePosition(_right);

    final leftShape = _HoleShape(hole, portrait, _leftPercentage);
    final rightShape = _HoleShape(nextHole, portrait, _rightPercentage);

    final isNeighbour = _right == _left + 1;
    final smallVersion = portrait && isNeighbour;

    final path = smallVersion
        ? _buildSmallVersionPath(leftShape, rightShape)
        : _buildNormalVersionPath(leftShape, rightShape);

    return _createFinalPath(path, size);
  }

  double _getHolePosition(int index) {
    return positions.elementAt(index).dx + _radius;
  }

  Path _createFinalPath(Path path, Size size) {
    return Path()
      ..addPath(path, Offset.zero)
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd
      ..close();
  }

  Path _buildSmallVersionPath(_HoleShape leftShape, _HoleShape rightShape) {
    return _fromLeft
        ? _buildPathFromLeft(leftShape, rightShape)
        : _buildPathFromRight(leftShape, rightShape);
  }

  Path _buildPathFromLeft(_HoleShape leftShape, _HoleShape rightShape) {
    return Path()
      ..moveTo(rightShape.pCurveRight.dx, rightShape.pCurveRight.dy)
      ..quadraticBezierTo(
        rightShape.cRight.dx,
        rightShape.cRight.dy,
        rightShape.pRight.dx,
        rightShape.pRight.dy,
      )
      ..quadraticBezierTo(
        rightShape.cBottomRight.dx,
        rightShape.cBottomRight.dy,
        rightShape.pBottom.dx,
        rightShape.pBottom.dy,
      )
      ..quadraticBezierTo(
        rightShape.cBottomLeft.dx,
        rightShape.cBottomLeft.dy,
        rightShape.pLeft.dx,
        rightShape.pLeft.dy,
      )
      ..quadraticBezierTo(
        leftShape.cRight.dx,
        leftShape.cRight.dy,
        leftShape.pRight.dx,
        leftShape.pRight.dy,
      )
      ..quadraticBezierTo(
        leftShape.cBottomRight.dx,
        leftShape.cBottomRight.dy,
        leftShape.pBottom.dx,
        leftShape.pBottom.dy,
      )
      ..quadraticBezierTo(
        leftShape.cBottomLeft.dx,
        leftShape.cBottomLeft.dy,
        leftShape.pLeft.dx,
        leftShape.pLeft.dy,
      )
      ..quadraticBezierTo(
        leftShape.cLeft.dx,
        leftShape.cLeft.dy,
        leftShape.pCurveLeft.dx,
        leftShape.pCurveLeft.dy,
      )
      ..close();
  }

  Path _buildPathFromRight(_HoleShape leftShape, _HoleShape rightShape) {
    return Path()
      ..moveTo(leftShape.pCurveLeft.dx, leftShape.pCurveLeft.dy)
      ..quadraticBezierTo(
        leftShape.cLeft.dx,
        leftShape.cLeft.dy,
        leftShape.pLeft.dx,
        leftShape.pLeft.dy,
      )
      ..quadraticBezierTo(
        leftShape.cBottomLeft.dx,
        leftShape.cBottomLeft.dy,
        leftShape.pBottom.dx,
        leftShape.pBottom.dy,
      )
      ..quadraticBezierTo(
        leftShape.cBottomRight.dx,
        leftShape.cBottomRight.dy,
        leftShape.pRight.dx,
        leftShape.pRight.dy,
      )
      ..quadraticBezierTo(
        rightShape.cLeft.dx,
        rightShape.cLeft.dy,
        rightShape.pLeft.dx,
        rightShape.pLeft.dy,
      )
      ..quadraticBezierTo(
        rightShape.cBottomLeft.dx,
        rightShape.cBottomLeft.dy,
        rightShape.pBottom.dx,
        rightShape.pBottom.dy,
      )
      ..quadraticBezierTo(
        rightShape.cBottomRight.dx,
        rightShape.cBottomRight.dy,
        rightShape.pRight.dx,
        rightShape.pRight.dy,
      )
      ..quadraticBezierTo(
        rightShape.cRight.dx,
        rightShape.cRight.dy,
        rightShape.pCurveRight.dx,
        rightShape.pCurveRight.dy,
      )
      ..close();
  }

  Path _buildNormalVersionPath(_HoleShape leftShape, _HoleShape rightShape) {
    return Path()
      ..moveTo(leftShape.pCurveLeft.dx, leftShape.pCurveLeft.dy)
      ..quadraticBezierTo(
        leftShape.cLeft.dx,
        leftShape.cLeft.dy,
        leftShape.pLeft.dx,
        leftShape.pLeft.dy,
      )
      ..quadraticBezierTo(
        leftShape.cBottomLeft.dx,
        leftShape.cBottomLeft.dy,
        leftShape.pBottom.dx,
        leftShape.pBottom.dy,
      )
      ..quadraticBezierTo(
        leftShape.cBottomRight.dx,
        leftShape.cBottomRight.dy,
        leftShape.pRight.dx,
        leftShape.pRight.dy,
      )
      ..quadraticBezierTo(
        leftShape.cRight.dx,
        leftShape.cRight.dy,
        leftShape.pCurveRight.dx,
        leftShape.pCurveRight.dy,
      )
      ..lineTo(rightShape.pCurveLeft.dx, rightShape.pCurveLeft.dy)
      ..quadraticBezierTo(
        rightShape.cLeft.dx,
        rightShape.cLeft.dy,
        rightShape.pLeft.dx,
        rightShape.pLeft.dy,
      )
      ..quadraticBezierTo(
        rightShape.cBottomLeft.dx,
        rightShape.cBottomLeft.dy,
        rightShape.pBottom.dx,
        rightShape.pBottom.dy,
      )
      ..quadraticBezierTo(
        rightShape.cBottomRight.dx,
        rightShape.cBottomRight.dy,
        rightShape.pRight.dx,
        rightShape.pRight.dy,
      )
      ..quadraticBezierTo(
        rightShape.cRight.dx,
        rightShape.cRight.dy,
        rightShape.pCurveRight.dx,
        rightShape.pCurveRight.dy,
      )
      ..close();
  }

  @override
  bool shouldReclip(TabBarCurveClipper oldClipper) {
    return oldClipper._left != _left ||
        oldClipper._right != _right ||
        oldClipper.portrait != portrait ||
        !oldClipper.positions.equals(positions) ||
        oldClipper._leftPercentage != _leftPercentage ||
        oldClipper._rightPercentage != _rightPercentage;
  }
}

class _HoleShape {
  _HoleShape(this.pos, bool portrait, this.percent) {
    final radius = (portrait ? 44.0 : 36.0) / 2.0;
    final tabTop = portrait ? 8.0 : 1.0;
    final space = portrait ? 4.0 : 2.0;

    // Define the positions for the hole shape
    left = pos - radius - space;
    right = pos + radius + space;
    vCenter = radius + tabTop;

    _offset = const Offset(32.0, 0.0);
    _controlOffset =
        const Offset(16.0, 0.0); // Adjust control offset for smoother curves

    // Initialize the points for the hole shape
    _initializePoints(radius, tabTop, space);
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

  void _initializePoints(double radius, double tabTop, double space) {
    const top = 0.0;
    final bottom = radius + radius;

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

  Offset get pLeft => _interpolate(_pTopLeft, _pCenterLeft);

  Offset get pRight => _interpolate(_pTopRight, _pCenterRight);

  Offset get pCenterLeft =>
      _interpolate(_pCenterLeft - _controlOffset, _pCenterLeft);

  Offset get pCenterRight =>
      _interpolate(_pCenterRight + _controlOffset, _pCenterRight);

  Offset get cLeft => _interpolate(_pTopLeft - _controlOffset, _pTopLeft);

  Offset get cRight => _interpolate(_pTopRight + _controlOffset, _pTopRight);

  Offset get cBottomCenter => _interpolate(_pTopCenter, _pBottomCenter);

  Offset get cBottomLeft =>
      _interpolate(_pTopCenter - _controlOffset, _pBottomLeft);

  Offset get cBottomRight =>
      _interpolate(_pTopCenter + _controlOffset, _pBottomRight);

  Offset get pBottom => _interpolate(_pTopCenter, _pBottomCenter);

  Offset _interpolate(Offset begin, Offset end) {
    return Tween(begin: begin, end: end).transform(percent);
  }
}
