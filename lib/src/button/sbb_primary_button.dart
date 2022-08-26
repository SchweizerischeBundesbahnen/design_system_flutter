import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';
import 'sbb_button_style_extensions.dart';

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
    return ElevatedButton(
      style: SBBButtonStyles.of(context).primaryMobile,
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

  ElevatedButton _buildThemedWeb(BuildContext context) {
    return ElevatedButton(
      style: SBBButtonStyles.of(context).primaryWebLean,
      onPressed: onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SBBButtonContent(label: label)
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
    final theme = Theme.of(context);
    switch (SBBBaseStyle.of(context).hostPlatform) {
      case HostPlatform.native:
        return _buildThemedMobile(theme);
      case HostPlatform.web:
        return _buildThemedWeb(theme);
      default:
        return _buildThemedMobile(theme);
    }
  }

  Widget _buildThemedMobile(ThemeData theme) {
    return ElevatedButton(
      style: theme.extension<SBBButtonStyles>()?.primaryMobileNegative,
      onPressed: isLoading ? null : onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) SBBLoadingIndicator.tinyCloud(),
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

  Widget _buildThemedWeb(ThemeData theme) {
    return ElevatedButton(
      style: theme.extension<SBBButtonStyles>()?.primaryWebNegative,
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
