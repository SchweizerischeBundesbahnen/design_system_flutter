part of 'sbb_tab_bar.dart';

typedef TabItemInteractionsBuilder = TabItemInteractions Function(SBBTabBarItem);

class TabItemInteractions({
  required final FocusNode focusNode,
  required final Function() onTap,
  required final Function() onTapDown,
  required final Function() onTapCancel,
});
