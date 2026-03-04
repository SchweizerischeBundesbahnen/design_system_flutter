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
/// * [showDialog], which is used to display the modal.
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
/// * [showCustomSBBModalSheet], variant for custom modal sheet.
/// * [SBBBottomSheet], which will be displayed.
/// * [showModalBottomSheet], which is used to display the modal.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/modal-view/>
Future<T?> showSBBBottomSheet<T>({
  required BuildContext context,
  required String title,
  required Widget body,
  Color? backgroundColor, // TODO: move to style
  String? barrierLabel,
  ShapeBorder? shape, // TODO: move to style as static const
  Clip? clipBehavior, // TODO: move to style
  BoxConstraints? constraints, // TODO: move to style
  Color barrierColor = SBBInternal.barrierColor, // TODO: move to style
  bool isScrollControlled = false, // TODO: EXPLICITLY STATE THAT THIS WAS DEFAULTED TO FALSE
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
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: SBBColors.green,
    // TODO: move to style
    barrierLabel: barrierLabel,
    shape: shape,
    // TODO: move to style
    clipBehavior: clipBehavior,
    // TODO: move to style
    constraints: constraints,
    // TODO: move to style
    barrierColor: barrierColor,
    // TODO: move to style
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
        title: title,
        // TODO: add this to the documentation that isDismissible influences this
        showCloseButton: isDismissible && showCloseButton,
        backgroundColor: backgroundColor,
        child: useSafeArea ? _wrapWithBottomSafeArea(body) : body,
      );
    },
  );
}

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
/// * [showSBBBottomSheet], which is used to display the modal.
/// * [SBBBottomSheet], which will be displayed.
/// * [showModalBottomSheet], which is used to display the modal.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/modal-view/>
Future<T?> showCustomSBBModalSheet<T>({
  required BuildContext context,
  required Widget header,
  required Widget child,
  bool useRootNavigator = true,
  bool useSafeArea = true,
  bool enableDrag = true,
  bool showCloseButton = true,
  Color? backgroundColor,
  BoxConstraints? constraints,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: SBBColors.green,
    useRootNavigator: useRootNavigator,
    useSafeArea: useSafeArea,
    enableDrag: enableDrag,
    constraints: constraints,
    builder: (_) {
      return SBBBottomSheet.custom(
        header: header,
        showCloseButton: showCloseButton,
        backgroundColor: backgroundColor,
        child: useSafeArea ? _wrapWithBottomSafeArea(child) : child,
      );
    },
    barrierColor: SBBInternal.barrierColor,
  );
}

/// The SBB Modal Sheet. Use according to documentation.
///
/// See also:
///
/// * [showSBBBottomSheet], which is typically used to display this Widget.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/modal-view/>
class SBBBottomSheet extends StatelessWidget {
  SBBBottomSheet({
    Key? key,
    required String title,
    required Widget child,
    bool showCloseButton = true,
    Color? backgroundColor,
  }) : this._(
         key: key,
         headerBuilder: (context) => Padding(
           padding: const EdgeInsetsDirectional.fromSTEB(
             SBBSpacing.medium,
             SBBSpacing.medium,
             0.0,
             SBBSpacing.medium,
           ),
           child: Semantics(
             header: true,
             child: Text(title, style: SBBControlStyles.of(context).modalTitleTextStyle),
           ),
         ),
         showCloseButton: showCloseButton,
         backgroundColor: backgroundColor,
         child: child,
       );

  SBBBottomSheet.custom({
    Key? key,
    required Widget header,
    required Widget child,
    bool showCloseButton = true,
    Color? backgroundColor,
  }) : this._(
         key: key,
         headerBuilder: (_) => header,
         showCloseButton: showCloseButton,
         backgroundColor: backgroundColor,
         child: child,
       );

  const SBBBottomSheet._({
    super.key,
    required this.headerBuilder,
    required this.child,
    required this.showCloseButton,
    this.backgroundColor,
  });

  final WidgetBuilder headerBuilder;
  final Widget child;
  final bool showCloseButton;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context);
    return Column(
      mainAxisSize: .min,
      children: [
        ExcludeSemantics(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(height: SBBSpacing.medium, color: SBBColors.transparent),
          ),
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? style.modalBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: .circular(SBBSpacing.medium),
                topRight: .circular(SBBSpacing.medium),
              ),
            ),
            child: Column(
              mainAxisSize: .min,
              children: [
                Row(
                  crossAxisAlignment: .start,
                  children: [
                    Expanded(child: headerBuilder(context)),
                    if (showCloseButton) _CloseButton(),
                  ],
                ),
                Flexible(child: child),
              ],
            ),
          ),
        ),
      ],
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
