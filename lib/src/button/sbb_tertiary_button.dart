import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sbb_design_system_mobile/src/button/default_button_label.dart';
import 'package:sbb_design_system_mobile/src/button/theme/default_button_themes.dart';
import 'package:sbb_design_system_mobile/src/button/theme/sbb_button_style_x.dart';

import '../../sbb_design_system_mobile.dart';
import '../sbb_internal.dart';

/// The tertiary variant of the SBB Button.
///
/// Provide either [label] for a custom content or [labelText] for text-only
/// content with standard styling. These parameters are mutually exclusive.
///
/// An optional leading icon can be added using [iconData] for standard icons
/// or [icon] for custom widgets. These parameters are mutually exclusive.
///
/// When [isLoading] is true, a loading indicator replaces the button content
/// and the button appears disabled.
///
/// The button is disabled when both [onPressed] and [onLongPress] are null.
///
/// See also:
///
///  * [SBBTertiaryButtonSmall], for a compact variant with reduced height.
///  * [SBBPrimaryButton], for the main action.
///  * [SBBSecondaryButton], for secondary actions.
///  * [SBBTertiaryButtonThemeData], for setting the [SBBButtonStyle] for all buttons within the current Theme.
///  * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=7-12)
class SBBTertiaryButton extends StatelessWidget {
  const SBBTertiaryButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.label,
    this.labelText,
    this.icon,
    this.iconData,
    this.isLoading = false,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.isSemanticButton = true,
    this.semanticLabel,
  }) : assert(!(labelText != null && label != null), 'Cannot provide both labelText and label!'),
       assert(!(iconData != null && icon != null), 'Cannot provide both iconData and icon!'),
       assert(
         !(labelText == null && label == null && !isLoading && icon == null && iconData == null),
         'One of labelText, label, icon, iconData must be set or isLoading must be true!',
       );

  /// Called when the button is tapped.
  ///
  /// The button is disabled when both this and [onLongPress] are null.
  ///
  /// Ignored when [isLoading] is true.
  final VoidCallback? onPressed;

  /// Called when the button is long-pressed.
  ///
  /// The button is disabled when both this and [onPressed] are null.
  ///
  /// Ignored when [isLoading] is true.
  final VoidCallback? onLongPress;

  /// A custom widget displayed as the button's content.
  ///
  /// For simple text labels, use [labelText] instead.
  ///
  /// Cannot be used together with [labelText].
  final Widget? label;

  /// The text displayed in the button.
  ///
  /// The text will be styled according to the SBB design system.
  ///
  /// Cannot be used together with [label].
  final String? labelText;

  /// A custom widget displayed before the label.
  ///
  /// Use this for custom icon layouts. For standard SBB icons, use
  /// [iconData] instead.
  ///
  /// Cannot be used together with [iconData].
  final Widget? icon;

  /// An icon displayed before the label.
  ///
  /// The icon will be sized and styled according to the SBB design system.
  ///
  /// Cannot be used together with [icon].
  final IconData? iconData;

  /// Whether to show a loading indicator instead of the button content.
  ///
  /// When true:
  ///  * A [SBBLoadingIndicator] replaces the leading icon and label
  ///  * The button becomes disabled ([onPressed] and [onLongPress] are ignored)
  ///  * The label remains visible if provided
  ///
  /// Defaults to false.
  final bool isLoading;

  /// Customizes this button's appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [DefaultSBBTertiaryButtonTheme.style].
  final SBBButtonStyle? style;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Determine whether this subtree represents a button.
  ///
  /// If this is null, the screen reader will not announce "button" when this
  /// is focused. This is useful for [MenuItemButton] and [SubmenuButton] when we
  /// traverse the menu system.
  ///
  /// Defaults to true.
  final bool isSemanticButton;

  /// Provides a textual description of the widget for assistive technologies.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return _BaseTertiaryButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      label: label,
      labelText: labelText,
      icon: icon,
      iconData: iconData,
      isLoading: isLoading,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      isSemanticButton: isSemanticButton,
      semanticLabel: semanticLabel,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isLoading', isLoading, defaultValue: false, showName: false));
    properties.add(DiagnosticsProperty<SBBButtonStyle>('style', style, defaultValue: null, showName: false));
    properties.add(DiagnosticsProperty<String>('semanticLabel', semanticLabel, defaultValue: null, showName: false));
  }
}

