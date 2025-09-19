part of 'sbb_stacked_column.dart';

enum SBBContractionBehavior {
  push,
  clip,
  center,
  shrink,
}

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
///     SBBStackedItem.contract(
///       child: Text('This widget gets clipped as the column shrinks'),
///     ),
///     SBBStackedItem.contract(
///        behavior: SBBContractionBehavior.push,
///        child: Text('This widget moves up under the widget above'),
///      ),
///   ],
/// )
/// ```
class SBBStackedItem extends StatelessWidget {
  SBBStackedItem._({
    super.key,
    this.minHeight,
    this.maxHeight,
    this.clipBehavior = Clip.none,
    this.behavior = SBBContractionBehavior.shrink,
    this.child,
    this.builder,
  });

  /// Allows full customization of the stacked item.
  ///
  /// By default, this will not contract unless you set [minHeight] to something smaller than your widget height,
  /// but using [builder] you can react to the contraction / expansion state of the headerbox.
  SBBStackedItem.custom({
    Key? key,
    double? minHeight,
    double? maxHeight,
    Widget? child,
    SBBStackedBuilder? builder,
  }) : this._(
         key: key,
         minHeight: minHeight,
         maxHeight: maxHeight,
         child: child,
         builder: builder,
         behavior: SBBContractionBehavior.shrink,
       );

  /// Crossfades between a [contractedChild] and an [expandedChild].
  ///
  /// Using [alignment] you can specify what happens to the position of the [expandedChild] when the widget shrinks.
  ///
  /// ## Caveats
  ///
  /// The [expandedChild] must be taller than [contractedChild], otherwise it is undefined behavior.
  SBBStackedItem.crossfade({
    Key? key,
    required Widget contractedChild,
    required Widget expandedChild,
    AlignmentGeometry alignment = AlignmentDirectional.centerStart,
  }) : this.custom(
         key: key,
         builder:
             (context, progress, _) => _Crossfade(
               alignment: alignment,
               progress: progress,
               contractedChild: contractedChild,
               expandedChild: expandedChild,
             ),
       );

  /// Creates a widget that contracts as the user scrolls.
  ///
  /// Use [behavior] to customize the way this widget contracts.
  ///
  /// The simplest way is to provide a [child], but you can also use a [builder] to get updates on the state of expansion.
  /// You can also provide both, in which case [child] will be passed into the builder function. This can be beneficial for performance.
  SBBStackedItem.contract({
    Key? key,
    SBBContractionBehavior behavior = SBBContractionBehavior.clip,
    Clip clipBehavior = Clip.hardEdge,
    double minHeight = 0,
    double? maxHeight,
    SBBStackedBuilder? builder,
    Widget? child,
  }) : this._(
         key: key,
         minHeight: minHeight,
         maxHeight: maxHeight,
         behavior: behavior,
         clipBehavior: clipBehavior,
         builder: builder,
         child: child,
       );

  final double? minHeight;
  final double? maxHeight;

  final SBBStackedBuilder? builder;
  final Widget? child;

  final SBBContractionBehavior behavior;
  final Clip clipBehavior;
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
            builder: _builder(builder!),
            child: child == null ? null : _child(child!, builder),
          ),
        ),
      );
    } else {
      return _SBBStackedItem(
        child: OverrideIntrinsics(
          minHeight: minHeight,
          maxHeight: maxHeight,
          child: child == null ? null : _child(child!, builder),
        ),
      );
    }
  }

  SBBStackedBuilder _builder(SBBStackedBuilder builder) {
    if (behavior == SBBContractionBehavior.shrink) {
      return builder;
    }

    final alignment = switch (behavior) {
      SBBContractionBehavior.push => Alignment.bottomLeft,
      SBBContractionBehavior.clip => Alignment.topLeft,
      SBBContractionBehavior.center => Alignment.centerLeft,
      SBBContractionBehavior.shrink => Alignment.centerLeft, // Handled above
    };

    return (context, progress, child) {
      return ClipRect(
        clipBehavior: clipBehavior,
        child: OverflowBox(
          maxHeight: double.infinity,
          alignment: alignment,
          child: builder(context, progress, child),
        ),
      );
    };
  }

  Widget _child(Widget child, SBBStackedBuilder? builder) {
    if (behavior == SBBContractionBehavior.shrink || builder != null) {
      return child;
    }

    final alignment = switch (behavior) {
      SBBContractionBehavior.push => Alignment.bottomLeft,
      SBBContractionBehavior.clip => Alignment.topLeft,
      SBBContractionBehavior.center => Alignment.centerLeft,
      SBBContractionBehavior.shrink => Alignment.centerLeft, // Handled above
    };

    return ClipRect(
      clipBehavior: clipBehavior,
      child: OverflowBox(
        maxHeight: double.infinity,
        alignment: alignment,
        child: child,
      ),
    );
  }
}

class _SBBStackedItem extends ParentDataWidget<StackedColumnParentData> {
  const _SBBStackedItem({
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

class _Crossfade extends StatelessWidget {
  const _Crossfade({
    super.key,
    required this.alignment,
    required this.progress,
    required this.contractedChild,
    required this.expandedChild,
  });

  final AlignmentGeometry alignment;
  final ExpansionState progress;
  final Widget contractedChild;
  final Widget expandedChild;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: alignment,
      children: [
        IgnorePointer(
          ignoring: progress.expansionRate > 0.1,
          child: Opacity(
            opacity: 1.0 - progress.expansionRate,
            child: contractedChild,
          ),
        ),
        OverrideIntrinsics(
          minHeight: 0.0,
          child: IgnorePointer(
            ignoring: progress.expansionRate < 0.9,
            child: Opacity(
              opacity: progress.expansionRate,
              child: expandedChild,
            ),
          ),
        ),
      ],
    );
  }
}
