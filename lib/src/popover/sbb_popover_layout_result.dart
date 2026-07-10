import 'package:sbb_design_system_mobile/src/popover/sbb_popover_direction.dart';

class SBBLayoutResult {
  const SBBLayoutResult({
    required this.direction,
  });

  final SBBPopoverDirection direction;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SBBLayoutResult && direction == other.direction;

  @override
  int get hashCode => direction.hashCode;
}
