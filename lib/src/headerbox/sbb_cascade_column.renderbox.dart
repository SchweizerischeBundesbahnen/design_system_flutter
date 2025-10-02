part of 'sbb_cascade_column.dart';

const _kSmallValue = 1.0;

class _RenderCascadeColumn extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, CascadeColumnParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, CascadeColumnParentData>,
        DebugOverflowIndicatorMixin {
  _RenderCascadeColumn(this.controller);

  _ContractionController controller;

  /// Theoretical height of the column when contracted.
  double _minExtent = 0.0;

  /// Theoretical height of the column when expanded.
  double _maxExtent = 0.0;

  final Set<_ProgressUpdate> _pendingProgress = {};

  @override
  double computeMinIntrinsicHeight(double width) {
    var child = firstChild;
    var accumulatedHeight = 0.0;

    while (child != null) {
      accumulatedHeight += child.getMinIntrinsicHeight(width);
      child = (child.parentData as CascadeColumnParentData).nextSibling;
    }

    return max(0.0, accumulatedHeight);
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    var child = firstChild;
    var accumulatedHeight = 0.0;

    while (child != null) {
      accumulatedHeight += child.getMaxIntrinsicHeight(width);
      child = (child.parentData as CascadeColumnParentData).nextSibling;
    }

    return max(0.0, accumulatedHeight);
  }

  @override
  void performLayout() {
    _computeExtents();

    RenderBox? child = lastChild;

    final currentExtent = min(constraints.maxHeight, _maxExtent);

    var pixelsToShrink = _maxExtent - currentExtent;
    var totalWidth = 0.0;

    final totalRange = _maxExtent - _minExtent;
    final totalProgress = totalRange > 0 ? (currentExtent - _minExtent) / totalRange : 1.0;

    var usedHeight = 0.0;

    // First pass to determine sizes
    while (child != null) {
      final parentData = child.parentData! as CascadeColumnParentData;
      final isFirst = parentData.previousSibling == null;

      var (minHeight, maxHeight) = _getMinMaxHeights(child);
      if (isFirst) {
        // Compensate for the case when the minHeight constraint is smaller than
        // our desired minHeight.
        minHeight = math.max(minHeight, constraints.minHeight - usedHeight);
        maxHeight = math.max(maxHeight, minHeight);
      }

      if (pixelsToShrink > 0 && minHeight < maxHeight) {
        // Child can be shrunk
        final height = math.max(minHeight, maxHeight - pixelsToShrink);
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

        pixelsToShrink -= (maxHeight - child.size.height);
      } else {
        // Child cannot be shrunk, so use original constraints
        child.layout(
          constraints.copyWith(
            maxHeight: maxHeight,
            minHeight: minHeight,
          ),
          parentUsesSize: true,
        );
      }

      usedHeight += child.size.height;

      _queueStateUpdate(
        parentData,
        _computeState(child, minHeight, maxHeight, totalProgress),
      );

      child = parentData.previousSibling;
    }

    // Second pass to determine positions
    child = firstChild;
    var offset = 0.0;
    while (child != null) {
      final parentData = child.parentData! as CascadeColumnParentData;

      parentData.offset = Offset(0.0, offset);
      offset += child.size.height;

      totalWidth = max(totalWidth, child.size.width);

      child = parentData.nextSibling;
    }

    size = Size(
      max(totalWidth, constraints.minWidth),
      max(currentExtent, constraints.minHeight),
    );

    // Notify controller
    final contractionState = ContractionState(expansionValue: totalProgress);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      controller.value = contractionState;
    });
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _reversePaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  void _computeExtents() {
    final width = constraints.maxWidth > _kSmallValue ? constraints.maxWidth : double.infinity;

    _maxExtent = getMaxIntrinsicHeight(width);
    _minExtent = max(getMinIntrinsicHeight(width), constraints.minHeight);
  }

  (double, double) _getMinMaxHeights(RenderBox child) {
    final width = constraints.maxWidth > _kSmallValue ? constraints.maxWidth : double.infinity;

    final min = child.getMinIntrinsicHeight(width);
    final max = child.getMaxIntrinsicHeight(width);
    return (min, math.max(max, min));
  }

  void _reversePaint(PaintingContext context, Offset offset) {
    RenderObject? child = lastChild;
    while (child != null) {
      final childParentData = child.parentData! as CascadeColumnParentData;

      context.paintChild(child, childParentData.offset + offset);

      child = childParentData.previousSibling;
    }
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! CascadeColumnParentData) {
      child.parentData = CascadeColumnParentData();
    }
  }

  ContractibleState _computeState(RenderBox child, double minHeight, double maxHeight, double totalProgress) {
    final range = (maxHeight - minHeight);
    final current = child.size.height.clamp(minHeight, maxHeight);
    var progress = range > 0 ? (current - minHeight) / range : 1.0;

    if (totalProgress < 0.01) {
      progress = 0.0;
    }

    return ContractibleState(
      expansionValue: progress,
      globalExpansionValue: totalProgress,
    );
  }

  void _queueStateUpdate(
    CascadeColumnParentData pd,
    ContractibleState state,
  ) {
    final n = pd.stateNotifier;

    if (n == null || n.value == state) return;

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
}

class _ProgressUpdate {
  const _ProgressUpdate(this.notifier, this.value);

  final ValueNotifier<ContractibleState> notifier;
  final ContractibleState value;

  @override
  bool operator ==(Object other) => other is _ProgressUpdate && other.notifier == notifier;

  @override
  int get hashCode => notifier.hashCode;
}
