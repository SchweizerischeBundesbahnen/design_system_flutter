part of 'sbb_tab_bar.dart';

class _TabIcon extends StatelessWidget {
  const _TabIcon({
    required this.item,
    required this.selected,
    required this.warning,
    required this.portrait,
    required this.onTap,
    required this.onTapDown,
    required this.onTapCancel,
    required this.tabIndex,
    required this.tabCount,
  });

  final SBBTabBarItem item;
  final bool selected;
  final SBBTabBarWarningSetting? warning;
  final bool portrait;
  final GestureTapCallback onTap;
  final GestureTapDownCallback onTapDown;
  final GestureTapCancelCallback onTapCancel;
  final int tabIndex;
  final int tabCount;

  @override
  Widget build(BuildContext context) {
    final label = item.translate(context);
    final semanticsHint = Localizations.of(
      context,
      MaterialLocalizations,
    ).tabLabel(tabIndex: tabIndex + 1, tabCount: tabCount);
    final viewPaddingBottom = MediaQuery.of(context).viewPadding.bottom;
    final bottomPadding = portrait ? 0.0 : max(viewPaddingBottom + 8.0, 8.0);
    return LayoutId(
      id: '${item.id}_tab',
      child: Material(
        color: SBBColors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Semantics(
            selected: selected,
            label: label,
            hint: warning?.shown == false ? warning?.semantics : null,
            button: true,
            child: Semantics(
              hint: semanticsHint,
              excludeSemantics: true,
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.only(bottom: bottomPadding),
                color: SBBColors.transparent,
                child: GestureDetector(
                  onTap: onTap,
                  onTapDown: onTapDown,
                  onTapCancel: onTapCancel,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8.0,
                    children: [
                      TabItemWidget(
                        item.icon,
                        // This version of the icon is clipped by the clip path.
                        // There is one underneath that will be drawn as selected.
                        selected: false,
                        warning: warning,
                      ),
                      if (!portrait)
                        Text(
                          item.translate(context),
                          style: SBBControlStyles.of(context).tabBarTextStyle,
                          textAlign: TextAlign.center,
                        ),
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
