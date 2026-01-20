// TODO: create and add SBBInputDecoration to params with moved trailing, leading and so forth
// TODO: add themeData according to v5.0.0 with
// TODO: improve docs
// TODO: add migration guideline & CHANGELOG

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../sbb_design_system_mobile.dart';

/// The SBBTextInput.
///
/// A text field lets the user enter text, either with hardware keyboard or with
/// an onscreen keyboard.
///
/// This component is based on the outlined Material Design text field with no borders. Unlike
/// the Material Design specifications, the SBB TextInput displays error messages *above* the bottom borderline and therefore
/// customizes the bottom border completely.
///
/// See [documentation](https://digital.sbb.ch/de/design-system/mobile/components/text-input/)
/// and [Figma design guidelines](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=309-2236).
class SBBTextInput extends StatefulWidget {
  const SBBTextInput({
    super.key,
    this.groupId = EditableText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.showCursor = true,
    this.autofocus = false,
    this.obscuringCharacter = "•",
    this.obscureText = false,
    this.autocorrect,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled = true,
    this.ignorePointers,
    this.keyboardAppearance,
    this.enableInteractiveSelection = true,
    this.onTap,
    this.onTapAlwaysCalled = false,
    this.scrollController,
    this.autofillHints,

    /// TODO: move these to SBBInputDecoration
    this.errorText,
    this.hintText,
    this.labelText,
    this.hintMaxLines,
    this.icon,
    this.suffixIcon,
  });

  /// {@macro flutter.widgets.editableText.groupId}
  final Object groupId;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType? keyboardType;

  /// {@macro flutter.widgets.TextField.textInputAction}
  final TextInputAction? textInputAction;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool showCursor;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.obscuringCharacter}
  final String obscuringCharacter;

  /// {@macro flutter.widgets.editableText.obscureText}
  final bool obscureText;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool? autocorrect;

  /// {@macro flutter.services.TextInputConfiguration.enableSuggestions}
  final bool enableSuggestions;

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

  /// {@macro flutter.widgets.editableText.onChanged}
  ///
  /// See also:
  ///
  ///  * [inputFormatters], which are called before [onChanged]
  ///    runs and can validate and change ("format") the input value.
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  final ValueChanged<String>? onSubmitted;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// If false the text field is "disabled". It ignores taps and its
  /// the disabled state properties are rendered.
  ///
  /// When a text field is disabled, all of its children widgets are also
  /// disabled, including the [SBBInputDecoration.trailing]. If you need to keep
  /// the trailing interactive while disabling the text field, consider using
  /// [readOnly] and [enableInteractiveSelection] instead:
  ///
  /// ```dart
  /// SBBTextInput(
  ///   enabled: true,
  ///   readOnly: true,
  ///   enableInteractiveSelection: false,
  ///   decoration: SBBInputDecoration(
  ///     trailing: IconButton(
  ///       onPressed: () {
  ///         // This will work because the SBBTextInput is enabled
  ///       },
  ///       icon: const Icon(Icons.edit_outlined),
  ///     ),
  ///   ),
  /// )
  /// ```
  final bool enabled;

  /// Determines whether this widget ignores pointer events.
  ///
  /// Defaults to null, and when null, does nothing.
  final bool? ignorePointers;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If unset, defaults to [ThemeData.brightness].
  final Brightness? keyboardAppearance;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// {@macro flutter.material.textfield.onTap}
  ///
  /// If [onTapAlwaysCalled] is enabled, this will also be called for consecutive
  /// taps.
  final GestureTapCallback? onTap;

  /// Whether [onTap] should be called for every tap.
  ///
  /// Defaults to false, so [onTap] is only called for each distinct tap. When
  /// enabled, [onTap] is called for every tap including consecutive taps.
  final bool onTapAlwaysCalled;

  /// {@macro flutter.widgets.editableText.scrollController}
  final ScrollController? scrollController;

  /// {@macro flutter.widgets.editableText.autofillHints}
  /// {@macro flutter.services.AutofillConfiguration.autofillHints}
  final Iterable<String>? autofillHints;

  /// Text that appears between the input field and the bottom border.
  final String? errorText;

  /// The label moves upward on focus.
  final String? labelText;

  /// The hint shows only in an empty field.
  ///
  /// It acts as a placeholder.
  final String? hintText;

  /// The maximum number of lines the [hintText] can occupy.
  final int? hintMaxLines;

  /// An icon to show before the input field and outside of the decoration's container.
  ///
  /// The decoration's container is the area which is underlined by the bottom underline of the SBBTextInput.
  ///
  /// The trailing edge of the icon is padded by 16px.
  final IconData? icon;

  /// An icon that appears after the editable part of the text field, within the text fields input decoration.
  final Widget? suffixIcon;

  @override
  State<StatefulWidget> createState() => _SBBTextInput();
}

