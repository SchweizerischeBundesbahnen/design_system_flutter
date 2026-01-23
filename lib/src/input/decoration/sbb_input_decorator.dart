import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sbb_design_system_mobile/src/input/decoration/sbb_decoration.dart';

import '../../../sbb_design_system_mobile.dart';

// Animation constants
const Duration _kTransitionDuration = Duration(milliseconds: 167);
const Curve _kTransitionCurve = Curves.fastOutSlowIn;
const double _kFinalLabelScale = 0.75;

class SBBInputDecorator extends StatefulWidget {
  const SBBInputDecorator({
    super.key,
    required this.decoration,
    this.expands = false,
    this.isMultiline = false,
    this.isEmpty = false,
    this.states = const <WidgetState>{},
    this.child,
  });

  /// The decoration to display around the input field.
  final SBBInputDecoration decoration;

  /// Whether the input field should expand to fill available space.
  final bool expands;

  /// Whether the input field can have multiple lines.
  ///
  /// When true, leading and trailing widgets are top-aligned instead of centered.
  final bool isMultiline;

  /// Whether the input field is empty.
  ///
  /// When true and the input field has focus, the placeholder is displayed.
  final bool isEmpty;

  /// The states of the input field.
  final Set<WidgetState> states;

  /// The widget below this decorator, usually some sort of [EditableText].
  final Widget? child;

  /// Whether the label needs to move above the input and seem to start floating.
  ///
  /// Will float when not empty or when focused while enabled.
  bool get _labelShouldFloat =>
      !isEmpty || (states.contains(WidgetState.focused) && !states.contains(WidgetState.disabled));

  @override
  State<SBBInputDecorator> createState() => _SBBInputDecoratorState();
}

class _SBBInputDecoratorState extends State<SBBInputDecorator> with SingleTickerProviderStateMixin {
  late final AnimationController _floatingLabelController;
  late final CurvedAnimation _floatingLabelAnimation;

  @override
  void initState() {
    super.initState();
    _floatingLabelController = AnimationController(
      duration: _kTransitionDuration,
      vsync: this,
      value: widget._labelShouldFloat ? 1.0 : 0.0,
    );
    _floatingLabelController.addListener(_handleAnimationChange);
    _floatingLabelAnimation = CurvedAnimation(
      parent: _floatingLabelController,
      curve: _kTransitionCurve,
      reverseCurve: _kTransitionCurve.flipped,
    );
  }

