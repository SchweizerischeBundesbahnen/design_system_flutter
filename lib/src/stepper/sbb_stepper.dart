import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import 'sbb_stepper_colors.dart';

typedef OnStepPressedCallback = void Function(SBBStepperItem item, int index);

/// SBB Stepper widget.
class SBBStepper extends StatelessWidget {
  const SBBStepper({
    super.key,
    required List<SBBStepperItem> steps,
    required int activeStep,
    required OnStepPressedCallback onStepPressed,
  })  : _steps = steps,
        _activeStep = activeStep,
        _onStepPressed = onStepPressed,
        _colors = null;

  /// This variant of the SSB Stepper should be used on a red background.
  const SBBStepper.red({
    super.key,
    required List<SBBStepperItem> steps,
    required int activeStep,
    required OnStepPressedCallback onStepPressed,
  })  : _steps = steps,
        _activeStep = activeStep,
        _onStepPressed = onStepPressed,
        _colors = SBBStepperColors.red;

  /// The list of steps.
  final List<SBBStepperItem> _steps;

  /// The index of the active step.
  final int _activeStep;

  /// Called when the user has pressed a step.
  final OnStepPressedCallback _onStepPressed;

  /// The colors of this stepper.
  final SBBStepperColors? _colors;

  @override
  Widget build(BuildContext context) {
    var colors = SBBStepperColors.light;
    if (_colors != null) {
      colors = _colors;
    } else if (Theme.of(context).brightness == Brightness.dark) {
      colors = SBBStepperColors.dark;
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final lineWidth = (width - _steps.length * 32) / (_steps.length - 1);
        final widgets = <Widget>[];
        for (int i = 0; i < _steps.length; i++) {
          final step = _steps[i];
          final x = (i * 32) + (i * lineWidth);
          // Create step circle widget.
          final circle = PositionedDirectional(
            start: x,
            top: 0,
            child: Semantics(
              button: true,
              selected: i == _activeStep,
              label: step.label,
              excludeSemantics: true,
              child: _Circle(
                colors: colors,
                index: i,
                active: i == _activeStep,
                icon: step.icon,
                onPressed: () => _onStepPressed(step, i),
              ),
            ),
          );
          widgets.add(circle);
          // If the current step is not the last step create a connector line.
          if (i <= _steps.length - 1) {
            final line = PositionedDirectional(
              start: x + 32,
              top: 16,
              child: _Line(
                colors: colors,
                width: lineWidth,
              ),
            );
            widgets.add(line);
          }
          // If this is the active step add the label below the circle. If the
          // active step is the first or last step make sure that the label
          // does not exceed the edge of the stepper.
          if (i == _activeStep) {
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
            } else if (i >= _steps.length - 1) {
              textAlign = TextAlign.end;
            }
            final label = PositionedDirectional(
              start: start,
              top: 56 - size.height,
              width: end - start,
              height: size.height,
              child: ExcludeSemantics(
                child: Text(
                  step.label,
                  style: baseStyle.themedTextStyle(
                    textStyle: SBBTextStyles.smallLight,
                    color: colors.label,
                  ),
                  textAlign: textAlign,
                  overflow: TextOverflow.ellipsis,
                ),
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
    required this.colors,
    required this.index,
    required this.active,
    this.icon,
    this.onPressed,
  });

  final SBBStepperColors colors;
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
        color: colors.circleBackground(active),
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

  ShapeBorder _shape(BuildContext context) {
    if (active) {
      return const CircleBorder();
    }
    return CircleBorder(
      side: BorderSide(
        color: colors.circleBorder(active),
        width: 1,
      ),
    );
  }

  Widget _iconOrNumber(BuildContext context) {
    if (icon != null) {
      return Icon(
        icon,
        size: 24,
        color: colors.circleContent(active),
      );
    } else {
      final baseStyle = SBBBaseStyle.of(context);
      final number = index + 1;
      return Text(
        number.toString(),
        style: baseStyle.themedTextStyle(
          textStyle: SBBTextStyles.mediumLight,
          color: colors.circleContent(active),
        ),
      );
    }
  }
}

class _Line extends StatelessWidget {
  const _Line({
    required this.colors,
    required this.width,
  });

  final SBBStepperColors colors;
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
      color: colors.line,
    );
  }
}
