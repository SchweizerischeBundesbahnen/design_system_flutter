import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';

/// Large variant of the SBB Icon Button. Use according to documentation.
///
/// The [icon] parameter must not be null. Make sure to use small icons
/// ([sbbIconSizeSmall] - 24x24).
///
/// If [onPressed] callback is null, then the button will be disabled.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/button>
class SBBIconButtonLarge extends StatelessWidget {
  const SBBIconButtonLarge({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.focusNode,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final sbbTheme = SBBTheme.of(context);
    return TextButton(
      style: Theme.of(context).textButtonTheme.style?.copyWith(
            minimumSize: SBBInternal.all(const Size(SBBInternal.defaultButtonHeight, SBBInternal.defaultButtonHeight)),
            fixedSize: SBBInternal.all(const Size(SBBInternal.defaultButtonHeight, SBBInternal.defaultButtonHeight)),
            padding: SBBInternal.all(EdgeInsets.zero),
            overlayColor: SBBInternal.resolveWith(
              defaultValue: sbbTheme.iconButtonLargeBackgroundColor,
              pressedValue: sbbTheme.iconButtonLargeBackgroundColorHighlighted,
            ),
            backgroundColor: SBBInternal.resolveWith(
              defaultValue: sbbTheme.iconButtonLargeBackgroundColor,
              pressedValue: sbbTheme.iconButtonLargeBackgroundColor,
              disabledValue: sbbTheme.iconButtonLargeBackgroundColorDisabled,
            ),
            foregroundColor: SBBInternal.resolveWith(
              defaultValue: sbbTheme.iconButtonLargeIconColor,
              pressedValue: sbbTheme.iconButtonLargeIconColorHighlighted,
              disabledValue: sbbTheme.iconButtonLargeIconColorDisabled,
            ),
            side: SBBInternal.resolveWith(
              defaultValue: BorderSide(color: sbbTheme.iconButtonLargeBorderColor),
              pressedValue: BorderSide(color: sbbTheme.iconButtonLargeBorderColorHighlighted),
              disabledValue: BorderSide(color: sbbTheme.iconButtonLargeBorderColorDisabled),
            ),
          ),
      onPressed: onPressed,
      focusNode: focusNode,
      child: Icon(icon, size: sbbIconSizeSmall),
    );
  }
}

/// Small variant of the SBB Icon Button. Use according to documentation.
///
/// The [icon] parameter must not be null. Make sure to use small icons
/// ([sbbIconSizeSmall] - 24x24).
///
/// If [onPressed] callback is null, then the button will be disabled.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/button>
class SBBIconButtonSmall extends StatelessWidget {
  const SBBIconButtonSmall({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.focusNode,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final sbbTheme = SBBTheme.of(context);
    return _SBBIconButtonSmallRaw(
      key: key,
      icon: icon,
      onPressed: onPressed,
      overlayColor: SBBInternal.resolveWith(
        defaultValue: sbbTheme.iconButtonSmallBackgroundColor,
        pressedValue: sbbTheme.iconButtonSmallBackgroundColorHighlighted,
      ),
      backgroundColor: SBBInternal.resolveWith(
        defaultValue: sbbTheme.iconButtonSmallBackgroundColor,
        pressedValue: sbbTheme.iconButtonSmallBackgroundColor,
        disabledValue: sbbTheme.iconButtonSmallBackgroundColorDisabled,
      ),
      foregroundColor: SBBInternal.resolveWith(
        defaultValue: sbbTheme.iconButtonSmallIconColor,
        pressedValue: sbbTheme.iconButtonSmallIconColorHighlighted,
        disabledValue: sbbTheme.iconButtonSmallIconColorDisabled,
      ),
      side: SBBInternal.resolveWith(
        defaultValue: BorderSide(color: sbbTheme.iconButtonSmallBorderColor),
        pressedValue: BorderSide(color: sbbTheme.iconButtonSmallBorderColorHighlighted),
        disabledValue: BorderSide(color: sbbTheme.iconButtonSmallBorderColorDisabled),
      ),
      focusNode: focusNode,
    );
  }
}

/// Small negative variant of the SBB Icon Button. Use according to
/// documentation.
///
/// The [icon] parameter must not be null. Make sure to use small icons
/// ([sbbIconSizeSmall] - 24x24).
///
/// If [onPressed] callback is null, then the button will be disabled.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/button>
class SBBIconButtonSmallNegative extends StatelessWidget {
  const SBBIconButtonSmallNegative({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.focusNode,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final sbbTheme = SBBTheme.of(context);
    return _SBBIconButtonSmallRaw(
      key: key,
      icon: icon,
      onPressed: onPressed,
      overlayColor: SBBInternal.resolveWith(
        defaultValue: sbbTheme.iconButtonSmallNegativeBackgroundColor,
        pressedValue: sbbTheme.iconButtonSmallNegativeBackgroundColorHighlighted,
      ),
      backgroundColor: SBBInternal.resolveWith(
        defaultValue: sbbTheme.iconButtonSmallNegativeBackgroundColor,
        pressedValue: sbbTheme.iconButtonSmallNegativeBackgroundColor,
        disabledValue: sbbTheme.iconButtonSmallNegativeBackgroundColorDisabled,
      ),
      foregroundColor: SBBInternal.resolveWith(
        defaultValue: sbbTheme.iconButtonSmallNegativeIconColor,
        pressedValue: sbbTheme.iconButtonSmallNegativeIconColorHighlighted,
        disabledValue: sbbTheme.iconButtonSmallNegativeIconColorDisabled,
      ),
      side: SBBInternal.resolveWith(
        defaultValue: BorderSide(color: sbbTheme.iconButtonSmallNegativeBorderColor),
        pressedValue: BorderSide(color: sbbTheme.iconButtonSmallNegativeBorderColorHighlighted),
        disabledValue: BorderSide(color: sbbTheme.iconButtonSmallNegativeBorderColorDisabled),
      ),
      focusNode: focusNode,
    );
  }
}

/// Small borderless variant of the SBB Icon Button. Use according to
/// documentation.
///
/// The [icon] parameter must not be null. Make sure to use small icons
/// ([sbbIconSizeSmall] - 24x24).
///
/// If [onPressed] callback is null, then the button will be disabled.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/button>
class SBBIconButtonSmallBorderless extends StatelessWidget {
  const SBBIconButtonSmallBorderless({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.focusNode,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final sbbTheme = SBBTheme.of(context);
    return _SBBIconButtonSmallRaw(
      key: key,
      icon: icon,
      onPressed: onPressed,
      overlayColor: SBBInternal.resolveWith(
        defaultValue: sbbTheme.iconButtonSmallBorderlessBackgroundColor,
        pressedValue: sbbTheme.iconButtonSmallBorderlessBackgroundColorHighlighted,
      ),
      backgroundColor: SBBInternal.resolveWith(
        defaultValue: sbbTheme.iconButtonSmallBorderlessBackgroundColor,
        pressedValue: sbbTheme.iconButtonSmallBorderlessBackgroundColor,
        disabledValue: sbbTheme.iconButtonSmallBorderlessBackgroundColorDisabled,
      ),
      foregroundColor: SBBInternal.resolveWith(
        defaultValue: sbbTheme.iconButtonSmallBorderlessIconColor,
        pressedValue: sbbTheme.iconButtonSmallBorderlessIconColorHighlighted,
        disabledValue: sbbTheme.iconButtonSmallBorderlessIconColorDisabled,
      ),
      side: SBBInternal.all(BorderSide(style: BorderStyle.none)),
      focusNode: focusNode,
    );
  }
}

/// Base widget for [SBBIconButtonSmall], [SBBIconButtonSmallNegative] and
/// [SBBIconButtonSmallBorderless].
class _SBBIconButtonSmallRaw extends StatelessWidget {
  const _SBBIconButtonSmallRaw({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.overlayColor,
    required this.side,
    this.focusNode,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onPressed;
  final MaterialStateProperty<Color?> backgroundColor;
  final MaterialStateProperty<Color?> foregroundColor;
  final MaterialStateProperty<Color?> overlayColor;
  final MaterialStateProperty<BorderSide?> side;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      button: true,
      enabled: onPressed != null,
      child: Container(
        height: SBBInternal.defaultButtonHeight,
        width: SBBInternal.defaultButtonHeight,
        child: _InputPadding(
          minSize: Size.square(SBBInternal.defaultButtonHeight),
          child: Center(
            child: TextButton(
              style: Theme.of(context).textButtonTheme.style?.copyWith(
                    minimumSize: SBBInternal.all(
                      const Size(
                        SBBInternal.defaultButtonHeightSmall,
                        SBBInternal.defaultButtonHeightSmall,
                      ),
                    ),
                    fixedSize: SBBInternal.all(
                      const Size(
                        SBBInternal.defaultButtonHeightSmall,
                        SBBInternal.defaultButtonHeightSmall,
                      ),
                    ),
                    padding: SBBInternal.all(EdgeInsets.zero),
                    backgroundColor: backgroundColor,
                    foregroundColor: foregroundColor,
                    overlayColor: overlayColor,
                    side: side,
                  ),
              onPressed: onPressed,
              focusNode: focusNode,
              child: Icon(icon, size: sbbIconSizeSmall),
            ),
          ),
        ),
      ),
    );
  }
}

/// Copied from [ButtonStyleButton]
///
/// A widget to pad the area around a [MaterialButton]'s inner [Material].
///
/// Redirect taps that occur in the padded area around the child to the center
/// of the child. This increases the size of the button and the button's
/// "tap target", but not its material or its ink splashes.
class _InputPadding extends SingleChildRenderObjectWidget {
  const _InputPadding({
    Key? key,
    Widget? child,
    required this.minSize,
  }) : super(key: key, child: child);

