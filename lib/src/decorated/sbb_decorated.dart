import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';
import 'package:sbb_design_system_mobile/src/input/decoration/sbb_input_decorator.dart';
import 'package:sbb_design_system_mobile/src/shared/debug.dart';
import 'package:sbb_design_system_mobile/src/shared/utils.dart';

/// The SBB Decorated.
///
/// Decorates an arbitrary widget with the same look as a text input: a floating label,
/// leading and trailing widgets, and an error message. Use this widget to display
/// content that is not text in the same visual style as a text input field.
///
/// Where [SBBDecoratedText] displays a [String] and [SBBTextInput] an editable text,
/// this widget places whatever you give it in the input slot.
///
/// ## Emptiness
///
/// The field is empty when [child] is null, and the label rests in its centered
/// position. Providing a [child] floats the label. A child that renders nothing,
/// such as `SizedBox.shrink()`, still counts as content and floats the label — pass
/// null rather than an empty widget to represent "no value".
///
/// ## Interaction Model
///
/// Like [SBBDecoratedText], this widget uses [InkWell] for tap interaction, and is
/// disabled when [onTap] is null. A disabled field greys out its label, its affixes
/// and its [child]. To display a field that looks enabled but does nothing on tap,
/// pass an empty callback.
///
/// The field counts as focused when the widget itself or any descendant of [child]
/// holds focus, so a child that manages its own focus floats the label as expected.
///
/// ## Sizing
///
/// The field is as tall as its content, bounded below by [minContentHeight] and by the
/// minimum height of an input field. Set [expands] to fill the available vertical
/// space instead, which also anchors the error message to the bottom of the field.
///
/// ## Key Properties
///
/// * [child]: The content to display, or null when there is no value
/// * [onTap]: Called when the widget is tapped. Provides visual feedback via InkWell
/// * [decoration]: Customizes the decoration surrounding the content, including icons,
///   labels, and error states
/// * [minContentHeight], [expands]: Control the height of the content
/// * [topAlignAffixes]: Top-aligns the leading and trailing widgets for tall content
///
/// See also:
/// * [SBBDecoratedText] for displaying a static [String]
/// * [SBBTextInput] for an editable text field with similar styling
/// * [SBBInputDecoration] for customizing the decoration surrounding the content
/// * [SBBDecoratedStyle] for customizing the visual appearance
class SBBDecorated extends StatefulWidget {
  const SBBDecorated({
    super.key,
    this.child,
    this.onTap,
    this.decoration,
    this.focusNode,
    this.autofocus = false,
    this.minContentHeight = 0.0,
    this.expands = false,
    this.topAlignAffixes = false,
    this.style,
  }) : assert(minContentHeight >= 0.0, 'minContentHeight must not be negative.');

  /// The content displayed in the input slot of the decoration.
  ///
  /// When null, the field is empty and the label rests in its centered position.
  /// Any non-null widget counts as content and floats the label, including one that
  /// renders nothing.
  final Widget? child;

  /// The decoration surrounding the displayed content.
  ///
  /// Includes styling for labels, icons, error states, and other visual elements.
  /// See [SBBInputDecoration] for customization options.
  final SBBInputDecoration? decoration;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// The minimum height reserved for the content.
  ///
  /// Defaults to 0.0, letting the content determine its own height. The field is
  /// never shorter than [SBBInputDecoration.minInputFieldHeight] regardless of this
  /// value.
  final double minContentHeight;

  /// Whether the field should expand to fill the available vertical space.
  ///
  /// When true, the error message is anchored to the bottom of the field instead of
  /// sitting directly below the content. Requires a bounded height from the parent.
  final bool expands;

  /// Whether the leading and trailing widgets are aligned to the top of the field.
  ///
  /// Defaults to false, which centers them against the content. Set this to true for
  /// tall content, where centered affixes would drift away from the label.
  final bool topAlignAffixes;

  /// Called when the widget is tapped.
  ///
  /// The tap triggers [InkWell] visual feedback (ripple/highlight). When null, the
  /// field is disabled.
  final GestureTapCallback? onTap;

  /// Customizes the visual appearance of the decorated content.
  ///
  /// Non-null properties override the corresponding properties in
  /// [SBBDecoratedThemeData.style] from the current theme.
  final SBBDecoratedStyle? style;

