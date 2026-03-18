import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import '../sbb_internal.dart';

/// Shows an SBB Popup dialog.
///
/// Provide either [titleText] for a simple text title or [title] for a custom
/// title widget. These parameters are mutually exclusive. Similarly, provide
/// either [leadingIconData] or [leading] for leading content, and either
/// [trailingIconData] or [trailing] for trailing content.
///
/// The [body] parameter is required and contains the main content of the popup.
///
/// The popup's appearance can be customized per-call via [style], which is merged
/// on top of the theme's default [SBBPopupStyle]. Use [SBBPopupThemeData] in
/// [SBBTheme] to apply app-wide defaults.
///
/// The [style] parameter additionally controls dialog-level properties:
/// * [SBBPopupStyle.constraints] – size constraints on the dialog.
/// * [SBBPopupStyle.alignment] – how the dialog is positioned on screen.
/// * [SBBPopupStyle.margin] – minimum padding between the dialog and screen edges.
///
/// Returns a `Future` that resolves to the value (if any) that was passed to
/// [Navigator.pop] when the popup was closed.
///
/// If you try to close the popup but the underlying page is navigated back
/// instead, try using the `rootNavigator` parameter:
/// ```dart
/// Navigator.of(context, rootNavigator: true).pop(result)
/// ```
///
/// See also:
///
/// * [SBBPopup], which will be displayed.
/// * [SBBPopupStyle], the style used to change the appearance.
/// * [showDialog], which is used by this function internally.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/modal-view/>
Future<T?> showSBBPopup<T>({
  Key? key,
  required BuildContext context,
  Widget? title,
  String? titleText,
  Widget? leading,
  IconData? leadingIconData,
  Widget? trailing,
  IconData? trailingIconData,
  required Widget body,
  SBBPopupStyle? style,
  bool useRootNavigator = true,
  bool isDismissible = true,
  bool showCloseButton = true,
  bool useSafeArea = true,
  TraversalEdgeBehavior? traversalEdgeBehavior,
  bool fullscreenDialog = false,
  bool? requestFocus,
  AnimationStyle? animationStyle,
  String? barrierLabel,
  RouteSettings? routeSettings,
}) {
  assert(title == null || titleText == null, 'Only title or titleText can be set!');
  assert(leading == null || leadingIconData == null, 'Only leading or leadingIconData can be set!');
  assert(trailing == null || trailingIconData == null, 'Only trailing or trailingIconData can be set!');

  final themeStyle = Theme.of(context).sbbPopupTheme?.style;
  final SBBPopupStyle resolvedStyle = (themeStyle ?? const SBBPopupStyle()).merge(style);

  return showDialog<T>(
    context: context,
    useRootNavigator: useRootNavigator,
    barrierDismissible: isDismissible,
    barrierLabel: barrierLabel,
    barrierColor: resolvedStyle.barrierColor ?? SBBInternal.barrierColor,
    useSafeArea: useSafeArea,
    fullscreenDialog: fullscreenDialog,
    requestFocus: requestFocus,
    animationStyle: animationStyle,
    traversalEdgeBehavior: traversalEdgeBehavior,
    routeSettings: routeSettings,
    builder: (_) => SBBPopup(
      key: key,
      title: title,
      titleText: titleText,
      leading: leading,
      leadingIconData: leadingIconData,
      trailing: trailing,
      trailingIconData: trailingIconData,
      showCloseButton: isDismissible && showCloseButton,
      useRootNavigator: useRootNavigator,
      style: style,
      body: body,
    ),
  );
}

