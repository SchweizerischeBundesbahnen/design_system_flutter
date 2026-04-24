import 'package:flutter/widgets.dart';

import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

/// The [ToastScope] is an [InheritedWidget] that provides the
/// [stream] and [SBBToast] to the
/// * [DefaultToastBody]
class ToastScope extends InheritedWidget {
  const ToastScope({
    super.key,
    required super.child,
    required this.stream,
    this.toast,
    this.style,
  });

  final Stream<bool> stream;
  final SBBToast? toast;
  final SBBToastStyle? style;

  static ToastScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ToastScope>();
  }

  static ToastScope of(BuildContext context) {
    final ToastScope? result = maybeOf(context);
    assert(result != null, 'No SBBToastContainer found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ToastScope oldWidget) => oldWidget.stream != stream || oldWidget.toast != toast;
}
