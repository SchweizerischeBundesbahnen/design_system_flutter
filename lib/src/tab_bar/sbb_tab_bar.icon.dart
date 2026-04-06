part of 'sbb_tab_bar.dart';

class _TabIcon extends StatelessWidget {
  const _TabIcon({
    required this.item,
    required this.selected,
    required this.warning,
    required this.badge,
    required this.portrait,
    required this.tabIndex,
    required this.tabCount,
    required this.interactions,
    this.style,
  });

  final SBBTabBarItem item;
  final bool selected;
  final SBBTabBarWarningSetting? warning;
  final SBBTabBarItemBadge? badge;
  final bool portrait;
  final int tabIndex;
  final int tabCount;
  final TabItemInteractions interactions;
  final SBBTabBarStyle? style;

  @override
  Widget build(BuildContext context) {
    final label = item.translate(context);
    final semanticsHint = Localizations.of(
      context,
      MaterialLocalizations,
    ).tabLabel(tabIndex: tabIndex + 1, tabCount: tabCount);
    final viewPaddingBottom = MediaQuery.of(context).viewPadding.bottom;
    final bottomPadding = portrait ? 0.0 : max(viewPaddingBottom + 8.0, 8.0);
    final labelTextStyle = style?.itemLabelTextStyle?.copyWith(
      color: style?.itemLabelForegroundColor,
    );
    return LayoutId(
      id: '${item.id}_tab',
      child: Semantics(
        selected: selected,
        label: label,
        hint: warning?.shown == false ? warning?.semantics : null,
        button: true,
        onTap: interactions.onTap,
        child: Semantics(
          hint: semanticsHint,
          excludeSemantics: true,
          child: GestureDetector(
            onTap: interactions.onTap,
            child: Container(
              color: SBBColors.transparent,
              padding: .only(bottom: bottomPadding),
              child: Row(
                mainAxisSize: .min,
                spacing: 8.0,
                children: [
                  TabItemWidget(
                    item.icon,
                    interactions: interactions,
                    selected: false,
                    warning: warning,
                    badge: badge,
                    style: style,
                  ),
                  if (!portrait)
                    Text(
                      item.translate(context),
                      style: labelTextStyle,
                      textAlign: .center,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
