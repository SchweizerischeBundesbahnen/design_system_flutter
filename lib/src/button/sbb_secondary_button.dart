import 'package:design_system_flutter/src/sbb_internal.dart';
import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import 'sbb_button_styles.dart';

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
    final theme = SBBTheme.of(context);
    final bool _isLoadingAndNative =
        (isLoading) && (theme.hostPlatform == HostPlatform.native);

    return OutlinedButton(
      style: SBBButtonStyles.secondaryButtonStyle(theme),
      onPressed: _isLoadingAndNative ? null : onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isLoadingAndNative)
            theme.isDark
                ? const SBBLoadingIndicator.tinyCement()
                : const SBBLoadingIndicator.tinySmoke(),
          SBBButtonContent(label: label)
        ],
      ),
    );
  }
}

class SBBGhostButton extends StatelessWidget {
  const SBBGhostButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.focusNode,
  }) : super(key: key);

  final String label;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final theme = SBBTheme.of(context);
    if (theme.hostPlatform == HostPlatform.native)
      debugPrint('WARNING: Ghost button should only be used for web platform.');
    return OutlinedButton(
      style: SBBButtonStyles.ghostButtonStyle(theme),
      onPressed: onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SBBButtonContent(label: label)],
      ),
    );
  }
}
