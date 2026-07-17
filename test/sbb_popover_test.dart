import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/popover/render_sbb_popover.dart';

import 'test_app.dart';

void main() {
  const triggerKey = Key('popover_trigger_test');

  testWidgets('SBBPopover positions itself using the trigger geometry captured at open time', (tester) async {
    late VoidCallback showOverlay;

    await tester.pumpWidget(
      TestApp(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, top: 100),
          child: SBBAnchoredOverlayBuilder(
            targetBuilder: (context, show) {
              showOverlay = show;
              return SizedBox(key: triggerKey, width: 80, height: 40);
            },
            followerBuilder: (context, hideOverlay) => const SBBPopover(
              child: SizedBox(width: 120, height: 60),
            ),
          ),
        ),
      ),
    );

    final triggerRect = tester.getRect(find.byKey(triggerKey));

    // Drive the state machine directly rather than via a real tap gesture:
    // this test targets the geometry-capture logic in _showOverlay(), not
    // gesture dispatch/hit-testing.
    showOverlay();
    await tester.pumpAndSettle();

    final popoverFinder = find.byType(SBBPopover);
    expect(popoverFinder, findsOneWidget);

    // RenderSBBPopover's own render box spans the full available space (it
    // has to, to support flipping/shifting under a paint-time-only
    // CompositedTransformFollower offset). Measure the Material it lays out
    // instead, which is sized/positioned to the actual visible content.
    final materialFinder = find.descendant(of: popoverFinder, matching: find.byType(Material));
    expect(materialFinder, findsOneWidget);

    final popoverTopLeft = tester.getTopLeft(materialFinder);
    final popoverSize = tester.getSize(materialFinder);

    // Preferred direction is bottom (default) with no collisions in this
    // layout, so the popover box sits directly below the trigger, with a
    // fixed 12px notch gap (drawn by RenderSBBPopover, outside Material's
    // own bounds) between the trigger and the content.
    const notchGap = 12.0;
    expect(popoverTopLeft.dy, closeTo(triggerRect.bottom + notchGap, 0.5));

    // Horizontally centered under the trigger (no edge shift in this layout).
    expect(popoverTopLeft.dx + popoverSize.width / 2, closeTo(triggerRect.center.dx, 0.5));
  });

  testWidgets('SBBPopover resolves the flipped direction on the very first frame (no flash)', (tester) async {
    late VoidCallback showOverlay;

    // Trigger placed near the bottom of the (default 800x600) test screen,
    // with tall enough content that placing it below would overflow.
    await tester.pumpWidget(
      TestApp(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, top: 550),
          child: SBBAnchoredOverlayBuilder(
            targetBuilder: (context, show) {
              showOverlay = show;
              return SizedBox(key: triggerKey, width: 80, height: 40);
            },
            followerBuilder: (context, hideOverlay) => const SBBPopover(
              child: SizedBox(width: 120, height: 100),
            ),
          ),
        ),
      ),
    );

    showOverlay();
    // Exactly one frame, not pumpAndSettle: the old ValueNotifier +
    // addPostFrameCallback implementation would still show the
    // pre-flip (bottom) shape/position here, correcting only on the
    // frame after. RenderSBBPopover resolves direction inside its own
    // performLayout(), consumed by its own paint() in the same frame,
    // so it must already be correct.
    await tester.pump();

    final renderObject = tester.renderObject<RenderSBBPopover>(find.byType(SBBPopoverLayout));
    expect(renderObject.resolvedDirection, SBBPopoverDirection.top);
  });

  testWidgets('popover content is hit-testable when direction is top', (tester) async {
    late VoidCallback showOverlay;

    // Plenty of room above the trigger, so direction stays `top` (the
    // preferred direction) without needing to flip.
    await tester.pumpWidget(
      TestApp(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, top: 400),
          child: SBBAnchoredOverlayBuilder(
            preferredDirection: SBBPopoverDirection.top,
            targetBuilder: (context, show) {
              showOverlay = show;
              return SizedBox(key: triggerKey, width: 80, height: 40);
            },
            followerBuilder: (context, hideOverlay) => const SBBPopover(
              child: SizedBox(width: 120, height: 60),
            ),
          ),
        ),
      ),
    );

    showOverlay();
    await tester.pumpAndSettle();

    final renderObject = tester.renderObject<RenderSBBPopover>(find.byType(SBBPopoverLayout));
    expect(renderObject.resolvedDirection, SBBPopoverDirection.top);

    // A point at the center of the popover's own visible rect. For `top`
    // direction this rect sits at a negative local y (above this render
    // object's own local origin, which is pinned to the trigger's position).
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
}
