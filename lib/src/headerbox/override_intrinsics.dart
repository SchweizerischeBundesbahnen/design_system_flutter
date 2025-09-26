import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Selectively lets you override specific intrinsics of [child].
///
/// In Flutter, there are four intrinsic values that describe how big a child *would like* to be:
///
/// * [minWidth]
/// * [maxWidth]
/// * [minHeight]
/// * [maxHeight]
///
/// By using this widget, you can change some of these, while `null` values will return the actual values from the child.
class OverrideIntrinsics extends SingleChildRenderObjectWidget {
  const OverrideIntrinsics({
    super.key,
    this.minHeight,
    this.maxHeight,
    this.minWidth,
    this.maxWidth,
    super.child,
  });

  const OverrideIntrinsics.ignore({Key? key, required Widget child})
    : this(
        key: key,
        minHeight: 0.0,
        maxHeight: 0.0,
        child: child,
      );

  final double? minHeight;
  final double? maxHeight;
  final double? minWidth;
  final double? maxWidth;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderOverrideIntrinsics(
      minHeight: minHeight,
      maxHeight: maxHeight,
      minWidth: minWidth,
      maxWidth: maxWidth,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderOverrideIntrinsics renderObject,
  ) {
    renderObject
      ..minHeight = minHeight
      ..maxHeight = maxHeight
      ..minWidth = minWidth
      ..maxWidth = maxWidth;
  }
}

class RenderOverrideIntrinsics extends RenderProxyBox {
  RenderOverrideIntrinsics({
    this.minHeight,
    this.maxHeight,
    this.minWidth,
    this.maxWidth,
  });

  double? minHeight;
  double? maxHeight;
  double? minWidth;
  double? maxWidth;

  @override
  double computeMinIntrinsicHeight(double width) => minHeight ?? super.computeMinIntrinsicHeight(width);

  @override
  double computeMaxIntrinsicHeight(double width) => maxHeight ?? super.computeMaxIntrinsicHeight(width);

  @override
  double computeMinIntrinsicWidth(double height) => minWidth ?? super.computeMinIntrinsicWidth(height);

  @override
  double computeMaxIntrinsicWidth(double height) => maxWidth ?? super.computeMaxIntrinsicWidth(height);
}
