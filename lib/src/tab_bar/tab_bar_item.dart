import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// Description of an Element in the [SbbTabBar]
abstract class TabBarItem {
  const TabBarItem(this.id, this.icon);

  /// An unique id. Necessary to properly align the item.
  final String id;
  final IconData icon;

  String translate(BuildContext context);

  /// An addition for the semantics to the [TabBarItem] name. e.g. Element 1 of 4
  String translateSemantics(BuildContext context, int index, int length);
}
