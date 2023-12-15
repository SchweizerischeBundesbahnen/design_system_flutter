import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';

/// Large variant of the SBB Tertiary Button. Use according to documentation.
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
class SBBTertiaryButtonLarge extends StatelessWidget {
  const SBBTertiaryButtonLarge({
    super.key,
    required this.label,
    this.icon,
    this.isLoading = false,
    required this.onPressed,
    this.focusNode,
  });

  final String label;
  final IconData? icon;
  final bool isLoading;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final style = SBBBaseStyle.of(context);
    final buttonStyles = SBBButtonStyles.of(context);
    return TextButton(
      style: Theme.of(context).textButtonTheme.style?.copyWith(
            // workaround for web
            padding: SBBTheme.allStates(EdgeInsets.zero),
          ),
      onPressed: isLoading ? null : onPressed,
      focusNode: focusNode,
      child: Padding(
        // workaround for web
        padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading)
              style.themeValue(
                const SBBLoadingIndicator.tinySmoke(),
                const SBBLoadingIndicator.tinyCement(),
              )
            else if (icon != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 4.0),
                child: Icon(icon, size: sbbIconSizeSmall),
              ),
            buttonStyles.buttonLabelBuilder!(context, label),
          ],
        ),
      ),
    );
  }
}

/// Small variant of the SBB Tertiary Button. Use according to documentation.
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
class SBBTertiaryButtonSmall extends StatelessWidget {
  const SBBTertiaryButtonSmall({
    Key? key,
    required this.label,
    this.icon,
    this.isLoading = false,
    required this.onPressed,
    this.focusNode,
  }) : super(key: key);

  final String label;
  final IconData? icon;
  final bool isLoading;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textButtonTheme.style?.copyWith(
          fixedSize: SBBTheme.allStates(
            const Size.fromHeight(SBBInternal.defaultButtonHeightSmall),
          ),
          // workaround for web
          padding: SBBTheme.allStates(EdgeInsets.zero),
        );
    final style = SBBBaseStyle.of(context);
    final buttonStyle = SBBButtonStyles.of(context);
    return TextButton(
      style: buttonStyle.tertiarySmallStyle?.overrideButtonStyle(baseStyle),
      onPressed: onPressed,
      focusNode: focusNode,
      child: Padding(
        // workaround for web
        padding: EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading)
              style.themeValue(
                const SBBLoadingIndicator.tinyCement(),
                const SBBLoadingIndicator.tinySmoke(),
              )
            else if (icon != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 4.0),
                child: Icon(icon, size: sbbIconSizeSmall),
              ),
            buttonStyle.buttonLabelBuilder!(context, label),
          ],
        ),
      ),
    );
  }
}
