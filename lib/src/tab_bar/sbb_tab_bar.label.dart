part of 'sbb_tab_bar.dart';

class _TabLabel extends StatelessWidget {
  const _TabLabel({required this.item, required this.visible, this.style});

  final SBBTabBarItem item;
  final bool visible;
  final SBBTabBarStyle? style;

  @override
  Widget build(BuildContext context) {
    final viewPaddingBottom = MediaQuery.of(context).viewPadding.bottom;
    final bottomPadding = max(viewPaddingBottom, 8.0);
    final labelTextStyle = style?.itemLabelTextStyle?.copyWith(
      color: style?.itemLabelForegroundColor,
    );
    return LayoutId(
      id: '${item.id}_label',
      child: Visibility(
        visible: visible,
        child: ExcludeSemantics(
          child: Padding(
            padding: .only(top: 4.0, bottom: bottomPadding),
            child: Text(
              item.translate(context),
              style: labelTextStyle,
              textAlign: .center,
            ),
          ),
        ),
      ),
    );
  }
}
