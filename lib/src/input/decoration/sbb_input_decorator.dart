import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/rendering.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/input/decoration/sbb_decoration.dart';
import 'package:sbb_design_system_mobile/src/input/theme/default_sbb_input_decoration_theme_data.dart';
import 'package:sbb_design_system_mobile/src/shared/utils.dart';

const Duration _kTransitionDuration = Duration(milliseconds: 168);
const Curve _kTransitionCurve = Curves.fastOutSlowIn;

/// The SBBInputDecorator is responsible for the label animation ticker, resolving
/// theme and WidgetProperty values and building the consequent RenderObjectWidget (_SBBDecorator).
class SBBInputDecorator extends StatefulWidget {
  const SBBInputDecorator({
    super.key,
    required this.decoration,
    required this.minInputHeight,
    this.expands = false,
    this.isMultiline = false,
    this.isEmpty = false,
    this.isBoxed = false,
    this.states = const <WidgetState>{},
    this.child,
  });

  /// The decoration to display around the input field.
  final SBBInputDecoration decoration;

  /// The minimum height of the input field given by one line text style.
  final double minInputHeight;

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

  /// Whether the decoration is assumed to be inside of an [SBBContentBox].
  ///
  /// This will draw the [decoration.borderColor] with a different shape.
  final bool isBoxed;

  /// The states of the input field.
  final Set<WidgetState> states;

  /// The widget below this decorator, usually some sort of [EditableText].
  final Widget? child;

  /// Whether the label needs to move above the input and seem to start floating.
  ///
  /// Will float when not empty, has a placeholder or when focused while enabled.
  bool get _labelShouldFloat =>
      !isEmpty ||
      (decoration.placeholder != null || decoration.placeholderText != null) ||
      (states.contains(WidgetState.focused) && !states.contains(WidgetState.disabled));

  @override
  State<SBBInputDecorator> createState() => _SBBInputDecoratorState();
}

class _SBBInputDecoratorState extends State<SBBInputDecorator> with SingleTickerProviderStateMixin {
  late final AnimationController _floatingLabelController;
  late final CurvedAnimation _floatingLabelAnimation;
  SBBFloatingLabelBehavior _inheritedFloatingLabelBehavior = .auto;

  // Provide unique sort keys to avoid mixing up sort order with sibling input decorators.
  late final _leadingSemanticsSortOrder = OrdinalSortKey(0, name: hashCode.toString());
  late final _inputSemanticsSortOrder = OrdinalSortKey(1, name: hashCode.toString());
  late final _trailingSemanticsSortOrder = OrdinalSortKey(2, name: hashCode.toString());

  @override
  void initState() {
    super.initState();
    _floatingLabelController = AnimationController(
      duration: _kTransitionDuration,
      vsync: this,
      value: _shouldFloat ? 1.0 : 0.0,
    );
    _floatingLabelController.addListener(_handleAnimationChange);
    _floatingLabelAnimation = CurvedAnimation(
      parent: _floatingLabelController,
      curve: _kTransitionCurve,
      reverseCurve: _kTransitionCurve.flipped,
    );
  }

  bool get _shouldFloat {
    final behavior = _effectiveFloatingLabelBehavior;
    return behavior == .always || (behavior == .auto && widget._labelShouldFloat);
  }

  SBBFloatingLabelBehavior get _effectiveFloatingLabelBehavior {
    return widget.decoration.floatingLabelBehavior ?? _inheritedFloatingLabelBehavior;
  }

