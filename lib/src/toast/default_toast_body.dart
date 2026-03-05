import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sbb_design_system_mobile/src/toast/toast_scope.dart';

import '../../sbb_design_system_mobile.dart';

class DefaultToastBody extends StatelessWidget {
  const DefaultToastBody({
    super.key,
    this.title,
    this.titleText,
    this.action,
  }) : assert(titleText == null || title == null, 'Cannot provide both titleText and title!'),
       assert(titleText != null || title != null, 'One of titleText or title must be set!');

  final Widget? title;
  final String? titleText;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final themeStyle = Theme.of(context).sbbToastTheme?.style;
    final toastScope = ToastScope.of(context);
    final resolvedStyle = (themeStyle ?? SBBToastStyle()).merge(toastScope.style);

    return StreamBuilder<bool>(
      stream: toastScope.stream,
      builder: (context, snapshot) {
        final isVisible = snapshot.data ?? false;
        return AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: kThemeAnimationDuration,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(SBBToastStyle.borderRadius),
              color: resolvedStyle.backgroundColor,
            ),
            margin: resolvedStyle.margin,
            padding: resolvedStyle.padding,
            child: body(resolvedStyle, context),
          ),
        );
      },
    );
  }

  Widget body(SBBToastStyle resolvedStyle, BuildContext context) {
    Widget resolvedTitle = _resolvedTitle(resolvedStyle)!;
    Widget? resolvedAction = _resolvedAction(resolvedStyle);
    final horizontalGap = resolvedStyle.titleActionHorizontalGap ?? SBBSpacing.xLarge;
    final verticalGap = resolvedStyle.titleActionVerticalGap ?? SBBSpacing.xSmall;
    final overflowThreshold = resolvedStyle.actionOverflowThreshold ?? 0.25;

    return _SBBDefaultToast(
      title: resolvedTitle,
      action: resolvedAction,
      horizontalGap: horizontalGap,
      verticalGap: verticalGap,
      overflowThreshold: overflowThreshold,
    );
  }

  Widget? _resolvedTitle(SBBToastStyle resolvedStyle) {
    final resolvedTitle =
        title ?? Text(titleText!, style: resolvedStyle.titleTextStyle, maxLines: resolvedStyle.titleMaxLines);

    return _addDefaultAncestorWithResolved(
      textStyle: resolvedStyle.titleTextStyle?.copyWith(color: resolvedStyle.titleForegroundColor),
      child: resolvedTitle,
    );
  }

  Widget? _resolvedAction(SBBToastStyle resolvedStyle) {
    return _addDefaultAncestorWithResolved(
      textStyle: resolvedStyle.actionTextStyle?.copyWith(color: resolvedStyle.actionForegroundColor),
      child: action,
    );
  }

  Widget? _addDefaultAncestorWithResolved({
    required TextStyle? textStyle,
    required Widget? child,
  }) {
    if (child == null) return null;
    return DefaultTextStyle.merge(
      style: textStyle,
      child: IconTheme.merge(
        data: IconThemeData(color: textStyle?.color),
        child: child,
      ),
    );
  }
}

enum _ToastSlot { title, action }

/// Lays out the title and action following a simplified Material layouting SnackBar approach:
///
/// - The width of the toast is determined by the width of the title, a horizontal gap and the width of the action
/// - The action will overflow to a separate line with a vertical gap to the title if its size is above the
///   configurable actionOverflowThreshold.
class _SBBDefaultToast extends SlottedMultiChildRenderObjectWidget<_ToastSlot, RenderBox> {
  const _SBBDefaultToast({
    required this.title,
    this.action,
    required this.horizontalGap,
    required this.verticalGap,
    required this.overflowThreshold,
  });

  final Widget title;
  final Widget? action;
  final double horizontalGap;
  final double verticalGap;
  final double overflowThreshold;

  @override
  Iterable<_ToastSlot> get slots => _ToastSlot.values;

  @override
  Widget? childForSlot(_ToastSlot slot) {
    return switch (slot) {
      _ToastSlot.title => title,
      _ToastSlot.action => action,
    };
  }

  @override
  _RenderSBBDefaultToast createRenderObject(BuildContext context) {
    return _RenderSBBDefaultToast(gap: horizontalGap, verticalGap: verticalGap, overflowThreshold: overflowThreshold);
  }

  @override
  void updateRenderObject(BuildContext context, _RenderSBBDefaultToast renderObject) {
    renderObject
      ..horizontalGap = horizontalGap
      ..verticalGap = verticalGap
      ..overflowThreshold = overflowThreshold;
  }
}

