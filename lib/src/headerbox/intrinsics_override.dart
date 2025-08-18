import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Lets you set specific values for the intrinsics of the child.
///
/// `null` values mean that the actual intrinsic is used.
class OverrideIntrinsics extends SingleChildRenderObjectWidget {
  const OverrideIntrinsics({
    super.key,
    this.minHeight,
    this.maxHeight,
    this.minWidth,
    this.maxWidth,
    super.child,
  });

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
  double computeMinIntrinsicHeight(double width) {
    return minHeight ?? super.computeMinIntrinsicHeight(width);
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return maxHeight ?? super.computeMaxIntrinsicHeight(width);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return minWidth ?? super.computeMinIntrinsicWidth(height);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return maxWidth ?? super.computeMaxIntrinsicWidth(height);
  }
}
