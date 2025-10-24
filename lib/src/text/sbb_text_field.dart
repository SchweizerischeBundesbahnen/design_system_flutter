import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../sbb_design_system_mobile.dart';
import 'sbb_text_field_underline.dart';

/// The SBBTextField.
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
class SBBTextField extends StatefulWidget {
  const SBBTextField({
    super.key,
    this.controller,
    this.enabled = true,
    this.enableInteractiveSelection = true,
    this.errorText,
    this.hintText,
    this.inputFormatters,
    this.isLastElement = false,
    this.keyboardType,
    this.labelText,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.hintMaxLines,
    this.onChanged,
    this.onTap,
    this.onTapAlwaysCalled = false,
    this.onSubmitted,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.icon,
    this.focusNode,
    this.suffixIcon,
    this.obscureText = false,
    this.obscuringCharacter = "•",
    this.autofocus = false,
    this.autofillHints,
  });

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// If false the text field is "disabled".
  final bool enabled;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// Text that appears between the input field and the bottom border.
  final String? errorText;

  /// Behaves differently (separator) when last element.
  final bool isLastElement;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType? keyboardType;

  /// The label moves upward on focus.
  final String? labelText;

  /// The hint shows only in an empty field.
  ///
  /// It acts as a placeholder.
  final String? hintText;

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

  /// The maximum number of lines the [hintText] can occupy.
  final int? hintMaxLines;

  /// {@macro flutter.widgets.editableText.onChanged}
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.material.textfield.onTap}
  final GestureTapCallback? onTap;

  /// Whether [onTap] should be called for every tap.
  ///
  /// Defaults to false, so [onTap] is only called for each distinct tap. When
  /// enabled, [onTap] is called for every tap including consecutive taps.
  final bool onTapAlwaysCalled;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  final ValueChanged<String>? onSubmitted;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// {@macro flutter.widgets.TextField.textInputAction}
  final TextInputAction? textInputAction;

  /// An icon to show before the input field and outside of the decoration's container.
  ///
  /// The decoration's container is the area which is underlined by the bottom underline of the SBBTextField.
  ///
  /// The trailing edge of the icon is padded by 16px.
  final IconData? icon;

  /// Defines the keyboard focus for this widget.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// If null, this widget will create its own [FocusNode].
  final FocusNode? focusNode;

  /// An icon that appears after the editable part of the text field, within the text fields input decoration.
  final Widget? suffixIcon;

  /// {@macro flutter.widgets.editableText.obscuringCharacter}
  final String obscuringCharacter;

  /// {@macro flutter.widgets.editableText.obscureText}
  final bool obscureText;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.autofillHints}
  /// {@macro flutter.services.AutofillConfiguration.autofillHints}
  final Iterable<String>? autofillHints;

  @override
  State<StatefulWidget> createState() => _SBBTextField();
}

class _SBBTextField extends State<SBBTextField> {
  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  TextEditingController? _controller;

  late bool _isTextEmpty;

  TextEditingController get controller => widget.controller ?? (_controller ??= TextEditingController());

  @override
  void initState() {
    super.initState();

    _effectiveFocusNode.canRequestFocus = widget.enabled;
    _effectiveFocusNode.addListener(_handleFocusChanged);

    _isTextEmpty = controller.text.isEmpty;
    controller.addListener(_handleTextControllerChanged);
  }

  void _handleFocusChanged() {
    setState(() {});
  }

  void _handleTextControllerChanged() {
    if (controller.text.isEmpty != _isTextEmpty) {
      setState(() {
        _isTextEmpty = controller.text.isEmpty;
      });
    }
  }

  @override
  void didUpdateWidget(covariant SBBTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
    }

    if (widget.controller == null && oldWidget.controller != null) {
      _controller = TextEditingController.fromValue(oldWidget.controller!.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      _controller!.dispose();
      _controller = null;
    }

    if (widget.controller != oldWidget.controller) {
      (oldWidget.controller ?? _controller)?.removeListener(_handleTextControllerChanged);
      (widget.controller ?? _controller)?.addListener(_handleTextControllerChanged);
    }

    _effectiveFocusNode.canRequestFocus = widget.enabled;
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();
    controller.removeListener(_handleTextControllerChanged);
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.only(start: sbbDefaultSpacing, top: 0.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.icon != null)
          Padding(padding: const EdgeInsetsDirectional.only(top: 12, end: 8.0), child: Icon(widget.icon)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Expanded(child: _buildTextField()), if (widget.suffixIcon != null) widget.suffixIcon!],
              ),
              SBBTextFieldUnderline(
                errorText: widget.errorText,
                hasFocus: _effectiveFocusNode.hasFocus,
                isLastElement: widget.isLastElement,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  TextField _buildTextField() {
    final textScaler = MediaQuery.of(context).textScaler;
    final style = SBBControlStyles.of(context).textField!;
    final hasError = widget.errorText?.isNotEmpty ?? false;
    final textStyle = _textStyle(widget.enabled, context);
    final labelStyle = style.placeholderTextStyle!;
    // adjust floating label style to get desired sizes
    final floatingLabelStyle = labelStyle.copyWith(fontSize: SBBTextStyles.helpersLabel.fontSize! * 1.335, height: 1.5);

    return TextField(
      autofocus: widget.autofocus,
      focusNode: _effectiveFocusNode,
      controller: controller,
      obscureText: widget.obscureText,
      obscuringCharacter: widget.obscuringCharacter,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      cursorHeight: textScaler.scale(22.0),
      cursorRadius: const Radius.circular(2.0),
      enableInteractiveSelection: widget.enableInteractiveSelection,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onTapAlwaysCalled: widget.onTapAlwaysCalled,
      onSubmitted: widget.onSubmitted,
      enabled: widget.enabled,
      decoration: _decoration(textScaler, labelStyle, floatingLabelStyle),
      style: hasError ? textStyle.copyWith(color: SBBColors.red) : textStyle,
      inputFormatters: widget.inputFormatters,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
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
