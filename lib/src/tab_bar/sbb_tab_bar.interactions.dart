part of 'sbb_tab_bar.dart';

typedef TabItemInteractionsBuilder = TabItemInteractions Function(SBBTabBarItem);

class TabItemInteractions {
  TabItemInteractions({
    required this.focusNode,
    required this.onTap,
    required this.onTapDown,
    required this.onTapCancel,
  });

  final FocusNode focusNode;
  final Function() onTap;
  final Function() onTapDown;
  final Function() onTapCancel;
}
