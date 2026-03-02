import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/toast/default_toast_body.dart';
import 'package:sbb_design_system_mobile/src/toast/toast_scope.dart';

import 'test_app.dart';

void main() {
  final Stream<bool> stream1 = (StreamController<bool>()..add(true)).stream;
  final Stream<bool> stream2 = (StreamController<bool>()..add(true)).stream;
  final Stream<bool> stream3 = (StreamController<bool>()..add(true)).stream;
  final Stream<bool> stream4 = (StreamController<bool>()..add(true)).stream;
  final Stream<bool> stream5 = (StreamController<bool>()..add(true)).stream;
  final Stream<bool> stream6 = (StreamController<bool>()..add(true)).stream;
  final Stream<bool> stream7 = (StreamController<bool>()..add(true)).stream;
  final Stream<bool> stream8 = (StreamController<bool>()..add(true)).stream;
  testWidgets('toast basic test', (WidgetTester tester) async {
    final widget = Column(
      spacing: SBBSpacing.medium,
      children: [
        ToastScope(
          stream: stream1,
          child: DefaultToastBody(titleText: 'Toast'),
        ),

        ToastScope(
          stream: stream2,
          child: DefaultToastBody(
            titleText: 'Toast with action on the same line',
            action: SBBToastAction(onTap: () {}, title: 'Action'),
          ),
        ),
        ToastScope(
          stream: stream3,
          child: DefaultToastBody(
            titleText:
                'Toast with multiple lines that should only expand to two lines. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum accumsan sem sit amet diam ornare ornare. Cras a justo neque. Proin enim lacus, hendrerit eu turpis quis, semper aliquet enim. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nam dictum ligula nec risus euismod, vel tincidunt nibh interdum. Donec neque tortor, viverra eget tristique non, cursus quis turpis. Morbi viverra id justo nec blandit. Nunc posuere dapibus mauris, ut sodales arcu dignissim a. Vivamus et orci id turpis ullamcorper varius eu vitae neque. Integer et auctor risus. Aenean vitae tincidunt tellus, nec eleifend ex. Maecenas ut erat eget tellus luctus porttitor et eget nisi.',
          ),
        ),
        ToastScope(
          stream: stream4,
          child: DefaultToastBody(
            titleText:
                'Toast with multiple lines that should only expand to two lines with an action. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum accumsan sem sit amet diam ornare ornare. Cras a justo neque. Proin enim lacus, hendrerit eu turpis quis, semper aliquet enim. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nam dictum ligula nec risus euismod, vel tincidunt nibh interdum. Donec neque tortor, viverra eget tristique non, cursus quis turpis. Morbi viverra id justo nec blandit. Nunc posuere dapibus mauris, ut sodales arcu dignissim a. Vivamus et orci id turpis ullamcorper varius eu vitae neque. Integer et auctor risus. Aenean vitae tincidunt tellus, nec eleifend ex. Maecenas ut erat eget tellus luctus porttitor et eget nisi.',
            action: SBBToastAction(onTap: () {}, title: 'Action'),
          ),
        ),
        ToastScope(
          stream: stream5,
          child: DefaultToastBody(
            titleText: 'Toast with long action title that should go to next row.',
            action: SBBToastAction(onTap: () {}, title: 'Long Action Title that is veeeeery long'),
          ),
        ),
        ToastScope(
          stream: stream6,
          style: SBBToastStyle(
            backgroundColor: SBBColors.sky,
            padding: .all(48.0),
          ),
          child: DefaultToastBody(
            titleText: 'Toast with custom styling (a lot of padding)',
            action: SBBToastAction(onTap: () {}, title: 'Long Action Title that is veeeeery long'),
          ),
        ),
        ToastScope(
          stream: stream7,
          style: SBBToastStyle(actionOverflowThreshold: 1.0),
          child: DefaultToastBody(
            titleText: 'Toast with action',
            action: SBBToastAction(onTap: () {}, title: 'Long Action still on same line'),
          ),
        ),
        ToastScope(
          stream: stream8,
          style: SBBToastStyle(actionOverflowThreshold: 0),
          child: DefaultToastBody(
            titleText: 'Toast with action always on next line',
            action: SBBToastAction(onTap: () {}, title: 'Short'),
          ),
        ),
      ],
    );

    await TestSpecs.run(
      TestSpecs.themedSpecs,
      widget,
      tester,
      'sbb_toast_test',
      find.byType(Column).first,
    );
  });
}
