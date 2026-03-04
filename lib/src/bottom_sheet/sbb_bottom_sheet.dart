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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SBBSpacing.medium)),
      clipBehavior: clipBehavior,
      backgroundColor: backgroundColor ?? style?.backgroundColor,
      child: Semantics(
        explicitChildNodes: true,
        child: Padding(
          padding: style?.padding?.copyWith(bottom: SBBSpacing.medium) ?? EdgeInsets.zero,
          child: Column(
            mainAxisSize: .min,
            children: [
              _ModalHeader(title, showCloseButton: showCloseButton),
              SizedBox(height: style?.titleBodyGap),
              Flexible(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO: parameter remodeling (optional title and move it up) - add trailing, leading and conveniences
// TODO: keep showCloseButton
// TODO: v5 Styling / Theming
// TODO: documentation
// TODO: migration guide

/// Shows an SBB Modal Sheet. Use according to documentation.
///
/// If you try to close the sheet but the underlying page is navigated back
/// instead, try using the `rootNavigator` parameter of the `Navigator`:
/// ```dart
/// Navigator.of(context, rootNavigator: true).pop(result)
/// ```
///
/// See also:
///
/// * [showCustomSBBModalSheet], variant for custom bottom_sheet sheet.
/// * [SBBBottomSheet], which will be displayed.
/// * [showModalBottomSheet], which is used to display the bottom_sheet.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/modal-view/>
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
  // TODO: EXPLICITLY STATE IN MIGRATION GUIDE THAT THIS WAS DEFAULTED TO FALSE AND SHOW EXAMPLE WITH PARAM BELOW
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
    builder: (_) {
      return SBBBottomSheet(
        key: key,
        title: title,
        titleText: titleText,
        leading: leading,
        leadingIconData: leadingIconData,
        trailing: trailing,
        trailingIconData: trailingIconData,
        // TODO: add this to the documentation that isDismissible influences this
        showCloseButton: isDismissible && showCloseButton,
        style: resolvedStyle,
        body: useSafeArea ? _wrapWithBottomSafeArea(body) : body,
      );
    },
  );
}

/// The SBB Modal Sheet. Use according to documentation.
///
/// See also:
///
/// * [showSBBBottomSheet], which is typically used to display this Widget.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/modal-view/>
class SBBBottomSheet extends StatelessWidget {
  const SBBBottomSheet({
    super.key,
    this.title,
    this.titleText,
    this.leading,
    this.leadingIconData,
    this.trailing,
    this.trailingIconData,
    required this.body,
    this.showCloseButton = true,
    this.useRootNavigator = false,
    required this.style,
  });

  final Widget? title;
  final String? titleText;
  final Widget? leading;
  final IconData? leadingIconData;
  final Widget? trailing;
  final IconData? trailingIconData;
  final Widget body;
  final bool showCloseButton;
  final bool useRootNavigator;
  final SBBBottomSheetStyle style;

  @override
  Widget build(BuildContext context) {
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
        foregroundColor: style.titleForegroundColor,
        textStyle: style.titleTextStyle,
      );
    }

    if (leadingWidget != null) {
      leadingWidget = _addDefaultAncestorWithResolved(
        child: leadingWidget,
        textStyle: style.leadingTextStyle,
        foregroundColor: style.leadingForegroundColor,
      );
    }

    if (trailingWidget != null) {
      trailingWidget = _addDefaultAncestorWithResolved(
        child: trailingWidget,
        foregroundColor: style.trailingForegroundColor,
        textStyle: style.trailingTextStyle,
      );
    }

    final Widget child;
    if (titleWidget != null || leadingWidget != null || trailingWidget != null || showCloseButton) {
      child = Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        spacing: style.titleBodyGap ?? 0,
        children: [
          _BottomSheetTitleRow(
            title: titleWidget,
            leading: leadingWidget,
            trailing: trailingWidget,
            showCloseButton: showCloseButton,
            style: style,
            useRootNavigator: useRootNavigator,
          ),
          Flexible(child: body),
        ],
      );
    } else {
      child = body;
    }

    return Container(
      padding: style.padding,
      color: style.backgroundColor,
      child: child,
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
    Widget child = title ?? const SizedBox();

    if (leading != null) {
      child = Row(
        children: [
          leading!,
          SizedBox(width: 8.0),
          Expanded(child: child),
        ],
      );
    } else {
      child = Align(alignment: .centerLeft, child: child);
    }

    if (trailing != null) {
      child = Row(
        children: [
          Expanded(child: child),
          SizedBox(width: 16.0),
          trailing!,
        ],
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: style.titleMinHeight ?? SBBSpacing.xLarge),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Expanded(child: child),
          if (showCloseButton) _CloseButton(useRootNavigator: useRootNavigator),
        ],
      ),
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
