import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('list_item_separated', (WidgetTester tester) async {
    final widget = Builder(
      builder: (context) {
        return ListView.separated(
          itemCount: 10,
          itemBuilder: (_, idx) => SBBListItem(
            style: SBBListItemStyle(backgroundColor: WidgetStatePropertyAll(SBBColors.lemon)),
            titleText: 'List Item $idx',
            leadingIconData: SBBIcons.dog_small,
            onTap: () {},
          ),
          separatorBuilder: (_, _) => SBBDivider(),
        );
      },
    );
    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'list_item_separated',
      find.byType(SBBContentBox).first,
    );
  });
}
