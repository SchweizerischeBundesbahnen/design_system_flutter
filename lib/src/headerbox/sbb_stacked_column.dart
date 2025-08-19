import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import 'intrinsics_override.dart';

typedef SBBStackedBuilder = Widget Function(
  BuildContext context,
  ExpansionState state,
  Widget? child,
);

class SBBStackedColumn extends MultiChildRenderObjectWidget {
  const SBBStackedColumn({
    super.key,
    required super.children,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderStackedColumn();
  }
}

class SBBStackedItem extends StatelessWidget {
  SBBStackedItem({
    super.key,
    this.minHeight,
    this.maxHeight,
    this.child,
    this.builder,
  });

  factory SBBStackedItem.crossfade({
    Key? key,
    required Widget firstChild,
    required Widget secondChild,
  }) {
    return SBBStackedItem(
      key: key,
      builder: (context, progress, _) => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.centerLeft,
        children: [
          IgnorePointer(
            ignoring: progress.localExpansionRate > 0.1,
            child: Opacity(
              opacity: 1.0 - progress.localExpansionRate,
              child: firstChild,
            ),
          ),
          OverrideIntrinsics(
            minHeight: 0.0,
            child: IgnorePointer(
              ignoring: progress.localExpansionRate < 0.9,
              child: Opacity(
                opacity: progress.localExpansionRate,
                child: secondChild,
              ),
            ),
          ),
        ],
      ),
    );
  }

  factory SBBStackedItem.aligned({
    Key? key,
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    Clip clipBehavior = Clip.none,
    double minHeight = 0,
    double? maxHeight,
    SBBStackedBuilder? builder,
    Widget? child,
  }) {
    return SBBStackedItem(
      key: key,
      minHeight: minHeight,
      maxHeight: maxHeight,
      builder: builder == null
          ? null
          : (context, progress, child) {
              return ClipRect(
                clipBehavior: clipBehavior,
                child: OverflowBox(
                  maxHeight: double.infinity,
                  alignment: alignment,
                  child: builder(context, progress, child),
                ),
              );
            },
      child: (child == null)
          ? null
          : builder != null
              ? child
              : ClipRect(
                  clipBehavior: clipBehavior,
                  child: OverflowBox(
                    maxHeight: double.infinity,
                    alignment: alignment,
                    child: child,
                  ),
                ),
    );
  }

  final double? minHeight;
  final double? maxHeight;

  final SBBStackedBuilder? builder;
  final Widget? child;
  final notifier = ValueNotifier<ExpansionState>(ExpansionState.of(1.0, 1.0));

  @override
  Widget build(BuildContext context) {
    if (builder != null) {
      return _SBBStackedItem(
        progressNotifier: notifier,
        child: OverrideIntrinsics(
          minHeight: minHeight,
          maxHeight: maxHeight,
          child: ValueListenableBuilder<ExpansionState>(
            valueListenable: notifier,
            builder: builder!,
            child: child,
          ),
        ),
      );
    } else {
      return _SBBStackedItem(
        child: OverrideIntrinsics(
          minHeight: minHeight,
          maxHeight: maxHeight,
          child: child!,
        ),
      );
    }
  }
}

class _SBBStackedItem extends ParentDataWidget<StackedColumnParentData> {
  const _SBBStackedItem({
    super.key,
    required super.child,
    this.progressNotifier,
  });

  final ValueNotifier<ExpansionState>? progressNotifier;

  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData as StackedColumnParentData;

    parentData.progressNotifier = progressNotifier;
  }

  @override
  Type get debugTypicalAncestorWidgetClass => SBBStackedColumn;
}

