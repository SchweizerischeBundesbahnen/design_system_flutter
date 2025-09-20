part of 'sbb_cascade_column.dart';

enum SBBContractionBehavior {
  displace,
  clip,
  center,
  shrink,
}

/// A widget that contracts as the user scrolls.
///
/// It must be a direct child of either [SBBSliverFloatingHeaderbox] or [SBBCascadeColumn].
///
/// By default, it will clip as its parent shrinks, but you can pass in a [behavior] to change this effect, e.g. to
/// achieve a displacement effect.
///
/// For example:
///
/// ```dart
/// SBBCascadeColumn(
///   children: [
///     SBBContractible(
///       child: Text('This widget gets clipped as the column shrinks'),
///     ),
///     SBBContractible(
///        behavior: SBBContractionBehavior.displace,
///        child: Text('This widget moves with the bottom edge'),
///      ),
///   ],
/// )
/// ```
class SBBContractible extends StatelessWidget {
  SBBContractible._({
    super.key,
    this.minHeight,
    this.maxHeight,
    this.clipBehavior = Clip.none,
    this.behavior = SBBContractionBehavior.shrink,
    this.child,
    this.builder,
  });

  /// Creates a widget that contracts as the user scrolls.
  ///
  /// Use [behavior] to customize the way this widget contracts. By default it will get clipped.
  ///
  /// The simplest way is to provide a [child], but you can also use a [builder] to get updates on the state of expansion.
  /// You can also provide both, in which case [child] will be passed into the builder function. This can be beneficial for performance.
  SBBContractible({
    Key? key,
    SBBContractionBehavior behavior = SBBContractionBehavior.clip,
    Clip clipBehavior = Clip.hardEdge,
    SBBContractibleBuilder? builder,
    Widget? child,
  }) : this._(
         key: key,
         behavior: behavior,
         clipBehavior: clipBehavior,
         minHeight: 0,
         maxHeight: null,
         builder: builder,
         child: child,
       );

  /// Allows for full customization of the contractible.
  /// In particular, you can override the heights.
  SBBContractible.custom({
    Key? key,
    SBBContractionBehavior behavior = SBBContractionBehavior.shrink,
    Clip clipBehavior = Clip.hardEdge,
    double minHeight = 0,
    double? maxHeight,
    SBBContractibleBuilder? builder,
    Widget? child,
  }) : this._(
         key: key,
         behavior: behavior,
         clipBehavior: clipBehavior,
         minHeight: minHeight,
         maxHeight: maxHeight,
         builder: builder,
         child: child,
       );

  /// Crossfades between a [contractedChild] and an [expandedChild].
  ///
  /// Using [alignment] you can specify what happens to the position of the [expandedChild] when the widget shrinks.
  ///
  /// ## Caveats
  ///
  /// The [expandedChild] must be taller than [contractedChild], otherwise it is undefined behavior.
  SBBContractible.crossfade({
    Key? key,
    required Widget contractedChild,
    required Widget expandedChild,
    AlignmentGeometry alignment = AlignmentDirectional.centerStart,
  }) : this._(
         key: key,
         builder:
             (context, progress, _) => _Crossfade(
               alignment: alignment,
               progress: progress,
               contractedChild: contractedChild,
               expandedChild: expandedChild,
             ),
       );

  final double? minHeight;
  final double? maxHeight;

  final SBBContractibleBuilder? builder;
  final Widget? child;

  final SBBContractionBehavior behavior;
  final Clip clipBehavior;
  final notifier = ValueNotifier<ExpansionState>(ExpansionState.of(1.0, 1.0));

  @override
  Widget build(BuildContext context) {
    if (builder != null) {
      return _SBBContractible(
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
      return _SBBContractible(
        child: OverrideIntrinsics(
          minHeight: minHeight,
          maxHeight: maxHeight,
          child: child == null ? null : _child(child!, builder),
        ),
      );
    }
  }

  SBBContractibleBuilder _builder(SBBContractibleBuilder builder) {
    if (behavior == SBBContractionBehavior.shrink) {
      return builder;
    }

    final alignment = switch (behavior) {
      SBBContractionBehavior.displace => Alignment.bottomLeft,
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

  Widget _child(Widget child, SBBContractibleBuilder? builder) {
    if (behavior == SBBContractionBehavior.shrink || builder != null) {
      return child;
    }

    final alignment = switch (behavior) {
      SBBContractionBehavior.displace => Alignment.bottomLeft,
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

/// A widget that listens to expansion state chanes.
///
/// It allows you to react to changes in the current [SBBCascadeColumn] or [SBBSliverFloatingHeaderbox], and must be a
/// direct child of either one.
///
/// You can provide a [child] which will be passed into [builder] which can be beneficial for performance.
///
/// Example:
///
/// ```dart
/// SBBCascadeColumn(
///   children: [
///     SBBContractionListener(builder: (context, state, _) => Text('${state.totalExpansionRate}')),
///     SBBContractible(child: 'Hide this'),
///   ]
/// )
/// ```
class SBBContractionListener extends StatelessWidget {
  const SBBContractionListener({
    super.key,
    this.child,
    this.builder,
  });

  final Widget? child;
  final SBBContractibleBuilder? builder;

  @override
  Widget build(BuildContext context) {
    return SBBContractible._(
      // minHeight is not set, so shrink will effectively do nothing
      behavior: SBBContractionBehavior.shrink,
      builder: builder,
      child: child,
    );
  }
}

class _SBBContractible extends ParentDataWidget<StackedColumnParentData> {
  const _SBBContractible({
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
  Type get debugTypicalAncestorWidgetClass => SBBCascadeColumn;
}

class _Crossfade extends StatelessWidget {
  const _Crossfade({
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
