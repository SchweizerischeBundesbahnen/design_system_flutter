part of 'sbb_cascade_column.dart';

typedef ContractibleBuilder =
    Widget Function(
      BuildContext context,
      ContractibleExpansionState state,
      Widget? child,
    );

typedef ContractionListenerBuilder =
    Widget Function(
      BuildContext context,
      ExpansionState state,
      Widget? child,
    );


/// A widget that listens to expansion state changes.
///
/// It allows you to react to changes in the nearest [SBBCascadeColumn] or [SBBSliverFloatingHeaderbox] and thus must
/// must be a descendant of either of them.
///
/// You can provide a [child] which will be passed into [builder] which can be beneficial for performance.
///
/// Example:
///
/// ```dart
/// SBBCascadeColumn(
///   children: [
///     SBBContractionListener(builder: (context, state, _) => Text('${state.expansionRate}')),
///     SBBContractible(child: 'Hide this'),
///   ]
/// )
/// ```
class SBBContractionListener extends StatelessWidget {
  const SBBContractionListener({
    super.key,
    required this.builder,
    this.child,
  });

  final ContractionListenerBuilder builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final controller = _ContractionScope.of(context);
    return ValueListenableBuilder<ExpansionState>(
      valueListenable: controller,
      builder: (context, state, _) => builder(context, state, child),
    );
  }
}

enum SBBContractionBehavior {
  /// Contractible moves along.
  displace,

  /// Contractible gets clipped by the parent.
  clip,

  /// Contractible centers on the remaining space.
  center,

  /// Contractible shrinks as the parent shrinks. It is the caller's responsibility to make sure the widget handles the
  /// lack of space gracefully.
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
    ContractibleBuilder? builder,
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
    ContractibleBuilder? builder,
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

  final ContractibleBuilder? builder;
  final Widget? child;

  final SBBContractionBehavior behavior;
  final Clip clipBehavior;

  final notifier = ValueNotifier<ContractibleExpansionState>(ContractibleExpansionState.of(1.0, 1.0));

  @override
  Widget build(BuildContext context) {
    if (builder != null) {
      return _SBBContractible(
        progressNotifier: notifier,
        child: OverrideIntrinsics(
          minHeight: minHeight,
          maxHeight: maxHeight,
          child: ValueListenableBuilder<ContractibleExpansionState>(
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

  ContractibleBuilder _builder(ContractibleBuilder builder) {
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

  Widget _child(Widget child, ContractibleBuilder? builder) {
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

class _SBBContractible extends ParentDataWidget<CascadeColumnParentData> {
  const _SBBContractible({
    required super.child,
    this.progressNotifier,
  });

  final ValueNotifier<ContractibleExpansionState>? progressNotifier;

  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData as CascadeColumnParentData;

    parentData.progressNotifier = progressNotifier;
  }

  @override
  Type get debugTypicalAncestorWidgetClass => _SBBCascadeColumn;
}

class _Crossfade extends StatelessWidget {
  const _Crossfade({
    required this.alignment,
    required this.progress,
    required this.contractedChild,
    required this.expandedChild,
  });

  final AlignmentGeometry alignment;
  final ContractibleExpansionState progress;
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
