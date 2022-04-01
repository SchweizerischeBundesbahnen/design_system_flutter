import 'package:flutter/material.dart';
import 'package:design_system_flutter/design_system_flutter.dart';

class SBBWebHeader extends StatelessWidget implements PreferredSizeWidget {
  const SBBWebHeader({
    Key? key,
    this.title = '',
    this.subtitle = '',
    this.logo = const SBBLeanLogo(),
    this.userMenu,
    this.leadingWidth = 54.0,
  }) : super(key: key);

  final String title;

  /// Optional subtitle in Header.
  ///
  /// This should only be used in a Web Header.
  final String subtitle;

  /// Optional logo to override default [SBBLeanLogo].
  ///
  /// Only considered when HostPlatform is web.
  final Widget logo;
  final double leadingWidth;

  /// Optional User Menu in Header.
  ///
  /// Only considered when HostPlatform is web.
  final SBBUserMenu? userMenu;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      toolbarHeight: leadingWidth,
      leadingWidth: leadingWidth,
      backgroundColor: SBBColors.white,
      title: _buildTitleWithSubtitle(),
      actions: [
        if (userMenu != null && !(SBBResponsive.isMobile(context))) userMenu!,
        _insertLogo(
          right: SBBResponsive.isDesktop(context) ? leadingWidth : 15.0,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(54.0);

  Widget _insertLogo({double left = 50.0, double right = 54.0}) => Padding(
        padding: EdgeInsets.only(left: left, right: right),
        child: logo,
      );

  Widget _buildTitleWithSubtitle() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: SBBLeanTextStyles.headerTitle,
          ),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              style: SBBLeanTextStyles.headerSubtitle,
            ),
        ],
      );
}

class SBBWebHeaderItem {}
