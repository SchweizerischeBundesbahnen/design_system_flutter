part of 'sbb_stacked_column.dart';

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
    final totalHeight = min(constraints.maxHeight, desiredHeight);
    // Pixels that we must shrink
    var toShrink = desiredHeight - totalHeight;
    var totalWidth = 0.0;

    final totalRange = desiredHeight - shrunkHeight;
    final totalProgress = totalRange <= 0.0 ? 1.0 : (totalHeight - shrunkHeight) / (desiredHeight - shrunkHeight);

    var usedHeight = 0.0;

    // First pass to determine sizes
    while (child != null) {
      final parentData = child.parentData! as StackedColumnParentData;
      final isFirst = parentData.previousSibling == null;

      var (minHeight, maxHeight) = _getMinMax(child);
      if (isFirst) {
        // Compensate for the case when the minHeight constraint is smaller than
        // our desired minHeight.
        minHeight = math.max(minHeight, constraints.minHeight - usedHeight);
        maxHeight = math.max(maxHeight, minHeight);
      }

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

      usedHeight += child.size.height;

      final range = (maxHeight - minHeight);
      final current = child.size.height.clamp(minHeight, maxHeight);
      var progress = range > 0 ? (current - minHeight) / range : 1.0;

      if (totalProgress < 0.01) {
        progress = 0.0;
      }

      _queueProgressUpdate(
        parentData,
        ExpansionState(expansionRate: progress, totalExpansionRate: totalProgress),
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