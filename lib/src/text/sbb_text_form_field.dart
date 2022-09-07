import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../design_system_flutter.dart';
import 'sbb_text_field_underline.dart';

/// The SBB TextFormField.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/textfield>
/// * <https://digital.sbb.ch/de/design-system-mobile-new/seitentypen/form>
class SBBTextFormField extends StatefulWidget {
  const SBBTextFormField({
    Key? key,
    this.controller,
    this.enabled = true,
    this.enableInteractiveSelection = true,
    this.hintText,
    this.inputFormatters,
    this.isLastElement = false,
    this.keyboardType,
    this.labelText,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.onTap,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.icon,
    this.focusNode,
    this.suffixIcon,
    this.validator,
    this.obscureText = false,
    this.autofocus = false,
    this.initialValue,
    this.onSaved,
    this.onEditingComplete,
    this.onFieldSubmitted,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool enabled;
  final bool enableInteractiveSelection;

  /// Behaves differently (separator) when last element.
  final bool isLastElement;
  final TextInputType? keyboardType;

  /// The label moves upward on focus.
  final String? labelText;

  /// The hint shows only in an empty field.
  final String? hintText;
  final int maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final IconData? icon;

  final FocusNode? focusNode;

  final Widget? suffixIcon;

  /// Takes field value and returns error message or `null`
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool autofocus;
  final String? initialValue;
  final ValueChanged<String?>? onSaved;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<StatefulWidget> createState() => _SBBTextField();
}

class _SBBTextField extends State<SBBTextFormField> {
  late FocusNode _focus;
  bool _hasFocus = false;
  String? errorText;

  @override
  void initState() {
    super.initState();
    _focus = widget.focusNode ?? FocusNode();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _focus.hasFocus;
    });
  }

  @override
  void dispose() {
    // if we created our own focus node , dispose of it
    // otherwise, let the caller dispose of their own instance
    if (widget.focusNode == null) {
      _focus.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = SBBBaseStyle.of(context);
    final bool isWeb = SBBBaseStyle.of(context).hostPlatform == HostPlatform.web;
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 8.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.icon != null)
            Padding(
              padding: EdgeInsets.only(top: isWeb ? 20 : 12, right: 8.0),
              child: Icon(
                widget.icon,
                size: 24,
                color: style.themeValue(SBBColors.black, SBBColors.white),
              ),
            ),
          Expanded(
            child:
                isWeb ? _buildTextFormFieldWeb() : _buildTextFormFieldNative(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormFieldNative() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTextFormField(),
            SBBTextFieldUnderline(
              errorText: errorText,
              hasFocus: _hasFocus,
              isLastElement: widget.isLastElement,
            )
          ],
        ),
        if (widget.suffixIcon != null)
          Positioned(
            top: -4.0,
            right: 0.0,
            child: widget.suffixIcon!,
          )
      ],
    );
  }

  Widget _buildTextFormFieldWeb() {
    final hasLabel = widget.labelText?.isNotEmpty ?? false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasLabel)
                    Text(
                      '${widget.labelText}',
                      style: SBBWebTextStyles.small
                          .copyWith(color: SBBColors.granite),
                    ),
                  _buildTextFormField(),
                ],
              ),
            ),
            if (widget.suffixIcon != null)
              Padding(
                padding: EdgeInsetsDirectional.only(top: 20, start: 8),
                child: widget.suffixIcon,
              ),
          ],
        ),
      ],
    );
  }

  TextFormField _buildTextFormField() {
    final hasError = errorText?.isNotEmpty ?? false;
    final bool isWeb = SBBBaseStyle.of(context).hostPlatform == HostPlatform.web;
    final textField = SBBControlStyles.of(context).textField!;

    return TextFormField(
      validator: (value) {
        if (widget.validator != null) {
          final error = widget.validator!(value);
          setState(() {
            errorText = error;
          });
          return error;
        }
        return null;
      },
      obscureText: widget.obscureText,
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      focusNode: _focus,
      autofocus: widget.autofocus,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      cursorHeight: 19.0,
      cursorRadius: const Radius.circular(2.0),
      enableInteractiveSelection: widget.enableInteractiveSelection,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      enabled: widget.enabled,
      decoration: isWeb ? _inputDecorationWeb() : _inputDecorationNative(),
      style: isWeb && hasError
          ? textField.errorTextStyle
          : textField.textStyle,
      inputFormatters: widget.inputFormatters,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
    );
  }

  InputDecoration _inputDecorationWeb() {
    return InputDecoration(
      isDense: true,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          borderSide: BorderSide(color: SBBColors.graphite, width: 1.0)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          borderSide: BorderSide(color: SBBColors.iron, width: 1.0)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          borderSide: BorderSide(color: SBBColors.graphite, width: 1.0)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          borderSide: BorderSide(color: SBBColors.aluminum, width: 1.0)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          borderSide: BorderSide(color: SBBColors.red, width: 1.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          borderSide: BorderSide(color: SBBColors.red, width: 1.0)),
      // Hide default error since we have our own
      errorStyle: SBBWebTextStyles.small,
      errorText: errorText,
      contentPadding: EdgeInsetsDirectional.only(
        top: 12,
        bottom: 12,
        start: 12,
      ),
      labelStyle: SBBWebTextStyles.small.copyWith(color: SBBColors.granite),
      hintText: widget.hintText,
      hintStyle: SBBWebTextStyles.medium.copyWith(color: SBBColors.storm),
    );
  }

  InputDecoration _inputDecorationNative() {
    final textField = SBBControlStyles.of(context).textField!;
    return InputDecoration(
      labelText: widget.labelText,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      // Hide default error since we have our own
      errorStyle: const TextStyle(fontSize: 0, height: 0),
      errorText: errorText,
      focusedErrorBorder: InputBorder.none,
      contentPadding: widget.maxLines == 1
          ? const EdgeInsets.only(bottom: 2.0)
          : const EdgeInsets.only(bottom: 8.0),
      labelStyle: textField.placeholderTextStyle,
      hintText: widget.hintText,
      hintStyle: textField.placeholderTextStyle,
      floatingLabelStyle: textField.placeholderTextStyle,
    );
  }
}
