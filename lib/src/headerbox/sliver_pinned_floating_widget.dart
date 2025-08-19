import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverPinnedFloatingWidget extends SingleChildRenderObjectWidget {
  const SliverPinnedFloatingWidget({
    super.key,
    required super.child,
    required this.vsync,
    required this.animationStyle,
    required this.snapMode,
  });

  final TickerProvider vsync;
  final AnimationStyle animationStyle;
  final FloatingHeaderSnapMode snapMode;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSliverPinnedFloatingWidget(
      vsync: vsync,
      animationStyle: animationStyle,
      snapMode: snapMode,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderSliverPinnedFloatingWidget renderObject) {
    renderObject
      ..vsync = vsync
      ..animationStyle = animationStyle
      ..snapMode = snapMode;
  }
}

class RenderSliverPinnedFloatingWidget extends RenderSliverSingleBoxAdapter {
  /// Creates a [RenderSliverPinnedFloatingWidget] that wraps a [RenderBox].
  RenderSliverPinnedFloatingWidget({
    required this.animationStyle,
    TickerProvider? vsync,
    this.snapMode = FloatingHeaderSnapMode.scroll,
    super.child,
  }) : _vsync = vsync;

  double minExtent = 0.0;
  double maxExtent = 0.0;

  TickerProvider? get vsync => _vsync;
  TickerProvider? _vsync;

  set vsync(TickerProvider? value) {
    if (value == _vsync) {
      return;
    }
    _vsync = value;
    if (value == null) {
      snapController?.dispose();
      snapController = null;
    } else {
      snapController?.resync(value);
    }
  }

  AnimationStyle? animationStyle;
  FloatingHeaderSnapMode snapMode;

  double _previousScrollOffset = 0.0;
  double _internalScrollOffset = 0.0;
  double _virtualScroll = 0.0;
  bool _wasAnimating = false;

  double _scrollOffsetAtScrollStart = 0.0;
  DateTime _timeAtScrollStart = DateTime.now();

  late Animation<double> snapAnimation;
  AnimationController? snapController;

  // Amount that can be scrolled
  double get extent {
    if (child == null) {
      return 0.0;
    }
    return maxExtent - minExtent;
  }

  double get childSize {
    if (child == null) {
      return 0.0;
    }
    return lerpDouble(maxExtent, minExtent, _internalScrollOffset / extent)!;
  }

  void _updateExtent() {
    final crossAxisExtent = constraints.crossAxisExtent > 1.0 ? constraints.crossAxisExtent : double.infinity;

    minExtent = child!.getMinIntrinsicHeight(crossAxisExtent);
    maxExtent = child!.getMaxIntrinsicHeight(crossAxisExtent);
  }

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }

    // Measure children
    _updateExtent();

    final scrollOffset = this.constraints.scrollOffset;

    // We keep track an internal scroll offset that ranges from 0..extent.
    // This is what is used to immediately hide or show the widget at hand.
    _internalScrollOffset = (_internalScrollOffset + (scrollOffset - _previousScrollOffset)).clamp(0, extent);
    _previousScrollOffset = scrollOffset;

    final snapping = snapController?.isAnimating == true || _wasAnimating;
    var scrollOffsetCorrection = 0.0;
    if (snapping) {
      if (snapMode == FloatingHeaderSnapMode.scroll || scrollOffset < extent) {
        // With this option, we can tell the layout algorithm that we want to scroll in a direction.
        // We use this to scroll the view in a natural way.
        scrollOffsetCorrection = _virtualScroll - _internalScrollOffset;
      } else {
        _internalScrollOffset = _virtualScroll;
      }
    }
    _wasAnimating = snapController?.isAnimating == true;

    // Make it so that it looks to the child like we are scrolled only by the internal value
    final SliverConstraints constraints = this.constraints.copyWith(
          scrollOffset: 0,
        );

    child!.layout(
      constraints.asBoxConstraints().copyWith(minHeight: childSize, maxHeight: childSize),
      parentUsesSize: true,
    );

    final layoutExtent = max(0.0, maxExtent - scrollOffset);

    final double paintedChildSize = max(layoutExtent, extent);
    final double cacheExtent = maxExtent;

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      layoutExtent: layoutExtent,
      scrollExtent: extent,
      paintExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxPaintExtent: maxExtent,
      hitTestExtent: maxExtent,
      hasVisualOverflow: layoutExtent > constraints.remainingPaintExtent || constraints.scrollOffset > 0.0,
      scrollOffsetCorrection: scrollOffsetCorrection.abs() > 0.5 ? scrollOffsetCorrection : null,
    );
    setChildParentData(child!, constraints, geometry!);
  }

  void isScrollingUpdate(ScrollPosition position) {
    if (kIsWeb) return;

    final now = DateTime.now();

    if (position.isScrollingNotifier.value) {
      _timeAtScrollStart = now;
      _scrollOffsetAtScrollStart = _internalScrollOffset;

      snapController?.stop();
    } else {
      final elapsed = now.difference(_timeAtScrollStart);
      final bool useScrollDirection =
          elapsed.inMilliseconds < 500.0 && (_scrollOffsetAtScrollStart - _internalScrollOffset).abs() > (extent / 4);

      final direction = useScrollDirection || extent < 1.0
          ? position.userScrollDirection
          : (_internalScrollOffset / extent) < 0.5
              ? ScrollDirection.forward
              : ScrollDirection.reverse;

      final bool headerIsPartiallyVisible = switch (direction) {
        ScrollDirection.forward when _internalScrollOffset <= 0 => false, // completely visible
        ScrollDirection.reverse when _internalScrollOffset >= extent => false, // not visible
        _ => true,
      };
      if (headerIsPartiallyVisible) {
        snapController ??= AnimationController(vsync: vsync!)
          ..addListener(() {
            if (_virtualScroll != snapAnimation.value) {
              _virtualScroll = snapAnimation.value;
              markNeedsLayout();
            }
          });
        snapController!.duration = switch (direction) {
          ScrollDirection.forward => animationStyle?.duration ?? const Duration(milliseconds: 300),
          _ => animationStyle?.reverseDuration ?? const Duration(milliseconds: 300),
        };
        snapAnimation = snapController!.drive(
          Tween<double>(
            begin: _internalScrollOffset,
            end: switch (direction) {
              ScrollDirection.forward => 0,
              _ => extent,
            },
          ).chain(
            CurveTween(
              curve: switch (direction) {
                ScrollDirection.forward => animationStyle?.curve ?? Curves.easeInOut,
                _ => animationStyle?.reverseCurve ?? Curves.easeInOut,
              },
            ),
          ),
        );
        snapController!.forward(from: 0.0);
      }
    }
  }

  @override
  bool hitTestChildren(
    SliverHitTestResult result, {
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) {
    assert(geometry!.hitTestExtent > 0.0);
    if (child != null) {
      return hitTestBoxChild(
        BoxHitTestResult.wrap(result),
        child!,
        mainAxisPosition: mainAxisPosition - constraints.scrollOffset,
        crossAxisPosition: crossAxisPosition,
      );
    }
    return false;
  }

  @override
  void detach() {
    snapController?.dispose();
    snapController = null; // lazily recreated if we're reattached.
    super.detach();
  }
}