/// The SBB Popup widget.
///
/// This widget displays a modal dialog with an optional header (title and close
/// button) and a body. The dialog is styled according to the SBB design system.
///
/// Provide either [titleText] for a simple text title or [title] for a custom
/// title widget. These parameters are mutually exclusive.
///
/// The header row is only shown if at least one of the following is true:
///  * [title] or [titleText] is provided
///  * [leading] or [leadingIconData] is provided
///  * [trailing] or [trailingIconData] is provided
///  * [showCloseButton] is true
///
/// See also:
///
/// * [showSBBPopup], which is typically used to display this widget.
/// * [SBBPopupStyle], the style used to change the appearance.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/modal-view/>
class SBBPopup extends StatelessWidget {
  const SBBPopup({
    super.key,
    required this.body,
    this.title,
    this.titleText,
    this.leading,
    this.leadingIconData,
    this.trailing,
    this.trailingIconData,
    this.showCloseButton = true,
    this.useRootNavigator = true,
    this.style,
  }) : assert(title == null || titleText == null, 'Only title or titleText can be set!'),
       assert(leading == null || leadingIconData == null, 'Only leading or leadingIconData can be set!'),
       assert(trailing == null || trailingIconData == null, 'Only trailing or trailingIconData can be set!');

  /// A custom widget displayed as the popup's title.
  ///
  /// For simple text titles, use [titleText] instead.
  ///
  /// Cannot be used together with [titleText].
  final Widget? title;

  /// Text string to display as the popup's title.
  ///
  /// Cannot be used together with [title].
  final String? titleText;

  /// A custom widget displayed at the leading edge of the header.
  ///
  /// For icon-only leading content, use [leadingIconData] instead.
  ///
  /// Cannot be used together with [leadingIconData].
  final Widget? leading;

  /// Icon data for an icon displayed at the leading edge of the header.
  ///
  /// Cannot be used together with [leading].
  final IconData? leadingIconData;

  /// A custom widget displayed at the trailing edge of the header.
  ///
  /// For icon-only trailing content, use [trailingIconData] instead.
  ///
  /// Cannot be used together with [trailingIconData].
  final Widget? trailing;

  /// Icon data for an icon displayed at the trailing edge of the header.
  ///
  /// Cannot be used together with [trailing].
  final IconData? trailingIconData;

  /// The main content widget of the popup.
  final Widget body;

  /// Whether to show a close button in the header.
  final bool showCloseButton;

  /// Whether to use the root navigator when popping the popup.
  ///
  /// When true, [Navigator.of] will use [rootNavigator: true] to dismiss
  /// the popup. This is useful when the popup needs to be dismissed from
  /// a context that is not the direct parent of the popup.
  ///
  /// Defaults to true.
  final bool useRootNavigator;

  /// Customizes this popup's appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties from the theme's default [SBBPopupStyle].
  final SBBPopupStyle? style;

