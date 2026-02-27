import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  testWidgets('header test', (WidgetTester tester) async {
    final widget = Column(
      spacing: SBBSpacing.medium,
      children: [
        _toolbarHeightSized(SBBHeader(titleText: 'No leading Widget', automaticallyImplyLeading: false)),
        _toolbarHeightSized(SBBHeader(titleText: 'Menu', leading: SBBHeaderLeadingMenuButton())),
        _toolbarHeightSized(SBBHeader(titleText: 'Back', leading: SBBHeaderLeadingBackButton())),
        _toolbarHeightSized(SBBHeader(titleText: 'Close', leading: SBBHeaderLeadingCloseButton())),
        SizedBox(
          height: SBBHeaderStyle.toolbarHeight + 48.0,
          child: SBBHeader(
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
      'header',
      find.byType(Column).first,
    );
  });
}

/// needed as [SBBHeader] set's a bottom widget as spacer which leads to unconstrainted height.
Widget _toolbarHeightSized(SBBHeader header) {
  return SizedBox(
    height: SBBHeaderStyle.toolbarHeight,
    child: header,
  );
}
