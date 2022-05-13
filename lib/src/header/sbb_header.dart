import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// The SBB Header. Use according to documentation.
///
/// See also:
///
/// * [AppBar], which is a part of this Widget.
/// * https://digital.sbb.ch/de/design-system-mobile-new/module/header
class SBBHeader extends StatelessWidget implements PreferredSizeWidget {
  const SBBHeader({
    Key? key,
    String title = '',
    Widget? leadingWidget,
    double? leadingWidth,
    bool automaticallyImplyLeading = true,
    List<Widget>? actions,
    VoidCallback? onPressedLogo,
    String? logoTooltip,
  }) : this._(
          key: key,
          title: title,
          leadingWidget: leadingWidget,
          leadingWidth: leadingWidth,
          automaticallyImplyLeading: automaticallyImplyLeading,
          actions: actions,
          onPressedLogo: onPressedLogo,
          logoTooltip: logoTooltip,
        );

  const SBBHeader.menu({
    Key? key,
    String title = '',
    VoidCallback? onPressed,
    VoidCallback? onPressedLogo,
    String? logoTooltip,
  }) : this._(
          key: key,
          title: title,
          automaticallyImplyLeading: false,
          useMenuButton: true,
          onPressed: onPressed,
          onPressedLogo: onPressedLogo,
          logoTooltip: logoTooltip,
        );

  const SBBHeader.back({
    Key? key,
    String title = '',
    VoidCallback? onPressed,
    VoidCallback? onPressedLogo,
    String? logoTooltip,
  }) : this._(
          key: key,
          title: title,
          automaticallyImplyLeading: false,
          useBackButton: true,
          onPressed: onPressed,
          onPressedLogo: onPressedLogo,
          logoTooltip: logoTooltip,
        );

  const SBBHeader.close({
    Key? key,
    String title = '',
    VoidCallback? onPressed,
    VoidCallback? onPressedLogo,
    String? logoTooltip,
  }) : this._(
          key: key,
          title: title,
          automaticallyImplyLeading: false,
          useCloseButton: true,
          onPressed: onPressed,
          onPressedLogo: onPressedLogo,
          logoTooltip: logoTooltip,
        );

  const SBBHeader._({
    Key? key,
    required this.title,
    this.leadingWidget,
    this.leadingWidth,
    required this.automaticallyImplyLeading,
    this.useMenuButton = false,
    this.useBackButton = false,
    this.useCloseButton = false,
    this.onPressed,
    required this.onPressedLogo,
    required this.logoTooltip,
    this.actions,
  })  : assert(actions == null || onPressedLogo == null),
        super(key: key);

  final String title;
  final Widget? leadingWidget;
  final double? leadingWidth;
  final bool automaticallyImplyLeading;
  final bool useMenuButton;
  final bool useBackButton;
  final bool useCloseButton;
  final VoidCallback? onPressed;
  final VoidCallback? onPressedLogo;
  final String? logoTooltip;
  final List<Widget>? actions;

  static const _menuButtonIconWidth = 20.718;
  static const _menuButtonIconHeight = 16.0;
  static const _menuButtonIconPadding = 16.688;
  static const _backButtonIconWidth = 10.025;
  static const _backButtonIconHeight = 15.401;
  static const _backButtonIconPadding = 18.027;
  static const _closeButtonIconWidth = 15.177;
  static const _closeButtonIconHeight = 15.401;
  static const _closeButtonIconPadding = 15.974;

  @override
  Widget build(BuildContext context) {
    final sbbTheme = SBBTheme.of(context);

    // TODO find better solution
    sbbTheme.updateStatusBarHeight(context);

    if (leadingWidget != null) {
      return _build(context, leadingWidget!, leadingWidth ?? kToolbarHeight);
    }

    var useMenuButton = this.useMenuButton;
    var useCloseButton = this.useCloseButton;
    var useBackButton = this.useBackButton;
    if (automaticallyImplyLeading) {
      final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
      useMenuButton = Scaffold.of(context).hasDrawer;
      useBackButton = parentRoute?.canPop ?? false;
      useCloseButton = useCloseButton || automaticallyImplyLeading && useBackButton && parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;
    }

    if (useMenuButton) {
      return _build(
        context,
        _buildMenuButton(context),
        _menuButtonIconWidth + _menuButtonIconPadding * 2,
      );
    }

    if (useCloseButton) {
      return _build(
        context,
        _buildCloseButton(context),
        _closeButtonIconWidth + _closeButtonIconPadding * 2,
      );
    }

    if (useBackButton) {
      return _build(
        context,
        _buildBackButton(context),
        _backButtonIconWidth + _backButtonIconPadding * 2,
      );
    }

    return _build(context, Container(), leadingWidth ?? kToolbarHeight);
  }

