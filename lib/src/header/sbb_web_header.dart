import '../../design_system_flutter.dart';
import 'package:flutter/material.dart';

class SBBWebHeader extends StatelessWidget implements PreferredSizeWidget {
  const SBBWebHeader({
    Key? key,
    this.title = '',
    this.subtitle = '',
    this.logo = const SBBWebLogo(),
    this.userMenu,
    this.leadingWidth = 54.0,
    this.height = 54.0,
    this.actions,
    this.navItems,
    this.leading,
  }) : super(key: key);

  final String title;

  /// Optional subtitle in Header.
  final String subtitle;

  /// Optional logo to override default [SBBWebLogo].
  final Widget logo;

  /// Defines the width of [leading] widget.
  ///
  /// Only applies if [leading] is not null.
  /// Defaults to 54 logical pixels.
  final double leadingWidth;

  /// The height of [this].
  ///
  /// Defaults to 54 logical pixels.
  final double height;

  /// Optional User Menu in Header.
  final SBBUserMenu? userMenu;

  final List<Widget>? actions;

  /// The Navigation Items of the web header.
  ///
  /// These will be displayed between the title and
  /// the [actions] widgets.
  final List<SBBWebHeaderNavItem>? navItems;

  /// The optional leading widget left of the title.
  ///
  /// In case of a null leading widget,
  /// the middle/title widget will stretch to start.
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      toolbarHeight: height,
      leading: leading,
      leadingWidth: leadingWidth,
      backgroundColor: SBBColors.white,
      title: _buildTitleWithNavItems(), // middle section
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
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(54.0);

  Widget _insertLogo({double left = 50.0, double right = 54.0}) => Padding(
        padding: EdgeInsets.only(left: left, right: right),
        child: logo,
      );

  Widget _buildTitleWithNavItems() {
    if (navItems == null || navItems!.isEmpty) return _buildTitleWithSubtitle();
    return Row(
      children: [
        _buildTitleWithSubtitle(),
        SizedBox(width: 90),
        ...navItems!,
      ],
    );
  }

  Widget _buildTitleWithSubtitle() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: SBBWebTextStyles.medium.copyWith(color: SBBColors.black),
          ),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              style: SBBWebTextStyles.small.copyWith(color: SBBColors.metal),
            ),
        ],
      );
}

class SBBWebHeaderNavItem extends StatefulWidget {
  const SBBWebHeaderNavItem({
    Key? key,
    required this.title,
    required this.onTap,
    this.selected = false,
  })  : assert(selected != null),
        super(key: key);

  /// The callback once the item is clicked.
  final VoidCallback onTap;

  /// The title of the header item.
  final String title;

  /// Whether the Navigation item is currently selected.
  ///
  /// This value may not be null.
  final bool? selected;

  @override
  State<SBBWebHeaderNavItem> createState() => _SBBWebHeaderNavItemState();
}

class _SBBWebHeaderNavItemState extends State<SBBWebHeaderNavItem>
    with MaterialStateMixin {
  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).headerNavItemForegroundColor;
    if (widget.selected!) setMaterialState(MaterialState.pressed, true);
    return Semantics(
      link: true,
      onTap: widget.onTap,
      child: Material(
        color: SBBColors.white,
        textStyle: SBBWebTextStyles.medium
            .copyWith(color: style!.resolve(materialStates)),
        child: InkWell(
            splashColor: SBBColors.transparent,
            overlayColor: SBBTheme.allStates(SBBColors.transparent),
            onTap: widget.onTap,
            onHover: widget.selected!
                ? null
                : updateMaterialState(MaterialState.hovered),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(widget.title))),
      ),
    );
  }
}
