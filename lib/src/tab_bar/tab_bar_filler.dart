import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// A filler item for the usage of [SbbTabBar] together with a [ScrollView] and a [Stack] to achieve a scroll behind the Tab Bar effect.
/// Add [TabBarFiller] as the last element to make all element in a [ScrollView] visible.
class TabBarFiller extends StatelessWidget {
  const TabBarFiller({
    Key? key,
  }) : super(key: key);

  /// Usage with [CustomScrollView]. Returns the [TabBarFiller] as a Sliver
  static Widget asSliver({Key? key}) => SliverToBoxAdapter(
        child: TabBarFiller(key: key),
      );

  /// Returns the calculated size of the [SbbTabBar] according to [Orientation] and [MediaQueryData.textScaleFactor]
  static double calcHeight(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final portrait = mediaQuery.orientation == Orientation.portrait;
    return portrait ? 64.0 + 20.0 * mediaQuery.textScaleFactor : 52.0;
  }

  @override
  Widget build(BuildContext context) => SizedBox.fromSize(
        size: Size.fromHeight(calcHeight(context)),
      );
}
