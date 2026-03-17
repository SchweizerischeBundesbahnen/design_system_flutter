import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import '../input/decoration/sbb_input_decorator.dart';

// TODO: add example for expands
// TODO: documentation / migration guide

/// The SBB Static Input.
///
/// This Widget mimics the appearance of a [SBBTextInput] without the underlying [EditableText] field.
/// It is mainly used displaying selected values in the same style as a [SBBTextInput], e.g. in the triggering
/// field of a [SBBDatePicker] or [SBBSelect].
///
/// ## Multiline Mode
///
/// When the text field is configured as multiline (either by setting [maxLines] to null
/// with [expands] set to true, or by setting [maxLines] to a value greater than 1),
/// the leading and trailing icons become top-aligned instead of center-aligned.
/// The leadingIconData and trailingIconData will have a default padding added to the top.
///
/// ## Key Properties
///
/// * [onTap]: Called when the text field is tapped. Use [onTapAlwaysCalled] to receive
///   this callback for every tap, including consecutive taps.
/// * [enabled]: Controls whether the text field is interactive. When false, the field
///   is disabled and its children (including trailing icons) are also disabled.
///   Use [readOnly] and [enableInteractiveSelection] if you need to keep trailing widgets
///   interactive while disabling the text field.
/// * [ignorePointers]: Determines whether the widget ignores pointer events (taps, etc.).
/// * [floatingLabelBehavior]: if no value is set and a placeholder is given, the floatingLabelBehavior of the [decoration] is set to always if it is null
///
/// See also:
/// * [SBBTextInputThemeData] for customizing the style across the current theme // TODO: change this
/// * [SBBInputDecoration] for customizing the decoration surrounding the raw input field
/// * [digital.sbb.ch documenation](https://digital.sbb.ch/de/design-system/mobile/components/text-input/)
/// * [Figma design guidelines](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=309-2236) (internal only)
class SBBDecoratedText extends StatefulWidget {
  const SBBDecoratedText({
    required this.value,
    super.key,
    this.onTap,
    this.enabled = true,
    this.decoration,
    this.focusNode,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.style,
  }) : assert(maxLines == null || maxLines > 0),
       assert(minLines == null || minLines > 0),
       assert(
         (maxLines == null) || (minLines == null) || (maxLines >= minLines),
         "minLines can't be greater than maxLines",
       ),
       assert(
         !expands || (maxLines == null && minLines == null),
         'minLines and maxLines must be null when expands is true.',
       );

  final String value;

  /// The decoration surrounding the underlying [Text] field.
  final SBBInputDecoration? decoration;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int? maxLines;

  /// {@macro flutter.widgets.editableText.minLines}
  final int? minLines;

  /// {@macro flutter.widgets.editableText.expands}
  final bool expands;

  final GestureTapCallback? onTap;

  /// Whether the text field is interactive.
  final bool enabled;

  /// Customizes this decorated text appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBDecoratedTextThemeData.style] of the theme found in [context].
  final SBBDecoratedTextStyle? style;

  @override
  State<StatefulWidget> createState() => _SBBDecoratedTextState();
}

class _SBBDecoratedTextState extends State<SBBDecoratedText> {
  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  late WidgetStatesController _statesController;

  @override
  void initState() {
    super.initState();

    _effectiveFocusNode.canRequestFocus = widget.enabled;
    _effectiveFocusNode.addListener(_handleFocusChanged);

    _statesController = WidgetStatesController();
    _updateStates();
  }

  @override
  void didUpdateWidget(covariant SBBDecoratedText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
    }
    _effectiveFocusNode.canRequestFocus = widget.enabled;

