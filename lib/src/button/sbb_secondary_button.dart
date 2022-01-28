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
    final sbbTheme = SBBTheme.of(context);
    return OutlinedButton(
      style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
            // workaround for web
            padding: SBBInternal.all(EdgeInsets.zero),
          ),
      onPressed: isLoading ? null : onPressed,
      focusNode: focusNode,
      child: Padding(
        // workaround for web
        padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) sbbTheme.isDark ? const SBBLoadingIndicator.tinyCement() : const SBBLoadingIndicator.tinySmoke(),
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
