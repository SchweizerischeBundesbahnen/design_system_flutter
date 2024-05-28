import 'package:flutter/widgets.dart';

import '../../design_system_flutter.dart';

/// The SBB Logo also known as the SBB Signet. Use according to documentation.
///
/// See also:
///
/// * https://digital.sbb.ch/de/design-system-mobile-new/basics/brand
class SBBLogo extends StatelessWidget {
  const SBBLogo(
      {Key? key, this.height, this.width, this.color = SBBColors.white})
      : super(key: key);

  static const _defaultHeight = 14.0;
  static const _defaultWidth = 28.0;

  final double? height;
  final double? width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    return LayoutBuilder(
      builder: (context, constraints) {
        var targetHeight = 0.0;
        var targetWidth = 0.0;
        if (height != null) {
          if (height == double.infinity) {
            targetHeight = constraints.maxHeight;
          } else {
            targetHeight = height!;
          }
        }
        if (width != null) {
          if (width == double.infinity) {
            targetWidth = constraints.maxWidth;
          } else {
            targetWidth = width!;
          }
        }
        if (height == null && width == null) {
          targetHeight = _defaultHeight;
          targetWidth = _defaultWidth;
        }
        if (height != null && width == null) {
          targetWidth = targetHeight * (_defaultWidth / _defaultHeight);
        } else if (width != null && height == null) {
          targetHeight = targetWidth / (_defaultWidth / _defaultHeight);
        }

        final yRatio = targetHeight / _defaultHeight;
        final xRatio = targetWidth / _defaultWidth;

        final path = Path()
          ..moveTo(00.000 * xRatio, 07.000 * yRatio)
          ..lineTo(06.988 * xRatio, 14.000 * yRatio)
          ..lineTo(11.066 * xRatio, 14.000 * yRatio)
          ..lineTo(05.566 * xRatio, 08.609 * yRatio)
          ..lineTo(12.391 * xRatio, 08.609 * yRatio)
          ..lineTo(12.391 * xRatio, 14.000 * yRatio)
          ..lineTo(15.609 * xRatio, 14.000 * yRatio)
          ..lineTo(15.609 * xRatio, 08.609 * yRatio)
          ..lineTo(22.434 * xRatio, 08.609 * yRatio)
          ..lineTo(16.934 * xRatio, 14.000 * yRatio)
          ..lineTo(21.012 * xRatio, 14.000 * yRatio)
          ..lineTo(28.000 * xRatio, 07.000 * yRatio)
          ..lineTo(21.012 * xRatio, 00.000 * yRatio)
          ..lineTo(16.934 * xRatio, 00.000 * yRatio)
          ..lineTo(22.434 * xRatio, 05.391 * yRatio)
          ..lineTo(15.609 * xRatio, 05.391 * yRatio)
          ..lineTo(15.609 * xRatio, 00.000 * yRatio)
          ..lineTo(12.391 * xRatio, 00.000 * yRatio)
          ..lineTo(12.391 * xRatio, 05.391 * yRatio)
          ..lineTo(05.566 * xRatio, 05.391 * yRatio)
          ..lineTo(11.066 * xRatio, 00.000 * yRatio)
          ..lineTo(06.988 * xRatio, 00.000 * yRatio)
          ..lineTo(00.000 * xRatio, 07.000 * yRatio);

        return CustomPaint(
          size: Size(targetWidth, targetHeight),
          painter: _Painter(paint, path),
        );
      },
    );
  }
}

/// creates SBB  Logo
///
/// respects parent's size and scales accordingly
class SBBWebLogo extends StatelessWidget {
  const SBBWebLogo({
    Key? key,
    this.height,
    this.width,
    this.foregroundColor = SBBColors.white,
    this.backgroundColor = SBBColors.red,
    this.borderColor,
  }) : super(key: key);
  static const _defaultHeight = 20.0;
  static const _defaultWidth = 59.0;
  static const _defaultAspectRatio = _defaultWidth / _defaultHeight;

