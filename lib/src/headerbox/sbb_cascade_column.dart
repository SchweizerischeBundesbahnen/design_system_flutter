import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'override_intrinsics.dart';

part 'sbb_cascade_column.contractible.dart';

part 'sbb_cascade_column.listener.dart';

part 'sbb_cascade_column.renderbox.dart';

/// A widget that accomplishes the cascading shrink effect of the [SBBSliverFloatingHeaderbox].
///
/// It lays out its children the same way as a [Column] with [MainAxisSize.min],
/// but contracts them one by one from the bottom to the top as it shrinks in size.
///
/// Only use this widget for sophisticated effects or when dealing with a contractible flap.
/// In all other cases, it is easier to use one of the constructors in [SBBSliverFloatingHeaderbox].
///
/// Example:
///
/// ```dart
/// SBBCascadeColumn(
///   children: [
///     Text('This will not shrink'),
///     SBBContractionListener(
///       builder: (context, state, _) {
///         return Text('Neither will this, but we know how much of the way we are: ${state.contractionValue}');
///       },
///     ),
///     SBBContractible(
///       child: Text('This one will go away'),
///     ),
///     SBBContractible(
///       behavior: SBBContractionBehavior.displace,
///       child: Text('This one will too, but in a different way!'),
///     )
///   ],
/// )
/// ```
///
/// See also:
///
///  * [SBBSliverFloatingHeaderbox], which is most likely the context in which you want to use this.
///  * [SBBContractible], which makes its child shrinkable.
///  * [SBBContractionListener], which allows you to get updates on the expansion rate.
class SBBCascadeColumn extends StatefulWidget {
  const SBBCascadeColumn({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  State<SBBCascadeColumn> createState() => _SBBCascadeColumnState();
}

class _SBBCascadeColumnState extends State<SBBCascadeColumn> {
  late final _ContractionController _controller = _ContractionController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _ContractionScope(
    controller: _controller,
    child: _SBBCascadeColumn(
      controller: _controller,
      children: widget.children,
    ),
  );
}

class _SBBCascadeColumn extends MultiChildRenderObjectWidget {
  const _SBBCascadeColumn({
    required this.controller,
    required super.children,
  });

  final _ContractionController controller;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderCascadeColumn(controller);
  }

  @override
  void updateRenderObject(BuildContext context, covariant _RenderCascadeColumn renderObject) {
    renderObject.controller = controller;
  }
}

class CascadeColumnParentData extends ContainerBoxParentData<RenderBox> {
  ValueNotifier<ContractibleState>? stateNotifier;
}

/// Stores the current state of expansion (and contraction).
@immutable
final class ContractionState {
  const ContractionState({
    required this.expansionValue,
  });

  final double expansionValue;

  double get contractionValue => 1.0 - expansionValue;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContractionState && runtimeType == other.runtimeType && expansionValue == other.expansionValue;

  @override
  int get hashCode => expansionValue.hashCode;
}

/// Stores the current state of expansion (and contraction).
@immutable
final class ContractibleState {
  const ContractibleState({
    required this.expansionValue,
    required this.globalExpansionValue,
  });

  const ContractibleState.of(double local, double global) : this(expansionValue: local, globalExpansionValue: global);

  final double expansionValue;
  final double globalExpansionValue;

  double get contractionValue => 1.0 - expansionValue;

  double get globalContractionValue => 1.0 - globalExpansionValue;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContractibleState &&
          runtimeType == other.runtimeType &&
          expansionValue == other.expansionValue &&
          globalExpansionValue == other.globalExpansionValue;

  @override
  int get hashCode => expansionValue.hashCode ^ globalExpansionValue.hashCode;
}

/// Controller that holds the current (global) expansion state of the column.
class _ContractionController extends ValueNotifier<ContractionState> {
  _ContractionController([
    super.initial = const ContractionState(expansionValue: 1.0),
  ]);
}

/// Makes the controller available to the subtree, so listeners can subscribe
/// from anywhere under the SBBCascadeColumn.
class _ContractionScope extends InheritedNotifier<_ContractionController> {
  const _ContractionScope({
    required _ContractionController controller,
    required super.child,
  }) : super(notifier: controller);

  static _ContractionController? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_ContractionScope>()?.notifier;
  }

  static _ContractionController of(BuildContext context) {
    final ctrl = maybeOf(context);
    assert(ctrl != null, 'No SBBCascadeColumn or SBBSliverFloatingHeaderbox found in context.');
    return ctrl!;
  }
}
