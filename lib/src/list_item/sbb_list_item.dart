import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sbb_design_system_mobile/src/shared/bottom_loading_indicator.dart';

import '../../sbb_design_system_mobile.dart';
import '../shared/divider/divider_painter.dart';

/// A customizable list item component following the SBB design system.
///
/// Provides a flexible layout with optional leading, title, subtitle, and trailing widgets.
/// The title and leading widgets are center-aligned vertically, with the subtitle positioned
/// below them.
///
/// Provide either [title] for custom content or [titleText] for text-only content with
/// standard styling. These parameters are mutually exclusive.
///
/// Optionally provide [subtitle] or [subtitleText] for additional information below the title.
/// These parameters are mutually exclusive.
///
/// Leading and trailing icons can be provided either as custom [Widget]s via [leading] and
/// [trailing], or as [IconData] via [leadingIconData] and [trailingIconData]. These parameter
/// pairs are mutually exclusive.
///
/// When [isLoading] is true, a loading indicator is displayed at the bottom of the item.
///
/// When [links] are provided, they are displayed below the list item with top dividers.
///
/// The list item is disabled when both [onTap] and [onLongPress] are null or [enabled] is false.
///
/// Use [SBBListItem.divideListItems] to automatically add dividers between multiple list items.
///
///
/// ## Sample code
///
/// ```dart
/// SBBListItem(
///   titleText: 'List Item Title',
///   subtitleText: 'Additional information',
///   onTap: () {},
/// )
/// ```
///
/// ## Sample code with dividers
///
/// ```dart
/// Column(
///   children: SBBListItem.divideListItems(
///     context: context,
///     items: [
///       SBBListItem(
///         titleText: 'First Item',
///         onTap: () {},
///       ),
///       SBBListItem(
///         titleText: 'Second Item',
///         onTap: () {},
///       ),
///       SBBListItem(
///         titleText: 'Third Item',
///         onTap: () {},
///       ),
///     ],
///   ).toList(),
/// )
/// ```
///
/// ## Customization
///
/// Use [style] to customize appearance for a single item, or
/// [SBBListItemThemeData] to apply consistent styling across your app:
///
/// ```dart
/// SBBListItem(
///   titleText: 'Styled Item',
///   onTap: () {},
///   style: SBBListItemStyle(
///     backgroundColor: WidgetStateProperty.all(Colors.blue),
///     titleForegroundColor: WidgetStateProperty.all(Colors.white),
///   ),
/// )
/// ```
///
/// See also:
///
///  * [SBBListItemBoxed], for a boxed variant.
///  * [SBBListItemStyle], for customizing the appearance.
///  * [SBBListItemThemeData], for setting list item theme properties across your app.
///  * [Design Guidelines](https://digital.sbb.ch/de/design-system/mobile/components/list-item)
///  * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=282-933) (internal only)
class SBBListItem extends StatefulWidget {
  const SBBListItem({
    super.key,
    this.leading,
    this.leadingIconData,
    this.title,
    this.titleText,
    this.subtitle,
    this.subtitleText,
    this.trailing,
    this.trailingIconData,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
    this.isLoading = false,
    this.links,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.padding,
    this.trailingHorizontalGapWidth,
    this.leadingHorizontalGapWidth,
    this.subtitleVerticalGapHeight,
    this.style,
  }) : assert(title != null || titleText != null, 'Either title or titleText must be provided'),
       assert(title == null || titleText == null, 'Only one of title or titleText can be set'),
       assert(subtitle == null || subtitleText == null, 'Only one of subtitle or subtitleText can be set'),
       assert(leading == null || leadingIconData == null, 'Only one of leading or leadingIconData can be set'),
       assert(trailing == null || trailingIconData == null, 'Only one of trailing or trailingIconData can be set');

  /// A custom widget displayed as the list item's leading content.
  ///
  /// For simple icons, use [leadingIconData] instead.
  ///
  /// The Widget is vertically centered with [titleText] or [title].
  ///
  /// Cannot be used together with [leadingIconData].
  final Widget? leading;