  final double? height;
  final double? width;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    Color resolvedBordercolor = borderColor ?? backgroundColor;
    return LayoutBuilder(
      builder: (context, constraints) {
        final Size targetSize = _determineTargetSize(
          constraints,
        );
        return Center(
          child: SizedBox.fromSize(
            size: targetSize,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(color: resolvedBordercolor),
              ),
              child: _SBBSignetPaint(
                color: foregroundColor,
                size: targetSize,
              ),
            ),
          ),
        );
      },
    );
  }

  Size _determineTargetSize(BoxConstraints constraints) {
    Size targetSize = _getUnconstrainedSize();
    targetSize = _constrainSize(targetSize, constraints);
    return targetSize;
  }

  Size _getUnconstrainedSize() {
    if (height == null && width == null) {
      return const Size(_defaultWidth, _defaultHeight);
    } else if (height != null && width == null) {
      return Size(height! * _defaultAspectRatio, height!);
    } else if (width != null && height == null) {
      return Size(width!, width! / _defaultAspectRatio);
    } else {
      return Size(width!, height!);
    }
  }

  Size _constrainSize(Size size, BoxConstraints constraints) {
    double targetHeight, targetWidth = 0.0;
    targetWidth = _getConstrainedValue(
      size.width,
      constraints.maxWidth,
    );
    targetHeight = _getConstrainedValue(
      size.height,
      constraints.maxHeight,
    );
    final bool isWidthConstraining =
        (targetHeight * _defaultAspectRatio) > targetWidth;

    if (isWidthConstraining) {
      targetHeight = targetWidth / _defaultAspectRatio;
    } else {
      targetWidth = targetHeight * _defaultAspectRatio;
    }
    return Size(targetWidth, targetHeight);
  }

  double _getConstrainedValue(double targetVal, double maxVal) =>
      targetVal > maxVal ? maxVal : targetVal;
}

class _SBBSignetPaint extends StatelessWidget {
  const _SBBSignetPaint({Key? key, required this.color, required this.size})
      : super(key: key);
  final Color color;
  final Size size;

  Path _sbbSignetPath(size) => Path()
    ..moveTo(size.width * 0.6110400, size.height * 0.8332450)
    ..lineTo(size.width * 0.6757517, size.height * 0.8332450)
    ..lineTo(size.width * 0.5886667, size.height * 0.5771800)
    ..lineTo(size.width * 0.6967433, size.height * 0.5771800)
    ..lineTo(size.width * 0.6967433, size.height * 0.8332450)
    ..lineTo(size.width * 0.7478233, size.height * 0.8332450)
    ..lineTo(size.width * 0.7478233, size.height * 0.5771800)
    ..lineTo(size.width * 0.8559067, size.height * 0.5771800)
    ..lineTo(size.width * 0.7687983, size.height * 0.8332450)
    ..lineTo(size.width * 0.8335200, size.height * 0.8332450)
    ..lineTo(size.width * 0.9443783, size.height * 0.5005650)
    ..lineTo(size.width * 0.8335200, size.height * 0.1668455)
    ..lineTo(size.width * 0.7687983, size.height * 0.1668455)
    ..lineTo(size.width * 0.8559067, size.height * 0.4239540)
    ..lineTo(size.width * 0.7478233, size.height * 0.4239540)
    ..lineTo(size.width * 0.7478233, size.height * 0.1668455)
    ..lineTo(size.width * 0.6967433, size.height * 0.1668455)
    ..lineTo(size.width * 0.6967433, size.height * 0.4239540)
    ..lineTo(size.width * 0.5886667, size.height * 0.4239540)
    ..lineTo(size.width * 0.6757517, size.height * 0.1668455)
    ..lineTo(size.width * 0.6110400, size.height * 0.1668455)
    ..lineTo(size.width * 0.5001717, size.height * 0.5005650)
    ..lineTo(size.width * 0.6110400, size.height * 0.8332450)
    ..close();

  Paint _paint(color) => Paint()
    ..style = PaintingStyle.fill
    ..color = color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: _Painter(_paint(color), _sbbSignetPath(size)),
    );
  }
}

class _Painter extends CustomPainter {
  const _Painter(this.paintObject, this.path);

  final Paint paintObject;
  final Path path;

  @override
  void paint(Canvas canvas, Size size) => canvas.drawPath(path, paintObject);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