  @override
  void didUpdateWidget(SBBInputDecorator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._labelShouldFloat != oldWidget._labelShouldFloat) {
      if (widget._labelShouldFloat) {
        _floatingLabelController.forward();
      } else {
        _floatingLabelController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _floatingLabelController.dispose();
    _floatingLabelAnimation.dispose();
    super.dispose();
  }

  void _handleAnimationChange() {
    setState(() {
      // The _floatingLabelController's value has changed.
    });
  }

  @override
  Widget build(BuildContext context) {
    final inputDecorationTheme = Theme.of(context).sbbInputDecorationTheme;

    Widget? leading = widget.decoration.leading;
    if (leading == null && widget.decoration.leadingIconData != null) {
      leading = Icon(widget.decoration.leadingIconData);
    }
    if (leading != null) {
      final Color? resolvedColor =
          (widget.decoration.leadingForegroundColor ?? inputDecorationTheme?.leadingForegroundColor)?.resolve(
            widget.states,
          );
      leading = _addDefaultAncestorWithResolved(
        child: leading,
        foregroundColor: resolvedColor,
      );
    }

    Widget? label = widget.decoration.label;
    if (label == null && widget.decoration.labelText != null) {
      label = Text(widget.decoration.labelText!);
    }
    if (label != null) {
      final Color? resolvedColor =
          (widget.decoration.labelForegroundColor ?? inputDecorationTheme?.labelForegroundColor)?.resolve(
            widget.states,
          );
      final TextStyle? textStyle = widget.decoration.labelTextStyle ?? inputDecorationTheme?.labelTextStyle;
      final TextStyle? floatingTextStyle =
          widget.decoration.floatingLabelTextStyle ?? inputDecorationTheme?.floatingLabelTextStyle;
      final resolvedTextStyle =
          (widget._labelShouldFloat ? floatingTextStyle : textStyle)?.copyWith(color: resolvedColor) ??
          TextStyle(color: resolvedColor);

      label = AnimatedDefaultTextStyle(
        style: resolvedTextStyle,
        duration: _kTransitionDuration,
        child: IconTheme.merge(
          data: IconThemeData(color: resolvedColor),
          child: label,
        ),
      );
    }

    Widget? trailing = widget.decoration.trailing;
    if (trailing == null && widget.decoration.trailingIconData != null) {
      trailing = Icon(widget.decoration.trailingIconData);
    }
    if (trailing != null) {
      final Color? resolvedColor =
          (widget.decoration.trailingForegroundColor ?? inputDecorationTheme?.trailingForegroundColor)?.resolve(
            widget.states,
          );
      trailing = _addDefaultAncestorWithResolved(
        child: trailing,
        foregroundColor: resolvedColor,
      );
    }

    Widget? placeholder = widget.decoration.placeholder;
    if (placeholder == null && widget.decoration.placeholderText != null) {
      placeholder = Text(widget.decoration.placeholderText!);
    }
    if (placeholder != null) {
      final Color? resolvedColor =
          (widget.decoration.placeholderForegroundColor ?? inputDecorationTheme?.placeholderForegroundColor)?.resolve(
            widget.states,
          );
      final TextStyle? textStyle = widget.decoration.placeholderTextStyle ?? inputDecorationTheme?.placeholderTextStyle;
      placeholder = _addDefaultAncestorWithResolved(
        child: placeholder,
        foregroundColor: resolvedColor,
        textStyle: textStyle,
      );
    }

    Widget? error = widget.decoration.error;
    if (error == null && widget.decoration.errorText != null) {
      error = Text(widget.decoration.errorText!);
    }
    if (error != null) {
      final Color? resolvedColor =
          (widget.decoration.errorForegroundColor ?? inputDecorationTheme?.errorForegroundColor)?.resolve(
            widget.states,
          );
      final TextStyle? textStyle = widget.decoration.errorTextStyle ?? inputDecorationTheme?.errorTextStyle;
      error = _addDefaultAncestorWithResolved(
        child: error,
        foregroundColor: resolvedColor,
        textStyle: textStyle,
      );
    }
    error = AnimatedSwitcher(
      duration: _kTransitionDuration,
      child: error ?? SizedBox.shrink(),
    );

    final Color resolvedBorderColor =
        (widget.decoration.borderColor ?? inputDecorationTheme?.borderColor)?.resolve(widget.states) ??
        SBBColors.transparent;
    final Widget container = AnimatedContainer(
      duration: _kTransitionDuration,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: resolvedBorderColor)),
      ),
    );

    return _SBBDecorator(
      decoration: SBBDecoration(
        leading: leading,
        label: label,
        trailing: trailing,
        placeholder: placeholder,
        error: error,
        container: container,
      ),
      expands: widget.expands,
      isMultiline: widget.isMultiline,
      isEmpty: widget.isEmpty,
      isFocused: widget.states.contains(WidgetState.focused),
      floatingLabelProgress: _floatingLabelAnimation.value,
      child: widget.child,
    );
  }

  Widget _addDefaultAncestorWithResolved({
    required Widget child,
    required Color? foregroundColor,
    TextStyle? textStyle,
  }) {
    final resolvedTextStyle = textStyle?.copyWith(color: foregroundColor) ?? TextStyle(color: foregroundColor);

    child = DefaultTextStyle.merge(
      style: resolvedTextStyle,
      child: IconTheme.merge(
        data: IconThemeData(color: foregroundColor),
        child: child,
      ),
    );
    return child;
  }
}

