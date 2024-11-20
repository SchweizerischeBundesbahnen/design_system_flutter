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
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/button>
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
    return ElevatedButton(
      style: styles.primaryMobile,
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

/// Negative variant of the SBB Primary Button. Use according to documentation.
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
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/button>
class SBBPrimaryButtonNegative extends StatelessWidget {
  const SBBPrimaryButtonNegative({
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
    return ElevatedButton(
      style: styles.primaryMobileNegative,
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