    _updateStates();
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();
    _statesController.dispose();
    super.dispose();
  }

  bool get _hasError => widget.decoration?.errorText != null || widget.decoration?.error != null;

  void _updateStates() {
    _statesController.update(WidgetState.disabled, !widget.enabled);
    _statesController.update(WidgetState.focused, _effectiveFocusNode.hasFocus);
    _statesController.update(WidgetState.error, _hasError);
  }

  /// Returns the effective decoration, automatically setting [SBBFloatingLabelBehavior.always]
  /// if no [floatingLabelBehavior] is provided, the value is empty, and a placeholder is present.
  SBBInputDecoration get _effectiveDecoration {
    final decoration = widget.decoration ?? SBBInputDecoration();
    if (decoration.floatingLabelBehavior == null &&
        widget.value.isEmpty &&
        (decoration.placeholder != null || decoration.placeholderText != null)) {
      return decoration.copyWith(floatingLabelBehavior: SBBFloatingLabelBehavior.always);
    }
    return decoration;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    final bool isMultiline = (widget.maxLines ?? 0) != 1;

    final themeData = Theme.of(context).sbbDecoratedTextTheme;
    final effectiveStyle = themeData?.style?.merge(widget.style) ?? widget.style;

    final effectiveInputTextStyle = _effectiveInputTextStyle(effectiveStyle);
    final child = Text(widget.value, maxLines: widget.maxLines, style: effectiveInputTextStyle);

    return InkWell(
      onTap: widget.enabled ? widget.onTap : null,
      focusNode: _effectiveFocusNode,
      excludeFromSemantics: true,
      autofocus: widget.autofocus,
      statesController: _statesController,
      overlayColor: effectiveStyle?.overlayColor,
      child: Semantics(
        enabled: widget.enabled,
        currentValueLength: widget.value.length,
        child: ListenableBuilder(
          listenable: _effectiveFocusNode,
          builder: (context, Widget? child) {
            return SBBInputDecorator(
              decoration: _effectiveDecoration,
              expands: widget.expands,
              minInputHeight:
                  effectiveInputTextStyle.height! * effectiveInputTextStyle.fontSize! * (widget.minLines ?? 1),
              isMultiline: isMultiline,
              isEmpty: widget.value.isEmpty,
              isBoxed: isBoxed,
              states: Set<WidgetState>.from(_statesController.value),
              child: child,
            );
          },
          child: child,
        ),
      ),
    );
  }

  TextStyle _effectiveInputTextStyle(SBBDecoratedTextStyle? style) {
    final textStyle = style?.valueTextStyle;
    final color = style?.valueForegroundColor?.resolve(_statesController.value);

    return (color != null ? textStyle?.copyWith(color: color) : textStyle) ?? TextStyle(color: color);
  }

  bool get isBoxed => false;

  void _handleFocusChanged() {
    _updateStates();
    setState(() {
      // Rebuild widget on focus change to update accordingly.
    });
  }
}

/// The boxed variant of [SBBDecoratedText].
///
/// This has mainly two effects:
/// * if no [decoration.contentPadding] is given, a default padding of
/// [EdgeInsets.symmetric(horizontal: SBBSpacing.medium)] will be applied.
/// * the border of the input decoration will only show if it has an error and in a surrounding manner.
class SBBDecoratedTextBoxed extends SBBDecoratedText {
  SBBDecoratedTextBoxed({
    super.key,
    required super.value,
    super.onTap,
    super.enabled,
    SBBInputDecoration? decoration,
    super.focusNode,
    super.autofocus,
    super.maxLines,
    super.minLines,
    super.expands,
    super.style,
  }) : super(
         decoration: decoration?.contentPadding != null
             ? decoration
             : (decoration ?? SBBInputDecoration()).copyWith(
                 contentPadding: .symmetric(horizontal: SBBSpacing.medium),
               ),
       );

  @override
  State<SBBDecoratedText> createState() => _SBBTextInputStateBoxed();
}

class _SBBTextInputStateBoxed extends _SBBDecoratedTextState {
  @override
  bool get isBoxed => true;

  @override
  Widget build(BuildContext context) {
    return SBBContentBox(child: super.build(context));
  }
}