enum _SBBDecorationSlot {
  label,
  leading,
  input,
  placeholder,
  trailing,
  error,
  container,
}

class _SBBDecorator extends SlottedMultiChildRenderObjectWidget<_SBBDecorationSlot, RenderBox> {
  const _SBBDecorator({
    required this.decoration,
    required this.expands,
    required this.isMultiline,
    required this.isEmpty,
    required this.isFocused,
    required this.floatingLabelProgress,
    this.child,
  });

  final SBBDecoration decoration;
  final bool expands;
  final bool isMultiline;
  final bool isEmpty;
  final bool isFocused;
  final double floatingLabelProgress;
  final Widget? child;

  @override
  Iterable<_SBBDecorationSlot> get slots => _SBBDecorationSlot.values;

  @override
  Widget? childForSlot(_SBBDecorationSlot slot) {
    return switch (slot) {
      _SBBDecorationSlot.label => decoration.label,
      _SBBDecorationSlot.leading => decoration.leading,
      _SBBDecorationSlot.input => child,
      _SBBDecorationSlot.placeholder => decoration.placeholder,
      _SBBDecorationSlot.trailing => decoration.trailing,
      _SBBDecorationSlot.error => decoration.error,
      _SBBDecorationSlot.container => decoration.container,
    };
  }

  @override
  _RenderSBBDecoration createRenderObject(BuildContext context) {
    return _RenderSBBDecoration(
      decoration: decoration,
      expands: expands,
      isMultiline: isMultiline,
      isEmpty: isEmpty,
      isFocused: isFocused,
      floatingLabelProgress: floatingLabelProgress,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderSBBDecoration renderObject) {
    renderObject
      ..decoration = decoration
      ..expands = expands
      ..isMultiline = isMultiline
      ..isEmpty = isEmpty
      ..isFocused = isFocused
      ..floatingLabelProgress = floatingLabelProgress;
  }
}

// Type definitions for layout helpers
typedef _ChildBaselineGetter = double Function(RenderBox child, BoxConstraints constraints);

// Container for layout values computed by _RenderSBBDecoration._layout.
class _RenderSBBDecorationLayout {
  const _RenderSBBDecorationLayout({
    required this.labelOffset,
    required this.leadingOffset,
    required this.inputOffset,
    required this.hintOffset,
    required this.trailingOffset,
    required this.errorOffset,
    required this.size,
  });

  final Offset labelOffset;
  final Offset leadingOffset;
  final Offset inputOffset;
  final Offset hintOffset;
  final Offset trailingOffset;
  final Offset errorOffset;
  final Size size;
}

// The workhorse
class _RenderSBBDecoration extends RenderBox with SlottedContainerRenderObjectMixin<_SBBDecorationSlot, RenderBox> {
  _RenderSBBDecoration({
    required SBBDecoration decoration,
    required bool expands,
    required bool isMultiline,
    required bool isEmpty,
    required bool isFocused,
    required double floatingLabelProgress,
  }) : _decoration = decoration,
       _expands = expands,
       _isMultiline = isMultiline,
       _isEmpty = isEmpty,
       _isFocused = isFocused,
       _floatingLabelProgress = floatingLabelProgress;

  RenderBox? get label => childForSlot(_SBBDecorationSlot.label);

  RenderBox? get leading => childForSlot(_SBBDecorationSlot.leading);

  RenderBox? get input => childForSlot(_SBBDecorationSlot.input);

  RenderBox? get placeholder => childForSlot(_SBBDecorationSlot.placeholder);

  RenderBox? get trailing => childForSlot(_SBBDecorationSlot.trailing);

  RenderBox? get error => childForSlot(_SBBDecorationSlot.error);

  RenderBox? get container => childForSlot(_SBBDecorationSlot.container);

