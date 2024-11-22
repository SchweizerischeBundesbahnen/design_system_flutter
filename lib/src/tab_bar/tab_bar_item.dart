import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// Description of an Element in the [SBBTabBar]
abstract class TabBarItem {
  const TabBarItem(this.id, this.icon);

  /// An unique id. Necessary to properly align the item.
  final String id;
  final IconData icon;

  String translate(BuildContext context);
}
