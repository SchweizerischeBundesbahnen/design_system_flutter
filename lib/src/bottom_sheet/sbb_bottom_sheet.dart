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
  bool showCloseButton = true,
  Color? backgroundColor,
}) {
  return showDialog<T>(
    context: context,
    builder: (_) {
      return SBBModalPopup(
        title: title,
        clipBehavior: clipBehavior,
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
    this.backgroundColor,
  });

  final String title;
  final Widget child;
  final Clip clipBehavior;
  final bool showCloseButton;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SBBSpacing.medium)),
      clipBehavior: clipBehavior,
      backgroundColor: backgroundColor ?? style.modalBackgroundColor,
      child: Semantics(
        explicitChildNodes: true,
        child: Column(
          mainAxisSize: .min,
          children: [
            _ModalHeader(title, showCloseButton: showCloseButton),
            child,
          ],
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
    required this.showCloseButton,
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
  final SBBBottomSheetStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: style.padding,
      color: style.backgroundColor,
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: style.titleMinHeight!),
            child: Row(
              mainAxisAlignment: .start,
              children: [
                Expanded(child: Text(titleText!, style: style.titleTextStyle)),
                if (showCloseButton) _CloseButton(),
              ],
            ),
          ),
          SizedBox(height: style.titleBodyGap),
          Flexible(child: body),
        ],
      ),
    );
  }
}

class _ModalHeader extends StatelessWidget {
  const _ModalHeader(this.title, {this.showCloseButton = true});

  final String title;
  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context);
    return Row(
      crossAxisAlignment: .start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(SBBSpacing.medium, SBBSpacing.medium, 0.0, SBBSpacing.medium),
            child: Semantics(header: true, child: Text(title, style: style.modalTitleTextStyle)),
          ),
        ),
        if (showCloseButton) _CloseButton(),
      ],
    );
  }
}

class _CloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Semantics(
    label: MaterialLocalizations.of(context).closeButtonTooltip,
    excludeSemantics: true,
    button: true,
    child: Padding(
      padding: const .all(6.0),
      child: SBBTertiaryButtonSmall(onPressed: () => Navigator.of(context).pop(), iconData: SBBIcons.cross_small),
    ),
  );
}

Widget _wrapWithBottomSafeArea(Widget child) {
  return SafeArea(top: false, left: false, right: false, child: child);
}
