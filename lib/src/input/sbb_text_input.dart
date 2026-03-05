import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sbb_design_system_mobile/src/input/theme/default_sbb_input_decoration_theme_data.dart';

import '../../sbb_design_system_mobile.dart';
import 'decoration/sbb_input_decorator.dart';

/// The SBB TextInput.
///
/// A customizable text input field that supports both single-line and multiline modes
/// with optional leading and trailing icons, error states, and validation.
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
/// * [inputFormatters]: Customize input validation and formatting. These are called
///   before [onChanged] and can validate or transform the input value.
/// * [onTap]: Called when the text field is tapped. Use [onTapAlwaysCalled] to receive
///   this callback for every tap, including consecutive taps.
/// * [enabled]: Controls whether the text field is interactive. When false, the field
///   is disabled and its children (including trailing icons) are also disabled.
///   Use [readOnly] and [enableInteractiveSelection] if you need to keep trailing widgets
///   interactive while disabling the text field.
/// * [ignorePointers]: Determines whether the widget ignores pointer events (taps, etc.).
///
/// See also:
/// * [SBBTextInputThemeData] for customizing the style across the current theme
/// * [SBBInputDecoration] for customizing the decoration surrounding the raw input field
/// * [digital.sbb.ch documenation](https://digital.sbb.ch/de/design-system/mobile/components/text-input/)
/// * [Figma design guidelines](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=309-2236) (internal only)
class SBBTextInput extends StatefulWidget {
  const SBBTextInput({
    super.key,
    this.groupId = EditableText,
    this.controller,
    this.decoration,
    this.focusNode,
    TextInputType? keyboardType,
    this.textInputAction,
    this.textCapitalization = .none,
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
    this.selectAllOnFocus = false,
    this.ignorePointers,
    this.keyboardAppearance,
    bool? enableInteractiveSelection,
    this.onTap,
    this.onTapAlwaysCalled = false,
    this.scrollController,
    this.autofillHints,
    this.inputTextStyle,
    this.inputForegroundColor,
    this.enableClearButton,
  }) : assert(obscuringCharacter.length == 1),
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
       assert(
         !identical(textInputAction, TextInputAction.newline) ||
             maxLines == 1 ||
             !identical(keyboardType, TextInputType.text),
         'Use keyboardType TextInputType.multiline when using TextInputAction.newline on a multiline TextField.',
       ),
       keyboardType = keyboardType ?? (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
       enableInteractiveSelection = enableInteractiveSelection ?? (!readOnly || !obscureText);

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

  /// {@macro flutter.widgets.editableText.selectAllOnFocus}
  final bool? selectAllOnFocus;

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

  /// The text style for the input text.
  ///
  /// If null, the value from [SBBTextInputThemeData.inputTextStyle] is used.
  /// If that is also null, the default text style is used.
  final TextStyle? inputTextStyle;

  /// The color of the input text.
  ///
  /// If null, the value from [SBBTextInputThemeData.inputForegroundColor] is used.
  /// If that is also null, the default color is used.
  final WidgetStateProperty<Color?>? inputForegroundColor;

  /// Whether to show a [SBBIcons.cross_tiny_small] tappable icon instead of this [decoration.trailingIconData]
  /// when the input is not empty and has focus.
  ///
  /// This only replaces the icon given in [decoration.trailingIconData]. Custom trailing widgets
  /// via [decoration.trailing] are not replaced.
  ///
  /// This setting can be overridden in the [SBBTextInputThemeData].
  ///
  /// Defaults to true.
  final bool? enableClearButton;

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

    _statesController = WidgetStatesController();
    _updateStates();
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

  bool get _hasError => widget.decoration?.errorText != null || widget.decoration?.error != null;

  void _updateStates() {
    _statesController.update(WidgetState.disabled, !widget.enabled);
    _statesController.update(WidgetState.focused, _effectiveFocusNode.hasFocus);
    _statesController.update(WidgetState.error, _hasError);
  }

  // The SBBTextInput does three things:
  // 1. Determine the WidgetStates and hand down the WidgetStates to SBBInputDecorator for color resolving
  // 2. Build styled EditableText with platform specific look (mainly cursor)
  // 3. Build the text selection gesture controls
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    final theme = Theme.of(context);
    final DefaultSelectionStyle selectionStyle = DefaultSelectionStyle.of(context);

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

    final effectiveInputTextStyle = _effectiveInputTextStyle(context);

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
      style: effectiveInputTextStyle,
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
      selectAllOnFocus: widget.selectAllOnFocus,
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

    return TextFieldTapRegion(
      child: IgnorePointer(
        ignoring: widget.ignorePointers ?? false,
        child: _selectionGestureDetectorBuilder.buildGestureDetector(
          behavior: .translucent,
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
                  builder: (context, Widget? child) {
                    return SBBInputDecorator(
                      decoration: _getEffectiveDecorationWithClearButton(context),
                      expands: widget.expands,
                      minInputHeight: effectiveInputTextStyle.height! * effectiveInputTextStyle.fontSize!,
                      isMultiline: isMultiline,
                      isEmpty: _effectiveController.text.isEmpty,
                      isBoxed: isBoxed,
                      states: Set<WidgetState>.from(_statesController.value),
                      child: child,
                    );
                  },
                  child: editableText,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _requestKeyboard() {
    _editableText?.requestKeyboard();
  }

  TextStyle _effectiveInputTextStyle(BuildContext context) {
    final themeData = Theme.of(context).sbbTextInputTheme;
    final states = _statesController.value;

    if (widget.inputTextStyle != null) {
      final textStyle = widget.inputTextStyle;
      final color = widget.inputForegroundColor?.resolve(states);
      return color != null ? textStyle!.copyWith(color: color) : textStyle!;
    }

    final textStyle = themeData!.inputTextStyle;
    final color = widget.inputForegroundColor?.resolve(states) ?? themeData.inputForegroundColor?.resolve(states);
    return color != null ? textStyle!.copyWith(color: color) : textStyle!;
  }

  SBBInputDecoration _getEffectiveDecorationWithClearButton(BuildContext context) {
    final themeData = Theme.of(context).sbbTextInputTheme;
    final effectiveShowClearButton = widget.enableClearButton ?? themeData?.enableClearButton ?? true;

    final baseDecoration = widget.decoration ?? SBBInputDecoration();

    if (baseDecoration.trailing != null || !effectiveShowClearButton) return baseDecoration;

    final shouldReplaceTrailingWithClearButton = _effectiveFocusNode.hasFocus && _effectiveController.text.isNotEmpty;

    final inputDecorationTheme = Theme.of(context).sbbInputDecorationTheme;
    final Widget trailing = widget.decoration?.trailingIconData == null
        ? SizedBox.shrink()
        : Padding(
            padding: .only(left: _effectiveTrailingInputGap(inputDecorationTheme)),
            child: Icon(widget.decoration!.trailingIconData),
          );

    return baseDecoration.copyWith(
      trailing: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: shouldReplaceTrailingWithClearButton
            ? Material(
                color: Colors.transparent,
                child: Ink(
                  width: 24.0,
                  height: 24.0,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () {
                      _effectiveController.clear();
                      widget.onChanged?.call('');
                    },
                    child: Icon(
                      SBBIcons.cross_tiny_small,
                      size: 24.0,
                    ),
                  ),
                ),
              )
            : trailing,
      ),
    );
  }

  EditableTextState? get _editableText => editableTextKey.currentState;

  bool get isBoxed => false;

  bool _shouldShowSelectionHandles(SelectionChangedCause? cause) {
    // When the text field is activated by something that doesn't trigger the
    // selection toolbar, we shouldn't show the handles either.
    if (!_selectionGestureDetectorBuilder.shouldShowSelectionToolbar ||
        !_selectionGestureDetectorBuilder.shouldShowSelectionHandles) {
      return false;
    }

    if (cause == .keyboard) {
      return false;
    }

    if (widget.readOnly && _effectiveController.selection.isCollapsed) {
      return false;
    }

    if (!widget.enabled) {
      return false;
    }

    if (cause == .longPress || cause == .stylusHandwriting) {
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

    if (cause == .longPress) {
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
        if (cause == .drag) {
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

  double _effectiveTrailingInputGap(SBBInputDecorationThemeData? inputDecorationTheme) {
    return widget.decoration?.inputTrailingGap ?? inputDecorationTheme?.inputTrailingGap ?? defaultInputTrailingGap;
  }
}

/// The boxed variant of [SBBTextInput].
///
/// This has mainly two effects:
/// * if no [decoration.contentPadding] is given, a default padding of
/// [EdgeInsets.symmetric(horizontal: SBBSpacing.medium)] will be applied.
/// * the border of the input decoration will only show if it has an error and in a surrounding manner.
class SBBTextInputBoxed extends SBBTextInput {
  SBBTextInputBoxed({
    super.key,
    super.groupId,
    super.controller,
    SBBInputDecoration? decoration,
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
    super.onChanged,
    super.onSubmitted,
    super.inputFormatters,
    super.enabled,
    super.selectAllOnFocus,
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
  }) : super(
         decoration: decoration?.contentPadding != null
             ? decoration
             : (decoration ?? SBBInputDecoration()).copyWith(
                 contentPadding: .symmetric(horizontal: SBBSpacing.medium),
               ),
       );

  @override
  State<SBBTextInput> createState() => _SBBTextInputStateBoxed();
}

class _SBBTextInputStateBoxed extends _SBBTextInputState {
  @override
  bool get isBoxed => true;

  @override
  Widget build(BuildContext context) {
    return SBBContentBox(child: super.build(context));
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
