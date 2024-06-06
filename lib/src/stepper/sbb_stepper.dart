import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

typedef OnStepPressedCallback = void Function(SBBStepperItem item, int index);

/// SBB Stepper widget.
class SBBStepper extends StatelessWidget {
  const SBBStepper({
    super.key,
    required this.steps,
    required this.activeStep,
    required this.onStepPressed,
  });

  /// The list of steps.
  final List<SBBStepperItem> steps;

  /// The index of the active step.
  final int activeStep;

  /// Called when the user has pressed a step.
  final OnStepPressedCallback onStepPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final lineWidth = (width - steps.length * 32) / (steps.length - 1);
        final widgets = <Widget>[];
        for (int i = 0; i < steps.length; i++) {
          final step = steps[i];
          final x = (i * 32) + (i * lineWidth);
          // Create step circle widget.
          final circle = PositionedDirectional(
            start: x,
            top: 0,
            child: _Circle(
              index: i,
              active: i == activeStep,
              icon: step.icon,
              onPressed: () => onStepPressed(step, i),
            ),
          );
          widgets.add(circle);
          // If the current step is not the last step create a connector line.
          if (i <= steps.length - 1) {
            final line = PositionedDirectional(
              start: x + 32,
              top: 16,
              child: _Line(width: lineWidth),
            );
            widgets.add(line);
          }
          // If this is the active step add the label below the circle. If the
          // active step is the first or last step make sure that the label
          // does not exceed the edge of the stepper.
          if (i == activeStep) {
            final size = _measureLabel(context, step.label, width);
            var start = (x + 16) - (size.width / 2);
            var end = start + size.width;
            if (start < 0) {
              start = 0;
              end = start + size.width;
            }
            if (end > width) {
              end = width;
              start = end - size.width;
            }
            final baseStyle = SBBBaseStyle.of(context);
            var textAlign = TextAlign.center;
            if (i == 0) {
              textAlign = TextAlign.start;
            } else if (i >= steps.length - 1) {
              textAlign = TextAlign.end;
            }
            final label = PositionedDirectional(
              start: start,
              top: 56 - size.height,
              width: end - start,
              height: size.height,
              child: Text(
                step.label,
                style: baseStyle.themedTextStyle(
                  textStyle: SBBTextStyles.smallLight,
                ),
                textAlign: textAlign,
                overflow: TextOverflow.ellipsis,
              ),
            );
            widgets.add(label);
          }
        }
        return SizedBox(
          width: width,
          height: 56,
          child: Stack(children: widgets),
        );
      },
    );
  }

  Size _measureLabel(BuildContext context, String label, double maxWidth) {
    final painter = TextPainter(
      text: TextSpan(text: label, style: SBBTextStyles.smallLight),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    painter.layout(minWidth: 0, maxWidth: maxWidth);
    return painter.size;
  }
}

// Internal

class _Circle extends StatelessWidget {
  const _Circle({
    required this.index,
    required this.active,
    this.icon,
    this.onPressed,
  });

  final int index;
  final bool active;
  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 32,
      child: Material(
        clipBehavior: Clip.antiAlias,
        color: _backgroundColor(context),
        shape: _shape(context),
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: _iconOrNumber(context),
          ),
        ),
      ),
    );
  }

  Color _backgroundColor(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.brightness == Brightness.dark) {
      return active ? SBBColors.white : SBBColors.charcoal;
    } else {
      return active ? SBBColors.red : SBBColors.white;
    }
  }

  ShapeBorder _shape(BuildContext context) {
    if (active) {
      return const CircleBorder();
    }
    final theme = Theme.of(context);
    if (theme.brightness == Brightness.dark) {
      return const CircleBorder(
        side: BorderSide(color: SBBColors.white, width: 1),
      );
    } else {
      return const CircleBorder(
        side: BorderSide(color: SBBColors.smoke, width: 1),
      );
    }
  }

  Widget _iconOrNumber(BuildContext context) {
    if (icon != null) {
      return Icon(
        icon,
        size: 24,
        color: _iconColor(context),
      );
    } else {
      final baseStyle = SBBBaseStyle.of(context);
      final number = index + 1;
      return Text(
        number.toString(),
        style: baseStyle.themedTextStyle(
          textStyle: SBBTextStyles.mediumLight,
          color: _numberColor(context),
        ),
      );
    }
  }

  Color _iconColor(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.brightness == Brightness.dark) {
      return active ? SBBColors.black : SBBColors.white;
    } else {
      return active ? SBBColors.black : SBBColors.red;
    }
  }

  Color _numberColor(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.brightness == Brightness.dark) {
      return active ? SBBColors.black : SBBColors.white;
    } else {
      return active ? SBBColors.white : SBBColors.black;
    }
  }
}

class _Line extends StatelessWidget {
  const _Line({
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    if (width <= 4) {
      return const SizedBox.shrink();
    }
    return Container(
      width: width - 4,
      height: 1,
      margin: const EdgeInsetsDirectional.fromSTEB(2, 0, 2, 0),
      color: _color(context),
    );
  }

  Color _color(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.brightness == Brightness.dark) {
      return SBBColors.white;
    } else {
      return SBBColors.smoke;
    }
  }
}
