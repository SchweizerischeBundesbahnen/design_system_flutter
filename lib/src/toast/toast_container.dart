import 'package:flutter/cupertino.dart';
import 'package:sbb_design_system_mobile/src/toast/default_toast_body.dart';
import 'package:sbb_design_system_mobile/src/toast/toast_action_body.dart';

import '../../sbb_design_system_mobile.dart';

/// The [ToastContainer] is an [InheritedWidget] that provides the
/// [stream] and [SBBToast] to the
/// * [DefaultToastBody]
/// * [ToastActionBody]
///
/// and all other widgets that are used in the [SBBMap.uiControlsBuilder] method.
class ToastContainer extends InheritedWidget {
  const ToastContainer({super.key, required this.stream, required super.child, this.toast});

  final Stream<bool> stream;
  final SBBToast? toast;

  static ToastContainer? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ToastContainer>();
  }

  static ToastContainer of(BuildContext context) {
    final ToastContainer? result = maybeOf(context);
    assert(result != null, 'No SBBToastContainer found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ToastContainer oldWidget) =>
      oldWidget.stream != stream || oldWidget.toast != toast;
}
