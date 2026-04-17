part of 'sbb_cascade_column.dart';

typedef ContractibleBuilder =
    Widget Function(
      BuildContext context,
      SBBContractibleState state,
      Widget? child,
    );

/// Describes how an [SBBContractible] reacts as its available height decreases.
enum SBBContractionBehavior {
  /// Keeps the child at its original size and moves it along the vertical axis.
  ///
  /// As the available height shrinks, the child is aligned to the bottom edge and
  /// appears to slide out of view instead of being resized.
  displace,

  /// Keeps the child at its original size and clips the overflowing part.
  ///
  /// This is the default behavior. The child stays aligned to the top edge while
  /// the parent reveals less of it as the available height decreases.
  clip,

  /// Keeps the child at its original size and centers it in the remaining space.
  ///
  /// As the available height shrinks, the visible portion remains centered
  /// vertically within the space that is left.
  center,

  /// Resizes the child to match the shrinking available height.
  ///
  /// Use this when the child can adapt gracefully to smaller vertical
  /// constraints.
  shrink,
}

/// A widget that changes its visible height as its parent contracts during scroll.
///
/// An [SBBContractible] must be used either as the body of [SBBSliverHeaderBox]
/// or as a descendant of [SBBCascadeColumn], with only [StatelessWidget]s and
/// [StatefulWidget]s between them.
///
/// By default, the child remains at its original size and is clipped as less
/// space becomes available. This can be customized with [behavior], for example
/// to make the child move with the bottom edge instead.
///
/// If [builder] is provided, the widget rebuilds with the current
/// [SBBContractibleState], which can be used to drive custom animations or
/// transitions.
///
/// ## Sample code
///
/// ```dart
/// SBBCascadeColumn(
///   children: [
///     SBBContractible(
///       child: Text('This widget gets clipped as the column shrinks'),
///     ),
///     SBBContractible(
///       behavior: .displace,
///       child: Text('This widget moves with the bottom edge'),
///     ),
///   ],
/// )
/// ```
///
/// See also:
///
///  * [SBBContractibleCrossfade], which crossfades between two widgets during
///    contraction.
///  * [SBBContractionListener], which allows reacting to changes in the state
///    of contraction.
///  * [SBBCascadeColumn], which applies a cascading contraction effect to its
///    children.
///  * [SBBSliverHeaderBox], which provides a sliver header that can host
///    contractible content.
class SBBContractible extends StatefulWidget {
  /// Creates a widget that responds to vertical contraction from its parent.
  ///
  /// When [builder] is omitted, [child] is rendered directly using the selected
  /// [behavior].
  ///
  /// When [builder] is provided, it receives the current
  /// [SBBContractibleState] and may use [child] as an optional static subtree.
  const SBBContractible({
    super.key,
    this.minHeight = 0,
    this.maxHeight,
    this.clipBehavior = .hardEdge,
    this.behavior = .clip,
    this.child,
    this.builder,
  });

  /// The minimum intrinsic height reported by this widget.
  ///
  /// This can be used to control how small the contractible is allowed to
  /// become.
  ///
  /// If null, the minimum intrinsic height is not overridden.
  /// This allows for custom transitions like [SBBContractibleCrossfade].
  ///
  /// Defaults to 0, meaning that the widget will contract fully.
  final double? minHeight;

  /// The maximum intrinsic height reported by this widget.
  ///
  /// This can be used to control the expanded height.
  ///
  /// If null, the maximum intrinsic height is not overridden.
  final double? maxHeight;

  /// Builds this widget based on the current [SBBContractibleState].
  ///
  /// Use this to implement custom visual effects that react to the current
  /// expansion or contraction progress.
  ///
  /// The optional [child] can be used to pass a static subtree that does not
  /// depend on the current state.
  ///
  /// When [builder] is provided, [child] is passed through the builder and is
  /// not rendered automatically.
  final ContractibleBuilder? builder;

  /// A subtree that is rendered by this widget.
  ///
  /// If [builder] is null, this widget displays [child] directly.
  ///
  /// If [builder] is non-null, [child] is forwarded to [builder] so it can be
  /// incorporated into the custom build output.
  final Widget? child;

  /// Defines how the child behaves as the available height decreases.
  ///
  /// Defaults to [SBBContractionBehavior.clip].
  final SBBContractionBehavior behavior;

  /// Controls how this widget clips its child when clipping is applied.
  ///
  /// This is relevant for behaviors that keep the child at its original size,
  /// such as [SBBContractionBehavior.clip],
  /// [SBBContractionBehavior.displace], and
  /// [SBBContractionBehavior.center].
  ///
  /// In some layouts, clipping may be better handled by an ancestor instead,
  /// for example to avoid unwanted interactions with padding. In those cases,
  /// consider using [Clip.none].
  final Clip clipBehavior;

