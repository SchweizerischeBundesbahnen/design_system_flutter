import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import 'override_intrinsics.dart';

part 'sbb_cascade_column.contractible.dart';

part 'sbb_cascade_column.renderbox.dart';

typedef SBBContractibleBuilder =
    Widget Function(
      BuildContext context,
      ExpansionState state,
      Widget? child,
    );

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
class SBBCascadeColumn extends MultiChildRenderObjectWidget {
  const SBBCascadeColumn({
    super.key,
    required super.children,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderStackedColumn();
  }
}

class StackedColumnParentData extends ContainerBoxParentData<RenderBox> {
  ValueNotifier<ExpansionState>? progressNotifier;
}

/// Stores the current state of expansion (and contraction).
@immutable
final class ExpansionState {
  const ExpansionState({
    required this.expansionRate,
    required this.totalExpansionRate,
  });

  const ExpansionState.of(double local, double global) : this(expansionRate: local, totalExpansionRate: global);

  final double expansionRate;
  final double totalExpansionRate;

  double get contractionRate => 1.0 - expansionRate;

  double get totalContractionRate => 1.0 - totalExpansionRate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpansionState &&
          runtimeType == other.runtimeType &&
          expansionRate == other.expansionRate &&
          totalExpansionRate == other.totalExpansionRate;

  @override
  int get hashCode => expansionRate.hashCode ^ totalExpansionRate.hashCode;
}

class _ProgressUpdate {
  _ProgressUpdate(this.notifier, this.value);

  final ValueNotifier<ExpansionState> notifier;
  final ExpansionState value;

  @override
  bool operator ==(Object other) => other is _ProgressUpdate && other.notifier == notifier;

  @override
  int get hashCode => notifier.hashCode;
}