  // The returned list is ordered for hit testing.
  @override
  Iterable<RenderBox> get children {
    return <RenderBox>[
      if (label != null) label!,
      if (leading != null) leading!,
      if (input != null) input!,
      if (placeholder != null) placeholder!,
      if (trailing != null) trailing!,
      if (error != null) error!,
      if (container != null) container!,
    ];
  }

  SBBDecoration get decoration => _decoration;
  SBBDecoration _decoration;

  set decoration(SBBDecoration value) {
    if (_decoration == value) return;
    _decoration = value;
    markNeedsLayout();
  }

  bool get expands => _expands;
  bool _expands;

  set expands(bool value) {
    if (_expands == value) return;
    _expands = value;
    markNeedsLayout();
  }

  bool get isMultiline => _isMultiline;
  bool _isMultiline;

  set isMultiline(bool value) {
    if (_isMultiline == value) return;
    _isMultiline = value;
    markNeedsLayout();
  }

  bool get isEmpty => _isEmpty;
  bool _isEmpty;

  set isEmpty(bool value) {
    if (_isEmpty == value) return;
    _isEmpty = value;
    markNeedsLayout();
  }

  bool get isFocused => _isFocused;
  bool _isFocused;

  set isFocused(bool value) {
    if (_isFocused == value) return;
    _isFocused = value;
    markNeedsLayout();
  }

  double get floatingLabelProgress => _floatingLabelProgress;
  double _floatingLabelProgress;

  set floatingLabelProgress(double value) {
    if (_floatingLabelProgress == value) return;
    _floatingLabelProgress = value;
    markNeedsLayout();
  }

  // Records where the label was painted (for transform).
  Matrix4? _labelTransform;

  static double _minWidth(RenderBox? box, double height) => box?.getMinIntrinsicWidth(height) ?? 0.0;

  static double _maxWidth(RenderBox? box, double height) => box?.getMaxIntrinsicWidth(height) ?? 0.0;

  static double _minHeight(RenderBox? box, double width) => box?.getMinIntrinsicHeight(width) ?? 0.0;

  static double _getBaseline(RenderBox box, BoxConstraints boxConstraints) {
    return ChildLayoutHelper.getBaseline(box, boxConstraints, TextBaseline.alphabetic) ?? box.size.height;
  }

  static double _getDryBaseline(RenderBox box, BoxConstraints boxConstraints) {
    return ChildLayoutHelper.getDryBaseline(box, boxConstraints, TextBaseline.alphabetic) ??
        ChildLayoutHelper.dryLayoutChild(box, boxConstraints).height;
  }

  BoxParentData _boxParentData(RenderBox box) => box.parentData! as BoxParentData;

