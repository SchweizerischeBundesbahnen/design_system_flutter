import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import '../sbb_internal.dart';

const double _defaultScrollControlDisabledMaxHeightRatio = 9.0 / 16.0;

/// Shows a SBB Modal Popup. Use according to documentation.
///
/// If you try to close the popup but the underlying page is navigated back
/// instead, try using the `rootNavigator` parameter of the `Navigator`:
/// ```dart
/// Navigator.of(context, rootNavigator: true).pop(result)
/// ```
///
/// See also:
///
/// * [SBBModalPopup], which will be displayed.
/// * [showDialog], which is used to display the bottom_sheet.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/modal-view/>
Future<T?> showSBBModalPopup<T>({
  required BuildContext context,
  required String title,
  required Widget child,
  Clip clipBehavior = .none,
  bool useRootNavigator = true,
  bool showCloseButton = true,
  Color? backgroundColor,
}) {
  return showDialog<T>(
    context: context,
    useRootNavigator: useRootNavigator,
    builder: (_) {
      return SBBModalPopup(
        title: title,
        clipBehavior: clipBehavior,
        useRootNavigator: useRootNavigator,
        showCloseButton: showCloseButton,
        backgroundColor: backgroundColor,
        child: child,
      );
    },
    barrierColor: SBBInternal.barrierColor,
  );
}

/// The SBB Modal Popup. Use according to documentation.
///
/// See also:
///
/// * [showSBBModalPopup], which is typically used to display this Widget.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/modal-view/>
class SBBModalPopup extends StatelessWidget {
  const SBBModalPopup({
    super.key,
    required this.title,
    required this.child,
    this.clipBehavior = .none,
    this.showCloseButton = true,
    this.useRootNavigator = true,
    this.backgroundColor,
  });

