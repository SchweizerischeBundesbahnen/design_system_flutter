part of 'sbb_cascade_column.dart';

typedef ContractionListenerBuilder =
    Widget Function(
      BuildContext context,
      SBBContractionState state,
      Widget? child,
    );

/// A widget that listens to expansion state changes.
///
/// It allows you to react to changes in the nearest [SBBCascadeColumn] or [SBBSliverHeaderBox] up the tree
/// and therefore must be a descendant of either of them.
///
/// Consider providing content that does not depend on the [SBBContractionState] as [child] in order to
/// prevent unnecessary rebuilds.
///
/// Example:
///
/// ```dart
/// SBBCascadeColumn(
///   children: [
///     SBBContractionListener(builder: (context, state, _) => Text('${state.expansionValue}')),
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
    return ValueListenableBuilder<SBBContractionState>(
      valueListenable: controller,
      builder: (context, state, _) => builder(context, state, child),
    );
  }
}