/// The tertiary variant of the SBB Button with reduced height.
///
/// Provide either [label] for a custom content or [labelText] for text-only
/// content with standard styling. These parameters are mutually exclusive.
///
/// An optional leading icon can be added using [iconData] for standard icons
/// or [icon] for custom widgets. These parameters are mutually exclusive.
///
/// When [isLoading] is true, a loading indicator replaces the button content
/// and the button appears disabled.
///
/// The button is disabled when both [onPressed] and [onLongPress] are null.
///
/// See also:
///
///  * [SBBTertiaryButton], for the standard height variant.
///  * [SBBTertiaryButtonThemeData], for setting the [SBBButtonStyle] for all buttons within the current Theme.
///  * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=7-12)
class SBBTertiaryButtonSmall extends SBBTertiaryButton {
  const SBBTertiaryButtonSmall({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.label,
    super.labelText,
    super.icon,
    super.iconData,
    super.isLoading = false,
    super.style,
    super.focusNode,
    super.autofocus = false,
    super.isSemanticButton = true,
    super.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseTertiaryButton(
      isSmall: true,
      onPressed: onPressed,
      onLongPress: onLongPress,
      label: label,
      labelText: labelText,
      icon: icon,
      iconData: iconData,
      isLoading: isLoading,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      isSemanticButton: isSemanticButton,
      semanticLabel: semanticLabel,
    );
  }
}

/// Base class for building both the small and the normal variant of SBBTertiaryButton.
class _BaseTertiaryButton extends StatelessWidget {
  const _BaseTertiaryButton({
    required this.onPressed,
    this.onLongPress,
    this.isSmall = false,
    this.label,
    this.labelText,
    this.icon,
    this.iconData,
    this.isLoading = false,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.isSemanticButton = false,
    this.semanticLabel,
  });

  final bool isSmall;

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Widget? label;
  final String? labelText;
  final Widget? icon;
  final IconData? iconData;
  final bool isLoading;
  final SBBButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool isSemanticButton;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final leading = _resolvedLeading();
    final label = _resolvedLabel();
    final loading = _resolvedLoading(context);

    Widget? child;
    if (leading != null && label != null) {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 4.0,
        children: [leading, label],
      );
    } else if (leading != null) {
      child = leading;
    } else if (label != null) {
      child = label;
    }

    if (loading != null) {
      child = loading;
    }

    final onlyLeading = (loading == null && leading != null && label == null);
    final resolvedButton = onlyLeading ? _iconButton(child!, context) : _textButton(child!, context);

