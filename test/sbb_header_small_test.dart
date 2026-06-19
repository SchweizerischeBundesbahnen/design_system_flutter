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
        _toolbarHeightSized(
          SBBHeaderSmall(
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
        _toolbarHeightSized(
          SBBHeaderSmall(
            titleText: 'Close',
            bottom: SBBHeaderBoxPreferredSize(
              textScaler: TextScaler.noScaling,
              titleText: 'Title',
              subtitleText: 'Subtitle',
              leadingIconData: SBBIcons.unicorn_small,
              trailing: SBBTertiaryButton(
                onPressed: () {},
                iconData: SBBIcons.lighthouse_small,
              ),
              flap: SBBHeaderBoxFlapPreferredSize(
                labelText: 'Flap',
                textScaler: TextScaler.noScaling,
              ),
            ),
          ),
        ),
        _toolbarHeightSized(
          SBBHeaderSmall(
            titleText: 'Close',
            bottom: SBBHeaderBoxPreferredSize(
              textScaler: TextScaler.noScaling,
              title: _box(50, Colors.red),
              subtitle: _box(20, Colors.green),
              leading: _box(60, Colors.blue),
              body: _box(30, Colors.yellow),
              flap: SBBHeaderBoxFlapPreferredSize(
                leading: _box(30, Colors.green),
                label: _box(20, Colors.yellow),
                trailing: _box(10, Colors.red),
                textScaler: TextScaler.noScaling,
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

PreferredSizeWidget _box(double height, Color color) {
  return PreferredSize(
    preferredSize: Size.fromHeight(height),
    child: Container(
      constraints: BoxConstraints(minWidth: 50),
      height: height,
      color: color,
    ),
  );
}

/// needed as [SBBHeader] sets a bottom widget as spacer which leads to unconstrainted height.
Widget _toolbarHeightSized(SBBHeader header) {
  return SizedBox(
    height: header.preferredSize.height,
    child: header,
  );
}
