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

/// A widget that accomplishes the cascading shrink effect of the [SBBSliverHeaderBox].
///
/// It lays out its children the same way as a [Column] with [MainAxisSize.min],
/// but contracts them one by one from the bottom to the top as it shrinks in size.
///
/// Children are resized within the bounds of their reported intrinsic sizes. This means that
/// this widget will behave the same as a [Column] unless [SBBContractible] is used.
///
/// Only use this widget for sophisticated effects.
/// In many cases it is enough to set a contractible body in [SBBSliverHeaderBox].
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
///       behavior: .displace,
///       child: Text('This one will too, but in a different way!'),
///     )
///   ],
/// )
/// ```
///
/// See also:
///
///  * [SBBSliverHeaderBox], which is most likely the context in which you want to use this.
///  * [SBBContractible], which makes its child shrinkable.
///  * [SBBContractionListener], which allows you to get updates on the expansion rate.
class SBBCascadeColumn extends StatefulWidget {
  const SBBCascadeColumn({
    super.key,
    required this.children,
  });

  /// The child widgets of this cascade.
  ///
  /// Children can make use of [SBBContractible], but don't have to.

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

class _CascadeColumnParentData extends ContainerBoxParentData<RenderBox> {
  ValueNotifier<SBBContractibleState>? stateNotifier;
}

/// Stores the current state of expansion (and contraction).
@immutable
final class SBBContractionState {
  const SBBContractionState({
    required this.expansionValue,
  });

  final double expansionValue;

  double get contractionValue => 1.0 - expansionValue;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SBBContractionState && runtimeType == other.runtimeType && expansionValue == other.expansionValue;

  @override
  int get hashCode => expansionValue.hashCode;
}

/// Stores the current state of expansion (and contraction).
@immutable
final class SBBContractibleState {
  const SBBContractibleState({
    required this.expansionValue,
    required this.globalExpansionValue,
  });

  const SBBContractibleState.of(double local, double global)
    : this(expansionValue: local, globalExpansionValue: global);

  final double expansionValue;
  final double globalExpansionValue;

  double get contractionValue => 1.0 - expansionValue;

  double get globalContractionValue => 1.0 - globalExpansionValue;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SBBContractibleState &&
          runtimeType == other.runtimeType &&
          expansionValue == other.expansionValue &&
          globalExpansionValue == other.globalExpansionValue;

  @override
  int get hashCode => expansionValue.hashCode ^ globalExpansionValue.hashCode;
}

/// Controller that holds the current (global) expansion state of the column.
class _ContractionController extends ValueNotifier<SBBContractionState> {
  _ContractionController([
    super.initial = const SBBContractionState(expansionValue: 1.0),
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
    assert(ctrl != null, 'No SBBCascadeColumn or SBBSliverFloatingHeaderBox found in context.');
    return ctrl!;
  }
}
