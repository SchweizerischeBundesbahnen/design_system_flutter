part of 'sbb_cascade_column.dart';

typedef ContractibleBuilder =
    Widget Function(
      BuildContext context,
      ContractibleState state,
      Widget? child,
    );

enum SBBContractionBehavior {
  /// Contractible moves along the scrolling axis direction instead of shrinking / expanding.
  displace,

  /// Contractible gets clipped by the parent.
  clip,

  /// Contractible centers on the remaining space.
  center,

  /// Contractible shrinks as the parent shrinks.
  ///
  /// The child must be able to handle the lack of space gracefully.
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
  /// Use [behavior] to customize the way this widget contracts.
  /// Defaults to [SBBContractionBehavior.clip].
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
         builder: (context, progress, _) => _Crossfade(
           alignment: alignment,
           state: progress,
           contractedChild: contractedChild,
           expandedChild: expandedChild,
         ),
       );

  final double? minHeight;
  final double? maxHeight;

  final ContractibleBuilder? builder;
  final Widget? child;

  final SBBContractionBehavior behavior;

  /// Controls how / whether the contractible is clipped.
  ///
  /// In some cases, you may want to disable this and let the headerbox itself take care of the clipping, e.g. because
  /// of padding issues.
  final Clip clipBehavior;

  final notifier = ValueNotifier<ContractibleState>(ContractibleState.of(1.0, 1.0));

  @override
  Widget build(BuildContext context) {
    if (builder != null) {
      return _SBBContractible(
        stateNotifier: notifier,
        child: OverrideIntrinsics(
          minHeight: minHeight,
          maxHeight: maxHeight,
          child: ValueListenableBuilder<ContractibleState>(
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
    this.stateNotifier,
  });

  final ValueNotifier<ContractibleState>? stateNotifier;

  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData as CascadeColumnParentData;

    parentData.stateNotifier = stateNotifier;
  }

  @override
  Type get debugTypicalAncestorWidgetClass => _SBBCascadeColumn;
}

class _Crossfade extends StatelessWidget {
  const _Crossfade({
    required this.alignment,
    required this.state,
    required this.contractedChild,
    required this.expandedChild,
  });

  final AlignmentGeometry alignment;
  final ContractibleState state;
  final Widget contractedChild;
  final Widget expandedChild;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: alignment,
      children: [
        IgnorePointer(
          ignoring: state.expansionValue > 0.1,
          child: Opacity(
            opacity: 1.0 - state.expansionValue,
            child: contractedChild,
          ),
        ),
        OverrideIntrinsics(
          minHeight: 0.0,
          child: IgnorePointer(
            ignoring: state.expansionValue < 0.9,
            child: Opacity(
              opacity: state.expansionValue,
              child: expandedChild,
            ),
          ),
        ),
      ],
    );
  }
}