  @override
  State<SBBContractible> createState() => _SBBContractibleState();
}

class _SBBContractibleState extends State<SBBContractible> {
  final notifier = ValueNotifier<SBBContractibleState>(SBBContractibleState.of(1.0, 1.0));

  @override
  Widget build(BuildContext context) {
    if (widget.builder != null) {
      return _SBBContractible(
        stateNotifier: notifier,
        child: OverrideIntrinsics(
          minHeight: widget.minHeight,
          maxHeight: widget.maxHeight,
          child: ValueListenableBuilder<SBBContractibleState>(
            valueListenable: notifier,
            builder: _builder(widget.builder!),
            child: widget.child == null ? null : _child(widget.child!, widget.builder),
          ),
        ),
      );
    } else {
      return _SBBContractible(
        child: OverrideIntrinsics(
          minHeight: widget.minHeight,
          maxHeight: widget.maxHeight,
          child: widget.child == null ? null : _child(widget.child!, widget.builder),
        ),
      );
    }
  }

  ContractibleBuilder _builder(ContractibleBuilder builder) {
    if (widget.behavior == .shrink) {
      return builder;
    }

    final Alignment alignment = switch (widget.behavior) {
      .displace => .bottomLeft,
      .clip => .topLeft,
      .center => .centerLeft,
      .shrink => .centerLeft, // Handled above
    };
    return (context, progress, child) {
      return ClipRect(
        clipBehavior: widget.clipBehavior,
        child: OverflowBox(
          maxHeight: .infinity,
          alignment: alignment,
          child: builder(context, progress, child),
        ),
      );
    };
  }

  Widget _child(Widget child, ContractibleBuilder? builder) {
    if (widget.behavior == .shrink || builder != null) {
      return child;
    }

    final Alignment alignment = switch (widget.behavior) {
      .displace => .bottomLeft,
      .clip => .topLeft,
      .center => .centerLeft,
      .shrink => .centerLeft, // Handled above
    };

    return ClipRect(
      clipBehavior: widget.clipBehavior,
      child: OverflowBox(
        maxHeight: .infinity,
        alignment: alignment,
        child: child,
      ),
    );
  }
}

/// A widget that crossfades between two children as a header contracts.
///
/// The widget fades from [expandedChild] to [contractedChild] as the available
/// height decreases.
///
/// During the transition, [expandedChild] is laid out with shrinking height
/// constraints so that it can visually blend into the size of
/// [contractedChild]. This enables more fluid transitions, but also means that
/// [expandedChild] must be able to handle reduced vertical space.
///
/// {@template sbb_design_system.contractible_crossfade.caveat}
/// If [expandedChild] cannot shrink gracefully, consider wrapping it in an
/// [OverflowBox] with its max height set to [double.infinity].
///
/// The [expandedChild] is expected to be taller than [contractedChild]. If that
/// is not the case, the visual result is undefined.
/// {@endtemplate}
class SBBContractibleCrossfade extends StatelessWidget {
  /// Creates a widget that crossfades between an expanded and a contracted
  /// child during contraction.
  ///
  /// {@macro sbb_design_system.contractible_crossfade.caveat}
  const SBBContractibleCrossfade({
    super.key,
    required this.contractedChild,
    required this.expandedChild,
    this.alignment = AlignmentDirectional.centerStart,
  });

  /// The child shown when the widget is fully contracted.
  ///
  /// This widget fades in as the available height decreases.
  final Widget contractedChild;

  /// The child shown when the widget is fully expanded.
  ///
  /// This widget fades out as the available height decreases.
  final Widget expandedChild;

  /// How the children are aligned within the crossfade stack.
  ///
  /// This affects how the widgets are positioned relative to each other during
  /// the transition.
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return SBBContractible(
      minHeight: null,
      clipBehavior: .none,
      behavior: .shrink,
      builder: (_, state, _) => _stack(state),
    );
  }

  Widget _stack(SBBContractibleState state) {
    return Stack(
      clipBehavior: .none,
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

class _SBBContractible extends ParentDataWidget<_CascadeColumnParentData> {
  const _SBBContractible({
    required super.child,
    this.stateNotifier,
  });

  final ValueNotifier<SBBContractibleState>? stateNotifier;

  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData as _CascadeColumnParentData;

    if (parentData.stateNotifier != stateNotifier && parentData.stateNotifier != null) {
      // Make sure that a new notifier retains the previous state to prevent flickering.
      // Additionally, we schedule a layout pass to make sure that it matches the actual layout.
      stateNotifier?.value = parentData.stateNotifier!.value;
      renderObject.markNeedsLayout();
    }

    parentData.stateNotifier = stateNotifier;
  }

  @override
  Type get debugTypicalAncestorWidgetClass => _SBBCascadeColumn;
}
