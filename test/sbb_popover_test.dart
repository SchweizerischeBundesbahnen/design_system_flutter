import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/popover/render_sbb_popover.dart';

import 'test_app.dart';

void main() {
  const targetKey = Key('popover_target_test');

  testWidgets('SBBPopover positions itself using the target geometry captured at open time', (tester) async {
    final controller = SBBPopoverController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      TestApp(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, top: 100),
          child: SBBPopover(
            controller: controller,
            targetBuilder: (context, showPopover) => const SizedBox(key: targetKey, width: 80, height: 40),
            builder: (context, hidePopover) => const SizedBox(width: 120, height: 60),
          ),
        ),
      ),
    );

    final targetRect = tester.getRect(find.byKey(targetKey));

    controller.show();
    await tester.pumpAndSettle();

    final popoverFinder = find.byType(SBBPopover);
    expect(popoverFinder, findsOneWidget);

    // RenderSBBPopover's own render box spans the full available space (it
    // has to, since the flip/shift decision depends on the child's measured
    // size, only known after layout). Measure the Material it lays out
    // instead, which is sized/positioned to the actual visible content.
    final materialFinder = find.descendant(of: popoverFinder, matching: find.byType(Material));
    expect(materialFinder, findsOneWidget);

    final popoverTopLeft = tester.getTopLeft(materialFinder);
    final popoverSize = tester.getSize(materialFinder);

    // Preferred direction is bottom (default) with no collisions in this
    // layout, so the popover box sits directly below the target, with a
    // fixed 12px notch gap (drawn by RenderSBBPopover, outside Material's
    // own bounds) between the target and the content.
    const notchGap = 12.0;
    expect(popoverTopLeft.dy, closeTo(targetRect.bottom + notchGap, 0.5));

    // Horizontally centered under the target (no edge shift in this layout).
    expect(popoverTopLeft.dx + popoverSize.width / 2, closeTo(targetRect.center.dx, 0.5));
  });

  testWidgets('SBBPopover with notch false sits flush against the target', (tester) async {
    final controller = SBBPopoverController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      TestApp(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, top: 100),
          child: SBBPopover(
            controller: controller,
            showNotch: false,
            targetBuilder: (context, showPopover) => const SizedBox(key: targetKey, width: 80, height: 40),
            builder: (context, hidePopover) => const SizedBox(width: 120, height: 60),
          ),
        ),
      ),
    );

    final targetRect = tester.getRect(find.byKey(targetKey));

    controller.show();
    await tester.pumpAndSettle();

    // Without a notch no vertical space is reserved for it, so the popover
    // box sits directly against the target's bottom edge.
    final materialFinder = find.descendant(of: find.byType(SBBPopover), matching: find.byType(Material));
    expect(tester.getTopLeft(materialFinder).dy, closeTo(targetRect.bottom, 0.5));
  });

  testWidgets('SBBPopover resolves the flipped direction on the very first frame (no flash)', (tester) async {
    final controller = SBBPopoverController();
    addTearDown(controller.dispose);

    // Target placed near the bottom of the (default 800x600) test screen,
    // with tall enough content that placing it below would overflow.
    await tester.pumpWidget(
      TestApp(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, top: 550),
          child: SBBPopover(
            controller: controller,
            targetBuilder: (context, showPopover) => const SizedBox(key: targetKey, width: 80, height: 40),
            builder: (context, hidePopover) => const SizedBox(width: 120, height: 100),
          ),
        ),
      ),
    );

    controller.show();
    // Exactly one frame, not pumpAndSettle: RenderSBBPopover resolves
    // direction inside its own performLayout(), consumed by its own paint()
    // in the same frame, so the flipped direction must already be correct on
    // the first frame the overlay appears — no pre-flip flash allowed.
    await tester.pump();

    final renderObject = tester.renderObject<RenderSBBPopover>(find.byType(SBBPopoverLayout));
    expect(renderObject.resolvedDirection, SBBPopoverDirection.top);
  });

  testWidgets('popover content is hit-testable when direction is top', (tester) async {
    final controller = SBBPopoverController();
    addTearDown(controller.dispose);

    // Plenty of room above the target, so direction stays `top` (the
    // preferred direction) without needing to flip.
    await tester.pumpWidget(
      TestApp(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, top: 400),
          child: SBBPopover(
            controller: controller,
            preferredDirection: SBBPopoverDirection.top,
            targetBuilder: (context, showPopover) => const SizedBox(key: targetKey, width: 80, height: 40),
            builder: (context, hidePopover) => const SizedBox(width: 120, height: 60),
          ),
        ),
      ),
    );

    controller.show();
    await tester.pumpAndSettle();

    final renderObject = tester.renderObject<RenderSBBPopover>(find.byType(SBBPopoverLayout));
    expect(renderObject.resolvedDirection, SBBPopoverDirection.top);

    // A point at the center of the popover's own visible rect. For `top`
    // direction this rect can sit at a negative local y relative to this
    // render object's own [0,0]-anchored box, if the target is close
    // enough to the top of the screen (as it is here).
    final centerOfPopover = renderObject.popoverRect.center;
    final hitResult = BoxHitTestResult();
    final wasHit = renderObject.hitTest(hitResult, position: centerOfPopover);

    expect(
      wasHit,
      isTrue,
      reason:
          'RenderSBBPopover.hitTest() must bypass the default RenderBox size.contains(position) '
          'gate, since top-direction content sits at a negative local y (above this render '
          'object\'s own [0,0]-anchored box) that gate would otherwise reject.',
    );
  });

  testWidgets('tapping the barrier hides the popover and syncs the controller value', (tester) async {
    final controller = SBBPopoverController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      TestApp(
        child: Center(
          child: SBBPopover(
            controller: controller,
            targetBuilder: (context, showPopover) => const SizedBox(key: targetKey, width: 80, height: 40),
            builder: (context, hidePopover) => const SizedBox(width: 120, height: 60),
          ),
        ),
      ),
    );

    controller.show();
    await tester.pumpAndSettle();
    expect(controller.value, isTrue);

    // Tap the barrier well away from both the target and the popover box.
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(controller.value, isFalse);
    expect(find.byType(SBBPopoverLayout), findsNothing);
  });

  testWidgets('a controller with initialValue true shows the popover after the first frame', (tester) async {
    final controller = SBBPopoverController(initialValue: true);
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      TestApp(
        child: Center(
          child: SBBPopover(
            controller: controller,
            targetBuilder: (context, showPopover) => const SizedBox(key: targetKey, width: 80, height: 40),
            builder: (context, hidePopover) => const SizedBox(width: 120, height: 60),
          ),
        ),
      ),
    );

    // The initial show is deferred by one frame (the target has to be laid
    // out before its geometry can be captured).
    await tester.pumpAndSettle();

    expect(find.byType(SBBPopoverLayout), findsOneWidget);
  });

  void goldenTest(String name, SBBPopoverDirection direction) {
    testWidgets('popover golden - $name', (tester) async {
      tester.view.physicalSize = const Size(300, 300);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      // Driven via the targetBuilder callback (instead of a controller) so
      // the tests cover both ways of showing a popover.
      late VoidCallback showPopover;

      final widget = Center(
        child: SBBPopover(
          preferredDirection: direction,
          targetBuilder: (context, show) {
            showPopover = show;
            return const SizedBox(width: 60, height: 30);
          },
          builder: (context, hidePopover) => const Padding(
            padding: EdgeInsets.all(SBBSpacing.small),
            child: Text('Popover content'),
          ),
        ),
      );

      for (final spec in TestSpecs.themedSpecs) {
        tester.platformDispatcher.platformBrightnessTestValue = spec.brightness;
        await tester.pumpWidget(TestApp(child: widget));
        showPopover();
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestApp),
          matchesGoldenFile('goldens/popover_$name.${spec.name}.png'),
        );
      }
    });
  }

  goldenTest('bottom', SBBPopoverDirection.bottom);
  goldenTest('top', SBBPopoverDirection.top);
}
