import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// Description of an Element in the [SBBTabBar]
abstract class TabBarItem {
  const TabBarItem(this.id, this.icon);

  /// An unique id. Necessary to properly align the item.
  final String id;
  final IconData icon;

  String translate(BuildContext context);
}
