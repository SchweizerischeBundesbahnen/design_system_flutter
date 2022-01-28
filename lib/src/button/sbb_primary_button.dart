import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';
import '../sbb_internal.dart';

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
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
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
    var sbbTheme = SBBTheme.of(context);
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            // workaround for web
            padding: SBBInternal.all(EdgeInsets.zero),
            overlayColor: SBBInternal.resolveWith(
              defaultValue: sbbTheme.primaryButtonNegativeBackgroundColor,
              pressedValue: sbbTheme.primaryButtonNegativeBackgroundColorHighlighted,
            ),
            backgroundColor: SBBInternal.resolveWith(
              defaultValue: sbbTheme.primaryButtonNegativeBackgroundColor,
              pressedValue: sbbTheme.primaryButtonNegativeBackgroundColor,
              disabledValue: sbbTheme.primaryButtonNegativeBackgroundColorDisabled,
            ),
            foregroundColor: SBBInternal.resolveWith(
              defaultValue: sbbTheme.primaryButtonNegativeTextStyle.color!,
              pressedValue: sbbTheme.primaryButtonNegativeTextStyleHighlighted.color,
              disabledValue: sbbTheme.primaryButtonNegativeTextStyleDisabled.color,
            ),
            textStyle: SBBInternal.resolveWith(
              defaultValue: sbbTheme.primaryButtonNegativeTextStyle,
              pressedValue: sbbTheme.primaryButtonNegativeTextStyleHighlighted,
              disabledValue: sbbTheme.primaryButtonNegativeTextStyleDisabled,
            ),
            side: SBBInternal.resolveWith(
              defaultValue: BorderSide(color: sbbTheme.primaryButtonNegativeBorderColor),
              pressedValue: BorderSide(color: sbbTheme.primaryButtonNegativeBorderColorHighlighted),
              disabledValue: BorderSide(color: sbbTheme.primaryButtonNegativeBorderColorDisabled),
            ),
          ),
      onPressed: isLoading ? null : onPressed,
      focusNode: focusNode,
      child: Padding(
        // workaround for web
        padding: const EdgeInsets.symmetric(horizontal: sbbDefaultSpacing),
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
      ),
    );
  }
}
