part of 'sbb_stacked_column.dart';



/// A widget that lets you react to changes in expansion and contraction and provides
/// several helper functions to achieve different effects.
///
/// For example:
///
/// ```dart
/// SBBStackedColumn(
///   children: [
///     // We can use a builder to get progress updates
///     SBBStackedItem(builder: (context, state, _) => Text('${state.totalExpansionRate}')),
///     SBBStackedItem.aligned(
///       child: Text('This widget gets clipped as the column shrinks'),
///     ),
///     SBBStackedItem.aligned(
///        alignment: Alignment.bottomLeft,
///        child: Text('This widget moves up under the widget above'),
///      ),
///   ],
/// )
/// ```
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
    AlignmentGeometry alignment = AlignmentDirectional.centerStart,
  }) {
    return SBBStackedItem(
      key: key,
      builder:
          (context, progress, _) => Stack(
        clipBehavior: Clip.none,
        alignment: alignment,
        children: [
          IgnorePointer(
            ignoring: progress.expansionRate > 0.1,
            child: Opacity(
              opacity: 1.0 - progress.expansionRate,
              child: firstChild,
            ),
          ),
          OverrideIntrinsics(
            minHeight: 0.0,
            child: IgnorePointer(
              ignoring: progress.expansionRate < 0.9,
              child: Opacity(
                opacity: progress.expansionRate,
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
    Clip clipBehavior = Clip.hardEdge,
    double minHeight = 0,
    double? maxHeight,
    SBBStackedBuilder? builder,
    Widget? child,
  }) {
    return SBBStackedItem(
      key: key,
      minHeight: minHeight,
      maxHeight: maxHeight,
      builder:
      builder == null
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
      child:
      (child == null)
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