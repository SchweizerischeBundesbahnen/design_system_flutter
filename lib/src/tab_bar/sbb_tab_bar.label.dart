part of 'sbb_tab_bar.dart';

class _TabLabel extends StatelessWidget {
  const _TabLabel({
    super.key,
    required this.item,
    required this.visible,
  });

  final TabBarItem item;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    final viewPaddingBottom = MediaQuery.of(context).viewPadding.bottom;
    final bottomPadding = max(viewPaddingBottom, 8.0);
    return LayoutId(
      id: '${item.id}_label',
      child: Visibility(
        visible: visible,
        child: ExcludeSemantics(
          child: Padding(
            padding: EdgeInsets.only(top: 4.0, bottom: bottomPadding),
            child: Text(
              item.translate(context),
              style: SBBControlStyles.of(context).tabBarTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
