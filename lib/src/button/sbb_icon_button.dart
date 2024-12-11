import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../sbb_design_system_mobile.dart';
import '../sbb_internal.dart';

/// SBBIconButtonLarge. Use this as [SBBTertiaryButtonLarge] without label.
///
/// The [icon] parameter must not be null. Make sure to use small or medium icons.
///
/// If [onPressed] callback is null, then the button will be disabled.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/button>
class SBBIconButtonLarge extends StatelessWidget {
  const SBBIconButtonLarge({
    super.key,
    required this.icon,
    required this.onPressed,
    this.focusNode,
    this.buttonStyle,
    this.semantics,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;
  final ButtonStyle? buttonStyle;
  final String? semantics;

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textButtonTheme.style?.copyWith(
          minimumSize: SBBTheme.allStates(const Size(SBBInternal.defaultButtonHeight, SBBInternal.defaultButtonHeight)),
          fixedSize: SBBTheme.allStates(const Size(SBBInternal.defaultButtonHeight, SBBInternal.defaultButtonHeight)),
          padding: SBBTheme.allStates(EdgeInsets.zero),
        );
    final style = buttonStyle != null
        ? buttonStyle!.merge(baseStyle)
        : SBBButtonStyles.of(context).iconLargeStyle?.overrideButtonStyle(baseStyle);
    return TextButton(
      style: style,
      onPressed: onPressed,
      focusNode: focusNode,
      child: Semantics(
        label: semantics,
        child: Icon(icon, size: sbbIconSizeSmall),
      ),
    );
  }
}

/// SBBIconButtonSmall. Use this as [SBBTertiaryButtonSmall] without label.
///
/// The [icon] parameter must not be null. Make sure to use small icons
/// ([sbbIconSizeSmall] - 24x24).
/// If [onPressed] callback is null, then the button will be disabled.
///
/// See also:
///
/// * <https://digital.sbb.ch/en/design-system/mobile/components/button/>
class SBBIconButtonSmall extends StatelessWidget {
  const SBBIconButtonSmall({
    super.key,
    required this.icon,
    required this.onPressed,
    this.focusNode,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return _SBBIconButtonSmallRaw(
      key: key,
      icon: icon,
      onPressed: onPressed,
      style: SBBButtonStyles.of(context).iconSmallStyle,
      focusNode: focusNode,
    );
  }
}

/// Negative variant of the [SBBIconButtonSmall].
///
/// THIS IS NOT IN THE MOBILE DESIGN SPECS. Can be removed in a future version.
///
/// The [icon] parameter must not be null. Make sure to use small icons
/// ([sbbIconSizeSmall] - 24x24).
///
/// If [onPressed] callback is null, then the button will be disabled.
class SBBIconButtonSmallNegative extends StatelessWidget {
  const SBBIconButtonSmallNegative({
    super.key,
    required this.icon,
    required this.onPressed,
    this.focusNode,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return _SBBIconButtonSmallRaw(
      key: key,
      icon: icon,
      onPressed: onPressed,
      style: SBBButtonStyles.of(context).iconSmallNegativeStyle,
      focusNode: focusNode,
    );
  }
}

/// Borderless variant of the [SBBIconButtonSmall].
///
/// THIS IS NOT IN THE MOBILE DESIGN SPECS. Can be removed in a future version.
///
/// The [icon] parameter must not be null. Make sure to use small icons
/// ([sbbIconSizeSmall] - 24x24).
///
/// If [onPressed] callback is null, then the button will be disabled.
@Deprecated("This component is not in the design specs and will be removed in the next major version.")
class SBBIconButtonSmallBorderless extends StatelessWidget {
  const SBBIconButtonSmallBorderless({
    super.key,
    required this.icon,
    required this.onPressed,
    this.focusNode,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return _SBBIconButtonSmallRaw(
      key: key,
      icon: icon,
      onPressed: onPressed,
      style: SBBButtonStyles.of(context).iconSmallBorderlessStyle,
      focusNode: focusNode,
    );
  }
}

/// Base widget for [SBBIconButtonSmall], [SBBIconButtonSmallNegative] and
/// [SBBIconButtonSmallBorderless].
class _SBBIconButtonSmallRaw extends StatelessWidget {
  const _SBBIconButtonSmallRaw({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.style,
    this.focusNode,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final SBBButtonStyle? style;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textButtonTheme.style?.copyWith(
          minimumSize: SBBTheme.allStates(
            const Size(
              SBBInternal.defaultButtonHeightSmall,
              SBBInternal.defaultButtonHeightSmall,
            ),
          ),
          fixedSize: SBBTheme.allStates(
            const Size(
              SBBInternal.defaultButtonHeightSmall,
              SBBInternal.defaultButtonHeightSmall,
            ),
          ),
          padding: SBBTheme.allStates(EdgeInsets.zero),
          side: SBBTheme.allStates(const BorderSide(style: BorderStyle.none)),
        );
    return Semantics(
      container: true,
      button: true,
      enabled: onPressed != null,
      child: SizedBox(
        height: SBBInternal.defaultButtonHeight,
        width: SBBInternal.defaultButtonHeight,
        child: _InputPadding(
          minSize: const Size.square(SBBInternal.defaultButtonHeight),
          child: Center(
            child: TextButton(
              style: style?.overrideButtonStyle(baseStyle),
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

/// Copied from [ButtonStyleButton] in version Flutter SDK 3.24.5
///
/// A widget to pad the area around a [ButtonStyleButton]'s inner [Material].
///
/// Redirect taps that occur in the padded area around the child to the center
/// of the child. This increases the size of the button and the button's
/// "tap target", but not its material or its ink splashes.
class _InputPadding extends SingleChildRenderObjectWidget {
  const _InputPadding({
    super.child,
    required this.minSize,
  });

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
    if (child != null) {
      return math.max(child!.getMinIntrinsicWidth(height), minSize.width);
    }
    return 0.0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (child != null) {
      return math.max(child!.getMinIntrinsicHeight(width), minSize.height);
    }
    return 0.0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (child != null) {
      return math.max(child!.getMaxIntrinsicWidth(height), minSize.width);
    }
    return 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (child != null) {
      return math.max(child!.getMaxIntrinsicHeight(width), minSize.height);
    }
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

  // add this method as soon as 3.19.6 is removed
  // @override
  // double? computeDryBaseline(covariant BoxConstraints constraints, TextBaseline baseline) {
  //   final RenderBox? child = this.child;
  //   if (child == null) {
  //     return null;
  //   }
  //   final double? result = child.getDryBaseline(constraints, baseline);
  //   if (result == null) {
  //     return null;
  //   }
  //   final Size childSize = child.getDryLayout(constraints);
  //   return result + Alignment.center.alongOffset(getDryLayout(constraints) - childSize as Offset).dy;
  // }

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
      hitTest: (BoxHitTestResult result, Offset position) {
        assert(position == center);
        return child!.hitTest(result, position: center);
      },
    );
  }
}
