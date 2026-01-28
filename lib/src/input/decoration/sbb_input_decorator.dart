import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sbb_design_system_mobile/src/input/decoration/sbb_decoration.dart';
import 'package:sbb_design_system_mobile/src/input/theme/default_sbb_input_decoration_theme_data.dart';

import '../../../sbb_design_system_mobile.dart';

// Animation constants
const Duration _kTransitionDuration = Duration(milliseconds: 168);
const Curve _kTransitionCurve = Curves.fastOutSlowIn;

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
  /// Will float when not empty or when focused while enabled.
  bool get _labelShouldFloat =>
      !isEmpty || (states.contains(WidgetState.focused) && !states.contains(WidgetState.disabled));

  @override
  State<SBBInputDecorator> createState() => _SBBInputDecoratorState();
}

class _SBBInputDecoratorState extends State<SBBInputDecorator> with SingleTickerProviderStateMixin {
  late final AnimationController _floatingLabelController;
  late final CurvedAnimation _floatingLabelAnimation;
  SBBFloatingLabelBehavior _inheritedFloatingLabelBehavior = SBBFloatingLabelBehavior.auto;

  // Provide unique sort keys to avoid mixing up sort order with sibling input decorators.
  late final OrdinalSortKey _leadingSemanticsSortOrder = OrdinalSortKey(
    0,
    name: hashCode.toString(),
  );
  late final OrdinalSortKey _inputSemanticsSortOrder = OrdinalSortKey(
    1,
    name: hashCode.toString(),
  );
  late final OrdinalSortKey _trailingSemanticsSortOrder = OrdinalSortKey(
    2,
    name: hashCode.toString(),
  );

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
    return behavior == SBBFloatingLabelBehavior.always ||
        (behavior == SBBFloatingLabelBehavior.auto && widget._labelShouldFloat);
  }

  SBBFloatingLabelBehavior get _effectiveFloatingLabelBehavior {
    return widget.decoration.floatingLabelBehavior ?? _inheritedFloatingLabelBehavior;
  }

  bool get _shouldShowPlaceholder =>
      widget.isEmpty &&
      (widget.states.contains(WidgetState.focused) ||
          _effectiveFloatingLabelBehavior == SBBFloatingLabelBehavior.always);

  @override
  void didUpdateWidget(SBBInputDecorator oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldBehavior = oldWidget.decoration.floatingLabelBehavior ?? _inheritedFloatingLabelBehavior;

    final oldShouldFloat =
        oldBehavior == SBBFloatingLabelBehavior.always ||
        (oldBehavior == SBBFloatingLabelBehavior.auto && oldWidget._labelShouldFloat);
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
    final newBehavior = inputDecorationTheme?.floatingLabelBehavior ?? SBBFloatingLabelBehavior.auto;

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
    final inputDecorationTheme = Theme.of(context).sbbInputDecorationTheme;

    final textScaler = MediaQuery.textScalerOf(context);

    print('Building Decorator');

    Widget? leading = widget.decoration.leading;
    if (leading == null && widget.decoration.leadingIconData != null) {
      leading = Padding(
        padding: EdgeInsets.only(right: _effectiveLeadingInputGap(inputDecorationTheme)),
        child: Icon(widget.decoration.leadingIconData),
      );
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
    double? maxLabelTextHeight;
    if (label == null && widget.decoration.labelText != null) {
      label = Text(widget.decoration.labelText!, maxLines: 1, overflow: TextOverflow.ellipsis);
    }
    if (label != null) {
      final Color? resolvedColor =
          (widget.decoration.labelForegroundColor ?? inputDecorationTheme?.labelForegroundColor)?.resolve(
            widget.states,
          );
      final TextStyle? textStyle = widget.decoration.labelTextStyle ?? inputDecorationTheme?.labelTextStyle;
      TextStyle? floatingTextStyle =
          widget.decoration.floatingLabelTextStyle ?? inputDecorationTheme?.floatingLabelTextStyle;

      final resolvedTextStyle =
          (_shouldFloat ? floatingTextStyle : textStyle)?.copyWith(color: resolvedColor) ??
          TextStyle(color: resolvedColor);

      if (widget.decoration.labelText != null && textStyle?.fontSize != null && textStyle?.height != null) {
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

    Widget? trailing = widget.decoration.trailing;
    if (trailing == null && widget.decoration.trailingIconData != null) {
      trailing = Padding(
        padding: EdgeInsets.only(left: _effectiveInputTrailingGap(inputDecorationTheme)),
        child: Icon(widget.decoration.trailingIconData),
      );
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
      placeholder = AnimatedOpacity(
        duration: _kTransitionDuration * 1.25,
        opacity: _shouldShowPlaceholder ? 1 : 0,
        child: Text(widget.decoration.placeholderText!),
      );
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
      error = Padding(
        padding: EdgeInsets.only(
          top: textScaler.scale(_effectiveTitleRowErrorGap(inputDecorationTheme)),
          bottom: _effectiveErrorBottomPadding(inputDecorationTheme),
        ),
        child: Text(widget.decoration.errorText!),
      );
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

    final Widget container = AnimatedContainer(
      duration: _kTransitionDuration,
      decoration: _effectiveBoxDecoration(inputDecorationTheme),
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
      floatingLabelInputGap: textScaler.scale(_effectiveFloatingLabelInputGap(inputDecorationTheme)),
      minInputHeight: widget.minInputHeight,
      minTotalHeight: textScaler.scale(SBBInputDecoration.minInputFieldHeight),
      maxLabelHeight: maxLabelTextHeight,
      contentPadding: _effectiveContentPadding(inputDecorationTheme),
    );
  }

  BoxDecoration _effectiveBoxDecoration(SBBInputDecorationThemeData? inputDecorationTheme) {
    final effectiveStates = Set<WidgetState>.from(widget.states);
    if (widget.isBoxed) effectiveStates.remove(WidgetState.focused);

    final Color resolvedBorderColor =
        (widget.decoration.borderColor ?? inputDecorationTheme?.borderColor)?.resolve(effectiveStates) ??
        SBBColors.transparent;
    final resolvedBorder = widget.isBoxed
        ? Border.all(color: resolvedBorderColor)
        : Border(bottom: BorderSide(color: resolvedBorderColor));

    return BoxDecoration(borderRadius: widget.isBoxed ? SBBContentBoxStyle.radius : null, border: resolvedBorder);
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

  // Gap resolution methods
  double _effectiveLeadingInputGap(SBBInputDecorationThemeData? theme) {
    return widget.decoration.leadingInputGap ?? theme?.leadingInputGap ?? defaultLeadingInputGap;
  }

  double _effectiveInputTrailingGap(SBBInputDecorationThemeData? theme) {
    return widget.decoration.inputTrailingGap ?? theme?.inputTrailingGap ?? defaultInputTrailingGap;
  }

  double _effectiveFloatingLabelInputGap(SBBInputDecorationThemeData? theme) {
    return widget.decoration.floatingLabelInputGap ?? theme?.floatingLabelInputGap ?? defaultFloatingLabelInputGap;
  }

  double _effectiveTitleRowErrorGap(SBBInputDecorationThemeData? theme) {
    return widget.decoration.titleRowErrorGap ?? theme?.titleRowErrorGap ?? defaultTitleRowErrorGap;
  }

  double _effectiveErrorBottomPadding(SBBInputDecorationThemeData? theme) {
    return widget.decoration.errorBottomPadding ?? theme?.errorBottomPadding ?? defaultErrorBottomPadding;
  }

  EdgeInsetsGeometry _effectiveContentPadding(SBBInputDecorationThemeData? theme) {
    return widget.decoration.contentPadding ?? theme?.contentPadding ?? defaultContentPadding;
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
    required this.floatingLabelProgress,
    required this.floatingLabelInputGap,
    required this.minInputHeight,
    required this.minTotalHeight,
    required this.contentPadding,
    this.maxLabelHeight,
  });

  final SBBDecoration decoration;
  final bool expands;
  final bool isMultiline;
  final bool isEmpty;
  final double floatingLabelProgress;
  final double floatingLabelInputGap;
  final double minInputHeight;
  final double minTotalHeight;
  final double? maxLabelHeight;
  final EdgeInsetsGeometry contentPadding;

  @override
  Iterable<_SBBDecorationSlot> get slots => _SBBDecorationSlot.values;

  @override
  Widget? childForSlot(_SBBDecorationSlot slot) {
    return switch (slot) {
      _SBBDecorationSlot.label => decoration.label,
      _SBBDecorationSlot.leading => decoration.leading,
      _SBBDecorationSlot.input => decoration.input,
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

// Type definitions for layout helpers
typedef _ChildBaselineGetter = double Function(RenderBox child, BoxConstraints constraints);

// Container for layout values computed by _RenderSBBDecoration._layout.
class _RenderSBBDecorationLayout {
  const _RenderSBBDecorationLayout({
    required this.labelOffset,
    required this.leadingOffset,
    required this.inputOffset,
    required this.placeholderOffset,
    required this.trailingOffset,
    required this.errorOffset,
    required this.size,
  });

  final Offset labelOffset;
  final Offset leadingOffset;
  final Offset inputOffset;
  final Offset placeholderOffset;
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
    required double floatingLabelProgress,
    required double floatingLabelInputGap,
    required double minInputHeight,
    required double minTotalHeight,
    required EdgeInsetsGeometry contentPadding,
    double? maxLabelHeight,
  }) : _decoration = decoration,
       _expands = expands,
       _isMultiline = isMultiline,
       _isEmpty = isEmpty,
       _floatingLabelProgress = floatingLabelProgress,
       _floatingLabelInputGap = floatingLabelInputGap,
       _minInputHeight = minInputHeight,
       _minTotalHeight = minTotalHeight,
       _maxLabelHeight = maxLabelHeight,
       _contentPadding = contentPadding;

  RenderBox? get label => childForSlot(_SBBDecorationSlot.label);

  RenderBox? get leading => childForSlot(_SBBDecorationSlot.leading);

  RenderBox? get input => childForSlot(_SBBDecorationSlot.input);

  RenderBox? get placeholder => childForSlot(_SBBDecorationSlot.placeholder);

  RenderBox? get trailing => childForSlot(_SBBDecorationSlot.trailing);

  RenderBox? get error => childForSlot(_SBBDecorationSlot.error);

  RenderBox? get container => childForSlot(_SBBDecorationSlot.container);

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

  double get floatingLabelProgress => _floatingLabelProgress;
  double _floatingLabelProgress;

  set floatingLabelProgress(double value) {
    if (_floatingLabelProgress == value) return;
    _floatingLabelProgress = value;
    markNeedsLayout();
  }

  double get floatingLabelInputGap => _floatingLabelInputGap;
  double _floatingLabelInputGap;

  set floatingLabelInputGap(double value) {
    if (_floatingLabelInputGap == value) return;
    _floatingLabelInputGap = value;
    markNeedsLayout();
  }

  double get minInputHeight => _minInputHeight;
  double _minInputHeight;

  set minInputHeight(double value) {
    if (_minInputHeight == value) return;
    _minInputHeight = value;
    markNeedsLayout();
  }

  double get minTotalHeight => _minTotalHeight;
  double _minTotalHeight;

  set minTotalHeight(double value) {
    if (_minTotalHeight == value) return;
    _minTotalHeight = value;
    markNeedsLayout();
  }

  double? get maxLabelHeight => _maxLabelHeight;
  double? _maxLabelHeight;

  set maxLabelHeight(double? value) {
    if (_maxLabelHeight == value) return;
    _maxLabelHeight = value;
    markNeedsLayout();
  }

  EdgeInsetsGeometry get contentPadding => _contentPadding;
  EdgeInsetsGeometry _contentPadding;

  set contentPadding(EdgeInsetsGeometry value) {
    if (_contentPadding == value) return;
    _contentPadding = value;
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
  _RenderSBBDecorationLayout _layout(
    BoxConstraints constraints, {
    required ChildLayouter layoutChild,
    required _ChildBaselineGetter getBaseline,
  }) {
    _assertHasBoundedWidth(constraints);

    final EdgeInsets resolvedContentPadding = contentPadding.resolve(TextDirection.ltr);
    final BoxConstraints looseConstraints = constraints.loosen();

    // Deflate constraints by contentPadding for all child layouts
    final BoxConstraints paddedConstraints = looseConstraints.deflate(resolvedContentPadding);

    // Layout error if present first to know the bottomHeight
    double errorHeight = 0.0;
    if (error != null) {
      final Size errorSize = layoutChild(error!, paddedConstraints);
      errorHeight = errorSize.height;
    }

    final BoxConstraints titleRowConstraints = paddedConstraints.deflate(EdgeInsets.only(bottom: errorHeight));

    // Layout leading
    double leadingWidth = 0.0;
    double leadingHeight = 0.0;
    if (leading != null) {
      final Size leadingSize = layoutChild(leading!, titleRowConstraints);
      leadingWidth = leadingSize.width;
      leadingHeight = leadingSize.height;
    }

    // Layout trailing
    double trailingWidth = 0.0;
    double trailingHeight = 0.0;
    if (trailing != null) {
      final Size trailingSize = layoutChild(trailing!, titleRowConstraints);
      trailingWidth = trailingSize.width;
      trailingHeight = trailingSize.height;
    }

    _assertTrailingLeadingDoNotOverflow(paddedConstraints, leadingWidth, trailingWidth);

    // Enforce input / placeholder and label to have maximum available width
    final double availableInputWidth = paddedConstraints.maxWidth - leadingWidth - trailingWidth;
    BoxConstraints inputConstraints = titleRowConstraints.tighten(width: availableInputWidth);

    // Layout label
    double labelHeight = 0.0;
    if (label != null) {
      labelHeight = layoutChild(label!, inputConstraints).height;
    }

    inputConstraints = inputConstraints.deflate(EdgeInsets.only(top: labelHeight));

    // Layout input
    double inputHeight = 0.0;
    if (input != null) {
      inputHeight = layoutChild(input!, inputConstraints).height;
    }

    // Layout placeholder
    double placeholderHeight = 0.0;
    if (placeholder != null) {
      placeholderHeight = layoutChild(placeholder!, inputConstraints).height;
    }

    // Calculate the maximum height among input/placeholder (placeholder only visible if empty)
    final double maxInputHeight = [inputHeight, placeholderHeight, minInputHeight].reduce(math.max);

    // For single-line case: Always reserve space for both floating label and input
    // to ensure height doesn't change during animation.
    // The height should accommodate: floatingLabel + gap + input when fully floated.
    final double stableContentHeight =
        (isMultiline ? maxLabelHeight ?? labelHeight : labelHeight) + floatingLabelInputGap + maxInputHeight;

    // Title row height is max of leading, content area, trailing
    final double titleRowHeight = [
      if (!isMultiline) leadingHeight,
      stableContentHeight,
      if (!isMultiline) trailingHeight,
      minTotalHeight,
    ].reduce(math.max);

    // Position label:
    // Calculate label offset based on floatingLabelProgress
    // When not floating (progress=0): label is centered vertically of titleRowHeight
    // When floating (progress=1): label is at top
    final labelBox = !isMultiline ? titleRowHeight : labelHeight + floatingLabelInputGap + minInputHeight;

    final double labelCenteredY = (labelBox - labelHeight) / 2.0;
    final double labelFloatingY = !isMultiline ? (labelBox - stableContentHeight) / 2.0 : 0.0;

    //  Interpolate label Y position (add top padding)
    final double labelY =
        lerpDouble(labelCenteredY, labelFloatingY, floatingLabelProgress)! + resolvedContentPadding.top;
    final Offset labelOffset = label != null ? Offset(leadingWidth + resolvedContentPadding.left, labelY) : Offset.zero;

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

    // Input position: when floating, input is below the floating label + gap
    // When not floating, input is centered (same as where the label would be)
    final double inputCenteredY = (titleRowHeight - maxInputHeight) / 2.0;
    final double inputFloatingY = labelFloatingY + labelHeight + floatingLabelInputGap;
    final double inputY =
        lerpDouble(inputCenteredY, inputFloatingY, floatingLabelProgress)! + resolvedContentPadding.top;

    final Offset inputOffset = Offset(
      leadingWidth + resolvedContentPadding.left,
      inputY,
    );

    // Placeholder is positioned at the same location as input
    final Offset placeholderOffset = Offset(
      leadingWidth + resolvedContentPadding.left,
      inputY,
    );

    // Layout error widget below the tallest of the widgets in the title row
    // if expands is true, needs to be laid out at the bottom
    final double topAlignedErrorY = [
      leadingOffset.dy + leadingHeight,
      isMultiline ? stableContentHeight + resolvedContentPadding.top : inputOffset.dy + maxInputHeight,
      trailingOffset.dy + trailingHeight,
    ].reduce(math.max);
    final errorY = expands ? constraints.maxHeight - errorHeight - resolvedContentPadding.bottom : topAlignedErrorY;
    final Offset errorOffset = error != null ? Offset(resolvedContentPadding.left, errorY) : Offset.zero;

    // Calculate total size (add padding to total height)
    final double contentHeight = expands
        ? constraints.maxHeight
        : math.max(topAlignedErrorY + errorHeight, titleRowHeight + resolvedContentPadding.top);
    final double totalHeight = contentHeight + resolvedContentPadding.bottom;
    final Size size = Size(constraints.maxWidth, totalHeight);

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
    setParentData(placeholder, layout.placeholderOffset);
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

    final EdgeInsets resolvedContentPadding = contentPadding.resolve(TextDirection.ltr);
    final double leadingWidth = leading?.getMinIntrinsicWidth(double.infinity) ?? 0.0;
    final double trailingWidth = trailing?.getMinIntrinsicWidth(double.infinity) ?? 0.0;

    return layout.inputOffset.dy +
        (input.getDryBaseline(
              BoxConstraints(
                minWidth: constraints.maxWidth - leadingWidth - trailingWidth - resolvedContentPadding.horizontal,
                maxWidth: constraints.maxWidth - leadingWidth - trailingWidth - resolvedContentPadding.horizontal,
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
    final EdgeInsets resolvedContentPadding = contentPadding.resolve(TextDirection.ltr);

    final double leadingWidth = _minWidth(leading, height);
    final double inputWidth = _minWidth(input, height);
    final double placeholderWidth = _minWidth(placeholder, height);
    final double trailingWidth = _minWidth(trailing, height);
    final double errorWidth = _minWidth(error, height);
    final double labelWidth = _minWidth(label, height);

    final double contentWidth = math.max(placeholderWidth, inputWidth);

    final double minWidth = <double>[
      errorWidth,
      leadingWidth + labelWidth + trailingWidth,
      leadingWidth + contentWidth + trailingWidth,
    ].reduce(math.max);

    return minWidth + resolvedContentPadding.horizontal;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final EdgeInsets resolvedContentPadding = contentPadding.resolve(TextDirection.ltr);

    final double leadingWidth = _maxWidth(leading, height);
    final double inputWidth = _maxWidth(input, height);
    final double placeholderWidth = _maxWidth(placeholder, height);
    final double trailingWidth = _maxWidth(trailing, height);
    final double errorWidth = _maxWidth(error, height);
    final double labelWidth = _maxWidth(label, height);

    final double contentWidth = math.max(placeholderWidth, inputWidth);

    final double maxWidth = <double>[
      errorWidth,
      leadingWidth + labelWidth + trailingWidth,
      leadingWidth + contentWidth + trailingWidth,
    ].reduce(math.max);

    return maxWidth + resolvedContentPadding.horizontal;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final EdgeInsets resolvedContentPadding = contentPadding.resolve(TextDirection.ltr);
    final double availableWidth = math.max(0.0, width - resolvedContentPadding.horizontal);

    final double leadingWidth = _minWidth(leading, double.infinity);
    final double trailingWidth = _minWidth(trailing, double.infinity);
    final double availableInputWidth = math.max(0.0, availableWidth - leadingWidth - trailingWidth);

    final double labelHeight = _minHeight(label, availableInputWidth);
    final double inputHeight = _minHeight(input, availableInputWidth);
    final double placeholderHeight = _minHeight(placeholder, availableInputWidth);
    final double leadingHeight = _minHeight(leading, availableWidth);
    final double trailingHeight = _minHeight(trailing, availableWidth);
    final double errorHeight = _minHeight(error, availableWidth);

    final double maxInputHeight = isEmpty ? math.max(inputHeight, placeholderHeight) : inputHeight;
    final double floatingContentHeight = labelHeight + floatingLabelInputGap + maxInputHeight;
    final double stableContentHeight = math.max(labelHeight, floatingContentHeight);

    final double titleRowHeight = [
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
