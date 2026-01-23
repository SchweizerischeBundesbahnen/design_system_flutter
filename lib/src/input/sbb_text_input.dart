import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../sbb_design_system_mobile.dart';
import 'decoration/sbb_input_decorator.dart';

// TODO: animate label and input when single line
// TODO: expose FloatingLabelBehavior
// TODO: think about case when multiline (center between baselines?)
// TODO: add themeData according to v5.0.0 with
// TODO: (add theme data and get effective in SBBTextInput)
// TODO: improve docs
// TODO: add migration guideline & CHANGELOG

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
    this.decoration,
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
  });

  /// {@macro flutter.widgets.editableText.groupId}
  final Object groupId;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// The decoration surrounding the underlying [EditableText] field.
  ///
  /// The values given for colors and text styles will override the values given in
  /// [SBBInputDecorationThemeData].
  final SBBInputDecoration? decoration;

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
  /// disabled, including the [SBBDecoration.trailing]. If you need to keep
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

  @override
  State<StatefulWidget> createState() => _SBBTextInputState();
}

class _SBBTextInputState extends State<SBBTextInput>
    implements TextSelectionGestureDetectorBuilderDelegate, AutofillClient {
  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  TextEditingController? _controller;

  TextEditingController get _effectiveController => widget.controller ?? (_controller ??= TextEditingController());

  late _SBBTextInputSelectionGestureDetectorBuilder _selectionGestureDetectorBuilder;

  bool _showSelectionHandles = false;

  late WidgetStatesController _statesController;

  @override
  final GlobalKey<EditableTextState> editableTextKey = GlobalKey<EditableTextState>();

  @override
  late bool forcePressEnabled;

  @override
  bool get selectionEnabled => widget.enableInteractiveSelection && widget.enabled;

  @override
  String get autofillId => _editableText!.autofillId;

  @override
  void autofill(TextEditingValue newEditingValue) => _editableText!.autofill(newEditingValue);

  @override
  TextInputConfiguration get textInputConfiguration {
    final List<String>? autofillHints = widget.autofillHints?.toList(growable: false);
    final AutofillConfiguration autofillConfiguration = autofillHints != null
        ? AutofillConfiguration(
            uniqueIdentifier: autofillId,
            autofillHints: autofillHints,
            currentEditingValue: _effectiveController.value,
            hintText: widget.decoration?.placeholderText,
          )
        : AutofillConfiguration.disabled;

    return _editableText!.textInputConfiguration.copyWith(
      autofillConfiguration: autofillConfiguration,
    );
  }

  @override
  void initState() {
    super.initState();
    _selectionGestureDetectorBuilder = _SBBTextInputSelectionGestureDetectorBuilder(state: this);

    _effectiveFocusNode.canRequestFocus = widget.enabled;
    _effectiveFocusNode.addListener(_handleFocusChanged);

    _statesController = WidgetStatesController(_computeStates());
  }

  @override
  void didUpdateWidget(covariant SBBTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller == null && oldWidget.controller != null) {
      _controller = TextEditingController.fromValue(oldWidget.controller!.value);
    } else if (widget.controller != null && oldWidget.controller == null) {
      _controller!.dispose();
      _controller = null;
    }

    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
    }
    _effectiveFocusNode.canRequestFocus = widget.enabled;

    if (_effectiveFocusNode.hasFocus && widget.readOnly != oldWidget.readOnly && widget.enabled) {
      if (_effectiveController.selection.isCollapsed) {
        _showSelectionHandles = !widget.readOnly;
      }
    }

    _updateStates();
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();
    _controller?.dispose();
    _statesController.dispose();
    super.dispose();
  }

  Set<WidgetState> _computeStates() {
    return <WidgetState>{
      if (!widget.enabled) WidgetState.disabled,
      if (_effectiveFocusNode.hasFocus) WidgetState.focused,
      if (_hasError) WidgetState.error,
    };
  }

  bool get _hasError => widget.decoration?.errorText != null || widget.decoration?.error != null;

  void _updateStates() {
    _statesController.value = _computeStates();
  }

  // The SBBTextInput does these things:
  // Determine the state and hand down the WidgetStates to SBBInputDecorator
  // (Determine effective decoration values by comparing to theme)
  // Build EditableText with platform specific controls
  // Build the text selection gesture controls
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    final theme = Theme.of(context);
    final DefaultSelectionStyle selectionStyle = DefaultSelectionStyle.of(context);

    final style = SBBControlStyles.of(context).textField!;
    final bool isMultiline = (widget.maxLines ?? 0) != 1;

    // determine platform specific properties (selection controls, cursor)
    TextSelectionControls? textSelectionControls;
    final bool paintCursorAboveText;
    final bool cursorOpacityAnimates;
    Offset? cursorOffset;
    final Color cursorColor = selectionStyle.cursorColor ?? theme.colorScheme.primary;
    final Color selectionColor = selectionStyle.selectionColor ?? theme.colorScheme.primary.withValues(alpha: 0.4);
    final SpellCheckConfiguration spellCheckConfiguration;
    final Brightness keyboardAppearance = widget.keyboardAppearance ?? theme.brightness;

    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        forcePressEnabled = true;
        textSelectionControls = cupertinoTextSelectionHandleControls;
        paintCursorAboveText = true;
        cursorOpacityAnimates = true;
        cursorOffset = Offset(iOSHorizontalOffset / MediaQuery.devicePixelRatioOf(context), 0);
        spellCheckConfiguration = CupertinoTextField.inferIOSSpellCheckConfiguration(null);

      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        forcePressEnabled = false;
        textSelectionControls ??= materialTextSelectionHandleControls;
        paintCursorAboveText = false;
        cursorOpacityAnimates = false;
        spellCheckConfiguration = TextField.inferAndroidSpellCheckConfiguration(null);
    }

    final textStyle = _textStyle(widget.enabled, context);
    final labelStyle = style.placeholderTextStyle!;
    // adjust floating label style to get desired sizes
    final floatingLabelStyle = labelStyle.copyWith(fontSize: SBBTextStyles.helpersLabel.fontSize! * (1 / 0.75));
    Widget editableText = EditableText(
      key: editableTextKey,
      readOnly: widget.readOnly || !widget.enabled,
      showCursor: widget.showCursor,
      showSelectionHandles: _showSelectionHandles,
      controller: _effectiveController,
      focusNode: _effectiveFocusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      style: _hasError ? textStyle.copyWith(color: SBBColors.error) : textStyle,
      autofocus: widget.autofocus,
      obscuringCharacter: widget.obscuringCharacter,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      selectionColor: _effectiveFocusNode.hasFocus ? selectionColor : null,
      selectionControls: widget.enableInteractiveSelection ? textSelectionControls : null,
      onChanged: widget.onChanged,
      onSelectionChanged: _handleSelectionChanged,
      onSubmitted: widget.onSubmitted,
      groupId: widget.groupId,
      onSelectionHandleTapped: _handleSelectionHandleTapped,
      inputFormatters: widget.inputFormatters,
      rendererIgnoresPointer: true,
      cursorOpacityAnimates: cursorOpacityAnimates,
      cursorOffset: cursorOffset,
      paintCursorAboveText: paintCursorAboveText,
      contextMenuBuilder: _defaultContextMenuBuilder,
      cursorColor: cursorColor,
      backgroundCursorColor: CupertinoColors.inactiveGray,
      keyboardAppearance: keyboardAppearance,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      scrollController: widget.scrollController,
      autofillHints: widget.autofillHints,
      autofillClient: this,
      restorationId: 'editable',
      spellCheckConfiguration: spellCheckConfiguration,
      magnifierConfiguration: TextMagnifier.adaptiveMagnifierConfiguration,
    );

    return _selectionGestureDetectorBuilder.buildGestureDetector(
      behavior: HitTestBehavior.translucent,
      child: AnimatedBuilder(
        animation: _effectiveController,
        builder: (context, child) {
          return Semantics(
            enabled: widget.enabled,
            currentValueLength: _effectiveController.text.characters.length,
            onTap: widget.readOnly
                ? null
                : () {
                    if (!_effectiveController.selection.isValid) {
                      _effectiveController.selection = TextSelection.collapsed(
                        offset: _effectiveController.text.length,
                      );
                    }
                    _requestKeyboard();
                  },
            onFocus: widget.enabled
                ? () {
                    assert(
                      _effectiveFocusNode.canRequestFocus,
                      'Received SemanticsAction.focus from the engine. However, the FocusNode '
                      'of this text field cannot gain focus. This likely indicates a bug. '
                      'If this text field cannot be focused (e.g. because it is not '
                      'enabled), then its corresponding semantics node must be configured '
                      'such that the assistive technology cannot request focus on it.',
                    );

                    if (_effectiveFocusNode.canRequestFocus && !_effectiveFocusNode.hasFocus) {
                      _effectiveFocusNode.requestFocus();
                    } else if (!widget.readOnly) {
                      _requestKeyboard();
                    }
                  }
                : null,
            child: AnimatedBuilder(
              animation: Listenable.merge(<Listenable>[_effectiveFocusNode, _effectiveController]),
              builder: (BuildContext context, Widget? child) {
                return SBBInputDecorator(
                  decoration: _getEffectiveDecoration(style: style),
                  expands: widget.expands,
                  isMultiline: isMultiline,
                  isEmpty: _effectiveController.text.isEmpty,
                  states: _statesController.value,
                  child: child,
                );
              },
              child: editableText,
            ),
          );
        },
      ),
    );
  }

  void _requestKeyboard() {
    _editableText?.requestKeyboard();
  }

  TextStyle _textStyle(bool enabled, BuildContext context) {
    final style = SBBControlStyles.of(context).textField;
    return (widget.enabled ? style?.textStyle : style?.textStyleDisabled)!;
  }

  SBBInputDecoration _getEffectiveDecoration({SBBTextFieldStyle? style}) {
    return (widget.decoration ?? SBBInputDecoration()).copyWith(
      borderColor: WidgetStatePropertyAll(
        _hasError
            ? SBBColors.error
            : _effectiveFocusNode.hasFocus
            ? SBBColors.granite
            : SBBColors.transparent,
      ),
    );
  }

  EditableTextState? get _editableText => editableTextKey.currentState;

  bool _shouldShowSelectionHandles(SelectionChangedCause? cause) {
    // When the text field is activated by something that doesn't trigger the
    // selection toolbar, we shouldn't show the handles either.
    if (!_selectionGestureDetectorBuilder.shouldShowSelectionToolbar ||
        !_selectionGestureDetectorBuilder.shouldShowSelectionHandles) {
      return false;
    }

    if (cause == SelectionChangedCause.keyboard) {
      return false;
    }

    if (widget.readOnly && _effectiveController.selection.isCollapsed) {
      return false;
    }

    if (!widget.enabled) {
      return false;
    }

    if (cause == SelectionChangedCause.longPress || cause == SelectionChangedCause.stylusHandwriting) {
      return true;
    }

    if (_effectiveController.text.isNotEmpty) {
      return true;
    }

    return false;
  }

  void _handleFocusChanged() {
    _updateStates();
    setState(() {
      // Rebuild widget on focus change to update accordingly.
    });
  }

  void _handleSelectionHandleTapped() {
    if (_effectiveController.selection.isCollapsed) {
      _editableText!.toggleToolbar();
    }
  }

  void _handleSelectionChanged(TextSelection selection, SelectionChangedCause? cause) {
    final bool willShowSelectionHandles = _shouldShowSelectionHandles(cause);
    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() {
        _showSelectionHandles = willShowSelectionHandles;
      });
    }

    if (cause == SelectionChangedCause.longPress) {
      _editableText?.bringIntoView(selection.extent);
    }

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        break;
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        if (cause == SelectionChangedCause.drag) {
          _editableText?.hideToolbar();
        }
    }
  }

  Widget _defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    if (defaultTargetPlatform == TargetPlatform.iOS && SystemContextMenu.isSupported(context)) {
      return SystemContextMenu.editableText(editableTextState: editableTextState);
    }
    return AdaptiveTextSelectionToolbar.editableText(editableTextState: editableTextState);
  }
}

class _SBBTextInputSelectionGestureDetectorBuilder extends TextSelectionGestureDetectorBuilder {
  _SBBTextInputSelectionGestureDetectorBuilder({required _SBBTextInputState state})
    : _state = state,
      super(delegate: state);

  final _SBBTextInputState _state;

  @override
  bool get onUserTapAlwaysCalled => _state.widget.onTapAlwaysCalled;

  @override
  void onUserTap() {
    _state.widget.onTap?.call();
  }
}
