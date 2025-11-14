import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// The secondary variant of the SBB Button.
///
/// The [label] parameter must not be null.
///
/// If [isLoading] is true, then the [SBBLoadingIndicator] will be displayed
/// inside the button and the [onPressed] callback will be ignored.
///
/// If [onPressed] callback is null, then the button will be disabled.
///
/// See also:
///
/// * <https://digital.sbb.ch/en/design-system/mobile/components/button/>
class SBBSecondaryButton extends StatelessWidget {
  const SBBSecondaryButton({
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
    final style = SBBBaseStyle.of(context);
    final buttonStyles = SBBButtonStyles.of(context);
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading)
            style.themeValue(
              const SBBLoadingIndicator.tinySmoke(),
              const SBBLoadingIndicator.tinyCement(),
            ),
          buttonStyles.buttonLabelBuilder!(context, label),
        ],
      ),
    );
  }
}
