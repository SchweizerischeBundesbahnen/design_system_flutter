import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

typedef OnStepPressedCallback = void Function(SBBStepperItem item, int index);

/// The SBB Stepper.
/// Use according to [documentation](https://digital.sbb.ch/de/design-system/mobile/components/stepper/).
///
/// TODO: Document code
///
class SBBStepper extends StatelessWidget {
  const SBBStepper({
    Key? key,
    required List<SBBStepperItem> steps,
    required int activeStep,
    required OnStepPressedCallback onStepPressed,
  }) : this._(
         key: key,
         steps: steps,
         activeStep: activeStep,
         onStepPressed: onStepPressed,
         isColoredStyle: false,
       );

  const SBBStepper.colored({
    Key? key,
    required List<SBBStepperItem> steps,
    required int activeStep,
    required OnStepPressedCallback onStepPressed,
  }) : this._(
         key: key,
         steps: steps,
         activeStep: activeStep,
         onStepPressed: onStepPressed,
         isColoredStyle: true,
       );

  const SBBStepper._({
    super.key,
    required this.steps,
    required this.activeStep,
    required this.onStepPressed,
    required bool isColoredStyle,
  }) : assert(steps.length >= 2, 'needs at least two steps to work'),
       _isColoredStyle = isColoredStyle;

  /// TODO:
  final List<SBBStepperItem> steps;

  /// TODO:
  final OnStepPressedCallback onStepPressed;

  /// TODO:
  final int activeStep;

  final bool _isColoredStyle;

  @override
  Widget build(BuildContext context) {
    // TODO: handle null style with default?
    final style = _isColoredStyle ? context.coloredStepperStyle : context.stepperStyle;
    return Row(
      spacing: 4.0,
      children:
          steps
              .mapIndexed(
                (i, step) => _Circle(
                  index: i,
                  active: i == activeStep,
                  style: style!,
                  icon: step.icon,
                  onPressed: () => onStepPressed(step, i),
                ),
              )
              .dividedBy(Expanded(child: _Divider(color: style?.dividerColor)))
              .toList(),
    );
  }
}

// internal widgets

class _Divider extends StatelessWidget {
  const _Divider({this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1),
        color: color,
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({
    required this.index,
    required this.active,
    required this.style,
    this.icon,
    this.onPressed,
  });

  final int index;
  final bool active;
  final IconData? icon;
  final VoidCallback? onPressed;
  final SBBStepperStyle style;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 32,
      child: Material(
        clipBehavior: Clip.antiAlias,
        color: active ? style.selectedBackgroundColor : style.backgroundColor,
        shape: _shape(context),
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(
                width: 24.0,
                height: 24.0,
              ),
              child: _iconOrNumber(context),
            ),
          ),
        ),
      ),
    );
  }

  ShapeBorder _shape(BuildContext context) {
    final borderColor = active ? style.selectedBackgroundBorderColor : style.backgroundBorderColor;
    return CircleBorder(
      side: borderColor != null ? BorderSide(color: borderColor, width: 1) : BorderSide.none,
    );
  }

  Widget _iconOrNumber(BuildContext context) {
    if (icon != null) {
      final iconColor = active ? style.selectedIconColor : style.iconColor;
      return Icon(icon, size: 24, color: iconColor);
    }

    final textStyle = active ? sbbTextStyle.medium.boldStyle : sbbTextStyle.medium.lightStyle;
    final textColor = active ? style.selectedTextColor : style.textColor;
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text('${index + 1}', style: textStyle.copyWith(color: textColor)),
    );
  }
}

// extensions

extension _ThemeBuildContextExtension on BuildContext {
  SBBStepperStyle? get stepperStyle => SBBControlStyles.of(this).stepper;

  SBBStepperStyle? get coloredStepperStyle => SBBControlStyles.of(this).coloredStepper;
}

extension _WidgetExtension on Iterable<Widget> {
  Iterable<Widget> dividedBy(Widget divider) => expand((x) => [divider, x]).skip(1);
}