class _RenderSBBDefaultToast extends RenderBox with SlottedContainerRenderObjectMixin<_ToastSlot, RenderBox> {
  _RenderSBBDefaultToast({
    required double gap,
    required double verticalGap,
    required double overflowThreshold,
  }) : _horizontalGap = gap,
       _verticalGap = verticalGap,
       _overflowThreshold = overflowThreshold;

  double _horizontalGap;

  double get horizontalGap => _horizontalGap;

  set horizontalGap(double value) {
    if (_horizontalGap == value) return;
    _horizontalGap = value;
    markNeedsLayout();
  }

  double _verticalGap;

  double get verticalGap => _verticalGap;

  set verticalGap(double value) {
    if (_verticalGap == value) return;
    _verticalGap = value;
    markNeedsLayout();
  }

  double _overflowThreshold;

  double get overflowThreshold => _overflowThreshold;

  set overflowThreshold(double value) {
    if (_overflowThreshold == value) return;
    _overflowThreshold = value;
    markNeedsLayout();
  }

  RenderBox? get _title => childForSlot(_ToastSlot.title);

  RenderBox? get _action => childForSlot(_ToastSlot.action);

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! BoxParentData) child.parentData = BoxParentData();
  }

  @override
  void performLayout() {
    final loose = constraints.loosen();
    final hasAction = _action != null;

    _action?.layout(loose, parentUsesSize: true);
    final actionSize = _action?.size ?? Size.zero;
    final actionWithGapWidth = actionSize.width + horizontalGap;

    final titleConstraints = hasAction ? loose.deflate(EdgeInsets.only(right: actionWithGapWidth)) : loose;
    _title?.layout(titleConstraints, parentUsesSize: true);
    final titleSize = _title?.size ?? Size.zero;

    final baseWidth = titleSize.width + (hasAction ? actionWithGapWidth : 0.0);
    final actionOnSeparateLine =
        hasAction && baseWidth > 0 && (actionSize.width / constraints.maxWidth) > overflowThreshold;

    final layoutHeight = actionOnSeparateLine
        ? titleSize.height + verticalGap + actionSize.height
        : math.max(titleSize.height, actionSize.height);

    size = constraints.constrain(Size(baseWidth, layoutHeight));

    if (_title != null) {
      final titleParentData = _title!.parentData! as BoxParentData;
      final titleDy = actionOnSeparateLine ? 0.0 : (size.height - titleSize.height) / 2.0;
      titleParentData.offset = Offset(0.0, titleDy);
    }

    if (_action != null) {
      final actionParentData = _action!.parentData! as BoxParentData;
      final actionDx = size.width - actionSize.width;
      final actionDy = actionOnSeparateLine ? titleSize.height + verticalGap : (size.height - actionSize.height) / 2.0;
      actionParentData.offset = Offset(actionDx, actionDy);
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final loose = constraints.loosen();
    final hasAction = _action != null;

    _action?.getDryLayout(loose);
    final actionSize = _action?.size ?? Size.zero;
    final actionWithGapWidth = actionSize.width + horizontalGap;

    final titleConstraints = hasAction ? loose.deflate(EdgeInsets.only(right: actionWithGapWidth)) : loose;
    _title?.getDryLayout(titleConstraints);
    final titleSize = _title?.size ?? Size.zero;

    final baseWidth = titleSize.width + (hasAction ? actionWithGapWidth : 0.0);
    final actionOnSeparateLine =
        hasAction && baseWidth > 0 && (actionSize.width / constraints.maxWidth) > overflowThreshold;

    final layoutHeight = actionOnSeparateLine
        ? titleSize.height + verticalGap + actionSize.height
        : math.max(titleSize.height, actionSize.height);

    return constraints.constrain(Size(baseWidth, layoutHeight));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_title != null) {
      final parentData = _title!.parentData! as BoxParentData;
      context.paintChild(_title!, offset + parentData.offset);
    }
    if (_action != null) {
      final parentData = _action!.parentData! as BoxParentData;
      context.paintChild(_action!, offset + parentData.offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    bool hit = false;
    if (_action != null) {
      final parentData = _action!.parentData! as BoxParentData;
      hit = result.addWithPaintOffset(
        offset: parentData.offset,
        position: position,
        hitTest: (result, transformed) => _action!.hitTest(result, position: transformed),
      );
      if (hit) return true;
    }
    if (_title != null) {
      final parentData = _title!.parentData! as BoxParentData;
      hit = result.addWithPaintOffset(
        offset: parentData.offset,
        position: position,
        hitTest: (result, transformed) => _title!.hitTest(result, position: transformed),
      );
    }
    return hit;
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    if (_title != null) visitor(_title!);
    if (_action != null) visitor(_action!);
  }
}
