import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// The SBB Secondary Button. Use according to documentation.
///
/// The [label] parameter must not be null.
///
/// If [isLoading] is true, then the [SBBLoadingIndicator] will be displayed inside the button and the [onPressed] callback will be ignored.
///
/// If [onPressed] callback is null, then the button will be disabled.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/button>
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
      style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
            padding: SBBTheme.allStates(EdgeInsets.zero),
          ),
      onPressed: isLoading ? null : onPressed,
      focusNode: focusNode,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
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
      ),
    );
  }
}
