import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import 'theme/default_sbb_header_theme_data.dart';

// TODO:
sealed class HeaderLeadingIconBuilder {
  const HeaderLeadingIconBuilder({this.onPressed});

  const factory HeaderLeadingIconBuilder.menu({VoidCallback? onPressed}) = _MenuLeadingButton;

  const factory HeaderLeadingIconBuilder.close({VoidCallback? onPressed}) = _CloseLeadingButton;

  const factory HeaderLeadingIconBuilder.back({VoidCallback? onPressed}) = _BackLeadingButton;

  final VoidCallback? onPressed;

  Widget build(BuildContext context, SBBHeaderStyle style) {
    return IconButton(
      padding: .symmetric(horizontal: _horizontalPadding),
      icon: CustomPaint(
        painter: _IconPainter(path: _iconPath, color: style.foregroundColor ?? defaultForegroundColor),
        size: Size(_width, _height),
      ),
      tooltip: _tooltip(context),
      onPressed: onPressed ?? () => _defaultOnPressed(context),
      splashColor: SBBColors.green,
      // TODO:
      focusColor: SBBColors.green,
      // TODO:
      hoverColor: SBBColors.transparent,
      highlightColor: SBBColors.transparent,
    );
  }

  double get leadingWidth;

  String _tooltip(BuildContext context);

  double get _height;

  double get _width;

  double get _horizontalPadding;

  Path get _iconPath;

  void _defaultOnPressed(BuildContext context);
}

final class _MenuLeadingButton extends HeaderLeadingIconBuilder {
  const _MenuLeadingButton({super.onPressed});

  @override
  double get leadingWidth => _width + _horizontalPadding * 2;

  @override
  double get _height => 16.0;

  @override
  double get _width => 20.718;

  @override
  double get _horizontalPadding => 16.688;

  @override
  Path get _iconPath => Path()
    ..moveTo(0.0, 1.0)
    ..lineTo(20.718, 1.0)
    ..moveTo(0.0, 8.0)
    ..lineTo(20.718, 8.0)
    ..moveTo(0.0, 15.0)
    ..lineTo(20.718, 15.0);

  @override
  String _tooltip(BuildContext context) => MaterialLocalizations.of(context).openAppDrawerTooltip;

  @override
  void _defaultOnPressed(BuildContext context) => Scaffold.of(context).openDrawer();
}

final class _BackLeadingButton extends HeaderLeadingIconBuilder {
  const _BackLeadingButton({super.onPressed});

  @override
  double get leadingWidth => _width + _horizontalPadding * 2;

  @override
  double get _height => 15.401;

  @override
  double get _width => 10.025;

  @override
  double get _horizontalPadding => 18.027;

  @override
  Path get _iconPath => Path()
    ..moveTo(9.322, 0.711)
    ..lineTo(1.422, 8.519)
    ..lineTo(9.322, 16.327);

  @override
  String _tooltip(BuildContext context) => MaterialLocalizations.of(context).backButtonTooltip;

  @override
  void _defaultOnPressed(BuildContext context) => Navigator.maybePop(context);
}

final class _CloseLeadingButton extends HeaderLeadingIconBuilder {
  const _CloseLeadingButton({super.onPressed});

  @override
  double get leadingWidth => _width + _horizontalPadding * 2;

  @override
  double get _height => 15.401;

  @override
  double get _width => 15.177;

  @override
  double get _horizontalPadding => 15.974;

  @override
  Path get _iconPath => Path()
    ..moveTo(0.713, 0.701)
    ..lineTo(14.463, 14.701)
    ..moveTo(0.713, 14.701)
    ..lineTo(14.463, 0.701);

  @override
  String _tooltip(BuildContext context) => MaterialLocalizations.of(context).closeButtonTooltip;

  @override
  void _defaultOnPressed(BuildContext context) => Navigator.maybePop(context);
}

class _IconPainter extends CustomPainter {
  const _IconPainter({required this.path, required this.color});

  final Path path;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = .stroke
      ..strokeWidth = 2.0
      ..strokeCap = .butt
      ..color = color;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _IconPainter oldDelegate) => path != oldDelegate.path || color != oldDelegate.color;
}
