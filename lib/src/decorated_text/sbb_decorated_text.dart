import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import '../input/decoration/sbb_input_decorator.dart';

/// The SBB Decorated Text.
///
/// A static text display widget that mimics the appearance of [SBBTextInput] without
/// the underlying [EditableText] editing capability. Use this widget to display
/// selected or pre-determined values in the same visual style as a text input field.
///
/// This widget is commonly used in non-editable contexts where you want a consistent
/// look with text inputs, such as:
/// * Displaying selected values in [SBBDatePicker] or [SBBDropdown] trigger fields
/// * Showing read-only information that matches text input styling
/// * Creating interactive display fields that respond to taps via [onTap]
///
/// ## Interaction Model
///
/// Unlike [SBBTextInput], which manages text editing, [SBBDecoratedText] uses
/// [InkWell] for tap interaction. This provides visual feedback (ripple/highlight)
/// when tapped without any text editing capability. Use [onTap] to handle
/// interactions, such as opening a picker or dialog.
///
/// ## Multiline Mode
///
/// When configured for multiline display (either by setting [maxLines] to null
/// with [expands] set to true, or by setting [maxLines] to a value greater than 1),
/// the leading and trailing icons become top-aligned instead of center-aligned.
///
/// ## Key Properties
///
/// * [value]: The static text to display (cannot be edited)
/// * [onTap]: Called when the widget is tapped. Provides visual feedback via InkWell
/// * [enabled]: Controls interactivity. When false, taps are ignored and disabled
///   styling is applied
/// * [decoration]: Customizes the decoration surrounding the value, including icons,
///   labels, and error states
/// * [maxLines], [minLines], [expands]: Control text layout similar to [SBBTextInput]
///
/// See also:
/// * [SBBTextInput] for an editable text field with similar styling
/// * [SBBInputDecoration] for customizing the decoration surrounding the text
/// * [SBBDecoratedTextStyle] for customizing the visual appearance
/// * [digital.sbb.ch documentation](https://digital.sbb.ch/de/design-system/mobile/components/text-input/)
/// * [Figma design guidelines](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=309-2236) (internal only)
class SBBDecoratedText extends StatefulWidget {
  const SBBDecoratedText({
    required this.value,
    super.key,
    this.onTap,
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

  /// The static text value to display.
  ///
  /// This value is not editable. To display dynamic content, rebuild the widget
  /// with a new value.
  final String value;

  /// The decoration surrounding the displayed text field.
  ///
  /// Includes styling for labels, icons, error states, and other visual elements.
  /// See [SBBInputDecoration] for customization options.
  final SBBInputDecoration? decoration;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@template sbb_design_system.sbb_decorated_text.maxLines}
  /// The maximum number of lines for the text display.
  ///
  /// Defaults to 1 (single-line). Set to null with [expands] = true for expanding
  /// multiline display, or to a specific number > 1 for fixed multiline height.
  /// {@endtemplate}
  final int? maxLines;

  /// {@template sbb_design_system.sbb_decorated_text.minLines}
  /// The minimum number of lines reserved for text display.
  /// {@endtemplate}
  final int? minLines;

  /// {@template sbb_design_system.sbb_decorated_text.expands}
  /// Whether the text field should expand to fill available vertical space.
  ///
  /// When true, both [maxLines] and [minLines] must be null.
  /// {@endtemplate}
  final bool expands;

  /// Called when the widget is tapped.
  ///
  /// The tap triggers [InkWell] visual feedback (ripple/highlight). This callback
  /// is only invoked if [enabled] is true.
  final GestureTapCallback? onTap;

  /// Customizes the visual appearance of the decorated text.
  ///
  /// Non-null properties override the corresponding properties in
  /// [SBBDecoratedTextThemeData.style] from the current theme.
  final SBBDecoratedTextStyle? style;

  @override
  State<StatefulWidget> createState() => _SBBDecoratedTextState();
}

class _SBBDecoratedTextState extends State<SBBDecoratedText> {
  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  late WidgetStatesController _statesController;

  bool get _enabled => widget.onTap != null;

  @override
  void initState() {
    super.initState();

    _effectiveFocusNode.canRequestFocus = _enabled;
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
    _effectiveFocusNode.canRequestFocus = _enabled;

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
    _statesController.update(WidgetState.disabled, !_enabled);
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
      onTap: _enabled ? widget.onTap : null,
      focusNode: _effectiveFocusNode,
      excludeFromSemantics: true,
      autofocus: widget.autofocus,
      statesController: _statesController,
      overlayColor: effectiveStyle?.overlayColor,
      child: Semantics(
        enabled: _enabled,
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
/// This variant applies default padding and special border styling for a contained
/// appearance. Specifically:
/// * If no [decoration.contentPadding] is provided, applies symmetric horizontal padding
///   of [SBBSpacing.medium]
/// * The border only displays when in an error state, showing a surrounding box
///
/// This is useful for creating grouped form-like layouts with consistent spacing.
class SBBDecoratedTextBoxed extends SBBDecoratedText {
  SBBDecoratedTextBoxed({
    super.key,
    required super.value,
    super.onTap,
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
