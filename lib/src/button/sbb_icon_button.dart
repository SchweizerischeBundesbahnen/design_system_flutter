import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';
import 'sbb_button_styles.dart';

typedef ButtonStyle themedSBBIconButtonStyle(SBBThemeData theme);

class SBBIconButton extends StatelessWidget {
  const SBBIconButton.large({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.tooltipMessage,
    this.buttonStyle = SBBButtonStyles.iconLarge,
    this.focusNode,
    this.isSmallIconButton = false,
  }) : super(key: key);

  const SBBIconButton.small({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.tooltipMessage,
    this.buttonStyle = SBBButtonStyles.iconSmall,
    this.focusNode,
    this.isSmallIconButton = true,
  }) : super(key: key);

  const SBBIconButton.smallNegative({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.tooltipMessage,
    this.buttonStyle = SBBButtonStyles.iconSmallNegative,
    this.focusNode,
    this.isSmallIconButton = true,
  }) : super(key: key);

  const SBBIconButton.smallBorderless({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.tooltipMessage,
    this.buttonStyle = SBBButtonStyles.iconSmallBorderless,
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
    final theme = SBBTheme.of(context);
    return Semantics(
        container: true,
        button: true,
        enabled: onPressed != null,
        child: (tooltipMessage == null)
            ? _iconButton(theme)
            : Tooltip(
                message: tooltipMessage,
                child: _iconButton(theme),
              ));
  }

  Widget _iconButton(SBBThemeData theme) {
    if (_buttonNeedsSurroundingTapMaterial(theme)) {
      return _surroundWithContainerAndPadding(theme);
    } else {
      return _styledTextButtonWithIcon(theme);
    }
  }

  Container _surroundWithContainerAndPadding(SBBThemeData theme) {
    return Container(
      height: SBBInternal.defaultButtonHeight,
      width: SBBInternal.defaultButtonHeight,
      child: _InputPadding(
        minSize: Size.square(SBBInternal.defaultButtonHeight),
        child: Center(child: _styledTextButtonWithIcon(theme)),
      ),
    );
  }

  TextButton _styledTextButtonWithIcon(SBBThemeData theme) {
    return TextButton(
      style: buttonStyle(theme),
      onPressed: onPressed,
      focusNode: focusNode,
      child: Icon(icon, size: sbbIconSizeSmall),
    );
  }

  bool _buttonNeedsSurroundingTapMaterial(SBBThemeData theme) =>
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
  void updateRenderObject(
      BuildContext context, covariant _RenderInputPadding renderObject) {
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
    if (child != null)
      return math.max(child!.getMinIntrinsicWidth(height), minSize.width);
    return 0.0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (child != null)
      return math.max(child!.getMinIntrinsicHeight(width), minSize.height);
    return 0.0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (child != null)
      return math.max(child!.getMaxIntrinsicWidth(height), minSize.width);
    return 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (child != null)
      return math.max(child!.getMaxIntrinsicHeight(width), minSize.height);
    return 0.0;
  }

  Size _computeSize(
      {required BoxConstraints constraints,
      required ChildLayouter layoutChild}) {
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
      childParentData.offset =
          Alignment.center.alongOffset(size - child!.size as Offset);
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

/// Base widget for [SBBIconButtonSmall], [SBBIconButtonSmallNegative] and
/// [SBBIconButtonSmallBorderless].
@Deprecated('Use SBBIconButton instead.')
class _SBBIconButtonSmallRaw extends StatelessWidget {
  const _SBBIconButtonSmallRaw({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.buttonStyle = SBBButtonStyles.iconSmall,
    this.focusNode,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onPressed;
  final themedSBBIconButtonStyle? buttonStyle;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    SBBThemeData sbbTheme = SBBTheme.of(context);
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
              style: buttonStyle!(sbbTheme),
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
@Deprecated("Use SBBIconButton.large instead.")
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
    final theme = SBBTheme.of(context);
    return TextButton(
      style: Theme.of(context).textButtonTheme.style?.copyWith(
            minimumSize: SBBThemeData.allStates(const Size(
                SBBInternal.defaultButtonHeight,
                SBBInternal.defaultButtonHeight)),
            fixedSize: SBBThemeData.allStates(const Size(
                SBBInternal.defaultButtonHeight,
                SBBInternal.defaultButtonHeight)),
            padding: SBBThemeData.allStates(EdgeInsets.zero),
            overlayColor: SBBThemeData.resolveStatesWith(
              defaultValue: theme.iconButtonLargeBackgroundColor,
              pressedValue: theme.iconButtonLargeBackgroundColorHighlighted,
            ),
            backgroundColor: SBBThemeData.resolveStatesWith(
              defaultValue: theme.iconButtonLargeBackgroundColor,
              pressedValue: theme.iconButtonLargeBackgroundColor,
              disabledValue: theme.iconButtonLargeBackgroundColorDisabled,
            ),
            foregroundColor: SBBThemeData.resolveStatesWith(
              defaultValue: theme.iconButtonLargeIconColor,
              pressedValue: theme.iconButtonLargeIconColorHighlighted,
              disabledValue: theme.iconButtonLargeIconColorDisabled,
            ),
            side: SBBThemeData.resolveStatesWith(
              defaultValue: BorderSide(color: theme.iconButtonLargeBorderColor),
              pressedValue: BorderSide(
                  color: theme.iconButtonLargeBorderColorHighlighted),
              disabledValue:
                  BorderSide(color: theme.iconButtonLargeBorderColorDisabled),
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
@Deprecated("Use SBBIconButton.small instead.")
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
@Deprecated("Use SBBIconButton.smallNegative instead.")
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
      buttonStyle: (_) => SBBButtonStyles.iconSmallNegative(sbbTheme),
      key: key,
      icon: icon,
      onPressed: onPressed,
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
@Deprecated("Use SBBIconButton.smallBorderless instead.")
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
      buttonStyle: (_) => SBBButtonStyles.iconSmallBorderless(sbbTheme),
      key: key,
      icon: icon,
      onPressed: onPressed,
      focusNode: focusNode,
    );
  }
}
