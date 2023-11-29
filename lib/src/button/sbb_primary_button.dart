import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

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
    switch (SBBBaseStyle.of(context).hostPlatform) {
      case HostPlatform.native:
        return _buildThemedMobile(context);
      case HostPlatform.web:
        return _buildThemedWeb(context);
      default:
        return _buildThemedMobile(context);
    }
  }

  ElevatedButton _buildThemedMobile(BuildContext context) {
    final styles = SBBButtonStyles.of(context);
    return ElevatedButton(
      style: styles.primaryMobile,
      onPressed: isLoading ? null : onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) SBBLoadingIndicator.tinyCloud(),
          styles.buttonLabelBuilder!(context, label),
        ],
      ),
    );
  }

  ElevatedButton _buildThemedWeb(BuildContext context) {
    final styles = SBBButtonStyles.of(context);
    return ElevatedButton(
      style: styles.primaryWebLean,
      onPressed: onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
    Key? key,
    required this.label,
    this.isLoading = false,
    required this.onPressed,
    this.focusNode,
  }) : super(key: key);

  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    switch (SBBBaseStyle.of(context).hostPlatform) {
      case HostPlatform.native:
        return _buildThemedMobile(context);
      case HostPlatform.web:
        return _buildThemedWeb(context);
      default:
        return _buildThemedMobile(context);
    }
  }

  Widget _buildThemedMobile(BuildContext context) {
    final styles = SBBButtonStyles.of(context);
    return ElevatedButton(
      style: styles.primaryMobileNegative,
      onPressed: isLoading ? null : onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) SBBLoadingIndicator.tinyCloud(),
          styles.buttonLabelBuilder!(context, label),
        ],
      ),
    );
  }

  Widget _buildThemedWeb(BuildContext context) {
    final styles = SBBButtonStyles.of(context);
    return ElevatedButton(
      style: styles.primaryWebNegative,
      onPressed: onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          styles.buttonLabelBuilder!(context, label),
        ],
      ),
    );
  }
}
