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

  /// The widget below this decorator, usually some sort of [EditableText].
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _SBBDecorator(
      decoration: decoration,
      expands: expands,
      isMultiline: isMultiline,
      child: child,
    );
  }
}

enum _SBBDecorationSlot {
  leading,
  input,
  trailing,
}

// Type definitions for layout helpers
typedef _ChildBaselineGetter = double Function(RenderBox child, BoxConstraints constraints);

// Container for layout values computed by _RenderSBBDecoration._layout.
class _RenderSBBDecorationLayout {
  const _RenderSBBDecorationLayout({
    required this.leadingOffset,
    required this.inputOffset,
    required this.trailingOffset,
    required this.size,
  });

  final Offset leadingOffset;
  final Offset inputOffset;
  final Offset trailingOffset;
  final Size size;
}

class _SBBDecorator extends SlottedMultiChildRenderObjectWidget<_SBBDecorationSlot, RenderBox> {
  const _SBBDecorator({
    required this.decoration,
    required this.expands,
    required this.isMultiline,
    this.child,
  });

  final SBBInputDecoration decoration;
  final bool expands;
  final bool isMultiline;
  final Widget? child;

  @override
  Iterable<_SBBDecorationSlot> get slots => _SBBDecorationSlot.values;

  @override
  Widget? childForSlot(_SBBDecorationSlot slot) {
    return switch (slot) {
      _SBBDecorationSlot.leading => decoration.leading,
      _SBBDecorationSlot.input => child,
      _SBBDecorationSlot.trailing => decoration.trailing,
    };
  }

  @override
  _RenderSBBDecoration createRenderObject(BuildContext context) {
    return _RenderSBBDecoration(
      decoration: decoration,
      expands: expands,
      isMultiline: isMultiline,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderSBBDecoration renderObject) {
    renderObject
      ..decoration = decoration
      ..expands = expands
      ..isMultiline = isMultiline;
  }
}

// The workhorse
class _RenderSBBDecoration extends RenderBox with SlottedContainerRenderObjectMixin<_SBBDecorationSlot, RenderBox> {
  _RenderSBBDecoration({
    required SBBInputDecoration decoration,
    required bool expands,
    required bool isMultiline,
  }) : _decoration = decoration,
       _expands = expands,
       _isMultiline = isMultiline;

  RenderBox? get leading => childForSlot(_SBBDecorationSlot.leading);

  RenderBox? get input => childForSlot(_SBBDecorationSlot.input);

  RenderBox? get trailing => childForSlot(_SBBDecorationSlot.trailing);

  // The returned list is ordered for hit testing.
  @override
  Iterable<RenderBox> get children {
    return <RenderBox>[
      if (leading != null) leading!,
      if (input != null) input!,
      if (trailing != null) trailing!,
      // if (container != null) container!,
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

    // Layout leading if present
    double leadingWidth = 0.0;
    double leadingHeight = 0.0;
    if (leading != null) {
      final Size leadingSize = layoutChild(leading!, looseConstraints);
      leadingWidth = leadingSize.width;
      leadingHeight = leadingSize.height;
    }

    // Layout trailing if present
    double trailingWidth = 0.0;
    double trailingHeight = 0.0;
    if (trailing != null) {
      final Size trailingSize = layoutChild(trailing!, looseConstraints);
      trailingWidth = trailingSize.width;
      trailingHeight = trailingSize.height;
    }

    // Calculate available width for input
    final double availableInputWidth = constraints.maxWidth - leadingWidth - trailingWidth;
    final BoxConstraints inputConstraints = constraints.tighten(width: availableInputWidth);

    // Layout input
    double inputHeight = 0.0;
    if (input != null) {
      final Size inputSize = layoutChild(input!, inputConstraints);
      inputHeight = inputSize.height;
    }

    // Calculate the maximum height among all three elements (row-like behavior)
    final double maxHeight = [leadingHeight, inputHeight, trailingHeight].reduce(math.max);

    // Calculate offsets to align each element vertically
    // For multiline inputs, top-align all elements; otherwise center them
    final Offset leadingOffset = leading != null
        ? Offset(0, isMultiline ? 0.0 : (maxHeight - leadingHeight) / 2.0)
        : Offset.zero;

    final Offset inputOffset = Offset(
      leadingWidth,
      isMultiline ? 0.0 : (maxHeight - inputHeight) / 2.0,
    );

    final Offset trailingOffset = trailing != null
        ? Offset(
            leadingWidth + availableInputWidth,
            isMultiline ? 0.0 : (maxHeight - trailingHeight) / 2.0,
          )
        : Offset.zero;

    // Calculate total size
    final double height = expands ? constraints.maxHeight : maxHeight;
    final Size size = Size(constraints.maxWidth, height);

    return _RenderSBBDecorationLayout(
      leadingOffset: leadingOffset,
      inputOffset: inputOffset,
      trailingOffset: trailingOffset,
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

    // Position trailing
    if (trailing != null) {
      final BoxParentData trailingParentData = _boxParentData(trailing!);
      trailingParentData.offset = layout.trailingOffset;
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
    return leadingWidth + inputWidth + trailingWidth;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final double leadingWidth = leading?.getMaxIntrinsicWidth(height) ?? 0.0;
    final double inputWidth = input?.getMaxIntrinsicWidth(height) ?? 0.0;
    final double trailingWidth = trailing?.getMaxIntrinsicWidth(height) ?? 0.0;
    return leadingWidth + inputWidth + trailingWidth;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    // Calculate available width for input after accounting for leading and trailing
    final double leadingWidth = leading?.getMinIntrinsicWidth(double.infinity) ?? 0.0;
    final double trailingWidth = trailing?.getMinIntrinsicWidth(double.infinity) ?? 0.0;
    final double availableInputWidth = math.max(0.0, width - leadingWidth - trailingWidth);

    // Get the intrinsic heights of all three children
    final double leadingHeight = leading?.getMinIntrinsicHeight(width) ?? 0.0;
    final double inputHeight = input?.getMinIntrinsicHeight(availableInputWidth) ?? 0.0;
    final double trailingHeight = trailing?.getMinIntrinsicHeight(width) ?? 0.0;

    // Return the maximum height among all three (row-like behavior)
    return math.max(leadingHeight, math.max(inputHeight, trailingHeight));
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (expands) {
      return double.infinity;
    }

    // Calculate available width for input after accounting for leading and trailing
    final double leadingWidth = leading?.getMaxIntrinsicWidth(double.infinity) ?? 0.0;
    final double trailingWidth = trailing?.getMaxIntrinsicWidth(double.infinity) ?? 0.0;
    final double availableInputWidth = math.max(0.0, width - leadingWidth - trailingWidth);

    // Get the intrinsic heights of all three children
    final double leadingHeight = leading?.getMaxIntrinsicHeight(width) ?? 0.0;
    final double inputHeight = input?.getMaxIntrinsicHeight(availableInputWidth) ?? 0.0;
    final double trailingHeight = trailing?.getMaxIntrinsicHeight(width) ?? 0.0;

    // Return the maximum height among all three (row-like behavior)
    return math.max(leadingHeight, math.max(inputHeight, trailingHeight));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (leading != null) {
      BoxParentData leadingParentData = _boxParentData(leading!);
      context.paintChild(leading!, leadingParentData.offset + offset);
    }
    if (input != null) {
      final BoxParentData inputParentData = _boxParentData(input!);
      context.paintChild(input!, inputParentData.offset + offset);
    }
    if (trailing != null) {
      final BoxParentData trailingParentData = _boxParentData(trailing!);
      context.paintChild(trailing!, trailingParentData.offset + offset);
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
