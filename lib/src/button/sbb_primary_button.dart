import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// The SBB Primary Button. Use according to documentation.
///
/// The [label] parameter must not be null.
///
/// If [isLoading] is true, then the [SBBLoadingIndicator] will be displayed
/// inside the button and the [onPressed] callback will be ignored.
///
/// If [onPressed] callback is null, then the button will be disabled.
///
/// For specifications see:
///
/// * <https://digital.sbb.ch/en/design-system/mobile/components/button/>
class SBBPrimaryButton extends StatelessWidget {
  const SBBPrimaryButton({
    super.key,
    required this.label,
    this.isLoading = false,
    required this.onPressed,
    this.focusNode,
  });

  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final styles = SBBButtonStyles.of(context);
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) const SBBLoadingIndicator.tinyCloud(),
          styles.buttonLabelBuilder!(context, label),
        ],
      ),
    );
  }
}
