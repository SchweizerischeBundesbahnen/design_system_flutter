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
    Key? key,
    required this.icon,
    required this.onPressed,
    this.focusNode,
  }) : super(key: key);

  static const _buttonSize = 48.0;

  final IconData icon;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final sbbTheme = SBBTheme.of(context);
    return TextButton(
      style: Theme.of(context).textButtonTheme.style?.copyWith(
            minimumSize: SBBThemeData.allStates(const Size(_buttonSize, _buttonSize)),
            fixedSize: SBBThemeData.allStates(const Size(_buttonSize, _buttonSize)),
            padding: SBBThemeData.allStates(EdgeInsets.zero),
            shape: SBBThemeData.allStates(RoundedRectangleBorder()),
            overlayColor: SBBThemeData.resolveStatesWith(
              defaultValue: sbbTheme.iconFormButtonBackgroundColor,
              pressedValue: sbbTheme.iconFormButtonBackgroundColorHighlighted,
            ),
            backgroundColor: SBBThemeData.resolveStatesWith(
              defaultValue: sbbTheme.iconFormButtonBackgroundColor,
              pressedValue: sbbTheme.iconFormButtonBackgroundColor,
              disabledValue: sbbTheme.iconFormButtonBackgroundColorDisabled,
            ),
            foregroundColor: SBBThemeData.resolveStatesWith(
              defaultValue: sbbTheme.iconFormButtonIconColor,
              pressedValue: sbbTheme.iconFormButtonIconColorHighlighted,
              disabledValue: sbbTheme.iconFormButtonIconColorDisabled,
            ),
            side: SBBThemeData.resolveStatesWith(
              defaultValue: BorderSide(color: sbbTheme.iconFormButtonBorderColor),
              pressedValue: BorderSide(color: sbbTheme.iconFormButtonBorderColorHighlighted),
              disabledValue: BorderSide(color: sbbTheme.iconFormButtonBorderColorDisabled),
            ),
          ),
      onPressed: onPressed,
      focusNode: focusNode,
      child: Icon(icon, size: sbbIconSizeSmall),
    );
  }
}
