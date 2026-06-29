import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/shared/debug.dart';
import 'package:sbb_design_system_mobile/src/shared/utils.dart';

typedef OnStepPressedCallback = void Function(SBBStepperItem item, int index);

/// Duration of the label transition animation played when the active step changes.
const Duration _kStepperTransitionDuration = Duration(milliseconds: 200);

/// Curve of the label transition animation played when the active step changes.
const Curve _kStepperTransitionCurve = Curves.fastOutSlowIn;

/// The SBB Stepper.
/// Use according to [documentation](https://digital.sbb.ch/de/design-system/mobile/components/stepper/).
///
/// Provide a list of [SBBStepperItem] via [steps] and indicate the current
/// active step with [activeStep]. When a step is tapped the [onStepPressed]
/// callback is invoked with the corresponding item and index. The stepper does
/// not manage selection state; its parent should update [activeStep] and
/// rebuild the widget.
///
/// Use [SBBStepper.filled] to create the filled variant of the stepper.
///
/// Custom appearance can be provided via [style], which will override
/// non-null properties from the theme.
///
/// The widget requires at least two steps and an [activeStep] within the
/// valid range.
///
/// See also:
/// * [SBBStepperItem] to define individual steps.
/// * [SBBStepperStyle], the overall style for the stepper.
/// * [SBBStepperItemStyle], the style for a step of the stepper.
/// * [SBBStepperThemeData], which applies the stepper style theme-wide.
class SBBStepper extends StatefulWidget {
  const SBBStepper({
    Key? key,
    required List<SBBStepperItem> steps,
    required int activeStep,
    required OnStepPressedCallback onStepPressed,
    SBBStepperStyle? style,
  }) : this._(
         key: key,
         steps: steps,
         activeStep: activeStep,
         onStepPressed: onStepPressed,
         isFilledStyle: false,
         style: style,
       );

  /// Creates the filled style variant of [SBBStepper].
  ///
  /// Semantics and behavior are identical to the default constructor; the only
  /// difference is that the stepper theming is adjusted to work on colored background.
  const SBBStepper.filled({
    Key? key,
    required List<SBBStepperItem> steps,
    required int activeStep,
    required OnStepPressedCallback onStepPressed,
    SBBStepperStyle? style,
  }) : this._(
         key: key,
         steps: steps,
         activeStep: activeStep,
         onStepPressed: onStepPressed,
         isFilledStyle: true,
         style: style,
       );

  const SBBStepper._({
    super.key,
    required this.steps,
    required this.activeStep,
    required this.onStepPressed,
    required bool isFilledStyle,
    this.style,
  }) : assert(steps.length >= 2, 'needs at least two steps to work'),
       assert(activeStep >= 0 && activeStep < steps.length, 'activeStep needs to be in range of steps'),
       _isFilledStyle = isFilledStyle;

  /// The list of steps shown by this stepper.
  ///
  /// Each item controls its content (icon or text), optional badge and an
  /// optional per-item style that can further override the resolved style.
  final List<SBBStepperItem> steps;

  /// Called when a step is pressed.
  ///
  /// The callback receives the pressed [SBBStepperItem] and its index in
  /// [steps]. The stepper does not change [activeStep] itself; the parent
  /// should update state and rebuild if necessary.
  final OnStepPressedCallback onStepPressed;

  /// Index of the currently active step in [steps].
  ///
  /// The active step is visually indicated and its label (if any) is shown
  /// under the corresponding circle.
  final int activeStep;

  final bool _isFilledStyle;

  /// Customizes this stepper appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBStepperThemeData.style] of the theme found in [context].
  final SBBStepperStyle? style;

  @override
  State<SBBStepper> createState() => _SBBStepperState();
}

