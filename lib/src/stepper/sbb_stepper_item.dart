import 'package:flutter/widgets.dart';

import '../../sbb_design_system_mobile.dart';

sealed class SBBStepperItem {
  const SBBStepperItem._({
    this.labelText,
    this.label,
    this.style,
    this.showBadgeWhenPassed = true,
  }) : assert(labelText == null || label == null, 'Cannot provide both labelText and label!');

  final String? labelText;
  final Widget? label;
  final SBBStepperItemStyle? style;
  final bool showBadgeWhenPassed;

  const factory SBBStepperItem.icon({
    required IconData icon,
    String? labelText,
    Widget? label,
    bool showBadgeWhenPassed,
    SBBStepperItemStyle? style,
  }) = SBBStepperItemIcon;

  const factory SBBStepperItem.text({
    required String text,
    String? labelText,
    Widget? label,
    bool showBadgeWhenPassed,
    SBBStepperItemStyle? style,
  }) = SBBStepperItemText;

  const factory SBBStepperItem.numbered({
    String? labelText,
    Widget? label,
    bool showBadgeWhenPassed,
    SBBStepperItemStyle? style,
  }) = SBBStepperItemNumbered;

  @override
  bool operator ==(Object other) => identical(this, other) || runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}

class SBBStepperItemIcon extends SBBStepperItem {
  const SBBStepperItemIcon({required this.icon, super.label, super.labelText, super.showBadgeWhenPassed, super.style})
    : super._();

  final IconData icon;
}

class SBBStepperItemText extends SBBStepperItem {
  const SBBStepperItemText({required this.text, super.label, super.labelText, super.showBadgeWhenPassed, super.style})
    : super._();

  final String text;
}

class SBBStepperItemNumbered extends SBBStepperItem {
  const SBBStepperItemNumbered({super.label, super.labelText, super.showBadgeWhenPassed, super.style}) : super._();
}
