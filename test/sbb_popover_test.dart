import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  // Each popover overlays the whole screen (barrier + positioned content),
  // so every scenario is its own golden. The whole TestApp is captured to
  // include the overlay content, which lives outside the test widget's own
  // subtree. A controller with initialValue true shows the popover without
  // needing a tap — the deferred initial show settles within TestSpecs.run.
  void generateTest(String name, SBBPopover Function(SBBPopoverController controller) buildPopover) {
    testWidgets('popover golden - $name', (WidgetTester tester) async {
      final controller = SBBPopoverController(initialValue: true);
      addTearDown(controller.dispose);

      await TestSpecs.run(
        TestSpecs.themedSpecs,
        Center(child: buildPopover(controller)),
        tester,
        'popover_$name',
        find.byType(TestApp),
      );
    });
  }

  // Default header: title + close button.
  generateTest(
    'bottom',
    (controller) => SBBPopover(
      controller: controller,
      titleText: 'Title',
      targetBuilder: (context, showPopover) => const SizedBox(width: 60, height: 30),
      builder: (context, hidePopover) => const Text('Popover content'),
    ),
  );

  // Same header, notch on the bottom edge.
  generateTest(
    'top',
    (controller) => SBBPopover(
      controller: controller,
      preferredDirection: SBBPopoverDirection.top,
      titleText: 'Title',
      targetBuilder: (context, showPopover) => const SizedBox(width: 60, height: 30),
      builder: (context, hidePopover) => const Text('Popover content'),
    ),
  );

  // Full header: leading icon + title + trailing icon + close button.
  generateTest(
    'header',
    (controller) => SBBPopover(
      controller: controller,
      titleText: 'Title',
      leadingIconData: SBBIcons.dog_small,
      trailingIconData: SBBIcons.circle_information_small,
      targetBuilder: (context, showPopover) => const SizedBox(width: 60, height: 30),
      builder: (context, hidePopover) => const Text('Popover content'),
    ),
  );

  // No header at all: no title and no close button — body only.
  generateTest(
    'plain',
    (controller) => SBBPopover(
      controller: controller,
      showCloseButton: false,
      targetBuilder: (context, showPopover) => const SizedBox(width: 60, height: 30),
      builder: (context, hidePopover) => const Text('Popover content'),
    ),
  );
}
