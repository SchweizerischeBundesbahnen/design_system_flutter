import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import '../input/decoration/sbb_input_decorator.dart';

// TODO: add enabled bool flag parameter instead of null check onTap
// TODO: theming / styling v5 (also add possibility for overriding ink well colors?)
// TODO: ancestor override of value field
// TODO: rename fields for childText / child
// TODO: floatingLabelBehavior override
// TODO: tests
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
    this.valueTextStyle,
    this.valueForegroundColor,
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
  ///
  /// The values given for colors and text styles will override the values given in
  /// [SBBInputDecorationThemeData].
  final SBBInputDecoration? decoration;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.maxLines}
  ///  * [expands], which determines whether the field should fill the height of
  ///    its parent.
  final int? maxLines;

  /// {@macro flutter.widgets.editableText.minLines}
  ///  * [expands], which determines whether the field should fill the height of
  ///    its parent.
  final int? minLines;

  /// {@macro flutter.widgets.editableText.expands}
  final bool expands;

  final GestureTapCallback? onTap;

  /// Whether the text field is interactive.
  ///
  /// When false, the field is disabled and its children are also disabled.
  final bool enabled;

  /// The text style for the [value] text.
  ///
  /// If null, the value from [SBBTextInputThemeData.inputTextStyle] is used. // TODO: move to own theme data
  /// If that is also null, the default text style is used.
  final TextStyle? valueTextStyle;

  /// The color of the [value] text.
  ///
  /// If null, the value from [SBBTextInputThemeData.inputForegroundColor] is used. // TODO: move to own theme data
  /// If that is also null, the default color is used.
  final WidgetStateProperty<Color?>? valueForegroundColor;

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

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    final bool isMultiline = (widget.maxLines ?? 0) != 1;

    final effectiveInputTextStyle = _effectiveInputTextStyle(context);

    final child = Text(widget.value, maxLines: widget.maxLines, style: effectiveInputTextStyle);

    return InkWell(
      onTap: widget.enabled ? widget.onTap : null,
      focusNode: _effectiveFocusNode,
      excludeFromSemantics: true,
      autofocus: widget.autofocus,
      statesController: _statesController,
      child: Semantics(
        enabled: widget.enabled,
        currentValueLength: widget.value.length,
        child: ListenableBuilder(
          listenable: _effectiveFocusNode,
          builder: (context, Widget? child) {
            return SBBInputDecorator(
              decoration: widget.decoration ?? SBBInputDecoration(),
              // TODO: think about setting floating label behavior in case placeholder not null
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

  TextStyle _effectiveInputTextStyle(BuildContext context) {
    final themeData = Theme.of(context).sbbTextInputTheme; // TODO: move this to own theme data
    final states = _statesController.value;

    if (widget.valueTextStyle != null) {
      final textStyle = widget.valueTextStyle;
      final color = widget.valueForegroundColor?.resolve(states);
      return color != null ? textStyle!.copyWith(color: color) : textStyle!;
    }

    final textStyle = themeData!.inputTextStyle;
    final color = widget.valueForegroundColor?.resolve(states) ?? themeData.inputForegroundColor?.resolve(states);
    return color != null ? textStyle!.copyWith(color: color) : textStyle!;
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
    super.valueTextStyle,
    super.valueForegroundColor,
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