  // Returns layout information used by performLayout to position all children.
  _RenderSBBDecorationLayout _layout(
    BoxConstraints constraints, {
    required ChildLayouter layoutChild,
    required _ChildBaselineGetter getBaseline,
  }) {
    assert(
      constraints.maxWidth < double.infinity,
      'An SBBInputDecorator, which is typically created by a SBBTextInput, cannot '
      'have an unbounded width.\n'
      'This happens when the parent widget does not provide a finite width '
      'constraint. For example, if the InputDecorator is contained by a Row, '
      'then its width must be constrained. An Expanded widget or a SizedBox '
      'can be used to constrain the width.',
    );

    final BoxConstraints looseConstraints = constraints.loosen();

    // Layout error if present first to know the bottomHeight
    double errorHeight = 0.0;
    if (error != null) {
      final Size errorSize = layoutChild(error!, looseConstraints);
      errorHeight = errorSize.height;
    }

    final BoxConstraints titleRowConstraints = looseConstraints.deflate(EdgeInsets.only(bottom: errorHeight));

    // Layout leading if present
    double leadingWidth = 0.0;
    double leadingHeight = 0.0;
    if (leading != null) {
      final Size leadingSize = layoutChild(leading!, titleRowConstraints);
      leadingWidth = leadingSize.width;
      leadingHeight = leadingSize.height;
    }

    // Layout trailing if present
    double trailingWidth = 0.0;
    double trailingHeight = 0.0;
    if (trailing != null) {
      final Size trailingSize = layoutChild(trailing!, titleRowConstraints);
      trailingWidth = trailingSize.width;
      trailingHeight = trailingSize.height;
    }

    // Calculate available width for input (and label)
    final double availableInputWidth = constraints.maxWidth - leadingWidth - trailingWidth;

    // Layout label with same width constraints as input
    // Increase the available width for the label when it is scaled down.
    double labelHeight = 0.0;
    double labelWidth = 0.0;
    if (label != null) {
      final double invertedLabelScale = lerpDouble(
        1.0,
        1 / _kFinalLabelScale,
        floatingLabelProgress,
      )!;
      final BoxConstraints labelConstraints = looseConstraints.copyWith(
        maxWidth: availableInputWidth * invertedLabelScale,
      );
      final Size labelSize = layoutChild(label!, labelConstraints);
      labelHeight = labelSize.height;
      labelWidth = labelSize.width;
    }

    // For single-line: calculate the floating label height (scaled)
    final double floatingLabelHeight = labelHeight * _kFinalLabelScale;

    // Layout input with constraints
    final BoxConstraints inputConstraints = constraints.tighten(width: availableInputWidth);

    // Layout input
    double inputHeight = 0.0;
    if (input != null) {
      final Size inputSize = layoutChild(input!, inputConstraints);
      inputHeight = inputSize.height;
    }

    // Layout placeholder with same constraints as input
    double hintHeight = 0.0;
    if (placeholder != null) {
      final Size hintSize = layoutChild(placeholder!, inputConstraints);
      hintHeight = hintSize.height;
    }

    // Calculate the maximum height among input/hint
    final double maxInputHeight = isEmpty ? math.max(inputHeight, hintHeight) : inputHeight;

    // For single-line case: Always reserve space for both floating label and input
    // to ensure height doesn't change during animation.
    // The height should accommodate: floatingLabel + input when fully floated.
    final double floatingContentHeight = floatingLabelHeight + maxInputHeight;

    // When not floating, label is centered (takes labelHeight).
    // We need the max of both scenarios to keep height stable.
    final double stableContentHeight = math.max(labelHeight, floatingContentHeight);

    // Title row height is max of leading, content area, trailing, and min height (48.0)
    final double titleRowHeight = [leadingHeight, stableContentHeight, trailingHeight, 48.0].reduce(math.max);

    // Calculate label offset based on floatingLabelProgress
    // When not floating (progress=0): label is centered vertically
    // When floating (progress=1): label is at top, scaled down
    final double labelCenteredY = (titleRowHeight - labelHeight) / 2.0;
    final double labelFloatingY = (titleRowHeight - floatingContentHeight) / 2.0;

    // Interpolate label Y position
    final double labelY = lerpDouble(labelCenteredY, labelFloatingY, floatingLabelProgress)!;

    final Offset labelOffset = label != null ? Offset(leadingWidth, isMultiline ? 0.0 : labelY) : Offset.zero;

    // For multiline inputs, top-align all elements; otherwise center them
    final Offset leadingOffset = leading != null
        ? Offset(0, isMultiline ? 0.0 : (titleRowHeight - leadingHeight) / 2.0)
        : Offset.zero;

    // Input position: when floating, input is below the floating label
    // When not floating, input is centered (same as where the label would be)
    final double inputCenteredY = (titleRowHeight - maxInputHeight) / 2.0;
    final double inputFloatingY = labelFloatingY + floatingLabelHeight;
    final double inputY = lerpDouble(inputCenteredY, inputFloatingY, floatingLabelProgress)!;

    final Offset inputOffset = Offset(
      leadingWidth,
      isMultiline ? labelHeight : inputY,
    );

    // Hint is positioned at the same location as input
    final Offset hintOffset = Offset(
      leadingWidth,
      isMultiline ? labelHeight : inputY,
    );

    final Offset trailingOffset = trailing != null
        ? Offset(leadingWidth + availableInputWidth, isMultiline ? 0.0 : (titleRowHeight - trailingHeight) / 2.0)
        : Offset.zero;

    // Layout error widget below the titleRowHeight
    // if expands, needs to be laid out at the bottom
    final double topAlignedErrorY = titleRowHeight;
    final errorY = expands ? constraints.maxHeight - errorHeight : topAlignedErrorY;
    final Offset errorOffset = error != null ? Offset(0, errorY) : Offset.zero;

    // Calculate total size
    final double totalHeight = expands
        ? constraints.maxHeight
        : math.max(topAlignedErrorY + errorHeight, titleRowHeight);
    final Size size = Size(constraints.maxWidth, totalHeight);

    return _RenderSBBDecorationLayout(
      labelOffset: labelOffset,
      leadingOffset: leadingOffset,
      inputOffset: inputOffset,
      hintOffset: hintOffset,
      trailingOffset: trailingOffset,
      errorOffset: errorOffset,
      size: size,
    );
  }