  /// Icon data for the leading icon.
  ///
  /// The icon is vertically centered with [titleText] or [title].
  ///
  /// Cannot be used together with [leading].
  final IconData? leadingIconData;

  /// {@template sbb_design_system.list_item.title}
  /// A custom widget displayed as the list item's title.
  ///
  /// For simple text labels, use [titleText] instead.
  ///
  /// The title is vertically centered with [leading] or [leadingIconData].
  ///
  /// Cannot be used together with [titleText].
  /// {@endtemplate}
  final Widget? title;

  /// {@template sbb_design_system.list_item.titleText}
  /// Text string to display as the list item's title using standard styling.
  ///
  /// The text is clamped to a single line with ellipsis overflow.
  /// The title is vertically centered with [leading] or [leadingIconData].
  ///
  /// Cannot be used together with [title].
  /// {@endtemplate}
  final String? titleText;

  /// {@template sbb_design_system.list_item.subtitle}
  /// A custom widget displayed as the list item's subtitle below the title.
  ///
  /// For simple text labels, use [subtitleText] instead.
  ///
  /// Cannot be used together with [subtitleText].
  /// {@endtemplate}
  final Widget? subtitle;

  /// {@template sbb_design_system.list_item.subtitleText}
  /// Text string to display as the list item's subtitle using standard styling.
  ///
  /// The subtitle is positioned below the title and leading widget.
  ///
  /// Cannot be used together with [subtitle].
  /// {@endtemplate}
  final String? subtitleText;

  /// {@template sbb_design_system.list_item.trailing}
  /// A custom widget displayed as the list item's trailing content.
  ///
  /// For simple icons, use [trailingIconData] instead.
  ///
  /// [trailing] is vertically centered relative to the list item.
  ///
  /// Note that when adding for example a button, the [padding] might have to be adapted
  /// for the button to be aligned with other trailing icons due to the button's inherent padding.
  ///
  /// Cannot be used together with [trailingIconData].
  /// {@endtemplate}
  final Widget? trailing;

  /// {@template sbb_design_system.list_item.trailingIconData}
  /// Icon data for the trailing icon.
  ///
  /// Cannot be used together with [trailing].
  /// {@endtemplate}
  final IconData? trailingIconData;

  /// {@template sbb_design_system.list_item.onTap}
  /// Called when the list item is tapped.
  ///
  /// The list item is disabled when both this and [onLongPress] are null.
  ///
  /// Ignored when [enabled] is false.
  /// {@endtemplate}
  final GestureTapCallback? onTap;

  /// {@template sbb_design_system.list_item.onLongPress}
  /// Called when the list item is long-pressed.
  ///
  /// The list item is disabled when both this and [onTap] are null.
  ///
  /// Ignored when [enabled] is false.
  /// {@endtemplate}
  final GestureLongPressCallback? onLongPress;

  /// {@template sbb_design_system.list_item.enabled}
  /// Whether the list item is enabled for interaction.
  ///
  /// When false, [onTap] and [onLongPress] are ignored and the item
  /// is styled as disabled.
  ///
  /// Defaults to true.
  /// {@endtemplate}
  final bool enabled;

  /// {@template sbb_design_system.list_item.isLoading}
  /// Whether to show a loading indicator at the bottom of the item.
  ///
  /// When true, a [BottomLoadingIndicator] is displayed at the bottom of the list item.
  ///
  /// Defaults to false.
  /// {@endtemplate}
  final bool isLoading;

  /// {@template sbb_design_system.list_item.links}
  /// Additional widgets displayed below the list item main content.
  ///
  /// This is typically used with a list of [SBBListItem] itself with a trailing icon.
  ///
  /// Links are displayed in a column below the list item with
  /// top dividers separating each link.
  /// {@endtemplate}
  final Iterable<Widget>? links;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// {@macro flutter.material.ListTile.enableFeedback}
  final bool enableFeedback;

  /// {@template sbb_design_system.list_item.padding}
  /// Padding around the list item's content.
  ///
  /// Defaults to symmetric padding of 16.0 horizontal and 10.0 vertical.
  /// {@endtemplate}
  final EdgeInsetsGeometry? padding;

