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
    final bool _isLoadingAndNative =
        (isLoading) && (theme.hostPlatform == HostPlatform.native);

    return ElevatedButton(
      style: SBBButtonStyles.primaryButtonStyle(theme),
      onPressed: _isLoadingAndNative ? null : onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isLoadingAndNative) SBBLoadingIndicator.tinyCloud(),
          SBBButtonContent(label: label)
        ],
      ),
    );
  }
}

/// Negative variant of the SBB Primary Button. Use according to documentation.
///
/// This widget turns to the Alternative Primary Button
/// in the Web Lean specification in [HostPlatform.web].
///
/// The [label] parameter must not be null.
///
/// If [isLoading] is true, then the [SBBLoadingIndicator] will be displayed
/// inside the button and the [onPressed] callback will be ignored.
///
/// If [onPressed] callback is null, then the button will be disabled.
///
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
    final bool _isLoadingAndNative =
        (isLoading) && (theme.hostPlatform == HostPlatform.native);

    return ElevatedButton(
      style: SBBButtonStyles.primaryNegativeButtonStyle(theme),
      onPressed: _isLoadingAndNative ? null : onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isLoadingAndNative) SBBLoadingIndicator.tinyCloud(),
          SBBButtonContent(label: label)
        ],
      ),
    );
  }
}
