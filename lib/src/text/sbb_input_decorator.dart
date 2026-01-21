import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'sbb_input_decoration.dart';

/// Displays decoration around an input field.
///
/// This is a simplified decorator that only supports a leading widget
/// and the input field itself. The leading widget is vertically centered
/// on the first baseline of the input field.
class SBBInputDecorator extends StatelessWidget {
  const SBBInputDecorator({
    super.key,
    required this.decoration,
    this.expands = false,
    this.isMultiline = false,
    this.isEmpty = false,
    this.isFocused = false,
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
  /// When true and [isFocused] is true, the hint is displayed.
  final bool isEmpty;

  /// Whether the input field has focus.
  ///
  /// When true and [isEmpty] is true, the hint is displayed.
  final bool isFocused;

  /// The widget below this decorator, usually some sort of [EditableText].
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _SBBDecorator(
      decoration: decoration,
      expands: expands,
      isMultiline: isMultiline,
      isEmpty: isEmpty,
      isFocused: isFocused,
      child: child,
    );
  }
}

enum _SBBDecorationSlot {
  leading,
  input,
  hint,
  trailing,
  error,
}

// Type definitions for layout helpers
typedef _ChildBaselineGetter = double Function(RenderBox child, BoxConstraints constraints);

// Container for layout values computed by _RenderSBBDecoration._layout.
class _RenderSBBDecorationLayout {
  const _RenderSBBDecorationLayout({
    required this.leadingOffset,
    required this.inputOffset,
    required this.hintOffset,
    required this.trailingOffset,
    required this.errorOffset,
    required this.size,
  });

  final Offset leadingOffset;
  final Offset inputOffset;
  final Offset hintOffset;
  final Offset trailingOffset;
  final Offset errorOffset;
  final Size size;
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

  final SBBInputDecoration decoration;
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
      _SBBDecorationSlot.leading => decoration.leading,
      _SBBDecorationSlot.input => child,
      _SBBDecorationSlot.hint => decoration.hint,
      _SBBDecorationSlot.trailing => decoration.trailing,
      _SBBDecorationSlot.error => decoration.error,
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

// The workhorse
class _RenderSBBDecoration extends RenderBox with SlottedContainerRenderObjectMixin<_SBBDecorationSlot, RenderBox> {
  _RenderSBBDecoration({
    required SBBInputDecoration decoration,
    required bool expands,
    required bool isMultiline,
    required bool isEmpty,
    required bool isFocused,
  }) : _decoration = decoration,
       _expands = expands,
       _isMultiline = isMultiline,
       _isEmpty = isEmpty,
       _isFocused = isFocused;

  RenderBox? get leading => childForSlot(_SBBDecorationSlot.leading);

  RenderBox? get input => childForSlot(_SBBDecorationSlot.input);

  RenderBox? get hint => childForSlot(_SBBDecorationSlot.hint);

  RenderBox? get trailing => childForSlot(_SBBDecorationSlot.trailing);

  RenderBox? get error => childForSlot(_SBBDecorationSlot.error);

  // The returned list is ordered for hit testing.
  @override
  Iterable<RenderBox> get children {
    return <RenderBox>[
      if (leading != null) leading!,
      if (input != null) input!,
      if (hint != null) hint!,
      if (trailing != null) trailing!,
      if (error != null) error!,
    ];
  }

  SBBInputDecoration get decoration => _decoration;
  SBBInputDecoration _decoration;

