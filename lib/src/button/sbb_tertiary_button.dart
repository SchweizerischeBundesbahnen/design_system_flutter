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
    final sbbTheme = SBBTheme.of(context);
    return TextButton(
      style: Theme.of(context).textButtonTheme.style?.copyWith(
            // workaround for web
            padding: SBBThemeData.allStates(EdgeInsets.zero),
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
              sbbTheme.isDark ? const SBBLoadingIndicator.tinyCement() : const SBBLoadingIndicator.tinySmoke()
            else if (icon != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 4.0),
                child: Icon(icon, size: sbbIconSizeSmall),
              ),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: sbbTheme.tertiaryButtonLargeTextStyle,
              ),
            ),
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
    final sbbTheme = SBBTheme.of(context);
    return TextButton(
      style: Theme.of(context).textButtonTheme.style?.copyWith(
            fixedSize: SBBThemeData.allStates(
              const Size.fromHeight(SBBInternal.defaultButtonHeightSmall),
            ),
            // workaround for web
            padding: SBBThemeData.allStates(EdgeInsets.zero),
            overlayColor: SBBThemeData.resolveStatesWith(
              defaultValue: sbbTheme.tertiaryButtonSmallBackgroundColor,
              pressedValue: sbbTheme.tertiaryButtonSmallBackgroundColorHighlighted,
            ),
            backgroundColor: SBBThemeData.resolveStatesWith(
              defaultValue: sbbTheme.tertiaryButtonSmallBackgroundColor,
              pressedValue: sbbTheme.tertiaryButtonSmallBackgroundColor,
              disabledValue: sbbTheme.tertiaryButtonSmallBackgroundColorDisabled,
            ),
            foregroundColor: SBBThemeData.resolveStatesWith(
              defaultValue: sbbTheme.tertiaryButtonSmallTextStyle.color!,
              pressedValue: sbbTheme.tertiaryButtonSmallTextStyleHighlighted.color,
              disabledValue: sbbTheme.tertiaryButtonSmallTextStyleDisabled.color,
            ),
            textStyle: SBBThemeData.resolveStatesWith(
              defaultValue: sbbTheme.tertiaryButtonSmallTextStyle,
              pressedValue: sbbTheme.tertiaryButtonSmallTextStyleHighlighted,
              disabledValue: sbbTheme.tertiaryButtonSmallTextStyleDisabled,
            ),
            side: SBBThemeData.resolveStatesWith(
              defaultValue: BorderSide(color: sbbTheme.tertiaryButtonSmallBorderColor),
              pressedValue: BorderSide(color: sbbTheme.tertiaryButtonSmallBorderColorHighlighted),
              disabledValue: BorderSide(color: sbbTheme.tertiaryButtonSmallBorderColorDisabled),
            ),
          ),
      onPressed: onPressed,
      focusNode: focusNode,
      child: Padding(
        // workaround for web
        padding: EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading)
              sbbTheme.isDark ? const SBBLoadingIndicator.tinyCement() : const SBBLoadingIndicator.tinySmoke()
            else if (icon != null)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 4.0),
                child: Icon(icon, size: sbbIconSizeSmall),
              ),
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
