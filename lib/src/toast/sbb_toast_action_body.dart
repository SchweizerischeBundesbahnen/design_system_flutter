import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

class SBBToastActionBody extends StatefulWidget {
  const SBBToastActionBody({
    required this.onPressed,
    required this.title,
    required this.toast,
    required this.style,
    super.key,
  });

  final VoidCallback onPressed;
  final String title;
  final SBBToast toast;
  final SBBToastStyle style;

  @override
  State<SBBToastActionBody> createState() => _SBBToastActionBodyState();
}

class _SBBToastActionBodyState extends State<SBBToastActionBody> {
  bool _isActionBeenTriggered = false;

  void _handlePressed() {
    if (_isActionBeenTriggered) return;

    setState(() => _isActionBeenTriggered = true);
    widget.onPressed();
    widget.toast.hide();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _isActionBeenTriggered ? null : _handlePressed,
        child: Text(
          widget.title,
          style: widget.style.actionTextStyle,
        ),
      );
}
