import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../design_system_flutter.dart';
import 'sbb_text_field_underline.dart';

/// The SBB TextField. Use according to documentation.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/textfield>
class SBBTextField extends StatefulWidget {
  const SBBTextField({
    Key? key,
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
    this.hintMaxLines,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.icon,
    this.focusNode,
    this.suffixIcon,
    this.obscureText = false,
    this.autofocus = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool enabled;
  final bool enableInteractiveSelection;
  final String? errorText;

  /// Behaves differently (separator) when last element.
  final bool isLastElement;
  final TextInputType? keyboardType;

  /// The label moves upward on focus.
  final String? labelText;

  /// The hint shows only in an empty field.
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final int? hintMaxLines;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final IconData? icon;

  final FocusNode? focusNode;

  final Widget? suffixIcon;

  final bool obscureText;
  final bool autofocus;

  @override
  State<StatefulWidget> createState() => _SBBTextField();
}

class _SBBTextField extends State<SBBTextField> {
  late FocusNode _focus;
  bool _hasFocus = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    _focus = widget.focusNode ?? FocusNode();
    _focus.addListener(_onFocusChange);
    controller = widget.controller ?? TextEditingController();
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
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: sbbDefaultSpacing,
        top: 0.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.icon != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 12, end: 8.0),
              child: Icon(widget.icon),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildTextField(),
                    ),
                    if (widget.suffixIcon != null) widget.suffixIcon!,
                  ],
                ),
                SBBTextFieldUnderline(
                  errorText: widget.errorText,
                  hasFocus: _hasFocus,
                  isLastElement: widget.isLastElement,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextField _buildTextField() {
    final textScaler = MediaQuery.of(context).textScaler;
    final style = SBBControlStyles.of(context).textField!;
    final hasError = widget.errorText?.isNotEmpty ?? false;
    final textStyle = _textStyle(widget.enabled, context);
    final labelStyle = style.placeholderTextStyle!;
    // adjust floating label style to get desired sizes
    final floatingLabelStyle = labelStyle.copyWith(
      fontSize: SBBTextStyles.helpersLabel.fontSize! * 1.335,
      height: 1.5,
    );

    return TextField(
      autofocus: widget.autofocus,
      focusNode: _focus,
      controller: controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      cursorHeight: textScaler.scale(22.0),
      cursorRadius: const Radius.circular(2.0),
      enableInteractiveSelection: widget.enableInteractiveSelection,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onSubmitted: widget.onSubmitted,
      enabled: widget.enabled,
      decoration: _decoration(textScaler, labelStyle, floatingLabelStyle),
      style: hasError ? textStyle.copyWith(color: SBBColors.red) : textStyle,
      inputFormatters: widget.inputFormatters,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
    );
  }

  TextStyle _textStyle(bool enabled, BuildContext context) {
    final style = SBBControlStyles.of(context).textField;
    return (widget.enabled ? style?.textStyle : style?.textStyleDisabled)!;
  }

  InputDecoration _decoration(
    TextScaler textScaler,
    TextStyle labelStyle,
    TextStyle floatingLabelStyle,
  ) {
    final hasValueOrFocus = controller.text.isNotEmpty || _hasFocus;
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
