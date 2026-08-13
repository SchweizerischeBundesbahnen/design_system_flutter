import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'test_app.dart';

void main() {
  // Each popover overlays the whole screen (barrier + positioned content),
  // so every scenario is its own golden.
  void generateTest(String name, Widget Function(SBBPopoverController controller) buildPopover) {
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

  generateTest(
    'bottom',
    (controller) => SBBPopover(
      controller: controller,
      titleText: 'Title',
      targetBuilder: (context, showPopover) => const SizedBox(width: 60, height: 30),
      builder: (context, hidePopover) => const Text('Popover content'),
    ),
  );

  generateTest(
    'top',
    (controller) => SBBPopover(
      controller: controller,
      placement: SBBPopoverPlacement.top,
      titleText: 'Title',
      targetBuilder: (context, showPopover) => const SizedBox(width: 60, height: 30),
      builder: (context, hidePopover) => const Text('Popover content'),
    ),
  );

  generateTest(
    'left',
    (controller) => SBBPopover(
      controller: controller,
      placement: SBBPopoverPlacement.left,
      titleText: 'Title',
      targetBuilder: (context, showPopover) => const SizedBox(width: 60, height: 30),
      builder: (context, hidePopover) => const Text('Popover content'),
    ),
  );

  generateTest(
    'right',
    (controller) => SBBPopover(
      controller: controller,
      placement: SBBPopoverPlacement.right,
      titleText: 'Title',
      targetBuilder: (context, showPopover) => const SizedBox(width: 60, height: 30),
      builder: (context, hidePopover) => const Text('Popover content'),
    ),
  );

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

  generateTest(
    'plain',
    (controller) => SBBPopover(
      controller: controller,
      showCloseButton: false,
      targetBuilder: (context, showPopover) => const SizedBox(width: 60, height: 30),
      builder: (context, hidePopover) => const Text('Popover content'),
    ),
  );

  generateTest(
    'left_edge_shift',
    (controller) => Align(
      alignment: .centerLeft,
      child: SBBPopover(
        controller: controller,
        showCloseButton: false,
        targetBuilder: (context, showPopover) => SizedBox(width: 60, height: 30),
        builder: (context, hidePopover) => const Text('Left edge shifted'),
      ),
    ),
  );

  generateTest(
    'right_edge_shift',
    (controller) => Align(
      alignment: .centerRight,
      child: SBBPopover(
        controller: controller,
        showCloseButton: false,
        targetBuilder: (context, showPopover) => SizedBox(width: 60, height: 30),
        builder: (context, hidePopover) => const Text('Right edge shifted'),
      ),
    ),
  );

  generateTest(
    'bottom_flip',
    (controller) => Align(
      alignment: .bottomCenter,
      child: SBBPopover(
        controller: controller,
        showCloseButton: false,
        targetBuilder: (context, showPopover) => SizedBox(width: 60, height: 30),
        builder: (context, hidePopover) => const Text('Flipped to top'),
      ),
    ),
  );

  generateTest(
    'top_flip',
    (controller) => Align(
      alignment: .topCenter,
      child: SBBPopover(
        placement: .top,
        controller: controller,
        showCloseButton: false,
        targetBuilder: (context, showPopover) => SizedBox(width: 60, height: 30),
        builder: (context, hidePopover) => const Text('Flipped to bottom'),
      ),
    ),
  );
}
