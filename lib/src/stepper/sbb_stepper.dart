import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

const _dividerHeight = 2.0;
const _stepCircleSize = 32.0;

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
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
  }) : this._(
         key: key,
         steps: steps,
         activeStep: activeStep,
         onStepPressed: onStepPressed,
         isColoredStyle: false,
         padding: padding,
       );

  const SBBStepper.colored({
    Key? key,
    required List<SBBStepperItem> steps,
    required int activeStep,
    required OnStepPressedCallback onStepPressed,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
  }) : this._(
         key: key,
         steps: steps,
         activeStep: activeStep,
         onStepPressed: onStepPressed,
         isColoredStyle: true,
         padding: padding,
       );

  const SBBStepper._({
    super.key,
    required this.steps,
    required this.activeStep,
    required this.onStepPressed,
    required this.padding,
    required bool isColoredStyle,
  }) : assert(steps.length >= 2, 'needs at least two steps to work'),
       _isColoredStyle = isColoredStyle;

  final EdgeInsets padding;

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
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _steps(style),
          _label(style),
        ],
      ),
    );
  }

  Widget _steps(SBBStepperStyle? style) {
    return Row(
      spacing: 4.0,
      children:
          steps
              .mapIndexed((i, step) => _circle(i, style!, step))
              .dividedBy(Expanded(child: _Divider(color: style?.dividerColor)))
              .toList(),
    );
  }

  Widget _label(SBBStepperStyle? style) {
    if (!_hasAnyLabel) return const SizedBox.shrink();

    final textStyle = sbbTextStyle.small.lightStyle.copyWith(color: style?.labelTextColor);

    final labelWidget =
        steps[activeStep].label ??
        Text(
          steps[activeStep].labelText!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          textAlign: TextAlign.center,
          style: textStyle,
        );

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          // Same center calculation you had in your delegate:
          final double xCenter = _stepCircleSize / 2 + activeStep * (width - _stepCircleSize) / (steps.length - 1);

          return _EdgeClampedCenterX(
            centerX: xCenter,
            child: labelWidget,
          );
        },
      ),
    );
  }

  Widget _circle(int i, SBBStepperStyle style, SBBStepperItem step) {
    return _StepCircle(
      index: i,
      activeStep: activeStep,
      style: style,
      item: step,
      onPressed: () => onStepPressed(step, i),
    );
  }

  bool get _hasAnyLabel => steps.any((step) => step.labelText != null || step.label != null);
}

class _Divider extends StatelessWidget {
  const _Divider({this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: _dividerHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_dividerHeight),
        color: color,
      ),
    );
  }
}

class _StepCircle extends StatelessWidget {
  const _StepCircle({
    required this.index,
    required this.activeStep,
    required this.style,
    required this.item,
    this.onPressed,
  });

  final int index;
  final int activeStep;
  final VoidCallback? onPressed;
  final SBBStepperStyle style;
  final SBBStepperItem item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _circle(context),
        if (_passedStep) _checkedBadge(),
      ],
    );
  }

  Widget _circle(BuildContext context) {
    return SizedBox.square(
      dimension: _stepCircleSize,
      child: Material(
        clipBehavior: Clip.antiAlias,
        color: _active ? style.selectedBackgroundColor : style.backgroundColor,
        shape: _shape(),
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(
                width: 24.0,
                height: 24.0,
              ),
              child: _circleContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _checkedBadge() {
    return Positioned(
      top: -4,
      right: -2,
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: style.checkedBackgroundColor,
          border:
              style.checkedBorderColor != null
                  ? BoxBorder.fromBorderSide(BorderSide(color: style.checkedBorderColor!))
                  : null,
        ),
        child: Icon(
          SBBIcons.tick_small,
          color: SBBColors.white,
          size: 10.0,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  ShapeBorder _shape() {
    final borderColor = _active ? style.selectedBackgroundBorderColor : style.backgroundBorderColor;
    return CircleBorder(
      side: borderColor != null ? BorderSide(color: borderColor, width: 1) : BorderSide.none,
    );
  }

  // TODO: Why is cast needed. Use when?
  Widget _circleContent() {
    if (item is SBBStepperItemIcon) {
      final iconColor = _active ? style.selectedIconColor : style.iconColor;
      return Icon((item as SBBStepperItemIcon).icon, size: 24, color: iconColor);
    }

    final textStyle = _active ? sbbTextStyle.medium.boldStyle : sbbTextStyle.medium.lightStyle;
    final textColor = _active ? style.selectedTextColor : style.textColor;
    final text = item is SBBStepperItemText ? (item as SBBStepperItemText).text : '${index + 1}';
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(text, style: textStyle.copyWith(color: textColor)),
    );
  }

  bool get _active => index == activeStep;

  bool get _passedStep => index < activeStep;
}

/// TODO: DOCUMENT, maybe rename?
class _EdgeClampedCenterX extends SingleChildRenderObjectWidget {
  const _EdgeClampedCenterX({required this.centerX, super.child});

  final double centerX;

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderEdgeClampedCenterX(centerX: centerX);

  @override
  void updateRenderObject(BuildContext context, _RenderEdgeClampedCenterX renderObject) {
    renderObject.centerX = centerX;
  }
}

/// TODO: DOCUMENT
class _RenderEdgeClampedCenterX extends RenderShiftedBox {
  _RenderEdgeClampedCenterX({required double centerX, RenderBox? child}) : _centerX = centerX, super(child);

  double _centerX;

  double get centerX => _centerX;

  set centerX(double value) {
    if (_centerX == value) return;
    _centerX = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final width = constraints.constrainWidth();

    if (child == null) {
      size = Size(width, 0.0);
      return;
    }

    final childConstraints = BoxConstraints(minWidth: 0.0, maxWidth: width);
    child!.layout(childConstraints, parentUsesSize: true);

    final childSize = child!.size;
    final height = constraints.constrainHeight(childSize.height);
    size = Size(width, height);

    // compute left offset: center at centerX, then clamp to keep within [0, width - childWidth].
    final unclampedLeft = centerX - childSize.width / 2.0;
    final clampedLeft = unclampedLeft.clamp(0.0, (width - childSize.width).clamp(0.0, double.infinity));

    final parentData = child!.parentData as BoxParentData;
    parentData.offset = Offset(clampedLeft, 0.0);
  }
}

extension _ThemeBuildContextExtension on BuildContext {
  SBBStepperStyle? get stepperStyle => SBBControlStyles.of(this).stepper;

  SBBStepperStyle? get coloredStepperStyle => SBBControlStyles.of(this).coloredStepper;
}

extension _WidgetExtension on Iterable<Widget> {
  Iterable<Widget> dividedBy(Widget divider) => expand((x) => [divider, x]).skip(1);
}
