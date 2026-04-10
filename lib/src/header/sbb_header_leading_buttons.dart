import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'sbb_header_style_scope.dart';
import 'theme/default_sbb_header_theme_data.dart';

/// An SBB-styled "menu" leading button for use in [SBBHeader].
///
/// If [onPressed] is null, the button defaults to `Scaffold.of(context).openDrawer()`.
class SBBHeaderLeadingMenuButton extends StatelessWidget {
  const SBBHeaderLeadingMenuButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  static const double leadingWidth = _width + _horizontalPadding * 2;

  static const double _height = 16.0;
  static const double _width = 20.718;
  static const double _horizontalPadding = 16.688;

  static final Path _iconPath = Path()
    ..moveTo(0.0, 1.0)
    ..lineTo(20.718, 1.0)
    ..moveTo(0.0, 8.0)
    ..lineTo(20.718, 8.0)
    ..moveTo(0.0, 15.0)
    ..lineTo(20.718, 15.0);

  @override
  Widget build(BuildContext context) {
    final iconColor = SBBHeaderStyleScope.of(context).foregroundColor ?? defaultForegroundColor;
    return _IconButton(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
      icon: CustomPaint(
        painter: _IconPainter(path: _iconPath, color: iconColor),
        size: Size(_width, _height),
      ),
      onPressed: onPressed ?? () => Scaffold.of(context).openDrawer(),
      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
    );
  }
}

/// An SBB-styled "back" leading button for use in [SBBHeader].
///
/// This button renders a platform specific icon.
/// - On iOS, a chevron.
/// - On Android, a back arrow.
///
/// If [onPressed] is null, the button defaults to `Navigator.maybePop(context)`.
class SBBHeaderLeadingBackButton extends StatelessWidget {
  const SBBHeaderLeadingBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  static double leadingWidth(BuildContext context) {
    final isAndroid = Theme.of(context).platform == TargetPlatform.android;
    final width = isAndroid ? _androidWidth : _iosWidth;
    return width + _horizontalPadding * 2;
  }

  static const double _horizontalPadding = 18.027;

  // iOS back button
  static const double _iosHeight = 15.401;
  static const double _iosWidth = 10.025;
  static final Path _iosIconPath = Path()
    ..moveTo(9.322, 0.711)
    ..lineTo(1.422, 8.519)
    ..lineTo(9.322, 16.327);

  static const double _androidHeight = 18.0;
  static const double _androidWidth = 17.0;
  static final Path _androidIconPath = Path()
    ..moveTo(10.0, 1.39746)
    ..lineTo(3.79492, 7.60254)
    ..lineTo(17.0, 7.60254)
    ..lineTo(17.0, 9.60254)
    ..lineTo(3.79492, 9.60254)
    ..lineTo(10.0, 15.8086)
    ..lineTo(8.60254, 17.2051)
    ..lineTo(0.0, 8.60254)
    ..lineTo(8.60254, 0.0)
    ..lineTo(10.0, 1.39746)
    ..close();

  @override
  Widget build(BuildContext context) {
    return _IconButton(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
      icon: _icon(context),
      onPressed: onPressed ?? () => Navigator.maybePop(context),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
    );
  }

  Widget _icon(BuildContext context) {
    final bool isAndroid = Theme.of(context).platform == TargetPlatform.android;

    // iOS chevron is a stroked path; Android arrow is a filled shape.
    final paintingStyle = isAndroid ? PaintingStyle.fill : PaintingStyle.stroke;
    final strokeWidth = isAndroid ? 0.0 : 2.0;

    return CustomPaint(
      painter: _IconPainter(
        path: isAndroid ? _androidIconPath : _iosIconPath,
        color: SBBHeaderStyleScope.of(context).foregroundColor ?? defaultForegroundColor,
        style: paintingStyle,
        strokeWidth: strokeWidth,
      ),
      size: Size(
        isAndroid ? _androidWidth : _iosWidth,
        isAndroid ? _androidHeight : _iosHeight,
      ),
    );
  }
}

/// An SBB-styled "close" leading button for use in [SBBHeader].
///
/// If [onPressed] is null, the button defaults to `Navigator.maybePop(context)`.
class SBBHeaderLeadingCloseButton extends StatelessWidget {
  const SBBHeaderLeadingCloseButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  static const double leadingWidth = _width + _horizontalPadding * 2;

  static const double _height = 15.401;
  static const double _width = 15.177;
  static const double _horizontalPadding = 15.974;

  static final Path _iconPath = Path()
    ..moveTo(0.713, 0.701)
    ..lineTo(14.463, 14.701)
    ..moveTo(0.713, 14.701)
    ..lineTo(14.463, 0.701);

  @override
  Widget build(BuildContext context) {
    final iconColor = SBBHeaderStyleScope.of(context).foregroundColor ?? defaultForegroundColor;
    return _IconButton(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
      icon: CustomPaint(
        painter: _IconPainter(path: _iconPath, color: iconColor),
        size: Size(_width, _height),
      ),
      onPressed: onPressed ?? () => Navigator.maybePop(context),
      tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    required this.onPressed,
    this.padding,
    this.tooltip,
  });

  final Widget icon;
  final EdgeInsets? padding;
  final VoidCallback onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: padding,
      icon: icon,
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }
}

class _IconPainter extends CustomPainter {
  const _IconPainter({
    required this.path,
    required this.color,
    this.style = PaintingStyle.stroke,
    this.strokeWidth = 2.0,
  });

  final Path path;
  final Color color;
  final PaintingStyle style;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, _) {
    final paint = Paint()
      ..style = style
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt
      ..color = color;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _IconPainter oldDelegate) =>
      path != oldDelegate.path ||
      color != oldDelegate.color ||
      style != oldDelegate.style ||
      strokeWidth != oldDelegate.strokeWidth;
}