class _SBBStepperState extends State<SBBStepper> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _animation;

  /// Index of the step the label animates away from during a transition.
  late int _previousStep;

  @override
  void initState() {
    super.initState();
    _previousStep = widget.activeStep;
    // Start settled (value 1.0) so the first build shows only the active label
    // without playing a transition.
    _controller = AnimationController(duration: _kStepperTransitionDuration, vsync: this, value: 1.0);
    _animation = CurvedAnimation(parent: _controller, curve: _kStepperTransitionCurve);
  }

  @override
  void didUpdateWidget(SBBStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activeStep != oldWidget.activeStep) {
      _previousStep = oldWidget.activeStep;
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animation.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasSBBBaseStyle(context));

    final theme = Theme.of(context).sbbStepperTheme;
    final themeStyle = widget._isFilledStyle ? theme.filledStyle! : theme.style!;
    final effectiveStyle = themeStyle.merge(widget.style);

    return Padding(
      padding: themeStyle.padding ?? .zero,
      child: Column(
        mainAxisSize: .min,
        children: [
          _steps(effectiveStyle),
          _label(effectiveStyle),
        ],
      ),
    );
  }

  Widget _steps(SBBStepperStyle style) {
    return Row(
      spacing: SBBSpacing.xxSmall,
      children: widget.steps
          .mapIndexed((i, step) => _circle(i, style, step))
          .dividedBy(Expanded(child: _Divider(color: style.dividerColor)))
          .toList(),
    );
  }

  /// Builds the label area shown below the step circles.
  ///
  /// During a step change the outgoing and incoming labels are cross-faded
  /// while each stays positioned under its own step circle. A single
  /// [AnimatedSwitcher] cannot be used here because it would fade the outgoing
  /// label out at the incoming label's position (see issue #502).
  Widget _label(SBBStepperStyle effectiveStyle) {
    if (!_hasAnyLabel) return const SizedBox.shrink();

    return Padding(
      padding: const .only(top: SBBSpacing.xxSmall),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          final double t = _animation.value;
          // The previous step is only valid for a cross-fade while it is still
          // a valid index (the steps list may shrink between transitions).
          final bool isTransitioning =
              _previousStep != widget.activeStep && _previousStep < widget.steps.length && t < 1.0;
          if (!isTransitioning) {
            return _positionedLabel(widget.activeStep, effectiveStyle);
          }
          return Stack(
            children: [
              Opacity(
                opacity: (1.0 - t).clamp(0.0, 1.0),
                child: _positionedLabel(_previousStep, effectiveStyle),
              ),
              Opacity(
                opacity: t.clamp(0.0, 1.0),
                child: _positionedLabel(widget.activeStep, effectiveStyle),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Builds the label for [stepIndex], horizontally positioned under its own
  /// step circle so that outgoing and incoming labels keep their correct
  /// spatial context during a transition.
  Widget _positionedLabel(int stepIndex, SBBStepperStyle effectiveStyle) {
    return _EdgeClampedCentered(
      stepCircleSize: SBBStepperItemStyle.stepCircleSize,
      activeStep: stepIndex,
      stepCount: widget.steps.length,
      child: _labelContent(stepIndex, effectiveStyle),
    );
  }

  Widget _labelContent(int stepIndex, SBBStepperStyle effectiveStyle) {
    final step = widget.steps[stepIndex];
    final Widget labelWidget =
        step.label ??
        (step.labelText != null
            ? Text(
                step.labelText!,
                maxLines: 1,
                overflow: .ellipsis,
                softWrap: false,
                textAlign: .center,
              )
            : const SizedBox.shrink());

    final effectiveItemStyle = effectiveStyle.itemStyle?.merge(step.style);
    final resolvedLabelTextStyle = effectiveStyle.itemStyle!.labelTextStyle?.merge(step.style?.labelTextStyle);
    return addDefaultAncestorWithResolved(
      textStyle: resolvedLabelTextStyle,
      foregroundColor: effectiveItemStyle?.labelForegroundColor,
      child: labelWidget,
    )!;
  }

  Widget _circle(int i, SBBStepperStyle style, SBBStepperItem step) {
    final effectiveItemStyle = style.itemStyle!.merge(step.style);
    return _StepCircle(
      index: i,
      activeStep: widget.activeStep,
      style: effectiveItemStyle,
      item: step,
      onPressed: () => widget.onStepPressed(step, i),
    );
  }

  bool get _hasAnyLabel => widget.steps.any((step) => step.labelText != null || step.label != null);
}

class _Divider extends StatelessWidget {
  const _Divider({this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .infinity,
      height: SBBStepperStyle.dividerHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SBBStepperStyle.dividerHeight),
        color: color,
      ),
    );
  }
}

class _StepCircle extends StatefulWidget {
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
  final SBBStepperItemStyle style;
  final SBBStepperItem item;

  @override
  State<_StepCircle> createState() => _StepCircleState();
}

class _StepCircleState extends State<_StepCircle> {
  late WidgetStatesController _statesController;

  @override
  void initState() {
    super.initState();
    _statesController = WidgetStatesController();
    _updateStatesController();
  }

  @override
  void didUpdateWidget(_StepCircle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != oldWidget.index || widget.activeStep != oldWidget.activeStep) {
      _updateStatesController();
    }
  }

  void _updateStatesController() {
    _statesController.update(WidgetState.selected, widget.index == widget.activeStep);
  }

  @override
  void dispose() {
    _statesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: .none,
      children: [
        _circle(context),
        if (_passedStep && widget.item.showBadgeWhenPassed) _badge(),
      ],
    );
  }

  Widget _circle(BuildContext context) {
    final resolvedBackgroundColor = widget.style.backgroundColor?.resolve(_statesController.value);
    return SizedBox.square(
      dimension: SBBStepperItemStyle.stepCircleSize,
      child: Material(
        clipBehavior: .antiAlias,
        color: resolvedBackgroundColor,
        shape: _shape(),
        child: InkWell(
          onTap: widget.onPressed,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(
                width: SBBSpacing.large,
                height: SBBSpacing.large,
              ),
              child: _circleContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _badge() {
    final backgroundColor = widget.style.badgeBorderColor;
    return Positioned(
      top: -4,
      right: -2,
      child: IgnorePointer(
        child: Container(
          width: SBBStepperItemStyle.badgeSize,
          height: SBBStepperItemStyle.badgeSize,
          decoration: BoxDecoration(
            shape: .circle,
            color: widget.style.badgeBackgroundColor,
            border: backgroundColor != null ? BoxBorder.fromBorderSide(BorderSide(color: backgroundColor)) : null,
          ),
          child: Icon(
            widget.item.badgeIcon,
            color: widget.style.badgeIconColor,
            size: SBBStepperItemStyle.badgeIconSize,
            fontWeight: .w900,
          ),
        ),
      ),
    );
  }

  ShapeBorder _shape() {
    final resolvedBorderColor = widget.style.borderColor?.resolve(_statesController.value);
    return CircleBorder(
      side: resolvedBorderColor != null ? BorderSide(color: resolvedBorderColor, width: 1) : BorderSide.none,
    );
  }

  Widget _circleContent() {
    final item = widget.item;
    Widget content;
    if (item is SBBStepperItemIcon) {
      content = Icon(item.icon, size: SBBStepperItemStyle.stepIconSize);
    } else {
      final text = item is SBBStepperItemText ? item.text : '${widget.index + 1}';
      content = FittedBox(fit: .scaleDown, child: Text(text));
    }

    final resolvedForegroundColor = widget.style.foregroundColor?.resolve(_statesController.value);
    final resolvedTextStyle = widget.style.textStyle?.resolve(_statesController.value);
    return addDefaultAncestorWithResolved(
      foregroundColor: resolvedForegroundColor,
      textStyle: resolvedTextStyle,
      child: content,
    )!;
  }

  bool get _passedStep => widget.index < widget.activeStep;
}

/// A widget that positions its child horizontally so that the child's
/// horizontal center below a step, but clamps the child's left edge to the
/// parent's horizontal bounds so that the child remains fully visible.
///
/// Used to center the active step's label under the circle while
/// preventing the label from overflowing past the stepper's edges.
class _EdgeClampedCentered extends SingleChildRenderObjectWidget {
  const _EdgeClampedCentered({
    required this.activeStep,
    required this.stepCount,
    required this.stepCircleSize,
    super.child,
  });

  final double stepCircleSize;

  final int activeStep;

  final int stepCount;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderEdgeClampedCenterX(activeStep: activeStep, stepsCount: stepCount, stepCircleSize: stepCircleSize);

  @override
  void updateRenderObject(BuildContext context, _RenderEdgeClampedCenterX renderObject) {
    renderObject.stepCount = stepCount;
    renderObject.activeStep = activeStep;
    renderObject.stepCircleSize = stepCircleSize;
  }
}

/// Render object used by [_EdgeClampedCentered].
class _RenderEdgeClampedCenterX extends RenderShiftedBox {
  _RenderEdgeClampedCenterX({
    required int activeStep,
    required int stepsCount,
    required double stepCircleSize,
    RenderBox? child,
  }) : _stepCircleSize = stepCircleSize,
       _activeStep = activeStep,
       _stepsCount = stepsCount,
       super(child);

  double _stepCircleSize;

  int _activeStep;

  int _stepsCount;

  /// Desired horizontal center of the child in the parent's coordinate space.
  double get centerX =>
      _stepCircleSize / 2 + _activeStep * (constraints.maxWidth - _stepCircleSize) / (_stepsCount - 1);

  set stepCircleSize(double value) {
    if (_stepCircleSize == value) return;
    _stepCircleSize = value;
    markNeedsLayout();
  }

  set activeStep(int value) {
    if (_activeStep == value) return;
    _activeStep = value;
    markNeedsLayout();
  }

  set stepCount(int value) {
    if (_stepsCount == value) return;
    _stepsCount = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    if (child == null) {
      size = Size.zero;
      return;
    }

    final maxWidth = constraints.maxWidth;
    final childConstraints = BoxConstraints(minWidth: 0.0, maxWidth: maxWidth);
    child!.layout(childConstraints, parentUsesSize: true);

    final childSize = child!.size;
    final height = constraints.constrainHeight(childSize.height);
    size = Size(maxWidth, height);

    // compute left offset: center at centerX, then clamp to keep within [0, width - childWidth].
    final unclampedLeft = centerX - childSize.width / 2.0;
    final clampedLeft = unclampedLeft.clamp(0.0, maxWidth - childSize.width);

    final parentData = child!.parentData as BoxParentData;
    parentData.offset = Offset(clampedLeft, 0.0);
  }
}

extension _WidgetIterableX on Iterable<Widget> {
  Iterable<Widget> dividedBy(Widget divider) => expand((x) => [divider, x]).skip(1);
}
