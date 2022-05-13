import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';
import 'sbb_button_styles.dart';

typedef ButtonStyle themedSBBIconButtonStyle(SBBTheme theme);

class SBBIconButton extends StatelessWidget {
  const SBBIconButton.large({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.tooltipMessage,
    this.buttonStyle = SBBButtonStyles.of(context).iconLargeStyle,
    this.focusNode,
    this.isSmallIconButton = false,
  }) : super(key: key);

  const SBBIconButton.small({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.tooltipMessage,
    this.buttonStyle = SBBButtonStyles.of(context).iconSmallStyle,
    this.focusNode,
    this.isSmallIconButton = true,
  }) : super(key: key);

  const SBBIconButton.smallNegative({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.tooltipMessage,
    this.buttonStyle = SBBButtonStyles.of(context).iconSmallNegativeStyle,
    this.focusNode,
    this.isSmallIconButton = true,
  }) : super(key: key);

  const SBBIconButton.smallBorderless({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.tooltipMessage,
    this.buttonStyle = SBBButtonStyles.of(context).iconSmallBorderlessStyle,
    this.focusNode,
    this.isSmallIconButton = true,
  }) : super(key: key);

  final String? tooltipMessage;
  final themedSBBIconButtonStyle buttonStyle;
  final IconData icon;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;
  final bool isSmallIconButton;

  @override
  Widget build(BuildContext context) {
    final style = SBBBaseStyle.of(context);
    return Semantics(
        container: true,
        button: true,
        enabled: onPressed != null,
        child: (tooltipMessage == null)
            ? _iconButton(style)
            : Tooltip(
                message: tooltipMessage,
                child: _iconButton(style),
              ));
  }

  Widget _iconButton(SBBBaseStyle style) {
    if (_buttonNeedsSurroundingTapMaterial(style)) {
      return _surroundWithContainerAndPadding(style);
    } else {
      return _styledTextButtonWithIcon(style);
    }
  }

  Container _surroundWithContainerAndPadding(SBBBaseStyle style) {
    return Container(
      height: SBBInternal.defaultButtonHeight,
      width: SBBInternal.defaultButtonHeight,
      child: _InputPadding(
        minSize: Size.square(SBBInternal.defaultButtonHeight),
        child: Center(child: _styledTextButtonWithIcon(style)),
      ),
    );
  }

  TextButton _styledTextButtonWithIcon(SBBBaseStyle style) {
    return TextButton(
      style: isSmallIconButton
          ? SBBButtonStyles.makeSmallIconButton(buttonStyle(style))
          : SBBButtonStyles.makeLargeIconButton(buttonStyle(style)),
      onPressed: onPressed,
      focusNode: focusNode,
      child: Icon(icon, size: sbbIconSizeSmall),
    );
  }

  bool _buttonNeedsSurroundingTapMaterial(SBBTheme theme) =>
      isSmallIconButton && theme.hostPlatform == HostPlatform.native;
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
