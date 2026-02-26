import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../sbb_design_system_mobile.dart';

// TODO: add tests
// TODO: documentation & migration guide

/// The SBB TextFormField.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/textfield>
/// * <https://digital.sbb.ch/de/design-system-mobile-new/seitentypen/form>
class SBBTextInputFormField extends FormField<String> {
  SBBTextInputFormField({
    super.key,
    // FIELDS FROM SBBTextInput
    this.groupId = EditableText,
    this.controller,
    SBBInputDecoration? decoration,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization textCapitalization = .none,
    bool readOnly = false,
    bool showCursor = true,
    bool autofocus = false,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    bool enableSuggestions = true,
    int? maxLines = 1,
    int? minLines,
    bool expands = false,
    bool selectAllOnFocus = false,
    List<TextInputFormatter>? inputFormatters,
    bool? ignorePointers,
    Brightness? keyboardAppearance,
    bool enableInteractiveSelection = true,
    GestureTapCallback? onTap,
    bool onTapAlwaysCalled = false,
    ScrollController? scrollController,
    Iterable<String>? autofillHints,
    TextStyle? inputTextStyle,
    WidgetStateProperty<Color?>? inputForegroundColor,
    bool? enableClearButton,
    // FIELDS FROM FormField
    String? initialValue,
    this.onChanged,
    ValueChanged<String>? onFieldSubmitted,
    super.enabled,
    super.forceErrorText,
    super.onSaved,
    super.validator,
    super.errorBuilder,
    Widget Function(FormFieldState<String>)? builder,
    AutovalidateMode? autovalidateMode,
    super.restorationId,
  }) : assert(initialValue == null || controller == null),
       assert(obscuringCharacter.length == 1),
       assert(maxLines == null || maxLines > 0),
       assert(minLines == null || minLines > 0),
       assert(
         (maxLines == null) || (minLines == null) || (maxLines >= minLines),
         "minLines can't be greater than maxLines",
       ),
       assert(
         !expands || (maxLines == null && minLines == null),
         'minLines and maxLines must be null when expands is true.',
       ),
       assert(!obscureText || maxLines == 1, 'Obscured fields cannot be multiline.'),
       super(
         initialValue: controller != null ? controller.text : (initialValue ?? ''),
         autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
         builder:
             builder ??
             (FormFieldState<String> field) {
               final _SBBTextInputFormFieldState state = field as _SBBTextInputFormFieldState;

               SBBInputDecoration effectiveDecoration = decoration ?? const SBBInputDecoration();
               final String? errorText = field.errorText;
               if (errorText != null) {
                 effectiveDecoration = errorBuilder != null
                     ? effectiveDecoration.copyWith(error: errorBuilder(state.context, errorText))
                     : effectiveDecoration.copyWith(errorText: errorText);
               }

               void onChangedHandler(String value) {
                 field.didChange(value);
                 onChanged?.call(value);
               }

               return SBBTextInput(
                 groupId: groupId,
                 controller: state._effectiveController,
                 decoration: effectiveDecoration,
                 focusNode: focusNode,
                 keyboardType: keyboardType,
                 textInputAction: textInputAction,
                 textCapitalization: textCapitalization,
                 readOnly: readOnly,
                 showCursor: showCursor,
                 autofocus: autofocus,
                 obscuringCharacter: obscuringCharacter,
                 obscureText: obscureText,
                 autocorrect: autocorrect,
                 enableSuggestions: enableSuggestions,
                 maxLines: maxLines,
                 minLines: minLines,
                 expands: expands,
                 onChanged: onChangedHandler,
                 onSubmitted: onFieldSubmitted,
                 inputFormatters: inputFormatters,
                 enabled: enabled,
                 selectAllOnFocus: selectAllOnFocus,
                 ignorePointers: ignorePointers,
                 keyboardAppearance: keyboardAppearance,
                 enableInteractiveSelection: enableInteractiveSelection,
                 onTap: onTap,
                 onTapAlwaysCalled: onTapAlwaysCalled,
                 scrollController: scrollController,
                 autofillHints: autofillHints,
                 inputTextStyle: inputTextStyle,
                 inputForegroundColor: inputForegroundColor,
                 enableClearButton: enableClearButton,
               );
             },
       );

  /// {@macro flutter.widgets.editableText.groupId}
  final Object groupId;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  final TextEditingController? controller;

  /// Called when the user initiates a change to the SBBTextInput's
  /// value: when they have inserted or deleted text or reset the form.
  final ValueChanged<String>? onChanged;

  @override
  FormFieldState<String> createState() => _SBBTextInputFormFieldState();
}

class _SBBTextInputFormFieldState extends FormFieldState<String> {
  TextEditingController? _controller;

  TextEditingController get _effectiveController => _textInputFormField.controller ?? _controller!;

  SBBTextInputFormField get _textInputFormField => super.widget as SBBTextInputFormField;