  @override
  Widget build(BuildContext context) {
    final themeStyle = Theme.of(context).sbbPopupTheme?.style;
    final SBBPopupStyle resolvedStyle = (themeStyle ?? const SBBPopupStyle()).merge(style);

    // Build actual widgets from convenience parameters
    Widget? leadingWidget = leading;
    if (leadingWidget == null && leadingIconData != null) {
      leadingWidget = Icon(leadingIconData);
    }

    Widget? titleWidget = title;
    if (titleWidget == null && titleText != null) {
      titleWidget = Text(titleText!);
    }

    Widget? trailingWidget = trailing;
    if (trailingWidget == null && trailingIconData != null) {
      trailingWidget = Icon(trailingIconData);
    }

    // Apply theming to all widgets
    if (titleWidget != null) {
      titleWidget = _addDefaultAncestorWithResolved(
        child: titleWidget,
        foregroundColor: resolvedStyle.titleForegroundColor,
        textStyle: resolvedStyle.titleTextStyle,
      );
    }

    if (leadingWidget != null) {
      leadingWidget = _addDefaultAncestorWithResolved(
        child: leadingWidget,
        foregroundColor: resolvedStyle.leadingForegroundColor,
        textStyle: resolvedStyle.leadingTextStyle,
      );
    }

    if (trailingWidget != null) {
      trailingWidget = _addDefaultAncestorWithResolved(
        child: trailingWidget,
        foregroundColor: resolvedStyle.trailingForegroundColor,
        textStyle: resolvedStyle.trailingTextStyle,
      );
    }

    final padding = resolvedStyle.padding ?? const .all(SBBSpacing.medium);

    final Widget child;
    if (titleWidget != null || leadingWidget != null || trailingWidget != null || showCloseButton) {
      final titleRowPadding = padding.copyWith(
        right: showCloseButton ? SBBSpacing.xSmall : padding.right,
        bottom: 0.0,
      );
      final bodyPadding = padding.copyWith(top: resolvedStyle.titleBodyGap ?? SBBSpacing.small);

      child = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: titleRowPadding,
            child: _PopupTitleRow(
              title: titleWidget,
              leading: leadingWidget,
              trailing: trailingWidget,
              showCloseButton: showCloseButton,
              useRootNavigator: useRootNavigator,
            ),
          ),
          Flexible(
            child: Padding(
              padding: bodyPadding,
              child: body,
            ),
          ),
        ],
      );
    } else {
      child = Padding(
        padding: padding,
        child: body,
      );
    }

    return Dialog(
      backgroundColor: resolvedStyle.backgroundColor,
      clipBehavior: resolvedStyle.clipBehavior ?? .hardEdge,
      shape: SBBPopupStyle.shape,
      alignment: resolvedStyle.alignment ?? .center,
      insetPadding: resolvedStyle.margin ?? const .symmetric(horizontal: SBBSpacing.xLarge, vertical: SBBSpacing.large),
      child: ConstrainedBox(
        constraints: resolvedStyle.constraints ?? const BoxConstraints(),
        child: Semantics(
          explicitChildNodes: true,
          child: child,
        ),
      ),
    );
  }

  static Widget _addDefaultAncestorWithResolved({
    required Widget child,
    required Color? foregroundColor,
    TextStyle? textStyle,
  }) {
    final resolvedTextStyle = textStyle?.copyWith(color: foregroundColor) ?? TextStyle(color: foregroundColor);
    return DefaultTextStyle.merge(
      style: resolvedTextStyle,
      child: IconTheme.merge(
        data: IconThemeData(color: foregroundColor),
        child: child,
      ),
    );
  }
}

class _PopupTitleRow extends StatelessWidget {
  const _PopupTitleRow({
    this.title,
    this.leading,
    this.trailing,
    required this.showCloseButton,
    required this.useRootNavigator,
  });

  final Widget? title;
  final Widget? leading;
  final Widget? trailing;
  final bool showCloseButton;
  final bool useRootNavigator;

  @override
  Widget build(BuildContext context) {
    final closeButton = showCloseButton ? _PopupCloseButton(useRootNavigator: useRootNavigator) : null;

    final nonNullChildren = [title, leading, trailing, closeButton].nonNulls.toList(growable: false);

    if (nonNullChildren.isEmpty) return const SizedBox.shrink();

    if (nonNullChildren.length > 1) {
      return Row(
        spacing: SBBSpacing.xSmall,
        children: [
          ?leading,
          if (title != null) Expanded(child: title!) else Spacer(),
          ?trailing,
          ?closeButton,
        ],
      );
    }

    if (closeButton != null || trailing != null) {
      return Align(alignment: .centerRight, child: closeButton ?? trailing);
    }

    return nonNullChildren.first;
  }
}

class _PopupCloseButton extends StatelessWidget {
  const _PopupCloseButton({required this.useRootNavigator});

  final bool useRootNavigator;

  @override
  Widget build(BuildContext context) => Semantics(
    label: MaterialLocalizations.of(context).closeButtonTooltip,
    excludeSemantics: true,
    button: true,
    child: SBBTertiaryButtonSmall(
      onPressed: () => Navigator.of(context, rootNavigator: useRootNavigator).pop(),
      iconData: SBBIcons.cross_small,
    ),
  );
}