  final Size minSize;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderInputPadding(minSize);
  }

  @override
  void updateRenderObject(BuildContext context, covariant _RenderInputPadding renderObject) {
    renderObject.minSize = minSize;
  }
}

class _RenderInputPadding extends RenderShiftedBox {
  _RenderInputPadding(this._minSize, [RenderBox? child]) : super(child);

  Size get minSize => _minSize;
  Size _minSize;

  set minSize(Size value) {
    if (_minSize == value) return;
    _minSize = value;
    markNeedsLayout();
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    if (child != null) return math.max(child!.getMinIntrinsicWidth(height), minSize.width);
    return 0.0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (child != null) return math.max(child!.getMinIntrinsicHeight(width), minSize.height);
    return 0.0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (child != null) return math.max(child!.getMaxIntrinsicWidth(height), minSize.width);
    return 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (child != null) return math.max(child!.getMaxIntrinsicHeight(width), minSize.height);
    return 0.0;
  }

  Size _computeSize({required BoxConstraints constraints, required ChildLayouter layoutChild}) {
    if (child != null) {
      final Size childSize = layoutChild(child!, constraints);
      final double height = math.max(childSize.width, minSize.width);
      final double width = math.max(childSize.height, minSize.height);
      return constraints.constrain(Size(height, width));
    }
    return Size.zero;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _computeSize(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.dryLayoutChild,
    );
  }

  @override
  void performLayout() {
    size = _computeSize(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.layoutChild,
    );
    if (child != null) {
      final BoxParentData childParentData = child!.parentData! as BoxParentData;
      childParentData.offset = Alignment.center.alongOffset(size - child!.size as Offset);
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (super.hitTest(result, position: position)) {
      return true;
    }
    final Offset center = child!.size.center(Offset.zero);
    return result.addWithRawTransform(
      transform: MatrixUtils.forceToPoint(center),
      position: center,
      hitTest: (BoxHitTestResult result, Offset? position) {
        assert(position == center);
        return child!.hitTest(result, position: center);
      },
    );
  }
}
