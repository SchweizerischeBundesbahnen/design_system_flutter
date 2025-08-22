import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';
import '../sbb_internal.dart';

/// Large variant of the SBB Tertiary Button. Use according to documentation.
///
/// The [label] parameter must not be null. In case you want to show a variant of this button
/// without a label, use the [SBBIconButtonLarge].
///
/// If [isLoading] is true, then the [SBBLoadingIndicator] will be displayed
/// inside the button and the [onPressed] callback will be ignored.
///
/// If [onPressed] callback is null, then the button will be disabled.
///
/// See also:
///
/// * <https://digital.sbb.ch/en/design-system/mobile/components/button/>
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
      onPressed: isLoading ? null : onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLoading)
            style.themeValue(
              const SBBLoadingIndicator.tinySmoke(),
              const SBBLoadingIndicator.tinyCement(),
            )
          else if (icon != null) ...[
            Icon(icon, size: sbbIconSizeSmall),
            SizedBox(width: 4.0),
          ],
          buttonStyles.buttonLabelBuilder!(context, label),
        ],
      ),
    );
  }
}

/// Small variant of the SBB Tertiary Button. Use according to documentation.
///
/// The [label] parameter must not be null. In case you want to show a variant of this button
/// without a label, use the [SBBIconButtonSmall].
///
/// If [isLoading] is true, then the [SBBLoadingIndicator] will be displayed inside the button and the [onPressed] callback will be ignored.
///
/// If [onPressed] callback is null, then the button will be disabled.
///
/// See also:
///
/// * <https://digital.sbb.ch/en/design-system/mobile/components/button/>
class SBBTertiaryButtonSmall extends StatelessWidget {
  const SBBTertiaryButtonSmall({
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
    final smallButtonStyle = _baseButtonStyleWithSmallerHeight(context);
    final style = SBBBaseStyle.of(context);
    final buttonStyle = SBBButtonStyles.of(context);
    return TextButton(
      style: smallButtonStyle,
      onPressed: onPressed,
      focusNode: focusNode,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLoading)
            style.themeValue(
              const SBBLoadingIndicator.tinyCement(),
              const SBBLoadingIndicator.tinySmoke(),
            )
          else if (icon != null) ...[
            Icon(icon, size: sbbIconSizeSmall),
            SizedBox(width: 4.0),
          ],
          buttonStyle.buttonLabelBuilder!(context, label),
        ],
      ),
    );
  }

  ButtonStyle? _baseButtonStyleWithSmallerHeight(BuildContext context) {
    final buttonStyle = SBBButtonStyles.of(context);

    return buttonStyle.tertiarySmallStyle?.overrideButtonStyle(
      Theme.of(context).textButtonTheme.style?.copyWith(
        fixedSize: SBBTheme.allStates(const Size.fromHeight(SBBInternal.defaultButtonHeightSmall)),
        minimumSize: SBBTheme.allStates(const Size(0, SBBInternal.defaultButtonHeightSmall)),
      ),
    );
  }
}
