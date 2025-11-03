import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/popover/popover_notch.dart';
import 'package:sbb_design_system_mobile/src/popover/sbb_popover_border.dart';

/// Clips a [RRect] extended by notches on the given sides.
class PopoverClipper extends CustomClipper<Path> {
  final SBBPopoverBorder border;
  final double borderRadius;

  const PopoverClipper({
    required this.border,
    this.borderRadius = 8.0,
  });

  @override
  Path getClip(Size size) {
    final path = Path();

    final innerRRect = _roundedRectWithInsets(size);
    path.addRRect(innerRRect);

    return _addNotchClips(innerRRect, path, size);
  }

  @override
  bool shouldReclip(covariant PopoverClipper oldClipper) =>
      oldClipper.border != border || oldClipper.borderRadius != borderRadius;

  RRect _roundedRectWithInsets(Size size) {
    var (topLeft, bottomRight) = (Offset(0, 0), Offset(size.width, size.height));
    if (border.notchTop) topLeft += Offset(0, PopoverNotch.outerHeight);
    if (border.notchLeft) topLeft += Offset(PopoverNotch.outerHeight, 0);
    if (border.notchBottom) bottomRight -= Offset(0, PopoverNotch.outerHeight);
    if (border.notchRight) bottomRight -= Offset(PopoverNotch.outerHeight, 0);

    final innerRect = Rect.fromPoints(topLeft, bottomRight);
    return RRect.fromRectAndRadius(innerRect, Radius.circular(borderRadius));
  }

  Path _addNotchClips(RRect rect, Path path, Size size) {
    Path result = path;
    if (border.notchTop) {
      final shiftedNotch = PopoverNotch.facingUp.shift(Offset(size.width / 2, 0));
      result = Path.combine(PathOperation.union, result, shiftedNotch);
    }
    if (border.notchRight) {
      final notchFacingRight = PopoverNotch.facingRight.shift(Offset(size.width, size.height / 2));
      result = Path.combine(PathOperation.union, result, notchFacingRight);
    }
    if (border.notchLeft) {
      final notchFacingLeft = PopoverNotch.facingLeft.shift(Offset(0, size.height / 2));
      result = Path.combine(PathOperation.union, result, notchFacingLeft);
    }
    if (border.notchBottom) {
      final notchClipFacingDown = PopoverNotch.facingDown.shift(Offset(size.width / 2, size.height));
      result = Path.combine(PathOperation.union, result, notchClipFacingDown);
    }
    return result;
  }
}
