import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sbb_design_system_mobile/src/input/decoration/sbb_decoration.dart';

import '../../../sbb_design_system_mobile.dart';

class SBBInputDecorator extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final inputDecorationTheme = Theme.of(context).sbbInputDecorationTheme;

    Widget? leading = decoration.leading;
    if (leading == null && decoration.leadingIconData != null) {
      leading = Icon(decoration.leadingIconData);
    }
    if (leading != null) {
      final Color? resolvedColor = (decoration.leadingForegroundColor ?? inputDecorationTheme?.leadingForegroundColor)
          ?.resolve(states);
      leading = _addDefaultAncestorWithResolved(
        child: leading,
        foregroundColor: resolvedColor,
      );
    }

    Widget? label = decoration.label;
    if (label == null && decoration.labelText != null) {
      label = Text(decoration.labelText!);
    }
    if (label != null) {
      final Color? resolvedColor = (decoration.labelForegroundColor ?? inputDecorationTheme?.labelForegroundColor)
          ?.resolve(states);
      final TextStyle? textStyle = decoration.labelTextStyle ?? inputDecorationTheme?.labelTextStyle;
      label = _addDefaultAncestorWithResolved(
        child: label,
        foregroundColor: resolvedColor,
        textStyle: textStyle,
      );
    }

    Widget? trailing = decoration.trailing;
    if (trailing == null && decoration.trailingIconData != null) {
      trailing = Icon(decoration.trailingIconData);
    }
    if (trailing != null) {
      final Color? resolvedColor = (decoration.trailingForegroundColor ?? inputDecorationTheme?.trailingForegroundColor)
          ?.resolve(states);
      trailing = _addDefaultAncestorWithResolved(
        child: trailing,
        foregroundColor: resolvedColor,
      );
    }

    Widget? placeholder = decoration.placeholder;
    if (placeholder == null && decoration.placeholderText != null) {
      placeholder = Text(decoration.placeholderText!);
    }
    if (placeholder != null) {
      final Color? resolvedColor =
          (decoration.placeholderForegroundColor ?? inputDecorationTheme?.placeholderForegroundColor)?.resolve(states);
      final TextStyle? textStyle = decoration.placeholderTextStyle ?? inputDecorationTheme?.placeholderTextStyle;
      placeholder = _addDefaultAncestorWithResolved(
        child: placeholder,
        foregroundColor: resolvedColor,
        textStyle: textStyle,
      );
    }

    Widget? error = decoration.error;
    if (error == null && decoration.errorText != null) {
      error = Text(decoration.errorText!);
    }
    if (error != null) {
      final Color? resolvedColor = (decoration.errorForegroundColor ?? inputDecorationTheme?.errorForegroundColor)
          ?.resolve(states);
      final TextStyle? textStyle = decoration.errorTextStyle ?? inputDecorationTheme?.errorTextStyle;
      error = _addDefaultAncestorWithResolved(
        child: error,
        foregroundColor: resolvedColor,
        textStyle: textStyle,
      );
    }
    error = AnimatedSwitcher(
      duration: Duration(milliseconds: 250), // TODO: define Animation duration
      child: error ?? SizedBox.shrink(),
    );

    final Color resolvedBorderColor =
        (decoration.borderColor ?? inputDecorationTheme?.borderColor)?.resolve(states) ?? SBBColors.transparent;
    final Widget container = AnimatedContainer(
      duration: Duration(milliseconds: 250), // TODO: define Animation duration
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
      expands: expands,
      isMultiline: isMultiline,
      isEmpty: isEmpty,
      isFocused: states.contains(WidgetState.focused),
      child: child,
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
    this.child,
  });

  final SBBDecoration decoration;
  final bool expands;
  final bool isMultiline;
  final bool isEmpty;
  final bool isFocused;
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
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderSBBDecoration renderObject) {
    renderObject
      ..decoration = decoration
      ..expands = expands
      ..isMultiline = isMultiline
      ..isEmpty = isEmpty
      ..isFocused = isFocused;
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
  }) : _decoration = decoration,
       _expands = expands,
       _isMultiline = isMultiline,
       _isEmpty = isEmpty,
       _isFocused = isFocused;

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
  // This method applies layout to all children using layoutChild.
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

    final BoxConstraints titleRowConstraints = looseConstraints.deflate(EdgeInsets.only(top: errorHeight));

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
    double labelHeight = 0.0;
    if (label != null) {
      final BoxConstraints labelConstraints = looseConstraints.tighten(width: availableInputWidth);
      final Size labelSize = layoutChild(label!, labelConstraints);
      labelHeight = labelSize.height;
    }

    // Layout input with constraints accounting for label and error
    final BoxConstraints inputConstraints = constraints
        .tighten(width: availableInputWidth)
        .deflate(EdgeInsets.only(top: labelHeight, bottom: errorHeight));

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

    // Calculate the maximum height among all three elements (row-like behavior)
    // The placeholder should be included in the height calculation if isEmpty
    final double maxInputHeight = isEmpty ? math.max(inputHeight, hintHeight) : inputHeight;
    final double labelInputHeight = labelHeight + maxInputHeight;
    final double titleRowHeight = [leadingHeight, labelInputHeight, trailingHeight, 48.0].reduce(math.max);

    // Calculate offsets
    final Offset labelOffset = label != null
        ? Offset(leadingWidth, isMultiline ? 0.0 : (titleRowHeight - labelInputHeight) / 2.0)
        : Offset.zero;

    // For multiline inputs, top-align all elements; otherwise center them
    final Offset leadingOffset = leading != null
        ? Offset(0, isMultiline ? 0.0 : (titleRowHeight - leadingHeight) / 2.0)
        : Offset.zero;

    final Offset inputOffset = Offset(
      leadingWidth,
      isMultiline ? labelHeight : labelOffset.dy + labelHeight,
    );

    // Hint is positioned at the same location as input
    final Offset hintOffset = Offset(
      leadingWidth,
      isMultiline ? labelHeight : labelOffset.dy + labelHeight,
    );

    final Offset trailingOffset = trailing != null
        ? Offset(leadingWidth + availableInputWidth, isMultiline ? 0.0 : (titleRowHeight - trailingHeight) / 2.0)
        : Offset.zero;

    // Layout error widget below the bottomMost of the titleRowHeight
    // if expands, needs to be laid out at the bottom
    final double topAlignedErrorY = [
      leadingHeight + leadingOffset.dy,
      labelInputHeight + labelOffset.dy,
      trailingHeight + trailingOffset.dy,
    ].reduce(math.max);
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

    // Return the maximum height among all (row-like behavior) plus error height
    // Include placeholder in calculation if isEmpty
    final double maxInputHeight = isEmpty ? math.max(inputHeight, hintHeight) : inputHeight;
    final double titleRowHeight = [
      leadingHeight,
      maxInputHeight + labelHeight,
      trailingHeight,
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

  @override
  void paint(PaintingContext context, Offset offset) {
    void doPaint(RenderBox? child) {
      if (child != null) {
        context.paintChild(child, _boxParentData(child).offset + offset);
      }
    }

    doPaint(label);
    doPaint(leading);
    if (isEmpty && isFocused) doPaint(placeholder);
    doPaint(input);
    doPaint(trailing);
    doPaint(error);
    doPaint(container);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (final RenderBox child in children) {
      final bool isHit = result.addWithPaintOffset(
        offset: _boxParentData(child).offset,
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