  /// {@template sbb_design_system.list_item.trailingHorizontalGapWidth}
  /// Horizontal gap width between the trailing widget and the [title].
  ///
  /// Overrides the value in [SBBListItemThemeData.trailingHorizontalGapWidth].
  ///
  /// Defaults to 16.0.
  /// {@endtemplate}
  final double? trailingHorizontalGapWidth;

  /// {@template sbb_design_system.list_item.leadingHorizontalGapWidth}
  /// Horizontal gap width between the leading widget and the title.
  ///
  /// Overrides the value in [SBBListItemThemeData.leadingHorizontalGapWidth].
  ///
  /// Defaults to 8.0.
  /// {@endtemplate}
  final double? leadingHorizontalGapWidth;

  /// {@template sbb_design_system.list_item.subtitleVerticalGapHeight}
  /// Vertical gap height between the title or leading (depending which is larger) and subtitle.
  ///
  /// Overrides the value in [SBBListItemThemeData.subtitleVerticalGapHeight].
  ///
  /// Defaults to 4.0.
  /// {@endtemplate}
  final double? subtitleVerticalGapHeight;

  /// {@template sbb_design_system.list_item.style}
  /// Customizes this list item appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties in [SBBListItemThemeData.style] of the theme found in [context].
  /// {@endtemplate}
  final SBBListItemStyle? style;

  /// Add a one pixel border in between each item. If color isn't specified the
  /// [ThemeData.dividerColor] of the context's [Theme] is used, which defaults to
  /// [SBBBaseStyle.dividerColor].
  ///
  /// See also [SBBDivider] for using the same underlying widget
  /// in indexed builder methods (e.g. [ListView.separated]).
  static List<Widget> divideListItems({
    BuildContext? context,
    required Iterable<Widget> items,
    Color? color,
  }) {
    assert(color != null || context != null);
    items = items.toList();

    if (items.isEmpty || items.length == 1) {
      return items.toList();
    }

    final resolvedColor = color ?? Theme.of(context!).dividerColor;

    Widget wrapListItem(Widget link) {
      return CustomPaint(
        foregroundPainter: DividerPainter(
          paintAtTop: false,
          color: resolvedColor,
          indent: 0.0,
        ),
        child: link,
      );
    }

    return <Widget>[...items.take(items.length - 1).map(wrapListItem), items.last];
  }

  @override
  State<SBBListItem> createState() => _SBBListItemState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      FlagProperty(
        'enabled',
        value: enabled,
        ifTrue: 'true',
        ifFalse: 'false',
        showName: true,
        defaultValue: true,
      ),
    );
    properties.add(
      FlagProperty(
        'isLoading',
        value: isLoading,
        ifTrue: 'true',
        ifFalse: 'false',
        showName: true,
        defaultValue: false,
      ),
    );
    properties.add(
      FlagProperty(
        'autofocus',
        value: autofocus,
        ifTrue: 'true',
        ifFalse: 'false',
        showName: true,
        defaultValue: false,
      ),
    );
    properties.add(
      FlagProperty(
        'enableFeedback',
        value: enableFeedback,
        ifTrue: 'true',
        ifFalse: 'false',
        showName: true,
        defaultValue: true,
      ),
    );
    properties.add(DiagnosticsProperty<Function>('onTap', onTap, defaultValue: null));
    properties.add(DiagnosticsProperty<Function>('onLongPress', onLongPress, defaultValue: null));
    properties.add(DiagnosticsProperty<FocusNode>('focusNode', focusNode, defaultValue: null));
    properties.add(
      DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding, defaultValue: null),
    );
    properties.add(
      DoubleProperty('trailingHorizontalGapWidth', trailingHorizontalGapWidth, defaultValue: null),
    );
    properties.add(
      DoubleProperty('leadingHorizontalGapWidth', leadingHorizontalGapWidth, defaultValue: null),
    );
    properties.add(
      DoubleProperty('subtitleVerticalGapHeight', subtitleVerticalGapHeight, defaultValue: null),
    );
    properties.add(DiagnosticsProperty<SBBListItemStyle>('style', style, defaultValue: null));
  }
}

