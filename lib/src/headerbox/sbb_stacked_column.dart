import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import 'override_intrinsics.dart';

part 'sbb_stacked_column.item.dart';

part 'sbb_stacked_column.renderbox.dart';

typedef SBBStackedBuilder =
    Widget Function(
      BuildContext context,
      ExpansionState state,
      Widget? child,
    );

/// A widget that lays out its children the same way as a shrink-wrapped column,
/// but contracts them one by one from bottom to top as it shrinks in size.
class SBBStackedColumn extends MultiChildRenderObjectWidget {
  const SBBStackedColumn({
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
