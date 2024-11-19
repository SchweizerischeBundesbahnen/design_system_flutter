import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// The SBB Icon Form Button. Use according to documentation.
///
/// The [icon] parameter must not be null. Make sure to use small icons
/// ([sbbIconSizeSmall] - 24x24).
///
/// If [onPressed] callback is null, then the button will be disabled.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/button>
class SBBIconFormButton extends StatelessWidget {
  const SBBIconFormButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.focusNode,
  });

  static const _buttonSize = 48.0;

  final IconData icon;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseStyle = theme.textButtonTheme.style?.copyWith(
      minimumSize: SBBTheme.allStates(const Size(_buttonSize, _buttonSize)),
      fixedSize: SBBTheme.allStates(const Size(_buttonSize, _buttonSize)),
      padding: SBBTheme.allStates(EdgeInsets.zero),
      shape: SBBTheme.allStates(const RoundedRectangleBorder()),
    );
    return TextButton(
      style: SBBButtonStyles.of(context)
          .iconFormStyle
          ?.overrideButtonStyle(baseStyle),
      onPressed: onPressed,
      focusNode: focusNode,
      child: Icon(icon, size: sbbIconSizeSmall),
    );
  }
}