class _SBBTextInput extends State<SBBTextInput> {
  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  TextEditingController? _controller;

  TextEditingController get controller => widget.controller ?? (_controller ??= TextEditingController());

  @override
  void initState() {
    super.initState();

    _effectiveFocusNode.canRequestFocus = widget.enabled;
    _effectiveFocusNode.addListener(_handleFocusChanged);
  }

  void _handleFocusChanged() {
    setState(() {
      // Rebuild widget on focus change to update accordingly.
    });
  }

  @override
  void didUpdateWidget(covariant SBBTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
    }
    _effectiveFocusNode.canRequestFocus = widget.enabled;

    if (widget.controller == null && oldWidget.controller != null) {
      _controller = TextEditingController.fromValue(oldWidget.controller!.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      _controller!.dispose();
      _controller = null;
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).textField;
    Widget child = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.icon != null)
          Padding(padding: const EdgeInsetsDirectional.only(top: 12, end: 8.0), child: Icon(widget.icon)),
        Expanded(child: _buildTextField()),
        if (widget.suffixIcon != null) widget.suffixIcon!,
      ],
    );

    if (widget.errorText != null) {
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child,
          Padding(
            padding: const EdgeInsets.only(bottom: 9.0),
            child: Text(widget.errorText!, style: style?.errorTextStyle),
          ),
        ],
      );
    }

    child = AnimatedContainer(
      duration: Durations.medium1,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color:
                (widget.errorText == null
                    ? _effectiveFocusNode.hasFocus
                          ? style?.dividerColorHighlighted
                          : SBBColors.transparent
                    : style?.dividerColorError) ??
                SBBColors.transparent,
          ),
        ),
      ),
      child: child,
    );

    return AnimatedSwitcher(duration: Durations.medium1, child: child);
  }

  TextField _buildTextField() {
    final textScaler = MediaQuery.of(context).textScaler;
    final style = SBBControlStyles.of(context).textField!;
    final hasError = widget.errorText?.isNotEmpty ?? false;
    final textStyle = _textStyle(widget.enabled, context);
    final labelStyle = style.placeholderTextStyle!;
    // adjust floating label style to get desired sizes
    final floatingLabelStyle = labelStyle.copyWith(fontSize: SBBTextStyles.helpersLabel.fontSize! * 1.335, height: 1.5);

    return TextField(
      groupId: widget.groupId,
      controller: controller,
      focusNode: _effectiveFocusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      readOnly: widget.readOnly,
      showCursor: widget.showCursor,
      autofocus: widget.autofocus,
      obscuringCharacter: widget.obscuringCharacter,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      ignorePointers: widget.ignorePointers,
      keyboardAppearance: widget.keyboardAppearance,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      onTap: widget.onTap,
      onTapAlwaysCalled: widget.onTapAlwaysCalled,
      scrollController: widget.scrollController,
      autofillHints: widget.autofillHints,

      /// TODO: change this to an SBBTextInputDecoration
      decoration: _decoration(textScaler, labelStyle, floatingLabelStyle),
      style: hasError ? textStyle.copyWith(color: SBBColors.red) : textStyle,

      /// TODO: check the effect without textScaler
      cursorHeight: textScaler.scale(22.0),
      cursorRadius: const Radius.circular(2.0),
    );
  }

  TextStyle _textStyle(bool enabled, BuildContext context) {
    final style = SBBControlStyles.of(context).textField;
    return (widget.enabled ? style?.textStyle : style?.textStyleDisabled)!;
  }

  InputDecoration _decoration(TextScaler textScaler, TextStyle labelStyle, TextStyle floatingLabelStyle) {
    final hasValueOrFocus = controller.text.isNotEmpty || _effectiveFocusNode.hasFocus;
    final hasLabel = widget.labelText?.isNotEmpty ?? false;
    final hasError = widget.errorText?.isNotEmpty ?? false;

    var topPadding = 0.0;
    var bottomPadding = 0.0;

    if (hasLabel && hasValueOrFocus) {
      topPadding = 5.0 + -2.0;

      if (hasError) {
        bottomPadding = 3.0;
      } else {
        bottomPadding = 9.0;
      }
    } else {
      topPadding = 14.0;

      if (hasError) {
        bottomPadding = 8.0;
      } else {
        bottomPadding = 14.0;
      }
    }
    return InputDecoration(
      isCollapsed: !hasValueOrFocus,
      isDense: true,
      labelText: widget.labelText,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      contentPadding: EdgeInsetsDirectional.only(
        top: textScaler.scale(topPadding),
        bottom: textScaler.scale(bottomPadding),
      ),
      floatingLabelStyle: floatingLabelStyle,
      labelStyle: labelStyle,
      hintText: widget.hintText,
      hintStyle: labelStyle,
      hintMaxLines: widget.hintMaxLines,
      alignLabelWithHint: true,
    );
  }
}
