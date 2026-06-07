import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Selectively lets you override specific intrinsics of [child].
///
/// Basically, it lets you change the "ideal" size (or just the width / height) of [child].
/// Leave unset to use the real value.
///
/// It behaves like a [ConstrainedBox] in that the min and max values are passed down the widget tree as constraints.
///
/// See also:
///
///  * [IntrinsicHeight] and [IntrinsicWidth], for more detailed information on this topic.
///
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
    renderObject.updateConstraints(
      minHeight: minHeight,
      maxHeight: maxHeight,
      minWidth: minWidth,
      maxWidth: maxWidth,
    );
  }
}

class RenderOverrideIntrinsics extends RenderConstrainedBox {
  RenderOverrideIntrinsics({
    this.minHeight,
    this.maxHeight,
    this.minWidth,
    this.maxWidth,
  }) : super(
         additionalConstraints: BoxConstraints(
           minHeight: minHeight ?? 0.0,
           maxHeight: maxHeight ?? double.infinity,
           minWidth: minWidth ?? 0.0,
           maxWidth: maxWidth ?? double.infinity,
         ),
       );

  double? minHeight;
  double? maxHeight;
  double? minWidth;
  double? maxWidth;

  void updateConstraints({
    double? minHeight,
    double? maxHeight,
    double? minWidth,
    double? maxWidth,
  }) {
    this.minHeight = minHeight;
    this.maxHeight = maxHeight;
    this.minWidth = minWidth;
    this.maxWidth = maxWidth;

    additionalConstraints = BoxConstraints(
      minHeight: minHeight ?? 0.0,
      maxHeight: maxHeight ?? double.infinity,
      minWidth: minWidth ?? 0.0,
      maxWidth: maxWidth ?? double.infinity,
    );
  }

  @override
  double computeMinIntrinsicHeight(double width) => minHeight ?? super.computeMinIntrinsicHeight(width);

  @override
  double computeMaxIntrinsicHeight(double width) => maxHeight ?? super.computeMaxIntrinsicHeight(width);

  @override
  double computeMinIntrinsicWidth(double height) => minWidth ?? super.computeMinIntrinsicWidth(height);

  @override
  double computeMaxIntrinsicWidth(double height) => maxWidth ?? super.computeMaxIntrinsicWidth(height);
}
