import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/toast/default_toast_body.dart';
import 'package:sbb_design_system_mobile/src/toast/toast_container.dart';

import 'test_app.dart';

void main() {
  final Stream<bool> stream1 = (StreamController<bool>()..add(true)).stream;
  final Stream<bool> stream2 = (StreamController<bool>()..add(true)).stream;
  final Stream<bool> stream3 = (StreamController<bool>()..add(true)).stream;
  final Stream<bool> stream4 = (StreamController<bool>()..add(true)).stream;
  final Stream<bool> stream5 = (StreamController<bool>()..add(true)).stream;
  final Stream<bool> stream6 = (StreamController<bool>()..add(true)).stream;
  const Duration duration = Duration(milliseconds: 0);
  testWidgets('toast basic test', (WidgetTester tester) async {
    final widget = Column(
      children: [
        ToastContainer(stream: stream1, child: DefaultToastBody(title: 'Toast', duration: duration)),
        SizedBox(height: sbbDefaultSpacing),
        ToastContainer(
          stream: stream2,
          child: DefaultToastBody(
            title: 'Toast with action',
            duration: duration,
            action: SBBToastAction(onPressed: () {}, title: 'Action'),
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        ToastContainer(
          stream: stream3,
          child: DefaultToastBody(
            title:
                'Toast with multiple lines that should only expand to two lines. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum accumsan sem sit amet diam ornare ornare. Cras a justo neque. Proin enim lacus, hendrerit eu turpis quis, semper aliquet enim. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nam dictum ligula nec risus euismod, vel tincidunt nibh interdum. Donec neque tortor, viverra eget tristique non, cursus quis turpis. Morbi viverra id justo nec blandit. Nunc posuere dapibus mauris, ut sodales arcu dignissim a. Vivamus et orci id turpis ullamcorper varius eu vitae neque. Integer et auctor risus. Aenean vitae tincidunt tellus, nec eleifend ex. Maecenas ut erat eget tellus luctus porttitor et eget nisi.',
            duration: duration,
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        ToastContainer(
          stream: stream4,
          child: DefaultToastBody(
            title:
                'Toast with multiple lines that should only expand to two lines with an action. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum accumsan sem sit amet diam ornare ornare. Cras a justo neque. Proin enim lacus, hendrerit eu turpis quis, semper aliquet enim. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nam dictum ligula nec risus euismod, vel tincidunt nibh interdum. Donec neque tortor, viverra eget tristique non, cursus quis turpis. Morbi viverra id justo nec blandit. Nunc posuere dapibus mauris, ut sodales arcu dignissim a. Vivamus et orci id turpis ullamcorper varius eu vitae neque. Integer et auctor risus. Aenean vitae tincidunt tellus, nec eleifend ex. Maecenas ut erat eget tellus luctus porttitor et eget nisi.',
            duration: duration,
            action: SBBToastAction(onPressed: () {}, title: 'Action'),
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        ToastContainer(
          stream: stream5,
          child: DefaultToastBody(
            title: 'Toast with long action title that should go to next row.',
            duration: duration,
            action: SBBToastAction(onPressed: () {}, title: 'Long Action Title that is veeeeery long'),
          ),
        ),
        SizedBox(height: sbbDefaultSpacing),
        ToastContainer(
          stream: stream6,
          child: DefaultToastBody(
            title: 'Toast with custom styling (a lot of padding)',
            duration: duration,
            style: SBBToastStyle(
              decoration: BoxDecoration(
                color: SBBColors.sky,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(sbbDefaultSpacing * 4, sbbDefaultSpacing * 2),
                  bottomRight: Radius.elliptical(sbbDefaultSpacing * 4, sbbDefaultSpacing * 2),
                ),
              ),
              padding: EdgeInsets.all(sbbDefaultSpacing * 3),
            ),
            action: SBBToastAction(onPressed: () {}, title: 'Long Action Title that is veeeeery long'),
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
