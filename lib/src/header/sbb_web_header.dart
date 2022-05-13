import '../../design_system_flutter.dart';
import 'package:flutter/material.dart';

class SBBWebHeader extends StatelessWidget implements PreferredSizeWidget {
  const SBBWebHeader({
    Key? key,
    this.title = '',
    this.subtitle = '',
    this.logo = const SBBLeanLogo(),
    this.userMenu,
    this.leadingWidth = 54.0,
    this.actions,
  }) : super(key: key);

  final String title;

  /// Optional subtitle in Header.
  final String subtitle;

  /// Optional logo to override default [SBBLeanLogo].
  final Widget logo;

  /// The space left to the [title].
  ///
  /// Defaults to 54 logical pixels.
  final double leadingWidth;

  /// Optional User Menu in Header.
  final SBBUserMenu? userMenu;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      centerTitle: false,
      toolbarHeight: leadingWidth,
      leadingWidth: leadingWidth,
      leading: Container(),
      backgroundColor: SBBColors.white,
      title: _buildTitleWithSubtitle(),
      shape: Border(
        bottom: BorderSide(
          color: SBBColors.silver,
        ),
      ),
      actions: [
        ...?actions,
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
