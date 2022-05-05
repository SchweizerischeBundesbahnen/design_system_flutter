import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';

class SBBSideBar extends StatelessWidget {
  const SBBSideBar({
    Key? key,
    required this.body,
    required this.items,
    this.backgroundColor,
    this.borderColor,
    this.width = 300.0,
  }) : super(key: key);

  /// The content displayed right of the [SBBSideBar].
  final Widget body;

  /// The items displayed in the sidebar.
  ///
  /// These may be a [SBBAccordion] with items or
  /// plain [SBBSidebarItem].
  final List<Widget> items;

  /// the backgroundcolor of this sidebar
  final Color? backgroundColor;

  /// the bordercolor of this sidebar
  final Color? borderColor;

  /// the width of this sidebar
  final double width;

  @override
  Widget build(BuildContext context) {
    final SBBThemeData theme = SBBTheme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: width,
          child: DecoratedBox(
            decoration: ShapeDecoration(
              color: backgroundColor ?? theme.sidebarBackgroundColor,
              shape: Border(
                right: BorderSide(
                  color: borderColor ?? theme.sidebarBorderColor,
                ),
              ),
            ),
            child: ListView(
              children: items,
            ),
          ),
        ),
        Expanded(child: body),
      ],
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

  final String title;
  final Widget? leading;
  final Function()? onTap;
  final Widget? trailing;
  final bool isSelected;

  @override
  State<SBBSidebarItem> createState() => _SBBSidebarItemState();
}

class _SBBSidebarItemState extends State<SBBSidebarItem>
    with MaterialStateMixin {
  @override
  Widget build(BuildContext context) {
    final SBBThemeData theme = SBBTheme.of(context);

    Color? resolvedForegroundColor =
        theme.sidebarItemForegroundColor.resolve(materialStates);

    Color? resolvedBackgroundColor =
        theme.sidebarItemBackgroundColor.resolve(materialStates);
    if (widget.isSelected) {
      resolvedBackgroundColor = SBBColors.cloud;
      resolvedForegroundColor = SBBColors.black;
    }
    return MergeSemantics(
      child: Semantics(
        selected: widget.isSelected,
        namesRoute: true,
        child: Material(
          color: resolvedBackgroundColor,
          child: InkWell(
            splashColor: SBBColors.transparent,
            highlightColor: SBBColors.transparent,
            overlayColor: SBBInternal.all(SBBColors.transparent),
            onTap: widget.isSelected ? null : widget.onTap,
            onHover: updateMaterialState(MaterialState.hovered),
            child: DefaultTextStyle(
              style: theme.sidebarItemTextStyle
                  .copyWith(color: resolvedForegroundColor),
              child: IconTheme.merge(
                data: IconThemeData(color: resolvedForegroundColor),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Text(
                          widget.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: widget.trailing ??
                            const Icon(
                              SBBIcons.arrow_right_medium,
                            ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
