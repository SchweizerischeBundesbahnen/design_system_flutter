import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

typedef OnStepPressedCallback = void Function(SBBStepperItem item, int index);

/// The SBB Stepper.
/// Use according to [documentation](https://digital.sbb.ch/de/design-system/mobile/components/stepper/).
///
/// Provide a list of [SBBStepperItem] via [steps] and indicate the current
/// active step with [activeStep]. When a step is tapped the [onStepPressed]
/// callback is invoked with the corresponding item and index. The stepper does
/// not manage selection state; its parent should update [activeStep] and
/// rebuild the widget.
///
/// Use [SBBStepper.colored] to create the colored variant of the stepper.
/// Custom appearance can be provided via [style], which will override
/// non-null properties from the theme.
///
/// The widget requires at least two steps and an [activeStep] within the
/// valid range.
///
/// See also:
/// * [SBBStepperItem] to define individual steps.
class SBBStepper extends StatelessWidget {
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
         isColoredStyle: false,
         style: style,
       );

  /// Creates the colored style variant of [SBBStepper].
  ///
  /// Semantics and behavior are identical to the default constructor; the only
  /// difference is that the stepper uses the theme's coloredStyle as the
  /// baseline when resolving appearance.
  const SBBStepper.colored({
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
         isColoredStyle: true,
         style: style,
       );

  const SBBStepper._({
    super.key,
    required this.steps,
    required this.activeStep,
    required this.onStepPressed,
    required bool isColoredStyle,
    this.style,
  }) : assert(steps.length >= 2, 'needs at least two steps to work'),
       assert(activeStep >= 0 && activeStep < steps.length, 'activeStep needs to be in range of steps'),
       _isColoredStyle = isColoredStyle;

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
  /// centered under the corresponding circle.
  final int activeStep;

  final bool _isColoredStyle;

  /// Customizes this stepper appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBStepperThemeData.style] of the theme found in [context].
  final SBBStepperStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).sbbStepperTheme!;
    final themeStyle = _isColoredStyle ? theme.coloredStyle! : theme.style!;
    final effectiveStyle = themeStyle.merge(style);

    final resolvedLabelTextStyle = effectiveStyle.itemStyle!.labelTextStyle?.merge(_activeItem.style?.labelTextStyle);

    return Padding(
      padding: themeStyle.padding ?? EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _steps(effectiveStyle),
          _label(resolvedLabelTextStyle),
        ],
      ),
    );
  }

  Widget _steps(SBBStepperStyle style) {
    return Row(
      spacing: SBBSpacing.xxSmall,
      children:
          steps
              .mapIndexed((i, step) => _circle(i, style, step))
              .dividedBy(Expanded(child: _Divider(color: style.dividerColor)))
              .toList(),
    );
  }

  Widget _label(TextStyle? labelTextStyle) {
    if (!_hasAnyLabel) return const SizedBox.shrink();

    final labelWidget =
        steps[activeStep].label ??
        Text(
          steps[activeStep].labelText!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          textAlign: TextAlign.center,
          style: labelTextStyle,
        );

    return Padding(
      padding: const EdgeInsets.only(top: SBBSpacing.xSmall),
      child: LayoutBuilder(
        builder: (_, constraints) {
          final stepCircleSize = SBBStepperItemStyle.stepCircleSize;
          final width = constraints.maxWidth;
          final xCenter = stepCircleSize / 2 + activeStep * (width - stepCircleSize) / (steps.length - 1);

          return _EdgeClampedCenterX(
            centerX: xCenter,
            child: labelWidget,
          );
        },
      ),
    );
  }

  Widget _circle(int i, SBBStepperStyle style, SBBStepperItem step) {
    final effectiveItemStyle = style.itemStyle!.merge(step.style);
    return _StepCircle(
      index: i,
      activeStep: activeStep,
      style: effectiveItemStyle,
      item: step,
      onPressed: () => onStepPressed(step, i),
    );
  }

  bool get _hasAnyLabel => steps.any((step) => step.labelText != null || step.label != null);

  SBBStepperItem get _activeItem => steps.elementAt(activeStep);
}

class _Divider extends StatelessWidget {
  const _Divider({this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      clipBehavior: Clip.none,
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
        clipBehavior: Clip.antiAlias,
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
      child: Container(
        width: SBBStepperItemStyle.badgeSize,
        height: SBBStepperItemStyle.badgeSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.style.badgeBackgroundColor,
          border: backgroundColor != null ? BoxBorder.fromBorderSide(BorderSide(color: backgroundColor)) : null,
        ),
        child: Icon(
          widget.item.badgeIcon,
          color: widget.style.badgeIconColor,
          size: SBBStepperItemStyle.badgeIconSize,
          fontWeight: FontWeight.w900,
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
    var item = widget.item;
    if (item is SBBStepperItemIcon) {
      final resolvedIconColor = widget.style.iconColor?.resolve(_statesController.value);
      return Icon(item.icon, size: SBBStepperItemStyle.stepIconSize, color: resolvedIconColor);
    }

    final resolvedTextStyle = widget.style.textStyle?.resolve(_statesController.value);
    final text = item is SBBStepperItemText ? item.text : '${widget.index + 1}';
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(text, style: resolvedTextStyle),
    );
  }

  bool get _passedStep => widget.index < widget.activeStep;
}

/// A widget that positions its single child horizontally so that the child's
/// horizontal center is at [centerX], but clamps the child's left edge to the
/// parent's horizontal bounds so that the child remains fully visible.
///
/// Used to center the active step's label under the active circle while
/// preventing the label from overflowing past the stepper's edges.
class _EdgeClampedCenterX extends SingleChildRenderObjectWidget {
  const _EdgeClampedCenterX({required this.centerX, super.child});

  /// Desired horizontal center of the child in the parent's coordinate space.
  final double centerX;

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderEdgeClampedCenterX(centerX: centerX);

  @override
  void updateRenderObject(BuildContext context, _RenderEdgeClampedCenterX renderObject) {
    renderObject.centerX = centerX;
  }
}

/// Render object used by [_EdgeClampedCenterX].
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

extension _WidgetExtension on Iterable<Widget> {
  Iterable<Widget> dividedBy(Widget divider) => expand((x) => [divider, x]).skip(1);
}