    // The button is surrounded by padding to allow the border to be drawn outside while maintaining correct distances
    // to other Widgets.
    return Semantics(
      enabled: !isLoading && (onPressed != null || onLongPress != null),
      button: isSemanticButton,
      label: semanticLabel,
      excludeSemantics: semanticLabel != null,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: resolvedButton,
      ),
    );
  }

  Widget? _resolvedLeading() {
    if (icon == null && iconData == null) return null;
    return icon ?? Icon(iconData, size: sbbIconSizeSmall);
  }

  Widget? _resolvedLabel() {
    if (label == null && labelText == null) return null;
    return label ?? DefaultButtonLabel(label: labelText!);
  }

  Widget? _resolvedLoading(BuildContext context) {
    if (!isLoading) return null;
    final sbbBaseStyle = SBBBaseStyle.of(context);
    return sbbBaseStyle.themeValue(const SBBLoadingIndicator.tinySmoke(), const SBBLoadingIndicator.tinyCement());
  }

  Widget _textButton(Widget child, BuildContext context) {
    final style = _effectiveTextButtonStyle();
    return TextButton(
      style: style,
      onPressed: isLoading ? null : onPressed,
      onLongPress: isLoading ? null : onLongPress,
      focusNode: focusNode,
      autofocus: autofocus,
      isSemanticButton: isSemanticButton,
      child: child,
    );
  }

  Widget _iconButton(Widget child, BuildContext context) {
    final style = _effectiveIconButtonStyle(context);

    final iconButton = IconButton.outlined(
      style: style,
      onPressed: isLoading ? null : onPressed,
      onLongPress: isLoading ? null : onLongPress,
      focusNode: focusNode,
      autofocus: autofocus,
      icon: child,
    );
    if (!isSmall) {
      return iconButton;
    } else {
      return _InputPadding(
        minSize: const Size.square(SBBInternal.defaultButtonHeight),
        child: iconButton,
      );
    }
  }

  ButtonStyle? _effectiveTextButtonStyle() {
    final widgetStyle = style?.toButtonStyle();
    if (!isSmall) return widgetStyle;

    final buttonStyleSmall = ButtonStyle(
      fixedSize: WidgetStatePropertyAll<Size>(Size.fromHeight(SBBInternal.defaultButtonHeightSmall)),
      minimumSize: SBBTheme.allStates(const Size(0, SBBInternal.defaultButtonHeightSmall)),
    );

    return _baseOverridenByWidgetStyle(widgetStyle, buttonStyleSmall);
  }

  ButtonStyle? _effectiveIconButtonStyle(BuildContext context) {
    final sideLength = isSmall ? SBBInternal.defaultButtonHeightSmall : SBBInternal.defaultButtonHeight;
    final baseStyle = Theme.of(context).textButtonTheme.style;
    final iconStyle = baseStyle?.copyWith(
      padding: WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.zero),
      minimumSize: WidgetStatePropertyAll<Size>(Size.square(sideLength)),
      fixedSize: WidgetStatePropertyAll<Size>(Size.square(sideLength)),
    );
    final widgetStyle = style?.toButtonStyle();

    return _baseOverridenByWidgetStyle(widgetStyle, iconStyle);
  }

  ButtonStyle? _baseOverridenByWidgetStyle(ButtonStyle? widgetStyle, ButtonStyle? baseStyle) {
    if (widgetStyle == null) return baseStyle;

    return baseStyle?.copyWith(
      backgroundColor: widgetStyle.backgroundColor,
      foregroundColor: widgetStyle.foregroundColor,
      iconColor: widgetStyle.iconColor,
      textStyle: widgetStyle.textStyle,
      overlayColor: widgetStyle.overlayColor,
      side: widgetStyle.side,
    );
  }
}

/// Copied from [ButtonStyleButton] in version Flutter SDK 3.38.1. Allows a tappable area of 44px.
///
/// A widget to pad the area around a [ButtonStyleButton]'s inner [Material].
///
/// Redirect taps that occur in the padded area around the child to the center
/// of the child. This increases the size of the button and the button's
/// "tap target", but not its material or its ink splashes.
class _InputPadding extends SingleChildRenderObjectWidget {
  const _InputPadding({super.child, required this.minSize});

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
    if (_minSize == value) {
      return;
    }
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
    return _computeSize(constraints: constraints, layoutChild: ChildLayoutHelper.dryLayoutChild);
  }

  @override
  double? computeDryBaseline(covariant BoxConstraints constraints, TextBaseline baseline) {
    final RenderBox? child = this.child;
    if (child == null) {
      return null;
    }
    final double? result = child.getDryBaseline(constraints, baseline);
    if (result == null) {
      return null;
    }
    final Size childSize = child.getDryLayout(constraints);
    return result + Alignment.center.alongOffset(getDryLayout(constraints) - childSize as Offset).dy;
  }

  @override
  void performLayout() {
    size = _computeSize(constraints: constraints, layoutChild: ChildLayoutHelper.layoutChild);
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