  Widget _build(BuildContext context, Widget leading, double leadingWidth) {
    final customLeadingWidth = leadingWidth > kToolbarHeight;
    final sbbTheme = SBBTheme.of(context);
    return AppBar(
      brightness: Brightness.dark,
      titleSpacing: 0.0,
      leading: Container(
        child: leading,
        padding: customLeadingWidth
            ? EdgeInsets.zero
            : EdgeInsets.only(
                right: kToolbarHeight - leadingWidth,
              ),
      ),
      leadingWidth: customLeadingWidth ? leadingWidth : kToolbarHeight,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Semantics(
        header: true,
        child: Text(title, style: sbbTheme.headerTextStyle),
      ),
      actions: actions != null && actions!.isNotEmpty
          ? actions
          : [
              ExcludeSemantics(
                excluding: onPressedLogo == null,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: sbbDefaultSpacing / 2),
                  height: kToolbarHeight,
                  width: customLeadingWidth ? leadingWidth : kToolbarHeight,
                  child: IconButton(
                    icon: SBBLogo(),
                    onPressed: onPressedLogo,
                    tooltip: logoTooltip,
                    splashColor: sbbTheme.headerButtonBackgroundColorHighlighted,
                    focusColor: sbbTheme.headerButtonBackgroundColorHighlighted,
                    hoverColor: SBBColors.transparent,
                    highlightColor: SBBColors.transparent,
                  ),
                ),
              ),
            ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget _buildMenuButton(BuildContext context) {
    final path = Path()
      ..moveTo(0.0, 1.0)
      ..lineTo(20.718, 1.0)
      ..moveTo(0.0, 8.0)
      ..lineTo(20.718, 8.0)
      ..moveTo(0.0, 15.0)
      ..lineTo(20.718, 15.0);
    return _buildPaintedIconButton(
      context,
      path,
      _menuButtonIconWidth,
      _menuButtonIconHeight,
      _menuButtonIconPadding,
      MaterialLocalizations.of(context).openAppDrawerTooltip,
      onPressed ?? () => Scaffold.of(context).openDrawer(),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    final path = Path()
      ..moveTo(9.322, 0.711)
      ..lineTo(1.422, 8.519)
      ..lineTo(9.322, 16.327);
    return _buildPaintedIconButton(
      context,
      path,
      _backButtonIconWidth,
      _backButtonIconHeight,
      _backButtonIconPadding,
      MaterialLocalizations.of(context).backButtonTooltip,
      onPressed ?? () => Navigator.maybePop(context),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    final path = Path()
      ..moveTo(0.713, 0.701)
      ..lineTo(14.463, 14.701)
      ..moveTo(0.713, 14.701)
      ..lineTo(14.463, 0.701);
    return _buildPaintedIconButton(
      context,
      path,
      _closeButtonIconWidth,
      _closeButtonIconHeight,
      _closeButtonIconPadding,
      MaterialLocalizations.of(context).closeButtonTooltip,
      onPressed ?? () => Navigator.maybePop(context),
    );
  }

  Widget _buildPaintedIconButton(
    BuildContext context,
    Path path,
    double width,
    double height,
    double padding,
    String tooltip,
    VoidCallback? onPressed,
  ) {
    final sbbTheme = SBBTheme.of(context);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.butt
      ..color = sbbTheme.headerIconColor;
    return IconButton(
      padding: EdgeInsets.symmetric(horizontal: padding),
      icon: CustomPaint(
        painter: _Painter(paint, path),
        size: Size(width, height),
      ),
      tooltip: tooltip,
      onPressed: onPressed,
      splashColor: sbbTheme.headerButtonBackgroundColorHighlighted,
      focusColor: sbbTheme.headerButtonBackgroundColorHighlighted,
      hoverColor: SBBColors.transparent,
      highlightColor: SBBColors.transparent,
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
