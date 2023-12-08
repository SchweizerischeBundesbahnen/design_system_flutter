import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// The SBB Sidebar. Use according to documentation.
///
/// See: https://digital.sbb.ch/de/webapps/modules/sidebar
class SBBSidebar extends StatelessWidget {
  const SBBSidebar({
    Key? key,
    required this.body,
    required this.items,
    this.backgroundColor,
    this.borderColor,
    this.width = 300.0,
  }) : super(key: key);

  /// The content displayed right of the [SBBSidebar].
  final Widget body;

  /// The items displayed in the sidebar.
  ///
  /// These may be a [SBBAccordion] with items or
  /// plain [SBBSidebarItem].
  final List<Widget> items;

  /// The backgroundcolor of this sidebar.
  ///
  /// defaults to [SBBThemeData.sidebarBackgroundColor]
  final Color? backgroundColor;

  /// The bordercolor of this sidebar.
  ///
  /// defaults to [SBBThemeData.sidebarBorderColor]
  final Color? borderColor;

  /// The width of this sidebar.
  ///
  /// Defaults to 300.0 px.
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildSizedBoxWithListViewItems(context),
        Expanded(child: body),
      ],
    );
  }

  SizedBox _buildSizedBoxWithListViewItems(BuildContext context) {
    final SBBControlStyles style = SBBControlStyles.of(context);
    return SizedBox(
      width: width,
      child: DecoratedBox(
        decoration: _createThemedShapeDecoration(style),
        child: ListView(
          children: items,
        ),
      ),
    );
  }

  ShapeDecoration _createThemedShapeDecoration(SBBControlStyles style) {
    return ShapeDecoration(
      color: backgroundColor ?? style.sidebarBackgroundColor,
      shape: Border(
        right: BorderSide(
          color: borderColor ?? style.sidebarBorderColor!,
        ),
      ),
    );
  }
}

class SBBSidebarItem extends StatefulWidget {
  const SBBSidebarItem({
    required this.title,
    this.leading,
    required this.onTap,
    this.isSelected = false,
    this.trailing,
  });

  /// Required title of the item.
  final String title;

  /// Optional leading widget.
  final Widget? leading;

  /// Callback to handle taps.
  final VoidCallback? onTap;

  /// Optional trailing widget.
  ///
  /// defaults to an Icon with [SBBIconswip.arrow_right_small].
  final Widget? trailing;

  /// Marks this item as selected inside the [SBBSidebar] parent.
  ///
  /// This field must be updated with navigation and once the user
  /// clicks on the item.
  /// Defaults to false.
  final bool isSelected;

  @override
  State<SBBSidebarItem> createState() => _SBBSidebarItemState();
}

class _SBBSidebarItemState extends State<SBBSidebarItem>
    with MaterialStateMixin {
  @override
  Widget build(BuildContext context) {
    if (widget.isSelected)
      setMaterialState(MaterialState.selected, true);
    else
      setMaterialState(MaterialState.selected, false);

    final SBBControlStyles style = SBBControlStyles.of(context);

    Color? resolvedForegroundColor =
        style.sidebarItemForegroundColor!.resolve(materialStates);
    Color? resolvedBackgroundColor =
        style.sidebarItemBackgroundColor!.resolve(materialStates);
    TextStyle resolvedTextStyle =
        style.sidebarItemTextStyle!.copyWith(color: resolvedForegroundColor);

    return MergeSemantics(
      child: Semantics(
        selected: widget.isSelected,
        namesRoute: true,
        child: Material(
          color: resolvedBackgroundColor,
          child: InkWell(
            splashColor: SBBColors.transparent,
            highlightColor: SBBColors.transparent,
            overlayColor: SBBTheme.allStates(SBBColors.transparent),
            onTap: widget.isSelected ? null : widget.onTap,
            onHover: updateMaterialState(MaterialState.hovered),
            child: IconTheme.merge(
              data: IconThemeData(color: resolvedForegroundColor),
              child: _innerTile(resolvedTextStyle),
            ),
          ),
        ),
      ),
    );
  }

  _innerTile(TextStyle resolvedTextStyle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (widget.leading != null) Expanded(child: widget.leading!),
          Expanded(
            flex: 10,
            child: _themedSingleLineOverflowingText(
              resolvedTextStyle,
            ),
          ),
          Expanded(child: _trailingWidget())
        ],
      ),
    );
  }

  Text _themedSingleLineOverflowingText(TextStyle resolvedTextStyle) {
    return Text(
      widget.title,
      style: resolvedTextStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _trailingWidget() {
    return widget.trailing ??
        const Icon(
          SBBIcons.arrow_right_medium,
        );
  }
}
