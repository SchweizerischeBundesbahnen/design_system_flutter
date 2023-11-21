import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';

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
    super. key,
    this.label,
    this.child,
    this.isLoading = false,
    required this.onPressed,
    this.focusNode,
  }) : assert(label != null && child == null || label == null && child != null);

  final String? label;
  final Widget? child;
  final bool isLoading;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final isWeb = SBBBaseStyle.of(context).hostPlatform == HostPlatform.web;
    final style = SBBBaseStyle.of(context);
    return OutlinedButton(
      style: isWeb
          ? Theme.of(context).extension<SBBButtonStyles>()?.secondaryWebLean
          : Theme.of(context).outlinedButtonTheme.style?.copyWith(
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
            if (label == null) child! else SBBButtonContent(label: label!),
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
    if (SBBBaseStyle.of(context).hostPlatform == HostPlatform.native)
      debugPrint('WARNING: Ghost button should only be used for web platform.');
    return OutlinedButton(
      style: Theme.of(context).extension<SBBButtonStyles>()?.ghostWebLean,
      onPressed: onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SBBButtonContent(label: label)],
      ),
    );
  }
}
