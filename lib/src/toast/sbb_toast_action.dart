import 'package:flutter/widgets.dart';
import 'package:sbb_design_system_mobile/src/toast/toast_scope.dart';

import '../../sbb_design_system_mobile.dart';

class SBBToastAction extends StatefulWidget {
  const SBBToastAction({
    required this.onTap,
    required this.title,
    this.style,
    this.hideOnTap = true,
    super.key,
  });

  final VoidCallback onTap;
  final String title;
  final SBBToastStyle? style;
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

    return GestureDetector(
      onTap: _isActionBeenTriggered ? null : () => _handlePressed(toastScope.toast?.hide),
      child: Text(
        widget.title,
        style: widget.style?.actionTextStyle?.copyWith(color: widget.style?.actionForegroundColor),
      ),
    );
  }
}