  @override
  void didUpdateWidget(SBBInputDecorator oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldBehavior = oldWidget.decoration.floatingLabelBehavior ?? _inheritedFloatingLabelBehavior;

    final oldShouldFloat = oldBehavior == .always || (oldBehavior == .auto && oldWidget._labelShouldFloat);
    final newShouldFloat = _shouldFloat;

    if (newShouldFloat != oldShouldFloat) {
      if (newShouldFloat) {
        _floatingLabelController.forward();
      } else {
        _floatingLabelController.reverse();
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final inputDecorationTheme = Theme.of(context).sbbInputDecorationTheme;
    final newBehavior = inputDecorationTheme.floatingLabelBehavior ?? .auto;

    if (_inheritedFloatingLabelBehavior != newBehavior) {
      _inheritedFloatingLabelBehavior = newBehavior;
      // Re-evaluate if label should float with the new theme value
      if (_shouldFloat != (_floatingLabelController.value == 1.0)) {
        if (_shouldFloat) {
          _floatingLabelController.forward();
        } else {
          _floatingLabelController.reverse();
        }
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
    final decoration = widget.decoration.applyThemeValues(Theme.of(context).sbbInputDecorationTheme);

    final textScaler = MediaQuery.textScalerOf(context);

    Widget? leading = _leading(textScaler, decoration);

    Widget? label = decoration.label;
    double? maxLabelTextHeight;
    if (label == null && decoration.labelText != null) {
      label = Text(decoration.labelText!, maxLines: 1, overflow: .ellipsis);
    }
    if (label != null) {
      final resolvedColor = decoration.labelForegroundColor?.resolve(
        widget.states,
      );
      final textStyle = decoration.labelTextStyle;
      final floatingTextStyle = decoration.floatingLabelTextStyle;

      final resolvedTextStyle =
          (_shouldFloat ? floatingTextStyle : textStyle)?.copyWith(color: resolvedColor) ??
          TextStyle(color: resolvedColor);

      if (decoration.labelText != null && textStyle?.fontSize != null && textStyle?.height != null) {
        maxLabelTextHeight = textStyle!.fontSize! * textStyle.height!;
      }

      label = AnimatedDefaultTextStyle(
        style: resolvedTextStyle,
        duration: _kTransitionDuration,
        child: IconTheme.merge(
          data: IconThemeData(color: resolvedColor),
          child: label,
        ),
      );
    }

    Widget? trailing = _trailing(textScaler, decoration);
    final placeholder = _placeholder(decoration);
    final error = _errorWidget(textScaler, decoration);

    final container = AnimatedContainer(
      duration: _kTransitionDuration,
      decoration: _effectiveBoxDecoration(context, decoration),
    );

    Widget? input = widget.child;
    if (input != null) {
      input = Semantics(sortKey: _inputSemanticsSortOrder, child: input);
    }

    if (leading != null) {
      leading = Semantics(sortKey: _leadingSemanticsSortOrder, child: leading);
    }

    if (trailing != null) {
      trailing = Semantics(sortKey: _trailingSemanticsSortOrder, child: trailing);
    }

    return _SBBDecorator(
      decoration: SBBDecoration(
        leading: leading,
        label: label,
        trailing: trailing,
        placeholder: placeholder,
        error: error,
        container: container,
        input: input,
      ),
      expands: widget.expands,
      isMultiline: widget.isMultiline,
      isEmpty: widget.isEmpty,
      floatingLabelProgress: _floatingLabelAnimation.value,
      floatingLabelInputGap: textScaler.scale(_effectiveFloatingLabelInputGap(decoration)),
      minInputHeight: widget.minInputHeight,
      minTotalHeight: textScaler.scale(SBBInputDecoration.minInputFieldHeight),
      maxLabelHeight: maxLabelTextHeight,
      contentPadding: _effectiveContentPadding(decoration),
    );
  }

  Widget? _leading(TextScaler textScaler, SBBInputDecoration decoration) {
    Widget? leading = decoration.leading;
    if (leading == null && decoration.leadingIconData != null) {
      leading = Padding(
        padding: .only(
          top: widget.isMultiline ? textScaler.scale(SBBSpacing.xxSmall) : 0.0,
          right: _effectiveLeadingInputGap(decoration),
        ),
        child: Icon(decoration.leadingIconData),
      );
    }
    if (leading != null) {
      final resolvedColor = decoration.leadingForegroundColor?.resolve(
        widget.states,
      );
      leading = addDefaultAncestorWithResolved(
        child: leading,
        foregroundColor: resolvedColor,
      );
    }
    return leading;
  }

  Widget? _trailing(TextScaler textScaler, SBBInputDecoration decoration) {
    Widget? trailing = decoration.trailing;
    if (trailing == null && decoration.trailingIconData != null) {
      trailing = Padding(
        padding: .only(
          top: widget.isMultiline ? textScaler.scale(SBBSpacing.xxSmall) : 0.0,
          left: _effectiveInputTrailingGap(decoration),
        ),
        child: Icon(decoration.trailingIconData),
      );
    }
    if (trailing != null) {
      final resolvedColor = decoration.trailingForegroundColor?.resolve(
        widget.states,
      );
      trailing = addDefaultAncestorWithResolved(
        child: trailing,
        foregroundColor: resolvedColor,
      );
    }
    return trailing;
  }

  Widget? _placeholder(SBBInputDecoration decoration) {
    Widget? placeholder = decoration.placeholder;
    if (placeholder == null && decoration.placeholderText != null) {
      placeholder = AnimatedOpacity(
        duration: _kTransitionDuration * 1.25,
        opacity: widget.isEmpty ? 1 : 0,
        child: Text(decoration.placeholderText!),
      );
    }
    if (placeholder != null) {
      final resolvedColor = decoration.placeholderForegroundColor?.resolve(
        widget.states,
      );
      final textStyle = decoration.placeholderTextStyle;
      placeholder = addDefaultAncestorWithResolved(
        child: placeholder,
        foregroundColor: resolvedColor,
        textStyle: textStyle,
      );
    }
    return placeholder;
  }

  Widget? _errorWidget(TextScaler textScaler, SBBInputDecoration decoration) {
    Widget? error = decoration.error;
    if (error == null && decoration.errorText != null) {
      error = Padding(
        padding: .only(
          top: textScaler.scale(_effectiveTitleRowErrorGap(decoration)),
          bottom: _effectiveErrorBottomPadding(decoration),
        ),
        child: Text(decoration.errorText!),
      );
    }
    if (error != null) {
      final resolvedColor = decoration.errorForegroundColor?.resolve(
        widget.states,
      );
      final textStyle = decoration.errorTextStyle;
      error = addDefaultAncestorWithResolved(
        child: error,
        foregroundColor: resolvedColor,
        textStyle: textStyle,
      );
    }
    error = AnimatedSwitcher(
      duration: _kTransitionDuration,
      child: error ?? SizedBox.shrink(),
    );
    return error;
  }

  BoxDecoration _effectiveBoxDecoration(BuildContext context, SBBInputDecoration decoration) {
    final effectiveStates = Set<WidgetState>.from(widget.states);
    if (widget.isBoxed) effectiveStates.remove(WidgetState.focused);

    var resolvedBorderColor = decoration.borderColor?.resolve(effectiveStates) ?? SBBColors.transparent;

    // add default border if not set for standalone as boxed/listed border is handled outside.
    if (decoration.borderType == .standalone && resolvedBorderColor == SBBColors.transparent) {
      final colorScheme = Theme.of(context).sbbBaseStyle.colorScheme;
      resolvedBorderColor = colorScheme.strokeSeparator ?? SBBColors.transparent;
    }

    final resolvedBorder = widget.isBoxed
        ? Border.all(color: resolvedBorderColor)
        : Border(
            bottom: BorderSide(color: resolvedBorderColor, width: 1.0, strokeAlign: BorderSide.strokeAlignInside),
          );

    return BoxDecoration(borderRadius: widget.isBoxed ? SBBContentBoxStyle.radius : null, border: resolvedBorder);
  }

  // Gap resolution methods
  double _effectiveLeadingInputGap(SBBInputDecoration decoration) {
    return decoration.leadingInputGap ?? defaultLeadingInputGap;
  }

  double _effectiveInputTrailingGap(SBBInputDecoration decoration) {
    return decoration.inputTrailingGap ?? defaultInputTrailingGap;
  }

  double _effectiveFloatingLabelInputGap(SBBInputDecoration decoration) {
    return decoration.floatingLabelInputGap ?? defaultFloatingLabelInputGap;
  }

  double _effectiveTitleRowErrorGap(SBBInputDecoration decoration) {
    return decoration.titleRowErrorGap ?? defaultTitleRowErrorGap;
  }

  double _effectiveErrorBottomPadding(SBBInputDecoration decoration) {
    return decoration.errorBottomPadding ?? defaultErrorBottomPadding;
  }

  EdgeInsetsGeometry _effectiveContentPadding(SBBInputDecoration decoration) {
    return decoration.contentPadding ?? defaultContentPadding;
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

class const _SBBDecorator({
  required final SBBDecoration decoration,
  required final bool expands,
  required final bool isMultiline,
  required final bool isEmpty,
  required final double floatingLabelProgress,
  required final double floatingLabelInputGap,
  required final double minInputHeight,
  required final double minTotalHeight,
  required final EdgeInsetsGeometry contentPadding,
  final double? maxLabelHeight,
}) extends SlottedMultiChildRenderObjectWidget<_SBBDecorationSlot, RenderBox> {
  @override
  Iterable<_SBBDecorationSlot> get slots => _SBBDecorationSlot.values;

  @override
  Widget? childForSlot(_SBBDecorationSlot slot) {
    return switch (slot) {
      .label => decoration.label,
      .leading => decoration.leading,
      .input => decoration.input,
      .placeholder => decoration.placeholder,
      .trailing => decoration.trailing,
      .error => decoration.error,
      .container => decoration.container,
    };
  }

  @override
  _RenderSBBDecoration createRenderObject(BuildContext context) {
    return _RenderSBBDecoration(
      decoration: decoration,
      expands: expands,
      isMultiline: isMultiline,
      isEmpty: isEmpty,
      floatingLabelProgress: floatingLabelProgress,
      floatingLabelInputGap: floatingLabelInputGap,
      minInputHeight: minInputHeight,
      minTotalHeight: minTotalHeight,
      maxLabelHeight: maxLabelHeight,
      contentPadding: contentPadding,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderSBBDecoration renderObject) {
    renderObject
      ..decoration = decoration
      ..expands = expands
      ..isMultiline = isMultiline
      ..isEmpty = isEmpty
      ..floatingLabelProgress = floatingLabelProgress
      ..floatingLabelInputGap = floatingLabelInputGap
      ..minInputHeight = minInputHeight
      ..maxLabelHeight = maxLabelHeight
      ..contentPadding = contentPadding;
  }
}

// Container for layout values computed by _RenderSBBDecoration._layout.
class const _RenderSBBDecorationLayout({
  required final Offset labelOffset,
  required final Offset leadingOffset,
  required final Offset inputOffset,
  required final Offset placeholderOffset,
  required final Offset trailingOffset,
  required final Offset errorOffset,
  required final Size size,
});

// The workhorse
class _RenderSBBDecoration({
  required var SBBDecoration _decoration,
  required var bool _expands,
  required var bool _isMultiline,
  required var bool _isEmpty,
  required var double _floatingLabelProgress,
  required var double _floatingLabelInputGap,
  required var double _minInputHeight,
  required var double _minTotalHeight,
  required var EdgeInsetsGeometry _contentPadding,
  var double? _maxLabelHeight,
}) extends RenderBox with SlottedContainerRenderObjectMixin<_SBBDecorationSlot, RenderBox> {
  RenderBox? get label => childForSlot(.label);

  RenderBox? get leading => childForSlot(.leading);

  RenderBox? get input => childForSlot(.input);

  RenderBox? get placeholder => childForSlot(.placeholder);

  RenderBox? get trailing => childForSlot(.trailing);

  RenderBox? get error => childForSlot(.error);

  RenderBox? get container => childForSlot(.container);

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    if (container != null) {
      visitor(container!);
    }
    if (label != null) {
      visitor(label!);
    }
    if (leading != null) {
      visitor(leading!);
    }
    if (placeholder != null) {
      visitor(placeholder!);
    }
    if (input != null) {
      visitor(input!);
    }
    if (trailing != null) {
      visitor(trailing!);
    }
    if (error != null) {
      visitor(error!);
    }
  }

  // The returned list is ordered for hit testing.
  @override
  Iterable<RenderBox> get children {
    return <RenderBox>[
      ?label,
      ?leading,
      ?input,
      ?placeholder,
      ?trailing,
      ?error,
      ?container,
    ];
  }

  SBBDecoration get decoration => _decoration;

  set decoration(SBBDecoration value) {
    if (_decoration == value) return;
    _decoration = value;
    markNeedsLayout();
  }

  bool get expands => _expands;

  set expands(bool value) {
    if (_expands == value) return;
    _expands = value;
    markNeedsLayout();
  }

  bool get isMultiline => _isMultiline;

  set isMultiline(bool value) {
    if (_isMultiline == value) return;
    _isMultiline = value;
    markNeedsLayout();
  }

  bool get isEmpty => _isEmpty;

  set isEmpty(bool value) {
    if (_isEmpty == value) return;
    _isEmpty = value;
    markNeedsLayout();
  }

  double get floatingLabelProgress => _floatingLabelProgress;

  set floatingLabelProgress(double value) {
    if (_floatingLabelProgress == value) return;
    _floatingLabelProgress = value;
    markNeedsLayout();
  }

  double get floatingLabelInputGap => _floatingLabelInputGap;

  set floatingLabelInputGap(double value) {
    if (_floatingLabelInputGap == value) return;
    _floatingLabelInputGap = value;
    markNeedsLayout();
  }

  double get minInputHeight => _minInputHeight;

  set minInputHeight(double value) {
    if (_minInputHeight == value) return;
    _minInputHeight = value;
    markNeedsLayout();
  }

  double get minTotalHeight => _minTotalHeight;

  set minTotalHeight(double value) {
    if (_minTotalHeight == value) return;
    _minTotalHeight = value;
    markNeedsLayout();
  }

  double? get maxLabelHeight => _maxLabelHeight;

  set maxLabelHeight(double? value) {
    if (_maxLabelHeight == value) return;
    _maxLabelHeight = value;
    markNeedsLayout();
  }

  EdgeInsetsGeometry get contentPadding => _contentPadding;

  set contentPadding(EdgeInsetsGeometry value) {
    if (_contentPadding == value) return;
    _contentPadding = value;
    markNeedsLayout();
  }

  static double _minWidth(RenderBox? box, double height) => box?.getMinIntrinsicWidth(height) ?? 0.0;

  static double _maxWidth(RenderBox? box, double height) => box?.getMaxIntrinsicWidth(height) ?? 0.0;

  static double _minHeight(RenderBox? box, double width) => box?.getMinIntrinsicHeight(width) ?? 0.0;

  BoxParentData _boxParentData(RenderBox box) => box.parentData! as BoxParentData;

  _RenderSBBDecorationLayout _layout(BoxConstraints constraints, {required ChildLayouter layoutChild}) {
    _assertHasBoundedWidth(constraints);

    final resolvedContentPadding = contentPadding.resolve(.ltr);
    final looseConstraints = constraints.loosen();

    // Deflate constraints by contentPadding for all child layouts
    final paddedConstraints = looseConstraints.deflate(resolvedContentPadding);

    // Layout error if present first to know the bottomHeight
    var errorHeight = 0.0;
    if (error != null) {
      final errorSize = layoutChild(error!, paddedConstraints);
      errorHeight = errorSize.height;
    }

    final titleRowConstraints = paddedConstraints.deflate(.only(bottom: errorHeight));

    // Layout leading
    var leadingWidth = 0.0;
    var leadingHeight = 0.0;
    if (leading != null) {
      final leadingSize = layoutChild(leading!, titleRowConstraints);
      leadingWidth = leadingSize.width;
      leadingHeight = leadingSize.height;
    }

    // Layout trailing
    var trailingWidth = 0.0;
    var trailingHeight = 0.0;
    if (trailing != null) {
      final trailingSize = layoutChild(trailing!, titleRowConstraints);
      trailingWidth = trailingSize.width;
      trailingHeight = trailingSize.height;
    }

    _assertTrailingLeadingDoNotOverflow(paddedConstraints, leadingWidth, trailingWidth);

    // Enforce input / placeholder and label to have maximum available width
    final availableInputWidth = paddedConstraints.maxWidth - leadingWidth - trailingWidth;
    var inputConstraints = titleRowConstraints.tighten(width: availableInputWidth);

    // Layout label
    var labelHeight = 0.0;
    if (label != null) {
      labelHeight = layoutChild(label!, inputConstraints).height;
    }

    inputConstraints = inputConstraints.deflate(.only(top: labelHeight));

    // Layout input
    var inputHeight = 0.0;
    if (input != null) {
      inputHeight = layoutChild(input!, inputConstraints).height;
    }

    // Layout placeholder
    var placeholderHeight = 0.0;
    if (placeholder != null) {
      placeholderHeight = layoutChild(placeholder!, inputConstraints).height;
    }

    final maxInputHeight = [inputHeight, placeholderHeight, minInputHeight].reduce(math.max);

    // To prevent changing height of the decorated field during animation,
    // space is reserved for both floating label and input.
    // The label shrinks as it floats, so the reservation uses its maximum height rather than
    // its current one: otherwise the field follows the label down whenever this sum, and not
    // minTotalHeight, is what decides the height.
    final stableContentHeight = (maxLabelHeight ?? labelHeight) + floatingLabelInputGap + maxInputHeight;

    // What the label and the input occupy right now. This is centered within the reserved
    // space, so that a label smaller than its maximum does not leave the content top-heavy.
    final currentContentHeight = labelHeight + floatingLabelInputGap + maxInputHeight;

    final titleRowHeight = [
      if (!isMultiline) leadingHeight,
      stableContentHeight,
      if (!isMultiline) trailingHeight,
      minTotalHeight,
    ].reduce(math.max);

    // Position label:
    // The labelSpaceHeight is the height of the theoretical space for the label to move around
    // In single line case, this is trivially the titleRowHeight (everything is centered)
    // In the multiline case, this is a theoretical box which assumes the height of the first line of the input,
    // and the maximum possible labelHeight.
    // Calculate label offset based on floatingLabelProgress
    // When not floating (progress=0): label is centered vertically of labelSpaceHeight
    // When floating (progress=1): label is at top of stableContentHeight middle
    final labelSpaceHeight = !isMultiline
        ? titleRowHeight
        : (maxLabelHeight ?? labelHeight) + floatingLabelInputGap + minInputHeight;

    final labelCenteredY = (labelSpaceHeight - labelHeight) / 2.0;
    final labelFloatingY = !isMultiline ? (labelSpaceHeight - currentContentHeight) / 2.0 : 0.0;

    //  Interpolate label Y position
    final labelY = lerpDouble(labelCenteredY, labelFloatingY, floatingLabelProgress)! + resolvedContentPadding.top;
    final labelOffset = label != null ? Offset(leadingWidth + resolvedContentPadding.left, labelY) : Offset.zero;

    // Position trailing & leading:
    // For multiline inputs, top-align leading and trailing elements; otherwise center them
    final Offset leadingOffset;
    if (leading != null) {
      leadingOffset = Offset(
        resolvedContentPadding.left,
        (isMultiline ? 0.0 : (titleRowHeight - leadingHeight) / 2) + resolvedContentPadding.top,
      );
    } else {
      leadingOffset = Offset.zero;
    }
    final Offset trailingOffset;
    if (trailing != null) {
      final trailingX = leadingWidth + availableInputWidth + resolvedContentPadding.left;
      trailingOffset = Offset(
        trailingX,
        (isMultiline ? 0.0 : (titleRowHeight - trailingHeight) / 2) + resolvedContentPadding.top,
      );
    } else {
      trailingOffset = Offset.zero;
    }

    // Input position:
    // single line: when floating, input is below the floating label + gap
    // multiline: when floating, input is below labelHeight and gap to not jitter with labelOffset.dy in extreme cases
    // When not floating, input is centered
    final inputCenteredY = (titleRowHeight - maxInputHeight) / 2.0;
    final inputFloatingY = !isMultiline
        ? labelFloatingY + labelHeight + floatingLabelInputGap
        : labelHeight + floatingLabelInputGap;
    final inputY = lerpDouble(inputCenteredY, inputFloatingY, floatingLabelProgress)! + resolvedContentPadding.top;

    final inputOffset = Offset(leadingWidth + resolvedContentPadding.left, inputY);

    // Placeholder is positioned at the same location as input
    final placeholderOffset = Offset(leadingWidth + resolvedContentPadding.left, inputY);

    // Layout error widget below the tallest of the widgets in the title row
    // if expands is true, needs to be laid out at the bottom
    final topAlignedErrorY = [
      leadingOffset.dy + leadingHeight,
      isMultiline ? stableContentHeight + resolvedContentPadding.top : inputOffset.dy + maxInputHeight,
      trailingOffset.dy + trailingHeight,
    ].reduce(math.max);
    final errorY = expands ? constraints.maxHeight - errorHeight - resolvedContentPadding.bottom : topAlignedErrorY;
    final errorOffset = error != null ? Offset(resolvedContentPadding.left, errorY) : Offset.zero;

    // Calculate total size (add padding to total height)
    final contentHeight = expands
        ? constraints.maxHeight
        : math.max(topAlignedErrorY + errorHeight, titleRowHeight + resolvedContentPadding.top);
    final totalHeight = contentHeight + resolvedContentPadding.bottom;
    final size = Size(constraints.maxWidth, totalHeight);

    return _RenderSBBDecorationLayout(
      labelOffset: labelOffset,
      leadingOffset: leadingOffset,
      inputOffset: inputOffset,
      placeholderOffset: placeholderOffset,
      trailingOffset: trailingOffset,
      errorOffset: errorOffset,
      size: size,
    );
  }

  @override
  void performLayout() {
    final layout = _layout(constraints, layoutChild: ChildLayoutHelper.layoutChild);

    size = constraints.constrain(layout.size);
    assert(size.width == constraints.constrainWidth(layout.size.width));
    assert(size.height == constraints.constrainHeight(layout.size.height));

    void setParentData(RenderBox? box, Offset offset) {
      if (box == null) return;
      _boxParentData(box).offset = offset;
    }

    if (container != null) {
      final containerConstraints = BoxConstraints.tight(size);
      container!.layout(containerConstraints, parentUsesSize: true);
      setParentData(container, Offset.zero);
    }

    setParentData(label, layout.labelOffset);
    setParentData(leading, layout.leadingOffset);
    setParentData(input, layout.inputOffset);
    setParentData(placeholder, layout.placeholderOffset);
    setParentData(trailing, layout.trailingOffset);
    setParentData(error, layout.errorOffset);
  }

  @override
  double? computeDryBaseline(covariant BoxConstraints constraints, TextBaseline baseline) {
    final input = this.input;
    if (input == null) {
      return 0.0;
    }

    final layout = _layout(constraints, layoutChild: ChildLayoutHelper.dryLayoutChild);

    final resolvedContentPadding = contentPadding.resolve(.ltr);
    final leadingWidth = leading?.getMinIntrinsicWidth(.infinity) ?? 0.0;
    final trailingWidth = trailing?.getMinIntrinsicWidth(.infinity) ?? 0.0;

    return layout.inputOffset.dy +
        (input.getDryBaseline(
              BoxConstraints(
                minWidth: constraints.maxWidth - leadingWidth - trailingWidth - resolvedContentPadding.horizontal,
                maxWidth: constraints.maxWidth - leadingWidth - trailingWidth - resolvedContentPadding.horizontal,
              ),
              .alphabetic,
            ) ??
            0.0);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final layout = _layout(constraints, layoutChild: ChildLayoutHelper.dryLayoutChild);
    return constraints.constrain(layout.size);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final resolvedContentPadding = contentPadding.resolve(.ltr);

    final leadingWidth = _minWidth(leading, height);
    final inputWidth = _minWidth(input, height);
    final placeholderWidth = _minWidth(placeholder, height);
    final trailingWidth = _minWidth(trailing, height);
    final errorWidth = _minWidth(error, height);
    final labelWidth = _minWidth(label, height);

    final double contentWidth = math.max(placeholderWidth, inputWidth);

    final minWidth = <double>[
      errorWidth,
      leadingWidth + labelWidth + trailingWidth,
      leadingWidth + contentWidth + trailingWidth,
    ].reduce(math.max);

    return minWidth + resolvedContentPadding.horizontal;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final resolvedContentPadding = contentPadding.resolve(.ltr);

    final leadingWidth = _maxWidth(leading, height);
    final inputWidth = _maxWidth(input, height);
    final placeholderWidth = _maxWidth(placeholder, height);
    final trailingWidth = _maxWidth(trailing, height);
    final errorWidth = _maxWidth(error, height);
    final labelWidth = _maxWidth(label, height);

    final double contentWidth = math.max(placeholderWidth, inputWidth);

    final maxWidth = <double>[
      errorWidth,
      leadingWidth + labelWidth + trailingWidth,
      leadingWidth + contentWidth + trailingWidth,
    ].reduce(math.max);

    return maxWidth + resolvedContentPadding.horizontal;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final resolvedContentPadding = contentPadding.resolve(.ltr);
    final availableWidth = math.max(0.0, width - resolvedContentPadding.horizontal);

    final leadingWidth = _minWidth(leading, .infinity);
    final trailingWidth = _minWidth(trailing, .infinity);
    final availableInputWidth = math.max(0.0, availableWidth - leadingWidth - trailingWidth);

    final labelHeight = _minHeight(label, availableInputWidth);
    final inputHeight = _minHeight(input, availableInputWidth);
    final placeholderHeight = _minHeight(placeholder, availableInputWidth);
    final leadingHeight = _minHeight(leading, availableWidth);
    final trailingHeight = _minHeight(trailing, availableWidth);
    final errorHeight = _minHeight(error, availableWidth);

    final maxInputHeight = isEmpty ? math.max(inputHeight, placeholderHeight) : inputHeight;
    final floatingContentHeight = labelHeight + floatingLabelInputGap + maxInputHeight;
    final stableContentHeight = math.max(labelHeight, floatingContentHeight);

    final titleRowHeight = [
      leadingHeight,
      stableContentHeight,
      trailingHeight,
      minTotalHeight,
    ].reduce(math.max);

    return titleRowHeight + errorHeight + resolvedContentPadding.vertical;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return getMinIntrinsicHeight(width);
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    final input = this.input;
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

    doPaint(container);
    doPaint(label);
    doPaint(leading);
    doPaint(placeholder);
    doPaint(input);
    doPaint(trailing);
    doPaint(error);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (final child in children) {
      final offset = _boxParentData(child).offset;
      final isHit = result.addWithPaintOffset(
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

  void _assertHasBoundedWidth(BoxConstraints constraints) {
    assert(
      constraints.maxWidth < double.infinity,
      'An SBBInputDecorator, which is typically created by a SBBTextInput, cannot '
      'have an unbounded width.\n'
      'This happens when the parent widget does not provide a finite width '
      'constraint. For example, if the InputDecorator is contained by a Row, '
      'then its width must be constrained. An Expanded widget or a SizedBox '
      'can be used to constrain the width.',
    );
  }

  void _assertTrailingLeadingDoNotOverflow(BoxConstraints constraints, double leadingWidth, double trailingWidth) {
    final maxWidth = constraints.loosen().maxWidth;
    assert(() {
      if (maxWidth == 0.0) {
        return true;
      }

      String? overflowedWidget;
      if (maxWidth == leadingWidth) {
        overflowedWidget = 'Leading';
      } else if (maxWidth == trailingWidth) {
        overflowedWidget = 'Trailing';
      }

      if (overflowedWidget == null) {
        return true;
      }

      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
          '$overflowedWidget widget consumes the entire width.',
        ),
        ErrorDescription(
          'Either resize the width so that the ${overflowedWidget.toLowerCase()} widget '
          'do not exceed the available width, or use a sized widget.',
        ),
      ]);
    }());
  }
}