  @override
  void performLayout() {
    final _RenderSBBDecorationLayout layout = _layout(
      constraints,
      layoutChild: ChildLayoutHelper.layoutChild,
      getBaseline: _getBaseline,
    );

    size = constraints.constrain(layout.size);
    assert(size.width == constraints.constrainWidth(layout.size.width));
    assert(size.height == constraints.constrainHeight(layout.size.height));

    void setParentData(RenderBox? box, Offset offset) {
      if (box == null) return;
      _boxParentData(box).offset = offset;
    }

    if (container != null) {
      final BoxConstraints containerConstraints = BoxConstraints.tight(size);
      container!.layout(containerConstraints, parentUsesSize: true);
      setParentData(container, Offset.zero);
    }

    setParentData(label, layout.labelOffset);
    setParentData(leading, layout.leadingOffset);
    setParentData(input, layout.inputOffset);
    setParentData(placeholder, layout.hintOffset);
    setParentData(trailing, layout.trailingOffset);
    setParentData(error, layout.errorOffset);
  }

  @override
  double? computeDryBaseline(covariant BoxConstraints constraints, TextBaseline baseline) {
    final RenderBox? input = this.input;
    if (input == null) {
      return 0.0;
    }

    final _RenderSBBDecorationLayout layout = _layout(
      constraints,
      layoutChild: ChildLayoutHelper.dryLayoutChild,
      getBaseline: _getDryBaseline,
    );

    final double leadingWidth = leading?.getMinIntrinsicWidth(double.infinity) ?? 0.0;
    final double trailingWidth = trailing?.getMinIntrinsicWidth(double.infinity) ?? 0.0;

    return layout.inputOffset.dy +
        (input.getDryBaseline(
              BoxConstraints(
                minWidth: constraints.maxWidth - leadingWidth - trailingWidth,
                maxWidth: constraints.maxWidth - leadingWidth - trailingWidth,
              ),
              TextBaseline.alphabetic,
            ) ??
            0.0);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final _RenderSBBDecorationLayout layout = _layout(
      constraints,
      layoutChild: ChildLayoutHelper.dryLayoutChild,
      getBaseline: _getDryBaseline,
    );
    return constraints.constrain(layout.size);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final double leadingWidth = _minWidth(leading, height);
    final double inputWidth = _minWidth(input, height);
    final double hintWidth = _minWidth(placeholder, height);
    final double trailingWidth = _minWidth(trailing, height);
    final double errorWidth = _minWidth(error, height);
    final double labelWidth = _minWidth(label, height);

    final double contentWidth = math.max(hintWidth, inputWidth);

    return <double>[
      errorWidth,
      leadingWidth + labelWidth + trailingWidth,
      leadingWidth + contentWidth + trailingWidth,
    ].reduce(math.max);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final double leadingWidth = _maxWidth(leading, height);
    final double inputWidth = _maxWidth(input, height);
    final double hintWidth = _maxWidth(placeholder, height);
    final double trailingWidth = _maxWidth(trailing, height);
    final double errorWidth = _maxWidth(error, height);
    final double labelWidth = _maxWidth(label, height);

    final double contentWidth = math.max(hintWidth, inputWidth);

    return <double>[
      errorWidth,
      leadingWidth + labelWidth + trailingWidth,
      leadingWidth + contentWidth + trailingWidth,
    ].reduce(math.max);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final double leadingWidth = _minWidth(leading, double.infinity);
    final double trailingWidth = _minWidth(trailing, double.infinity);
    final double availableInputWidth = math.max(0.0, width - leadingWidth - trailingWidth);

    final double labelHeight = _minHeight(label, availableInputWidth);
    final double inputHeight = _minHeight(input, availableInputWidth);
    final double hintHeight = _minHeight(placeholder, availableInputWidth);
    final double leadingHeight = _minHeight(leading, width);
    final double trailingHeight = _minHeight(trailing, width);
    final double errorHeight = _minHeight(error, width);

    // For single-line: always reserve space for floating state
    final double maxInputHeight = isEmpty ? math.max(inputHeight, hintHeight) : inputHeight;
    final double floatingLabelHeight = labelHeight * _kFinalLabelScale;
    final double floatingContentHeight = floatingLabelHeight + maxInputHeight;
    final double stableContentHeight = math.max(labelHeight, floatingContentHeight);

    final double titleRowHeight = [
      leadingHeight,
      stableContentHeight,
      trailingHeight,
      48.0,
    ].reduce(math.max);
    return titleRowHeight + errorHeight;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return getMinIntrinsicHeight(width);
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    final RenderBox? input = this.input;
    if (input == null) {
      return 0.0;
    }
    return _boxParentData(input).offset.dy + (input.getDistanceToActualBaseline(baseline) ?? input.size.height);
  }

