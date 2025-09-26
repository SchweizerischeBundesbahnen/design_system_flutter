import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const _kQuickSnapTime = Duration(milliseconds: 500);
const _kSmallValue = 1.0;

/// A widget that is pinned to the top of a viewport and can float, i.e.
/// appear immediately when the user starts scrolling in the opposite direction.
///
/// Crucially, this widgets calculates the intrinsic min and the max height and
/// transitions between these two heights.
class SliverPinnedFloatingWidget extends SingleChildRenderObjectWidget {
  const SliverPinnedFloatingWidget({
    super.key,
    required super.child,
    required this.vsync,
    required this.animationStyle,
    this.snapMode = FloatingHeaderSnapMode.scroll,
    this.resizing = true,
    this.floating = true,
  });

  final TickerProvider vsync;
  final AnimationStyle animationStyle;
  final FloatingHeaderSnapMode snapMode;
  final bool resizing;
  final bool floating;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSliverPinnedFloatingWidget(
      vsync: vsync,
      animationStyle: animationStyle,
      snapMode: snapMode,
      resizing: resizing,
      floating: floating,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderSliverPinnedFloatingWidget renderObject) {
    renderObject
      ..vsync = vsync
      ..animationStyle = animationStyle
      ..snapMode = snapMode
      ..resizing = resizing
      ..floating = floating;
  }
}

class RenderSliverPinnedFloatingWidget extends RenderSliverSingleBoxAdapter {
  /// Creates a [RenderSliverPinnedFloatingWidget] that wraps a [RenderBox].
  RenderSliverPinnedFloatingWidget({
    required this.animationStyle,
    TickerProvider? vsync,
    this.snapMode = FloatingHeaderSnapMode.scroll,
    this.resizing = true,
    this.floating = true,
    super.child,
  }) : _vsync = vsync;

  // Configured by the widget
  AnimationStyle? animationStyle;
  FloatingHeaderSnapMode snapMode;
  bool resizing = true;
  bool floating = true;

  // State management
  double _minExtent = 0.0;
  double _maxExtent = 0.0;
  double _previousScrollOffset = 0.0;
  double _internalScrollOffset = 0.0;
  double _virtualScroll = 0.0;
  bool _wasAnimating = false;

  // Snapping related variables
  double _scrollOffsetAtScrollStart = 0.0;
  DateTime _timeAtScrollStart = DateTime.now();

  late Animation<double> _snapAnimation;
  AnimationController? _snapController;

  TickerProvider? get vsync => _vsync;
  TickerProvider? _vsync;

  set vsync(TickerProvider? value) {
    if (value == _vsync) {
      return;
    }
    _vsync = value;
    if (value == null) {
      _snapController?.dispose();
      _snapController = null;
    } else {
      _snapController?.resync(value);
    }
  }

  /// The contracted size of the render widget.
  double get minExtent => _minExtent;

  /// The expanded size of the render widget.
  double get maxExtent => _maxExtent;

  /// The amount the widget can stretch, i.e. max - min.
  double get expandableExtent {
    if (child == null || !resizing) {
      return 0.0;
    }
    return _maxExtent - _minExtent;
  }

