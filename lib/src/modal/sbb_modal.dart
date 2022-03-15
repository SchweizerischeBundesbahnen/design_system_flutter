import 'dart:ui';

import 'package:flutter/material.dart';

import '../sbb_internal.dart';
import '../../design_system_flutter.dart';

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
/// * <https://digital.sbb.ch/de/design-system-mobile-new/module/modal>
Future<T?> showSBBModalPopup<T>({
  required BuildContext context,
  required String title,
  required Widget child,
  Clip clipBehavior = Clip.none,
}) {
  return showDialog<T>(
    context: context,
    builder: (BuildContext context) {
      return SBBModalPopup(
        title: title,
        child: child,
        clipBehavior: clipBehavior,
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
/// * <https://digital.sbb.ch/de/design-system-mobile-new/module/modal>
class SBBModalPopup extends StatelessWidget {
  const SBBModalPopup({
    Key? key,
    required this.title,
    required this.child,
    this.clipBehavior = Clip.none,
  }) : super(key: key);

  final String title;
  final Widget child;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    var sbbTheme = SBBTheme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(sbbDefaultSpacing),
      ),
      clipBehavior: clipBehavior,
      backgroundColor: sbbTheme.modalBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ModalHeader(title),
          child,
        ],
      ),
    );
  }
}

/// Shows a SBB Modal Sheet. Use according to documentation.
///
/// If you try to close the sheet but the underlying page is navigated back
/// instead, try using the `rootNavigator` parameter of the `Navigator`:
/// ```dart
/// Navigator.of(context, rootNavigator: true).pop(result)
/// ```
///
/// See also:
///
/// * [SBBModalSheet], which will be displayed.
/// * [showModalBottomSheet], which is used to display the modal.
/// * <https://digital.sbb.ch/de/design-system-mobile-new/module/modal>
Future<T?> showSBBModalSheet<T>({
  required BuildContext context,
  required String title,
  required Widget child,
  bool useRootNavigator = false,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: SBBColors.transparent,
    useRootNavigator: useRootNavigator,
    builder: (BuildContext context) {
      return SBBModalSheet(
        title: title,
        child: child,
      );
    },
    barrierColor: SBBInternal.barrierColor,
  );
}

Future<T?> showCustomSBBModalSheet<T>({
  required BuildContext context,
  required Widget header,
  required Widget child,
  bool useRootNavigator = false,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: SBBColors.transparent,
    useRootNavigator: useRootNavigator,
    builder: (BuildContext context) {
      return SBBModalSheet.custom(
        header: header,
        child: child,
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
/// * <https://digital.sbb.ch/de/design-system-mobile-new/module/modal>
class SBBModalSheet extends StatelessWidget {
  SBBModalSheet({
    Key? key,
    required String title,
    required Widget child,
  }) : this._(
          key: key,
          headerBuilder: (BuildContext context) => Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              sbbDefaultSpacing,
              sbbDefaultSpacing,
              0.0,
              sbbDefaultSpacing,
            ),
            child: Text(
              title,
              style: SBBTheme.of(context).modalTitleTextStyle,
            ),
          ),
          child: child,
        );

  SBBModalSheet.custom({
    Key? key,
    required Widget header,
    required Widget child,
  }) : this._(
          key: key,
          headerBuilder: (BuildContext context) => header,
          child: child,
        );

  const SBBModalSheet._({
    Key? key,
    required this.headerBuilder,
    required this.child,
  }) : super(key: key);

  final WidgetBuilder headerBuilder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final sbbTheme = SBBTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            height: sbbTheme.statusBarHeight + sbbDefaultSpacing,
            color: SBBColors.transparent,
          ),
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: sbbTheme.modalBackgroundColor,
              borderRadius: BorderRadius.only(
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
                    Expanded(
                      child: headerBuilder.call(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SBBIconButtonSmall(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: SBBIcons.cross_small,
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ModalHeader extends StatelessWidget {
  const _ModalHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              sbbDefaultSpacing,
              sbbDefaultSpacing,
              0.0,
              sbbDefaultSpacing,
            ),
            child: Text(title, style: SBBTheme.of(context).modalTitleTextStyle),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: SBBIconButtonSmall(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: SBBIcons.cross_small,
          ),
        ),
      ],
    );
  }
}
