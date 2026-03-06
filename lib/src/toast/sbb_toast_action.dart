import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/src/toast/toast_scope.dart';

import '../../sbb_design_system_mobile.dart';

/// An action button for use within a [SBBToast].
///
/// This widget is automatically wrapped in a [GestureDetector] and will hide the toast
/// when tapped, unless [hideOnTap] is set to false.
///
/// Use this widget when you want to provide an interactive action within a toast,
/// such as "Undo" or "Retry". The button automatically manages the pressed state
/// to prevent duplicate triggers.
///
/// **Example:**
/// ```dart
/// SBBToast.of(context).show(
///   titleText: 'Item deleted',
///   action: SBBToastAction(
///     title: 'Undo',
///     onTap: () => undoDelete(),
///   ),
/// );
/// ```
///
/// For complete control over action appearance and behavior, pass a custom widget
/// to [SBBToast.show] via the [action] parameter instead.
class SBBToastAction extends StatefulWidget {
  /// Creates a [SBBToastAction].
  const SBBToastAction({
    required this.onTap,
    required this.title,
    this.hideOnTap = true,
    super.key,
  });

  /// Callback invoked when the action is tapped.
  ///
  /// This callback is always executed, regardless of the [hideOnTap] setting.
  /// The action is wrapped in a [GestureDetector], so this is triggered on tap.
  ///
  /// Tapping is prevented if already triggered once during the widget's lifetime.
  final VoidCallback onTap;

  /// The text displayed in the action button.
  ///
  /// This text is displayed using the [SBBToastStyle.actionTextStyle] from the toast's [SBBToastStyle].
  final String title;

  /// Whether to hide the toast after this action is tapped.
  ///
  /// When true (default), tapping this action automatically hides the parent toast
  /// after [onTap] completes. Set to false to keep the toast visible after the action
  /// is triggered, allowing the user to interact further or observe the result.
  ///
  /// Default: true.
  final bool hideOnTap;

  @override
  State<SBBToastAction> createState() => _SBBToastActionState();
}

class _SBBToastActionState extends State<SBBToastAction> {
  bool _isActionBeenTriggered = false;

  void _handlePressed(VoidCallback? hideToast) {
    if (_isActionBeenTriggered) return;

    setState(() => _isActionBeenTriggered = true);
    widget.onTap();
    if (widget.hideOnTap) hideToast?.call();
  }

  @override
  Widget build(BuildContext context) {
    final toastScope = ToastScope.of(context);
    final resolvedStyle = toastScope.style;

    return GestureDetector(
      onTap: _isActionBeenTriggered ? null : () => _handlePressed(toastScope.toast?.hide),
      child: Text(
        widget.title,
        style: resolvedStyle?.actionTextStyle?.copyWith(color: resolvedStyle.actionForegroundColor),
      ),
    );
  }
}