  @override
  void initState() {
    super.initState();
    if (_textInputFormField.controller == null) {
      _createLocalController(widget.initialValue != null ? TextEditingValue(text: widget.initialValue!) : null);
    } else {
      _textInputFormField.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(SBBTextInputFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_textInputFormField.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      _textInputFormField.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && _textInputFormField.controller == null) {
        _createLocalController(oldWidget.controller!.value);
      }

      if (_textInputFormField.controller != null) {
        setValue(_textInputFormField.controller!.text);
        if (oldWidget.controller == null) {
          _controller!.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    _textInputFormField.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.value = TextEditingValue(text: value ?? '');
    }
  }

  @override
  void reset() {
    // Set the controller value before calling super.reset() to let
    // _handleControllerChanged suppress the change.
    _effectiveController.value = TextEditingValue(text: widget.initialValue ?? '');
    super.reset();
    _textInputFormField.onChanged?.call(_effectiveController.text);
  }

  void _createLocalController(TextEditingValue? value) {
    assert(_controller == null);
    _controller = value == null ? TextEditingController() : TextEditingController.fromValue(value);
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}

class SBBTextInputBoxedFormField extends SBBTextInputFormField {
  SBBTextInputBoxedFormField({
    super.key,
    // FIELDS FROM SBBTextInput
    super.groupId = EditableText,
    super.controller,
    super.decoration,
    super.focusNode,
    super.keyboardType,
    super.textInputAction,
    super.textCapitalization,
    super.readOnly,
    super.showCursor,
    super.autofocus,
    super.obscuringCharacter,
    super.obscureText,
    super.autocorrect,
    super.enableSuggestions,
    super.maxLines,
    super.minLines,
    super.expands,
    super.selectAllOnFocus,
    super.inputFormatters,
    super.ignorePointers,
    super.keyboardAppearance,
    super.enableInteractiveSelection,
    super.onTap,
    super.onTapAlwaysCalled,
    super.scrollController,
    super.autofillHints,
    super.inputTextStyle,
    super.inputForegroundColor,
    super.enableClearButton,
    // FIELDS FROM FormField
    super.initialValue,
    super.onChanged,
    super.onFieldSubmitted,
    super.enabled,
    super.forceErrorText,
    super.onSaved,
    super.validator,
    super.errorBuilder,
    super.autovalidateMode,
    super.restorationId,
  }) : assert(initialValue == null || controller == null),
       assert(obscuringCharacter.length == 1),
       assert(maxLines == null || maxLines > 0),
       assert(minLines == null || minLines > 0),
       assert(
         (maxLines == null) || (minLines == null) || (maxLines >= minLines),
         "minLines can't be greater than maxLines",
       ),
       assert(
         !expands || (maxLines == null && minLines == null),
         'minLines and maxLines must be null when expands is true.',
       ),
       assert(!obscureText || maxLines == 1, 'Obscured fields cannot be multiline.'),
       super(
         builder: (FormFieldState<String> field) {
           final _SBBTextInputFormFieldState state = field as _SBBTextInputFormFieldState;

           SBBInputDecoration effectiveDecoration = decoration ?? const SBBInputDecoration();
           final String? errorText = field.errorText;
           if (errorText != null) {
             effectiveDecoration = errorBuilder != null
                 ? effectiveDecoration.copyWith(error: errorBuilder(state.context, errorText))
                 : effectiveDecoration.copyWith(errorText: errorText);
           }

           void onChangedHandler(String value) {
             field.didChange(value);
             onChanged?.call(value);
           }

           return SBBTextInputBoxed(
             groupId: groupId,
             controller: state._effectiveController,
             decoration: effectiveDecoration,
             focusNode: focusNode,
             keyboardType: keyboardType,
             textInputAction: textInputAction,
             textCapitalization: textCapitalization,
             readOnly: readOnly,
             showCursor: showCursor,
             autofocus: autofocus,
             obscuringCharacter: obscuringCharacter,
             obscureText: obscureText,
             autocorrect: autocorrect,
             enableSuggestions: enableSuggestions,
             maxLines: maxLines,
             minLines: minLines,
             expands: expands,
             onChanged: onChangedHandler,
             onSubmitted: onFieldSubmitted,
             inputFormatters: inputFormatters,
             enabled: enabled,
             selectAllOnFocus: selectAllOnFocus,
             ignorePointers: ignorePointers,
             keyboardAppearance: keyboardAppearance,
             enableInteractiveSelection: enableInteractiveSelection,
             onTap: onTap,
             onTapAlwaysCalled: onTapAlwaysCalled,
             scrollController: scrollController,
             autofillHints: autofillHints,
             inputTextStyle: inputTextStyle,
             inputForegroundColor: inputForegroundColor,
             enableClearButton: enableClearButton,
           );
         },
       );
}