  void _paintLabel(PaintingContext context, Offset offset) {
    context.paintChild(label!, offset);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    void doPaint(RenderBox? child) {
      if (child != null) {
        context.paintChild(child, _boxParentData(child).offset + offset);
      }
    }

    doPaint(container);

    // Paint label with transform for scaling animation (single-line only)
    if (label != null && !isMultiline) {
      final Offset labelOffset = _boxParentData(label!).offset;

      // Calculate scale
      final double scale = lerpDouble(1.0, _kFinalLabelScale, floatingLabelProgress)!;

      // The label should stay at its left position, only scale and move vertically
      final double dx = labelOffset.dx;
      final double dy = labelOffset.dy;

      _labelTransform = Matrix4.identity()
        ..translate(dx, dy)
        ..scale(scale, scale);

      layer = context.pushTransform(
        needsCompositing,
        offset,
        _labelTransform!,
        _paintLabel,
        oldLayer: layer as TransformLayer?,
      );
    } else {
      doPaint(label);
      layer = null;
    }

    doPaint(leading);
    if (isEmpty && isFocused) doPaint(placeholder);
    doPaint(input);
    doPaint(trailing);
    doPaint(error);
  }

  @override
  void applyPaintTransform(RenderObject child, Matrix4 transform) {
    if (child == label && _labelTransform != null && !isMultiline) {
      final Offset labelOffset = _boxParentData(label!).offset;
      transform
        ..multiply(_labelTransform!)
        ..translate(-labelOffset.dx, -labelOffset.dy);
    }
    super.applyPaintTransform(child, transform);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (final RenderBox child in children) {
      final Offset offset = _boxParentData(child).offset;
      final bool isHit = result.addWithPaintOffset(
        offset: offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          return child.hitTest(result, position: transformed);
        },
      );
      if (isHit) return true;
    }
    return false;
  }
}