  @override
  State<SBBDecorated> createState() => _SBBDecoratedState();
}

class _SBBDecoratedState extends State<SBBDecorated> {
  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  late WidgetStatesController _statesController;

  bool get _enabled => widget.onTap != null;

  bool get _isEmpty => widget.child == null;

  @override
  void initState() {
    super.initState();

    _effectiveFocusNode.canRequestFocus = _enabled;
    _effectiveFocusNode.addListener(_handleFocusChanged);

    _statesController = WidgetStatesController();
    _updateStates();
  }

  @override
  void didUpdateWidget(covariant SBBDecorated oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      _effectiveFocusNode.addListener(_handleFocusChanged);
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
  /// if no [SBBInputDecoration.floatingLabelBehavior] is provided, the field is empty,
  /// and a placeholder is present.
  SBBInputDecoration get _effectiveDecoration {
    final decoration = widget.decoration ?? SBBInputDecoration();
    if (decoration.floatingLabelBehavior == null &&
        _isEmpty &&
        (decoration.placeholder != null || decoration.placeholderText != null)) {
      return decoration.copyWith(floatingLabelBehavior: SBBFloatingLabelBehavior.always);
    }
    return decoration;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasSBBBaseStyle(context));

    final themeStyle = Theme.of(context).sbbDecoratedTheme.style!;
    final effectiveStyle = themeStyle.merge(widget.style);

    // Let the content inherit the resolved color and text style, so that a disabled or
    // errored field greys out its content along with its label and affixes. Merging
    // means a style set explicitly on the child still wins.
    final child = addDefaultAncestorWithResolved(
      child: widget.child,
      foregroundColor: effectiveStyle.contentForegroundColor?.resolve(_statesController.value),
      textStyle: effectiveStyle.contentTextStyle,
    );

    return InkWell(
      onTap: _enabled ? widget.onTap : null,
      focusNode: _effectiveFocusNode,
      excludeFromSemantics: true,
      autofocus: widget.autofocus,
      statesController: _statesController,
      overlayColor: effectiveStyle.overlayColor,
      child: Semantics(
        enabled: _enabled,
        child: ListenableBuilder(
          listenable: _effectiveFocusNode,
          builder: (context, Widget? child) {
            return SBBInputDecorator(
              decoration: _effectiveDecoration,
              expands: widget.expands,
              minInputHeight: widget.minContentHeight,
              isMultiline: widget.topAlignAffixes,
              isEmpty: _isEmpty,
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

  bool get isBoxed => false;

  void _handleFocusChanged() {
    _updateStates();
    setState(() {
      // Rebuild widget on focus change to update accordingly.
    });
  }
}

/// The boxed variant of [SBBDecorated].
///
/// This variant applies default padding and special border styling for a contained
/// appearance. Specifically:
/// * If no [decoration.contentPadding] is provided, applies symmetric horizontal padding
///   of [SBBSpacing.medium]
/// * The border only displays when in an error state, showing a surrounding box
///
/// This is useful for creating grouped form-like layouts with consistent spacing.
class SBBDecoratedBoxed extends SBBDecorated {
  SBBDecoratedBoxed({
    super.key,
    super.child,
    super.onTap,
    SBBInputDecoration? decoration,
    super.focusNode,
    super.autofocus,
    super.minContentHeight,
    super.expands,
    super.topAlignAffixes,
    super.style,
    this.margin,
  }) : super(
         decoration: decoration?.contentPadding != null
             ? decoration
             : (decoration ?? SBBInputDecoration()).copyWith(
                 contentPadding: .symmetric(horizontal: SBBSpacing.medium),
               ),
       );

  /// The margin of the content box surrounding the [SBBDecorated].
  final EdgeInsetsGeometry? margin;

  @override
  State<SBBDecorated> createState() => _SBBDecoratedStateBoxed();
}

class _SBBDecoratedStateBoxed extends _SBBDecoratedState {
  @override
  bool get isBoxed => true;

  @override
  Widget build(BuildContext context) {
    return SBBContentBox(margin: (widget as SBBDecoratedBoxed).margin, child: super.build(context));
  }
}
