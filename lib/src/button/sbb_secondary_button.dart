import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

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
    final style = SBBBaseStyle.of(context);
    final theme = SBBTheme.of(context);
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
    return OutlinedButton(
      style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
            // workaround for web
            padding: SBBTheme.allStates(EdgeInsets.zero),
          ),
      onPressed: isLoading ? null : onPressed,
      focusNode: focusNode,
      child: Padding(
        // workaround for web
        padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              style.themeValue(
                const SBBLoadingIndicator.tinySmoke(),
                const SBBLoadingIndicator.tinyCement(),
              ),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
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
    switch (theme.hostPlatform) {
      case HostPlatform.native:
        debugPrint(
            'WARNING: Ghost button should only be used for web platform.');
        return _buildThemedWeb(theme);
      case HostPlatform.web:
        return _buildThemedWeb(theme);
      default:
        return _buildThemedWeb(theme);
    }
  }

  Widget _buildThemedWeb(SBBThemeData theme) {
    return OutlinedButton(
      style: SBBButtonStyles.webGhost(theme: theme),
      onPressed: onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