  /// The actual current extent of the render widget.
  double get currentExtent {
    if (child == null) {
      return 0.0;
    }

    if (!resizing) {
      return _maxExtent;
    }

    return lerpDouble(_maxExtent, _minExtent, _internalScrollOffset / expandableExtent)!;
  }

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }

    // Measure children
    _computeExtents();

    final scrollOffset = constraints.scrollOffset;

    // 1. Floating logic
    // -------------------
    // We keep track an internal scroll offset that ranges from 0..extent.
    // This is what is used to immediately hide or show the widget at hand.
    if (floating) {
      final delta = scrollOffset - _previousScrollOffset;
      final clampedDelta = switch (constraints.userScrollDirection) {
        ScrollDirection.idle => delta,
        ScrollDirection.forward => min(0.0, delta),
        ScrollDirection.reverse => max(0.0, delta),
      };

      _internalScrollOffset = (_internalScrollOffset + clampedDelta).clamp(0, expandableExtent);
    } else {
      _internalScrollOffset = scrollOffset.clamp(0, expandableExtent);
    }

    _previousScrollOffset = scrollOffset;

    // 2. Snapping logic
    // -------------------
    final snapping = _snapController?.isAnimating == true || _wasAnimating;
    var scrollOffsetCorrection = 0.0;
    if (snapping) {
      if (snapMode == FloatingHeaderSnapMode.scroll || scrollOffset < expandableExtent) {
        // With this option, we can tell the layout algorithm that we want to scroll in a direction.
        // We use this to scroll the view in a natural way.
        final delta = _virtualScroll - _internalScrollOffset;
        scrollOffsetCorrection = max(-scrollOffset, delta);

        // If there's not enough space to scroll, we simulate the remainder
        final remainder = scrollOffsetCorrection - delta;
        _internalScrollOffset -= remainder;
      } else {
        _internalScrollOffset = _virtualScroll;
      }

      _wasAnimating = _snapController?.isAnimating == true;
    }

    // 3. Layouting
    // -------------------
    child!.layout(
      constraints.asBoxConstraints(
        minExtent: minExtent,
        maxExtent: currentExtent,
      ),
      parentUsesSize: true,
    );

    final double layoutExtent = max(0.0, _maxExtent - scrollOffset);

    final double paintedChildSize = max(layoutExtent, currentExtent);
    final double cacheExtent = _maxExtent;

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      paintOrigin: constraints.overlap,
      layoutExtent: layoutExtent,
      scrollExtent: _maxExtent,
      paintExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxPaintExtent: _maxExtent,
      hitTestExtent: _maxExtent,
      maxScrollObstructionExtent: _minExtent,
      hasVisualOverflow: layoutExtent > constraints.remainingPaintExtent,
      scrollOffsetCorrection: scrollOffsetCorrection.abs() > 0.01 ? scrollOffsetCorrection : null,
    );

    // Layout the child as if we had scrolled only by the internal value
    setChildParentData(
      child!,
      constraints.copyWith(
        scrollOffset: 0,
      ),
      geometry!,
    );
  }

  void _computeExtents() {
    final crossAxisExtent = constraints.crossAxisExtent > _kSmallValue ? constraints.crossAxisExtent : double.infinity;

    _maxExtent = child!.getMaxIntrinsicHeight(crossAxisExtent);
    _minExtent = child!.getMinIntrinsicHeight(crossAxisExtent);
  }

  Future<void> snap(ScrollDirection direction) {
    final bool headerIsPartiallyVisible = switch (direction) {
      ScrollDirection.forward when _internalScrollOffset <= 0 => false, // completely visible
      ScrollDirection.reverse when _internalScrollOffset >= expandableExtent => false, // not visible
      _ => true,
    };

    if (headerIsPartiallyVisible) {
      _snapController ??= AnimationController(vsync: vsync!)..addListener(() {
        if (_virtualScroll != _snapAnimation.value) {
          _virtualScroll = _snapAnimation.value;
          markNeedsLayout();
        }
      });
      _snapController!.duration = switch (direction) {
        ScrollDirection.forward => animationStyle?.duration ?? const Duration(milliseconds: 300),
        _ => animationStyle?.reverseDuration ?? const Duration(milliseconds: 300),
      };
      _snapAnimation = _snapController!.drive(
        Tween<double>(
          begin: _internalScrollOffset,
          end: switch (direction) {
            ScrollDirection.forward => 0,
            _ => expandableExtent,
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

      return _snapController!.forward(from: 0.0);
    }

    return Future.value();
  }

  void onScrollingUpdate(ScrollPosition position) {
    final now = DateTime.now();
    if (position.isScrollingNotifier.value) {
      _timeAtScrollStart = now;
      _scrollOffsetAtScrollStart = _internalScrollOffset;
      _snapController?.stop();
    } else {
      final elapsed = now.difference(_timeAtScrollStart);
      final scrollAmountSinceStart = (_scrollOffsetAtScrollStart - _internalScrollOffset).abs();
      final bool useScrollDirection = elapsed < _kQuickSnapTime && scrollAmountSinceStart > (expandableExtent / 4);

      final direction =
          useScrollDirection || expandableExtent < _kSmallValue
              ? position.userScrollDirection
              : (_internalScrollOffset / expandableExtent) < 0.5
              ? ScrollDirection.forward
              : ScrollDirection.reverse;

      snap(direction);
    }
  }

  @override
  void showOnScreen({
    RenderObject? descendant,
    Rect? rect,
    Duration duration = Duration.zero,
    Curve curve = Curves.ease,
  }) {
    // The widget is always on screen by definition.
    // We could extend it to `maxExtent` here, but this might cause issues if the developer expects
    // it to stay small.
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
    _snapController?.dispose();
    _snapController = null; // lazily recreated if we're reattached.
    super.detach();
  }
}