class _SBBListItemState extends State<SBBListItem> {
  late WidgetStatesController _statesController;

  bool get _isInteractive => widget.enabled && (widget.onTap != null || widget.onLongPress != null);

  @override
  void initState() {
    super.initState();
    _statesController = WidgetStatesController();
    _updateStatesController();
  }

  @override
  void didUpdateWidget(SBBListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled ||
        widget.onTap != oldWidget.onTap ||
        widget.onLongPress != oldWidget.onLongPress) {
      _updateStatesController();
    }
  }

  void _updateStatesController() {
    _statesController.update(WidgetState.disabled, !_isInteractive);
  }

  @override
  void dispose() {
    _statesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    final themeData = Theme.of(context).sbbListItemTheme;
    final effectiveStyle = (themeData?.style ?? SBBListItemStyle()).merge(widget.style);
    final states = _statesController.value;

    final effectivePadding = widget.padding ?? themeData?.padding ?? SBBListItemStyle.defaultPadding;
    final effectiveTrailingGapWidth =
        widget.trailingHorizontalGapWidth ?? themeData?.trailingHorizontalGapWidth ?? 16.0;
    final effectiveLeadingGapWidth = widget.leadingHorizontalGapWidth ?? themeData?.leadingHorizontalGapWidth ?? 8.0;
    final effectiveSubtitleGapHeight = widget.subtitleVerticalGapHeight ?? themeData?.subtitleVerticalGapHeight ?? 4.0;
    final effectiveOverlayColor = effectiveStyle.overlayColor;

    final resolvedTitleTextStyle = effectiveStyle.titleTextStyle?.resolve(states) ?? SBBTextStyles.mediumLight;
    final resolvedSubtitleTextStyle = effectiveStyle.subtitleTextStyle?.resolve(states) ?? SBBTextStyles.smallLight;
    final resolvedTitleForegroundColor = effectiveStyle.titleForegroundColor?.resolve(states);
    final resolvedSubtitleForegroundColor = effectiveStyle.subtitleForegroundColor?.resolve(states);
    final resolvedLeadingForegroundColor = effectiveStyle.leadingForegroundColor?.resolve(states);
    final resolvedTrailingForegroundColor = effectiveStyle.trailingForegroundColor?.resolve(states);
    final resolvedBackgroundColor = effectiveStyle.backgroundColor?.resolve(states);

    // Build actual widgets from convenience parameters
    Widget? leadingWidget = widget.leading;
    if (leadingWidget == null && widget.leadingIconData != null) {
      leadingWidget = Icon(widget.leadingIconData);
    }

    Widget titleWidget;
    if (widget.title != null) {
      titleWidget = widget.title!;
    } else {
      titleWidget = Text(widget.titleText!, maxLines: 1, overflow: .ellipsis);
    }

    Widget? subtitleWidget = widget.subtitle;
    if (subtitleWidget == null && widget.subtitleText != null) {
      subtitleWidget = Text(widget.subtitleText!);
    }

    Widget? trailingWidget = widget.trailing;
    if (trailingWidget == null && widget.trailingIconData != null) {
      trailingWidget = Icon(widget.trailingIconData);
    }

    // Apply theming to all widgets
    titleWidget = _addDefaultAncestorWithResolved(
      child: titleWidget,
      foregroundColor: resolvedTitleForegroundColor,
      textStyle: resolvedTitleTextStyle,
    );

    if (leadingWidget != null) {
      leadingWidget = _addDefaultAncestorWithResolved(
        child: leadingWidget,
        foregroundColor: resolvedLeadingForegroundColor,
      );
    }

    if (subtitleWidget != null) {
      subtitleWidget = _addDefaultAncestorWithResolved(
        child: subtitleWidget,
        foregroundColor: resolvedSubtitleForegroundColor,
        textStyle: resolvedSubtitleTextStyle,
      );
    }

    if (trailingWidget != null) {
      trailingWidget = _addDefaultAncestorWithResolved(
        child: trailingWidget,
        foregroundColor: resolvedTrailingForegroundColor,
      );
    }

    // Arrange widgets to each other
    Widget child = titleWidget;
    if (leadingWidget != null) {
      child = Row(
        children: [
          leadingWidget,
          SizedBox(width: effectiveLeadingGapWidth),
          Expanded(child: titleWidget),
        ],
      );
    } else {
      child = Align(alignment: .centerLeft, child: child);
    }

    if (subtitleWidget != null) {
      child = Column(
        mainAxisSize: .min,
        mainAxisAlignment: .start,
        crossAxisAlignment: .stretch,
        children: [
          child,
          SizedBox(height: effectiveSubtitleGapHeight),
          subtitleWidget,
        ],
      );
    }

    if (trailingWidget != null) {
      child = Row(
        children: [
          Expanded(child: child),
          SizedBox(width: effectiveTrailingGapWidth),
          trailingWidget,
        ],
      );
    }

    child = InkWell(
      onTap: widget.enabled ? widget.onTap : null,
      onLongPress: widget.enabled ? widget.onLongPress : null,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      enableFeedback: widget.enableFeedback,
      statesController: _statesController,
      overlayColor: effectiveOverlayColor,
      child: Semantics(
        button: _isInteractive,
        enabled: _isInteractive,
        focused: widget.focusNode?.hasFocus,
        child: Ink(
          color: resolvedBackgroundColor,
          child: Padding(
            padding: effectivePadding,
            child: child,
          ),
        ),
      ),
    );

    child = ConstrainedBox(
      constraints: BoxConstraints(minWidth: .infinity, minHeight: 44.0),
      child: child,
    );

    if (widget.isLoading) {
      child = Stack(
        alignment: .bottomCenter,
        children: [
          child,
          BottomLoadingIndicator(),
        ],
      );
    }

    if (widget.links?.isNotEmpty ?? false) {
      child = Column(
        crossAxisAlignment: .stretch,
        children: [
          child,
          ..._divideLinks(context: context, links: widget.links!),
        ],
      );
    }

    return child;
  }

  Widget _addDefaultAncestorWithResolved({
    required Widget child,
    required Color? foregroundColor,
    TextStyle? textStyle,
  }) {
    final resolvedTextStyle = textStyle?.copyWith(color: foregroundColor) ?? TextStyle(color: foregroundColor);

    child = DefaultTextStyle.merge(
      style: resolvedTextStyle,
      child: IconTheme.merge(
        data: IconThemeData(color: foregroundColor),
        child: child,
      ),
    );
    return child;
  }

  Iterable<Widget> _divideLinks({
    BuildContext? context,
    required Iterable<Widget> links,
    Color? color,
    double indent = SBBSpacing.medium,
  }) {
    assert(color != null || context != null);
    links = links.toList();

    if (links.isEmpty) return links;

    final resolvedColor = color ?? Theme.of(context!).dividerColor;

    Widget wrapLink(Widget link) {
      return CustomPaint(
        foregroundPainter: DividerPainter(
          paintAtTop: true,
          color: resolvedColor,
          indent: indent,
        ),
        child: link,
      );
    }

    return links.map(wrapLink);
  }
}

/// The boxed variant of [SBBListItem].
///
/// This is a convenience class and is equivalent to wrapping
/// the [SBBListItem] inside a [SBBContentBox].
class SBBListItemBoxed extends SBBListItem {
  const SBBListItemBoxed({
    super.key,
    super.leading,
    super.leadingIconData,
    super.title,
    super.titleText,
    super.subtitle,
    super.subtitleText,
    super.trailing,
    super.trailingIconData,
    super.onTap,
    super.onLongPress,
    super.enabled,
    super.isLoading,
    super.links,
    super.focusNode,
    super.autofocus,
    super.enableFeedback,
    super.style,
    super.padding,
    super.trailingHorizontalGapWidth,
    super.leadingHorizontalGapWidth,
    super.subtitleVerticalGapHeight,
  });

  @override
  State<SBBListItem> createState() => _SBBListItemBoxedState();
}

class _SBBListItemBoxedState extends _SBBListItemState {
  @override
  Widget build(BuildContext context) {
    return SBBContentBox(child: super.build(context));
  }
}