  final String title;
  final Widget child;
  final Clip clipBehavior;
  final bool showCloseButton;
  final bool useRootNavigator;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).sbbBottomSheetTheme?.style;
    final resolvedTitlePadding = _resolvedTitlePadding(style);
    final resolvedBodyPadding = _resolvedBodyPadding(style);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SBBSpacing.medium)),
      clipBehavior: clipBehavior,
      backgroundColor: backgroundColor ?? style?.backgroundColor,
      child: Semantics(
        explicitChildNodes: true,
        child: Column(
          mainAxisSize: .min,
          children: [
            Padding(
              padding: resolvedTitlePadding,
              child: _ModalHeader(title, showCloseButton: showCloseButton, useRootNavigator: useRootNavigator),
            ),
            Flexible(
              child: Padding(
                padding: resolvedBodyPadding,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  EdgeInsets _resolvedBodyPadding(SBBBottomSheetStyle? style) =>
      (style?.padding ?? EdgeInsets.zero).copyWith(top: style?.titleBodyGap ?? 0.0, bottom: SBBSpacing.medium);

  // need to adjust this in case showCloseButton is displayed
  EdgeInsets _resolvedTitlePadding(SBBBottomSheetStyle? style) {
    return (style?.padding ?? EdgeInsets.zero).copyWith(
      right: showCloseButton ? SBBSpacing.xSmall : (style?.padding ?? EdgeInsets.zero).right,
      bottom: 0.0,
    );
  }
}

/// Shows an SBB Bottom Sheet.
///
/// A bottom sheet is a modal window displayed at the bottom of the screen that
/// prevents the user from interacting with the rest of the app until dismissed.
///
/// Provide either [titleText] for a simple text title or [title] for custom title
/// content. These parameters are mutually exclusive. Similarly, provide either
/// [leadingIconData] or [leading] for leading content, and either
/// [trailingIconData] or [trailing] for trailing content.
///
/// The sheet can be dismissed by tapping outside (if [isDismissible] is true),
/// swiping downward (if [enableDrag] is true), or tapping the close button
/// (if [showCloseButton] is true and [isDismissible] is true).
///
/// The [body] parameter is required and contains the main content of the sheet.
///
/// Returns a `Future` that resolves to the value (if any) that was passed to
/// [Navigator.pop] when the bottom sheet was closed.
///
/// ## Parameters
///
/// * **[isScrollControlled]**: When `false` (default), the sheet has a fixed maximum
///   height determined by [scrollControlDisabledMaxHeightRatio]. When `true`, the sheet
///   can expand to fill the entire available space (minus safe areas) and becomes draggable
///   if it contains scrollable content. Use `isScrollControlled: true` when your content
///   is a [ListView], [GridView], or other scrollable widget.
///
///   **Example - Fixed height (isScrollControlled: false):**
///   ```dart
///   showSBBBottomSheet(
///     context: context,
///     titleText: 'Select Item',
///     body: Column(
///       children: [
///         ListTile(title: Text('Option 1')),
///         ListTile(title: Text('Option 2')),
///       ],
///     ),
///     isScrollControlled: false, // Sheet takes 9 / 16 of screen height
///   );
///   ```
///
///   **Example - Full height scrollable (isScrollControlled: true):**
///   ```dart
///   showSBBBottomSheet(
///     context: context,
///     titleText: 'Long List',
///     body: ListView.builder(
///       itemCount: 100,
///       itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
///     ),
///     isScrollControlled: true, // Sheet expands to fill available space
///   );
///   ```
///
/// * **[scrollControlDisabledMaxHeightRatio]**: Only used when [isScrollControlled] is `false`.
///   Defines the maximum height of the sheet as a ratio of the screen height.
///   Defaults to `9.0 / 16.0`. Valid range is typically 0.0 to 1.0.
///   Ignored when [isScrollControlled] is `true`.
///
///   **Example - Custom height ratio:**
///   ```dart
///   showSBBBottomSheet(
///     context: context,
///     titleText: 'Half Screen',
///     body: Text('This sheet takes 50% of screen height'),
///     isScrollControlled: false,
///     scrollControlDisabledMaxHeightRatio: 0.5,
///   );
///   ```
/// * useSafeArea wraps the [SBBBottomSheet] in a SafeArea that also respects the bottom
///
/// If you try to close the sheet but the underlying page is navigated back
/// instead, try using the `rootNavigator` parameter:
/// ```dart
/// Navigator.of(context, rootNavigator: true).pop(result)
/// ```
///
/// See also:
///
/// * [SBBBottomSheet], which will be displayed.
/// * [SBBBottomSheetStyle], the style used to change the appearance of this
/// * [showModalBottomSheet], which is used by this function internally.
/// * <https://digital.sbb.ch/de/design-system/mobile/components/bottom-sheet/>
Future<T?> showSBBBottomSheet<T>({
  Key? key,
  required BuildContext context,
  Widget? title,
  String? titleText,
  Widget? leading,
  IconData? leadingIconData,
  Widget? trailing,
  IconData? trailingIconData,
  required Widget body,
  SBBBottomSheetStyle? style,
  String? barrierLabel,
  // TODO: EXPLICITLY STATE IN MIGRATION GUIDE THAT THIS IS NOW SET TO FALSE BY DEFAULT
  bool isScrollControlled = false,
  double scrollControlDisabledMaxHeightRatio = _defaultScrollControlDisabledMaxHeightRatio,
  bool useRootNavigator = true,
  bool isDismissible = true,
  bool enableDrag = true,
  bool useSafeArea = true,
  AnimationController? transitionAnimationController,
  AnimationStyle? sheetAnimationStyle,
  bool showCloseButton = true,
  bool? requestFocus,
}) {
  assert(title == null || titleText == null, 'Only title or titleText can be set!');
  assert(leading == null || leadingIconData == null, 'Only leading or leadingIconData can be set!');
  assert(trailing == null || trailingIconData == null, 'Only trailing or trailingIconData can be set!');
  assert(
    scrollControlDisabledMaxHeightRatio >= 0.0 && scrollControlDisabledMaxHeightRatio <= 1.0,
    'scrollControlDisabledMaxHeightRatio must be between 0.0 and 1.0!',
  );

  final themeStyle = Theme.of(context).sbbBottomSheetTheme?.style;
  final SBBBottomSheetStyle resolvedStyle = (themeStyle ?? SBBBottomSheetStyle()).merge(style);

  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: resolvedStyle.backgroundColor,
    barrierLabel: barrierLabel,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(SBBSpacing.medium))),
    clipBehavior: resolvedStyle.clipBehavior,
    constraints: resolvedStyle.constraints,
    barrierColor: resolvedStyle.barrierColor,
    isScrollControlled: isScrollControlled,
    scrollControlDisabledMaxHeightRatio: scrollControlDisabledMaxHeightRatio,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    useSafeArea: useSafeArea,
    transitionAnimationController: transitionAnimationController,
    sheetAnimationStyle: sheetAnimationStyle,
    requestFocus: requestFocus,
    builder: (_) => SBBBottomSheet(
      key: key,
      title: title,
      titleText: titleText,
      leading: leading,
      leadingIconData: leadingIconData,
      trailing: trailing,
      trailingIconData: trailingIconData,
      showCloseButton: isDismissible && showCloseButton,
      style: style,
      body: useSafeArea ? _wrapWithBottomSafeArea(body) : body,
    ),
  );
}

/// The SBB Bottom Sheet widget.
///
/// This widget displays a modal sheet with optional header elements (title, leading,
/// trailing icons) and a body. The sheet is styled according to the SBB design system.
///
/// Provide either [titleText] for a simple text title or [title] for custom title
/// content. These parameters are mutually exclusive. Similarly, provide either
/// [leadingIconData] or [leading] for leading content, and either [trailingIconData]
/// or [trailing] for trailing content.
///
/// The header row is only shown if at least one of the following is true:
///  * [title] or [titleText] is provided
///  * [leading] or [leadingIconData] is provided
///  * [trailing] or [trailingIconData] is provided
///  * [showCloseButton] is true
///
/// See also:
///
/// * [showSBBBottomSheet], which is typically used to display this Widget.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/modal-view/>
class SBBBottomSheet extends StatelessWidget {
  const SBBBottomSheet({
    super.key,
    required this.body,
    this.title,
    this.titleText,
    this.leading,
    this.leadingIconData,
    this.trailing,
    this.trailingIconData,
    this.showCloseButton = true,
    this.useRootNavigator = false,
    this.style,
  });

  /// A custom widget displayed as the sheet's title.
  ///
  /// For simple text titles, use [titleText] instead.
  ///
  /// Cannot be used together with [titleText].
  final Widget? title;

  /// Text string to display as the sheet's title.
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

  /// The main content widget of the bottom sheet.
  final Widget body;

  /// Whether to show a close button in the header.
  final bool showCloseButton;

  /// Whether to use the root navigator when popping the sheet.
  ///
  /// When true, [Navigator.of] will use [rootNavigator: true] to dismiss
  /// the sheet. This is useful when the sheet needs to be dismissed from
  /// a context that is not the direct parent of the sheet.
  ///
  /// Defaults to false.
  final bool useRootNavigator;

  /// Customizes this sheet's appearance.
  ///
  /// Non-null properties of this style override the corresponding
  /// properties from the theme's default [SBBBottomSheetStyle].
  final SBBBottomSheetStyle? style;

  @override
  Widget build(BuildContext context) {
    final themeStyle = Theme.of(context).sbbBottomSheetTheme?.style;
    final SBBBottomSheetStyle resolvedStyle = (themeStyle ?? SBBBottomSheetStyle()).merge(style);

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
        textStyle: resolvedStyle.leadingTextStyle,
        foregroundColor: resolvedStyle.leadingForegroundColor,
      );
    }

    if (trailingWidget != null) {
      trailingWidget = _addDefaultAncestorWithResolved(
        child: trailingWidget,
        foregroundColor: resolvedStyle.trailingForegroundColor,
        textStyle: resolvedStyle.trailingTextStyle,
      );
    }

    final Widget child;
    if (titleWidget != null || leadingWidget != null || trailingWidget != null || showCloseButton) {
      final resolvedTitleRowPadding = _resolvedTitlePadding(resolvedStyle);
      final resolvedBodyPadding = _resolvedBodyPadding(resolvedStyle);
      child = Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: resolvedTitleRowPadding,
            child: _BottomSheetTitleRow(
              title: titleWidget,
              leading: leadingWidget,
              trailing: trailingWidget,
              showCloseButton: showCloseButton,
              style: resolvedStyle,
              useRootNavigator: useRootNavigator,
            ),
          ),
          Flexible(
            child: Padding(padding: resolvedBodyPadding, child: body),
          ),
        ],
      );
    } else {
      child = Padding(
        padding: resolvedStyle.padding ?? EdgeInsets.zero,
        child: body,
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(color: resolvedStyle.backgroundColor),
      child: child,
    );
  }

  EdgeInsets _resolvedBodyPadding(SBBBottomSheetStyle style) =>
      (style.padding ?? EdgeInsets.zero).copyWith(top: style.titleBodyGap ?? 0);

  // need to adjust for the close button
  EdgeInsets _resolvedTitlePadding(SBBBottomSheetStyle style) {
    return (style.padding ?? EdgeInsets.zero).copyWith(
      right: showCloseButton ? SBBSpacing.xSmall : style.padding?.right ?? 0.0,
      bottom: 0.0,
    );
  }

  static Widget _addDefaultAncestorWithResolved({
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
}

class _BottomSheetTitleRow extends StatelessWidget {
  const _BottomSheetTitleRow({
    this.title,
    this.leading,
    this.trailing,
    required this.showCloseButton,
    required this.style,
    required this.useRootNavigator,
  });

  final Widget? title;
  final Widget? leading;
  final Widget? trailing;
  final bool showCloseButton;
  final SBBBottomSheetStyle style;
  final bool useRootNavigator;

  @override
  Widget build(BuildContext context) {
    final closeButton = showCloseButton ? _CloseButton(useRootNavigator: useRootNavigator) : null;

    final nonNullChildren = [title, leading, trailing, closeButton].nonNulls.toList(growable: false);

    if (nonNullChildren.isEmpty) return SizedBox.shrink();

    final Widget child;
    if (nonNullChildren.length > 1) {
      child = Row(
        spacing: SBBSpacing.xSmall,
        children: [
          ?leading,
          if (title != null) Expanded(child: title!),
          ?trailing,
          ?closeButton,
        ],
      );
    } else {
      child = nonNullChildren.first;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: style.titleMinHeight ?? SBBSpacing.xLarge),
      child: child,
    );
  }
}

class _ModalHeader extends StatelessWidget {
  const _ModalHeader(this.title, {this.showCloseButton = true, this.useRootNavigator = true});

  final String title;
  final bool showCloseButton;
  final bool useRootNavigator;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).sbbBottomSheetTheme?.style;
    return Row(
      children: [
        Expanded(
          child: Semantics(header: true, child: Text(title, style: style?.titleTextStyle)),
        ),
        if (showCloseButton) _CloseButton(useRootNavigator: useRootNavigator),
      ],
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.useRootNavigator});

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

Widget _wrapWithBottomSafeArea(Widget child) {
  return SafeArea(top: false, left: false, right: false, child: child);
}
