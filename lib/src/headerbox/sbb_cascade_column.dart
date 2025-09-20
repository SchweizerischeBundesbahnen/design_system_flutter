import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'override_intrinsics.dart';

part 'sbb_cascade_column.contractible.dart';

part 'sbb_cascade_column.renderbox.dart';

/// A widget that accomplishes the cascading shrink effect of the [SBBSliverFloatingHeaderbox].
///
/// It lays out its children the same way as a shrink-wrapped column,
/// but contracts them one by one from the bottom to the top as it shrinks in size.
///
/// Only use this widget for sophisticated effects or when dealing with a contractible flap.
/// In any other case, it is easier to use one of the constructors in [SBBSliverFloatingHeaderbox].
///
/// See also:
///
///  * [SBBSliverFloatingHeaderbox], which is most likely the context in which you want to use this.
///  * [SBBContractible], which shrinkable children should be wrapped in.
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
  Widget build(BuildContext context) {
    return _ContractionScope(
      controller: _controller,
      child: _SBBCascadeColumn(
        controller: _controller,
        children: widget.children,
      ),
    );
  }
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
  ValueNotifier<ContractibleExpansionState>? progressNotifier;
}

/// Stores the current state of expansion (and contraction).
@immutable
final class ExpansionState {
  const ExpansionState({
    required this.expansionRate,
  });

  final double expansionRate;

  double get contractionRate => 1.0 - expansionRate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpansionState && runtimeType == other.runtimeType && expansionRate == other.expansionRate;

  @override
  int get hashCode => expansionRate.hashCode;
}

/// Stores the current state of expansion (and contraction).
@immutable
final class ContractibleExpansionState {
  const ContractibleExpansionState({
    required this.expansionRate,
    required this.totalExpansionRate,
  });

  const ContractibleExpansionState.of(double local, double global)
    : this(expansionRate: local, totalExpansionRate: global);

  final double expansionRate;
  final double totalExpansionRate;

  double get contractionRate => 1.0 - expansionRate;

  double get totalContractionRate => 1.0 - totalExpansionRate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContractibleExpansionState &&
          runtimeType == other.runtimeType &&
          expansionRate == other.expansionRate &&
          totalExpansionRate == other.totalExpansionRate;

  @override
  int get hashCode => expansionRate.hashCode ^ totalExpansionRate.hashCode;
}

/// Controller that holds the current (global) expansion state of the column.
class _ContractionController extends ValueNotifier<ExpansionState> {
  _ContractionController([
    super.initial = const ExpansionState(expansionRate: 1.0),
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
    assert(ctrl != null, 'No SBBCascadeColumn or SBBSliverFloatingHeaderbox found in context. ');
    return ctrl!;
  }
}
