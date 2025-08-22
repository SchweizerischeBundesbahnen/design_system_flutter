import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import '../sbb_internal.dart';

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
  Clip clipBehavior = Clip.none,
  bool showCloseButton = true,
  Color? backgroundColor,
}) {
  return showDialog<T>(
    context: context,
    builder: (BuildContext context) {
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
    this.clipBehavior = Clip.none,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sbbDefaultSpacing)),
      clipBehavior: clipBehavior,
      backgroundColor: backgroundColor ?? style.modalBackgroundColor,
      child: Semantics(
        explicitChildNodes: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_ModalHeader(title, showCloseButton: showCloseButton), child],
        ),
      ),
    );
  }
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
/// * [showCustomSBBModalSheet], variant for custom modal sheet.
/// * [SBBModalSheet], which will be displayed.
/// * [showModalBottomSheet], which is used to display the modal.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/modal-view/>
Future<T?> showSBBModalSheet<T>({
  required BuildContext context,
  required String title,
  required Widget child,
  bool useRootNavigator = true,
  bool useSafeArea = true,
  bool enableDrag = true,
  bool showCloseButton = true,
  BoxConstraints? constraints,
  Color? backgroundColor,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: SBBColors.transparent,
    useRootNavigator: useRootNavigator,
    useSafeArea: useSafeArea,
    enableDrag: enableDrag,
    constraints: constraints,
    builder: (BuildContext context) {
      return SBBModalSheet(
        title: title,
        showCloseButton: showCloseButton,
        backgroundColor: backgroundColor,
        child: useSafeArea ? _wrapWithBottomSafeArea(child) : child,
      );
    },
    barrierColor: SBBInternal.barrierColor,
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
/// * [showSBBModalSheet], which is used to display the modal.
/// * [SBBModalSheet], which will be displayed.
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
    backgroundColor: SBBColors.transparent,
    useRootNavigator: useRootNavigator,
    useSafeArea: useSafeArea,
    enableDrag: enableDrag,
    constraints: constraints,
    builder: (BuildContext context) {
      return SBBModalSheet.custom(
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
/// * [showSBBModalSheet], which is typically used to display this Widget.
/// * <https://digital.sbb.ch/en/design-system/mobile/components/modal-view/>
class SBBModalSheet extends StatelessWidget {
  SBBModalSheet({
    Key? key,
    required String title,
    required Widget child,
    bool showCloseButton = true,
    Color? backgroundColor,
  }) : this._(
         key: key,
         headerBuilder:
             (BuildContext context) => Padding(
               padding: const EdgeInsetsDirectional.fromSTEB(
                 sbbDefaultSpacing,
                 sbbDefaultSpacing,
                 0.0,
                 sbbDefaultSpacing,
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

  SBBModalSheet.custom({
    Key? key,
    required Widget header,
    required Widget child,
    bool showCloseButton = true,
    Color? backgroundColor,
  }) : this._(
         key: key,
         headerBuilder: (BuildContext context) => header,
         showCloseButton: showCloseButton,
         backgroundColor: backgroundColor,
         child: child,
       );

  const SBBModalSheet._({
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
      mainAxisSize: MainAxisSize.min,
      children: [
        ExcludeSemantics(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(height: sbbDefaultSpacing, color: SBBColors.transparent),
          ),
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? style.modalBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(sbbDefaultSpacing),
                topRight: Radius.circular(sbbDefaultSpacing),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(sbbDefaultSpacing, sbbDefaultSpacing, 0.0, sbbDefaultSpacing),
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
      padding: const EdgeInsets.all(6.0),
      child: SBBIconButtonSmall(onPressed: () => Navigator.of(context).pop(), icon: SBBIcons.cross_small),
    ),
  );
}

Widget _wrapWithBottomSafeArea(Widget child) {
  return SafeArea(top: false, left: false, right: false, child: child);
}
