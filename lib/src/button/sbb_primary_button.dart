import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';
import 'sbb_button_styles.dart';

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
    final SBBThemeData theme = SBBTheme.of(context);
    switch (theme.hostPlatform) {
      case HostPlatform.native:
        return _buildThemedMobile(theme);
      case HostPlatform.web:
        return _buildThemedWeb(theme);
      default:
        return _buildThemedMobile(theme);
    }
  }

  ElevatedButton _buildThemedMobile(SBBThemeData theme) {
    return ElevatedButton(
      style: SBBButtonStyles.primaryMobile(theme: theme),
      onPressed: isLoading ? null : onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) SBBLoadingIndicator.tinyCloud(),
          SBBButtonContent(label: label)
        ],
      ),
    );
  }

  ElevatedButton _buildThemedWeb(SBBThemeData theme) {
    return ElevatedButton(
        style: SBBButtonStyles.primaryWebLean(theme: theme),
        onPressed: onPressed,
        focusNode: focusNode,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SBBButtonContent(label: label),
          ],
        ));
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
    final SBBThemeData theme = SBBTheme.of(context);
    switch (theme.hostPlatform) {
      case HostPlatform.native:
        return _buildThemedMobile(theme);
      case HostPlatform.web:
        return _buildThemedWeb(theme);
      default:
        return _buildThemedMobile(theme);
    }
  }

  Widget _buildThemedMobile(SBBThemeData theme) {
    return ElevatedButton(
      style: SBBButtonStyles.primaryMobileNegative(theme: theme),
      onPressed: isLoading ? null : onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) SBBLoadingIndicator.tinyCloud(),
          SBBButtonContent(label: label)
        ],
      ),
    );
  }

  Widget _buildThemedWeb(SBBThemeData theme) {
    return ElevatedButton(
      style: SBBButtonStyles.primaryWebNegative(theme: theme),
      onPressed: onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SBBButtonContent(label: label)],
      ),
    );
  }
}
