import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('small header test', (WidgetTester tester) async {
    final widget = Column(
      spacing: SBBSpacing.medium,
      children: [
        const SBBHeaderSmall(titleText: 'No leading Widget', automaticallyImplyLeading: false),
        const SBBHeaderSmall(titleText: 'Menu', leading: SBBHeaderLeadingMenuButton()),
        const SBBHeaderSmall(titleText: 'Back', leading: SBBHeaderLeadingBackButton()),
        const SBBHeaderSmall(titleText: 'Close', leading: SBBHeaderLeadingCloseButton()),
        SizedBox(
          height: SBBHeaderStyle.smallToolbarHeight + 48.0,
          child: SBBHeaderSmall(
            leading: Container(
              color: SBBColors.turquoise,
              child: Center(child: Text('Custom')),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8.0,
              children: [
                Icon(SBBIcons.train_small),
                Text('Custom'),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(SBBIcons.unicorn_small),
                onPressed: () {},
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Container(
                height: 48,
                color: SBBColors.red150,
                child: Center(
                  child: Text(
                    'Bottom Widget',
                    style: TextStyle(color: SBBColors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'header_small',
      find.byType(Column).first,
    );
  });
}
