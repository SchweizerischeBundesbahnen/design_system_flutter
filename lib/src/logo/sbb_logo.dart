import 'package:flutter/widgets.dart';

import '../../sbb_design_system_mobile.dart';

/// The SBB Logo also known as the SBB Signet. Use according to documentation.
///
/// See also:
///
/// * https://digital.sbb.ch/de/design-system-mobile-new/basics/brand
class SBBLogo extends StatelessWidget {
  const SBBLogo({super.key, this.height, this.width, this.color = SBBColors.white});

  static const _defaultHeight = 14.0;
  static const _defaultWidth = 28.0;

  final double? height;
  final double? width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final paint =
        Paint()
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

        final path =
            Path()
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

        return CustomPaint(size: Size(targetWidth, targetHeight), painter: _Painter(paint, path));
      },
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
