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
  });

  final TickerProvider vsync;
  final AnimationStyle animationStyle;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSliverPinnedFloatingWidget(
      vsync: vsync,
      animationStyle: animationStyle,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderSliverPinnedFloatingWidget renderObject) {
    renderObject
      ..vsync = vsync
      ..animationStyle = animationStyle;
  }
}

class RenderSliverPinnedFloatingWidget extends RenderSliverSingleBoxAdapter {
  /// Creates a [RenderSliverPinnedFloatingWidget] that wraps a [RenderBox].
  RenderSliverPinnedFloatingWidget({
    required this.animationStyle,
    TickerProvider? vsync,
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

    _updateExtent();

    final scrollOffset = this.constraints.scrollOffset;
    // We keep track an internal scroll offset that ranges from 0..extent
    _internalScrollOffset = (_internalScrollOffset + (scrollOffset - _previousScrollOffset)).clamp(0, extent);

    _previousScrollOffset = scrollOffset;

    final scrollOffsetCorrection =
        snapController?.isAnimating == true || _wasAnimating ? _virtualScroll - _internalScrollOffset : 0.0;

    _wasAnimating = snapController?.isAnimating == true;

    // Make it so that it looks to us like we are scrolled only by the internal value
    final SliverConstraints constraints = this.constraints.copyWith(
          scrollOffset: 0,
        );

    child!.layout(
      constraints.asBoxConstraints().copyWith(
            minHeight: childSize,
            maxHeight: childSize,
          ),
      parentUsesSize: true,
    );

    // To keep all following elements consistent, we must not change the layout height when displaying the floating header
    final layoutExtent = scrollOffset > extent ? minExtent : maxExtent - scrollOffset;

    final double paintedChildSize = layoutExtent;
    final double cacheExtent = maxExtent;

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: extent,
      paintExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxPaintExtent: layoutExtent,
      hitTestExtent: minExtent + extent,
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