class _RenderStackedColumn extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, StackedColumnParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, StackedColumnParentData>,
        DebugOverflowIndicatorMixin {
  double shrunkHeight = 0.0;
  double desiredHeight = 0.0;

  double minExtent = 0.0;

  final Set<_ProgressUpdate> _pendingProgress = {};

  @override
  double computeMinIntrinsicHeight(double width) {
    var child = firstChild;
    var acc = 0.0;

    while (child != null) {
      acc += child.getMinIntrinsicHeight(width);
      child = (child.parentData as StackedColumnParentData).nextSibling;
    }

    return max(minExtent, acc);
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    var child = firstChild;
    var acc = 0.0;

    while (child != null) {
      acc += child.getMaxIntrinsicHeight(width);
      child = (child.parentData as StackedColumnParentData).nextSibling;
    }

    return max(minExtent, acc);
  }

  void _measureDesiredHeight() {
    final width = constraints.maxWidth > 1.0 ? constraints.maxWidth : double.infinity;

    shrunkHeight = max(getMinIntrinsicHeight(width), constraints.minHeight);
    desiredHeight = getMaxIntrinsicHeight(width);
  }

  (double, double) _getMinMax(RenderBox child) {
    final width = constraints.maxWidth > 1.0 ? constraints.maxWidth : double.infinity;

    return (child.getMinIntrinsicHeight(width), child.getMaxIntrinsicHeight(width));
  }

  void _queueProgressUpdate(StackedColumnParentData pd, ExpansionState state) {
    final n = pd.progressNotifier;

    if (n == null || n.value == state) return;

    // Maybe use a vsync instead?
    final scheduled = _pendingProgress.isNotEmpty;
    _pendingProgress.add(_ProgressUpdate(n, state));
    if (!scheduled) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) {
          // publish to listeners in the *next* frame
          for (final u in _pendingProgress) {
            u.notifier.value = u.value;
          }
          _pendingProgress.clear();
        },
      );
    }
  }

  @override
  void detach() {
    _pendingProgress.clear();
    super.detach();
  }

  @override
  void performLayout() {
    _measureDesiredHeight();

    RenderBox? child = lastChild;

    // Max height of the construct
    var totalHeight = min(constraints.maxHeight, desiredHeight);
    // Pixels that we must shrink
    var toShrink = desiredHeight - totalHeight;
    var totalWidth = 0.0;

    final totalRange = desiredHeight - shrunkHeight;
    final totalProgress = totalRange <= 0.0 ? 1.0 : (totalHeight - shrunkHeight) / (desiredHeight - shrunkHeight);

    // First pass to determine sizes
    while (child != null) {
      final parentData = child.parentData! as StackedColumnParentData;

      final (minHeight, maxHeight) = _getMinMax(child);

      if (toShrink > 0 && minHeight < maxHeight) {
        final height = math.max(minHeight, maxHeight - toShrink);
        // Child can be shrunk
        child.layout(
          constraints.copyWith(
            maxHeight: height,
            minHeight: min(
              constraints.minHeight,
              height,
            ),
          ),
          parentUsesSize: true,
        );

        toShrink -= (maxHeight - child.size.height);
      } else {
        // Child cannot be shrunk, so use original constraints
        child.layout(
          constraints.copyWith(
            maxHeight: maxHeight,
            minHeight: min(minHeight, maxHeight),
          ),
          parentUsesSize: true,
        );
      }

      final range = (maxHeight - minHeight);
      final current = child.size.height.clamp(minHeight, maxHeight);
      var progress = range > 0 ? (current - minHeight) / range : 1.0;

      if (totalProgress < 0.01) {
        progress = 0.0;
      }

      _queueProgressUpdate(
        parentData,
        ExpansionState(localExpansionRate: progress, globalExpansionRate: totalProgress),
      );

      child = parentData.previousSibling;
    }

    // Second pass to determine positions
    child = firstChild;
    var offset = 0.0;
    while (child != null) {
      final parentData = child.parentData! as StackedColumnParentData;

      parentData.offset = Offset(0.0, offset);
      offset += child.size.height;

      totalWidth = max(totalWidth, child.size.width);

      child = parentData.nextSibling;
    }

    size = Size(
      max(totalWidth, constraints.minWidth),
      max(totalHeight, constraints.minHeight),
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _reversePaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  void _reversePaint(PaintingContext context, Offset offset) {
    RenderObject? child = lastChild;
    while (child != null) {
      final childParentData = child.parentData! as StackedColumnParentData;

      context.paintChild(child, childParentData.offset + offset);

      child = childParentData.previousSibling;
    }
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! StackedColumnParentData) {
      child.parentData = StackedColumnParentData();
    }
  }
}

class StackedColumnParentData extends ContainerBoxParentData<RenderBox> {
  ValueNotifier<ExpansionState>? progressNotifier;
}

@immutable
final class ExpansionState {
  const ExpansionState({
    required this.localExpansionRate,
    required this.globalExpansionRate,
  });

  const ExpansionState.of(double local, double global) : this(localExpansionRate: local, globalExpansionRate: global);

  final double localExpansionRate;
  final double globalExpansionRate;

  double get localCollapseRate => 1.0 - localExpansionRate;
  double get globalCollapseRate => 1.0 - globalExpansionRate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpansionState &&
          runtimeType == other.runtimeType &&
          localExpansionRate == other.localExpansionRate &&
          globalExpansionRate == other.globalExpansionRate;

  @override
  int get hashCode => localExpansionRate.hashCode ^ globalExpansionRate.hashCode;
}

class _ProgressUpdate {
  _ProgressUpdate(this.notifier, this.value);

  final ValueNotifier<ExpansionState> notifier;
  final ExpansionState value;

  @override
  bool operator ==(Object other) => other is _ProgressUpdate && other.notifier == notifier;

  @override
  int get hashCode => notifier.hashCode;
}
