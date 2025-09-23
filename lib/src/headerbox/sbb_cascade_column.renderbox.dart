part of 'sbb_cascade_column.dart';

class _RenderCascadeColumn extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, CascadeColumnParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, CascadeColumnParentData>,
        DebugOverflowIndicatorMixin {
  _RenderCascadeColumn(this.controller);

  /// Theoretical height of the column when contracted.
  double contractedHeight = 0.0;

  /// Theoretical height of the column when expanded.
  double expandedHeight = 0.0;

  _ContractionController controller;

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
    _calculateHeights();

    RenderBox? child = lastChild;

    // Current height of the construct
    final currentHeight = min(constraints.maxHeight, expandedHeight);

    // Pixels that we must shrink
    var pixelsToShrink = expandedHeight - currentHeight;
    var totalWidth = 0.0;

    final totalRange = expandedHeight - contractedHeight;
    final totalProgress = totalRange > 0 ? (currentHeight - contractedHeight) / totalRange : 1.0;

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
        final height = math.max(minHeight, maxHeight - pixelsToShrink);
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

        pixelsToShrink -= (maxHeight - child.size.height);
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

      usedHeight += child.size.height;

      final range = (maxHeight - minHeight);
      final current = child.size.height.clamp(minHeight, maxHeight);
      var progress = range > 0 ? (current - minHeight) / range : 1.0;

      if (totalProgress < 0.01) {
        progress = 0.0;
      }

      _queueProgressUpdate(
        parentData,
        ContractibleState(expansionValue: progress, globalExpansionValue: totalProgress),
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
      max(currentHeight, constraints.minHeight),
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

  void _calculateHeights() {
    final width = constraints.maxWidth > 1.0 ? constraints.maxWidth : double.infinity;

    expandedHeight = getMaxIntrinsicHeight(width);
    contractedHeight = max(getMinIntrinsicHeight(width), constraints.minHeight);
  }

  (double, double) _getMinMaxHeights(RenderBox child) {
    final width = constraints.maxWidth > 1.0 ? constraints.maxWidth : double.infinity;

    return (child.getMinIntrinsicHeight(width), child.getMaxIntrinsicHeight(width));
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

  void _queueProgressUpdate(CascadeColumnParentData pd, ContractibleState state) {
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
