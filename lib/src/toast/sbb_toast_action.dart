import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/toast/toast_scope.dart';

import '../../sbb_design_system_mobile.dart';

class SBBToastAction extends StatefulWidget {
  const SBBToastAction({required this.onPressed, required this.title, this.style, super.key});

  final VoidCallback onPressed;
  final String title;
  final SBBToastStyle? style;

  @override
  State<SBBToastAction> createState() => _SBBToastActionState();
}

class _SBBToastActionState extends State<SBBToastAction> {
  bool _isActionBeenTriggered = false;

  void _handlePressed(VoidCallback? hideToast) {
    if (_isActionBeenTriggered) return;

    setState(() => _isActionBeenTriggered = true);
    widget.onPressed();
    hideToast?.call();
  }

  @override
  Widget build(BuildContext context) {
    final toastScope = ToastScope.of(context);

    return GestureDetector(
      onTap: _isActionBeenTriggered ? null : () => _handlePressed(toastScope.toast?.hide),
      child: Text(widget.title, style: widget.style?.actionTextStyle),
    );
  }
}
