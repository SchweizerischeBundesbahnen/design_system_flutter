import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// Description of an Element in the [SBBTabBar]
abstract class SBBTabBarItem {
  const SBBTabBarItem(this.id, this.icon);

  /// An unique id. Necessary to properly align the item.
  final String id;
  final IconData icon;

  String translate(BuildContext context);

  @override
  get hashCode => Object.hash(id, icon);

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is SBBTabBarItem && other.icon == icon && other.id == id;
  }
}
