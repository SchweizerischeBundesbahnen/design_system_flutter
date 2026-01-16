import 'package:flutter/widgets.dart';

// TODO: Add style for each step
// TODO: Allow override of badge icon and to be hidden
// TODO: Custom content?
sealed class SBBStepperItem {
  const SBBStepperItem._({this.labelText, this.label});

  final String? labelText;
  final Widget? label;

  const factory SBBStepperItem.icon({required IconData icon, String? labelText, Widget? label}) = SBBStepperItemIcon;

  const factory SBBStepperItem.text({required String text, String? labelText, Widget? label}) = SBBStepperItemText;

  const factory SBBStepperItem.numbered({String? labelText, Widget? label}) = SBBStepperItemNumbered;

  @override
  bool operator ==(Object other) => identical(this, other) || runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}

class SBBStepperItemIcon extends SBBStepperItem {
  const SBBStepperItemIcon({required this.icon, super.label, super.labelText}) : super._();

  final IconData icon;
}

class SBBStepperItemText extends SBBStepperItem {
  const SBBStepperItemText({required this.text, super.label, super.labelText}) : super._();

  final String text;
}

class SBBStepperItemNumbered extends SBBStepperItem {
  const SBBStepperItemNumbered({super.label, super.labelText}) : super._();
}
