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
    this.child,
  });

  /// The decoration to display around the input field.
  final SBBInputDecoration decoration;

  /// Whether the input field should expand to fill available space.
  final bool expands;

  /// The widget below this decorator, usually some sort of [EditableText].
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _SBBDecorator(
      decoration: decoration,
      expands: expands,
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
    this.child,
  });

  final SBBInputDecoration decoration;
  final bool expands;
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
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderSBBDecoration renderObject) {
    renderObject
      ..decoration = decoration
      ..expands = expands;
  }
}

// The workhorse
class _RenderSBBDecoration extends RenderBox with SlottedContainerRenderObjectMixin<_SBBDecorationSlot, RenderBox> {
  _RenderSBBDecoration({
    required SBBInputDecoration decoration,
    required bool expands,
  }) : _decoration = decoration,
       _expands = expands;

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
    final double availableWidth = constraints.maxWidth - leadingWidth - trailingWidth;

    // Layout input
    double inputHeight = 0.0;
    if (input != null) {
      final BoxConstraints inputConstraints = expands
          ? BoxConstraints(
              minWidth: availableWidth,
              maxWidth: availableWidth,
              minHeight: constraints.maxHeight,
              maxHeight: constraints.maxHeight,
            )
          : BoxConstraints(minWidth: availableWidth, maxWidth: availableWidth);

      final Size inputSize = layoutChild(input!, inputConstraints);
      inputHeight = inputSize.height;
    }

    // Calculate total size
    final double height = expands ? constraints.maxHeight : inputHeight;
    final Size size = Size(constraints.maxWidth, height);

    // Calculate input baseline
    final double inputBaseline = input == null
        ? 0.0
        : getBaseline(
            input!,
            BoxConstraints(
              minWidth: availableWidth,
              maxWidth: availableWidth,
            ),
          );

    // Calculate leading offset (centered on input's first baseline)
    Offset leadingOffset = Offset.zero;
    if (leading != null && input != null) {
      final double leadingBaseline = getBaseline(
        leading!,
        looseConstraints,
      );
      final double leadingY = inputBaseline - leadingBaseline;
      leadingOffset = Offset(0, leadingY);
    }

    // Calculate input offset
    final Offset inputOffset = Offset(leadingWidth, 0);

    // Calculate trailing offset (aligned with input baseline)
    Offset trailingOffset = Offset.zero;
    if (trailing != null && input != null) {
      final double trailingBaseline = getBaseline(
        trailing!,
        looseConstraints,
      );
      final double trailingY = inputBaseline - trailingBaseline;
      trailingOffset = Offset(leadingWidth + availableWidth, trailingY);
    }

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
    return input?.getMinIntrinsicHeight(width) ?? 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (expands) {
      return double.infinity;
    }
    return input?.getMaxIntrinsicHeight(width) ?? 0.0;
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