  set decoration(SBBInputDecoration value) {
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

    // Calculate available width for input
    final double availableInputWidth = constraints.maxWidth - leadingWidth - trailingWidth;
    final BoxConstraints inputConstraints = constraints
        .tighten(width: availableInputWidth)
        .deflate(EdgeInsets.only(top: errorHeight));

    // Layout input
    double inputHeight = 0.0;
    if (input != null) {
      final Size inputSize = layoutChild(input!, inputConstraints);
      inputHeight = inputSize.height;
    }

    // Layout hint with same constraints as input
    double hintHeight = 0.0;
    if (hint != null) {
      final Size hintSize = layoutChild(hint!, inputConstraints);
      hintHeight = hintSize.height;
    }

    // Calculate the maximum height among all three elements (row-like behavior)
    // The hint should be included in the height calculation if isEmpty
    final double maxInputHeight = isEmpty ? math.max(inputHeight, hintHeight) : inputHeight;
    final double titleRowHeight = [leadingHeight, maxInputHeight, trailingHeight, 48.0].reduce(math.max);

    // Calculate offsets to align each element vertically
    // For multiline inputs, top-align all elements; otherwise center them
    final Offset leadingOffset = leading != null
        ? Offset(0, isMultiline ? 0.0 : (titleRowHeight - leadingHeight) / 2.0)
        : Offset.zero;

    final Offset inputOffset = Offset(
      leadingWidth,
      isMultiline ? 0.0 : (titleRowHeight - inputHeight) / 2.0,
    );

    // Hint is positioned at the same location as input (baseline-aligned)
    final Offset hintOffset = Offset(
      leadingWidth,
      isMultiline ? 0.0 : (titleRowHeight - hintHeight) / 2.0,
    );

    final Offset trailingOffset = trailing != null
        ? Offset(
            leadingWidth + availableInputWidth,
            isMultiline ? 0.0 : (titleRowHeight - trailingHeight) / 2.0,
          )
        : Offset.zero;

    // Layout error widget below the main content
    // if expands, needs to be laid out at the bottom
    final errorY = expands ? constraints.maxHeight - errorHeight : titleRowHeight;
    final Offset errorOffset = error != null ? Offset(0, errorY) : Offset.zero;

    // Calculate total size
    final double contentHeight = expands ? constraints.maxHeight : titleRowHeight;
    final double totalHeight = contentHeight + errorHeight;
    final Size size = Size(constraints.maxWidth, totalHeight);

    return _RenderSBBDecorationLayout(
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

    // Position leading
    if (leading != null) {
      BoxParentData leadingParentData = _boxParentData(leading!);
      leadingParentData.offset = layout.leadingOffset;
    }

    // Position input
    if (input != null) {
      final BoxParentData inputParentData = _boxParentData(input!);
      inputParentData.offset = layout.inputOffset;
    }

    // Position hint
    if (hint != null) {
      final BoxParentData hintParentData = _boxParentData(hint!);
      hintParentData.offset = layout.hintOffset;
    }

    // Position trailing
    if (trailing != null) {
      final BoxParentData trailingParentData = _boxParentData(trailing!);
      trailingParentData.offset = layout.trailingOffset;
    }

    // Position error
    if (error != null) {
      final BoxParentData errorParentData = _boxParentData(error!);
      errorParentData.offset = layout.errorOffset;
    }
  }

  @override
  double? computeDryBaseline(covariant BoxConstraints constraints, TextBaseline baseline) {
    assert(baseline == TextBaseline.alphabetic, 'Only alphabetic baseline is supported');

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
    final double leadingWidth = leading?.getMinIntrinsicWidth(height) ?? 0.0;
    final double inputWidth = input?.getMinIntrinsicWidth(height) ?? 0.0;
    final double trailingWidth = trailing?.getMinIntrinsicWidth(height) ?? 0.0;
    final double errorWidth = error?.getMinIntrinsicWidth(height) ?? 0.0;
    return math.max(leadingWidth + inputWidth + trailingWidth, errorWidth);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final double leadingWidth = leading?.getMaxIntrinsicWidth(height) ?? 0.0;
    final double inputWidth = input?.getMaxIntrinsicWidth(height) ?? 0.0;
    final double trailingWidth = trailing?.getMaxIntrinsicWidth(height) ?? 0.0;
    final double errorWidth = error?.getMaxIntrinsicWidth(height) ?? 0.0;
    return math.max(leadingWidth + inputWidth + trailingWidth, errorWidth);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    // Calculate available width for input after accounting for leading and trailing
    final double leadingWidth = leading?.getMinIntrinsicWidth(double.infinity) ?? 0.0;
    final double trailingWidth = trailing?.getMinIntrinsicWidth(double.infinity) ?? 0.0;
    final double availableInputWidth = math.max(0.0, width - leadingWidth - trailingWidth);

    final double leadingHeight = leading?.getMinIntrinsicHeight(width) ?? 0.0;
    final double inputHeight = input?.getMinIntrinsicHeight(availableInputWidth) ?? 0.0;
    final double hintHeight = hint?.getMinIntrinsicHeight(availableInputWidth) ?? 0.0;
    final double trailingHeight = trailing?.getMinIntrinsicHeight(width) ?? 0.0;

    final double errorHeight = error?.getMinIntrinsicHeight(width) ?? 0.0;

    // Return the maximum height among all (row-like behavior) plus error height
    // Include hint in calculation if isEmpty
    final double maxInputHeight = isEmpty ? math.max(inputHeight, hintHeight) : inputHeight;
    return math.max(leadingHeight, math.max(maxInputHeight, trailingHeight)) + errorHeight;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final double leadingWidth = leading?.getMaxIntrinsicWidth(double.infinity) ?? 0.0;
    final double trailingWidth = trailing?.getMaxIntrinsicWidth(double.infinity) ?? 0.0;
    final double availableInputWidth = math.max(0.0, width - leadingWidth - trailingWidth);

    // Get the intrinsic heights of all three children
    final double leadingHeight = leading?.getMaxIntrinsicHeight(width) ?? 0.0;
    final double inputHeight = input?.getMaxIntrinsicHeight(availableInputWidth) ?? 0.0;
    final double hintHeight = hint?.getMaxIntrinsicHeight(availableInputWidth) ?? 0.0;
    final double trailingHeight = trailing?.getMaxIntrinsicHeight(width) ?? 0.0;

    // Get the error height
    final double errorHeight = error?.getMaxIntrinsicHeight(width) ?? 0.0;

    // Return the maximum height among all (row-like behavior) plus error height
    // Include hint in calculation if isEmpty
    final double maxInputHeight = isEmpty ? math.max(inputHeight, hintHeight) : inputHeight;
    return math.max(leadingHeight, math.max(maxInputHeight, trailingHeight)) + errorHeight;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (leading != null) {
      BoxParentData leadingParentData = _boxParentData(leading!);
      context.paintChild(leading!, leadingParentData.offset + offset);
    }

    // Only paint hint if focused and empty
    if (hint != null && isFocused && isEmpty) {
      final BoxParentData hintParentData = _boxParentData(hint!);
      context.paintChild(hint!, hintParentData.offset + offset);
    }

    // Paint input (may be empty)
    if (input != null) {
      final BoxParentData inputParentData = _boxParentData(input!);
      context.paintChild(input!, inputParentData.offset + offset);
    }

    if (trailing != null) {
      final BoxParentData trailingParentData = _boxParentData(trailing!);
      context.paintChild(trailing!, trailingParentData.offset + offset);
    }
    if (error != null) {
      final BoxParentData errorParentData = _boxParentData(error!);
      context.paintChild(error!, errorParentData.offset + offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (final RenderBox child in children) {
      final BoxParentData parentData = _boxParentData(child);
      final bool isHit = result.addWithPaintOffset(
        offset: parentData.offset,
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
