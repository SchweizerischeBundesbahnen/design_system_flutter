import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/src/toast/toast_container.dart';

import '../../sbb_design_system_mobile.dart';

class ToastActionBody extends StatefulWidget {
  const ToastActionBody({required this.onPressed, required this.title, required this.style, super.key});

  final VoidCallback onPressed;
  final String title;
  final SBBToastStyle style;

  @override
  State<ToastActionBody> createState() => _ToastActionBodyState();
}

class _ToastActionBodyState extends State<ToastActionBody> {
  bool _isActionBeenTriggered = false;

  void _handlePressed(VoidCallback? hideToast) {
    if (_isActionBeenTriggered) return;

    setState(() => _isActionBeenTriggered = true);
    widget.onPressed();
    hideToast?.call();
  }

  @override
  Widget build(BuildContext context) {
    final toastContainer = ToastContainer.of(context);

    return GestureDetector(
      onTap: _isActionBeenTriggered ? null : () => _handlePressed(toastContainer.toast?.hide),
      child: Text(widget.title, style: widget.style.actionTextStyle),
    );
  }
}
