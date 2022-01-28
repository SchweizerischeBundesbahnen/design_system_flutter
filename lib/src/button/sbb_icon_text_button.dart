import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// The SBB Icon Text Button. Use according to documentation.
///
/// The [icon] parameter must not be null. Make sure to use large icons
/// ([sbbIconSizeLarge] - 48x48).
///
/// The [label] parameter must not be null.
///
/// If [onPressed] callback is null, then the button will be disabled.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/button>
class SBBIconTextButton extends StatefulWidget {
  const SBBIconTextButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.focusNode,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;

  @override
  _SBBIconTextButtonState createState() => _SBBIconTextButtonState();
}

class _SBBIconTextButtonState extends State<SBBIconTextButton> {
  bool _isPressed = false;
  bool _hasFocus = false;

  @override
  Widget build(BuildContext context) {
    final sbbTheme = SBBTheme.of(context);
    final isEnabled = widget.onPressed != null;
    return Semantics(
      button: true,
      child: SBBGroup(
        useShadow: true,
        child: Material(
          color: isEnabled ? sbbTheme.iconTextButtonBackgroundColor : sbbTheme.iconTextButtonBackgroundColorDisabled,
          child: InkWell(
            splashColor: sbbTheme.iconTextButtonBackgroundColorHighlighted,
            focusColor: sbbTheme.iconTextButtonBackgroundColorHighlighted,
            highlightColor: SBBColors.transparent,
            hoverColor: SBBColors.transparent,
            onFocusChange: (hasFocus) => setState(() => _hasFocus = hasFocus),
            onTapDown: (details) => setState(() => _isPressed = true),
            onTap: isEnabled
                ? () {
                    setState(() => _isPressed = false);
                    widget.onPressed!();
                  }
                : null,
            focusNode: widget.focusNode,
            child: Container(
              constraints: const BoxConstraints.tightFor(height: 104, width: 96),
              padding: const EdgeInsets.symmetric(
                vertical: sbbDefaultSpacing,
                horizontal: sbbDefaultSpacing / 2,
              ),
              // color: _isPressed || _hasFocus
              //     ? sbbTheme.iconTextButtonBackgroundColorHighlighted
              //     : isEnabled
              //         ? sbbTheme.iconTextButtonBackgroundColor
              //         : sbbTheme.iconTextButtonBackgroundColorDisabled,
              child: Column(
                children: [
                  Icon(
                    widget.icon,
                    size: sbbIconSizeLarge,
                    color: _isPressed || _hasFocus
                        ? sbbTheme.iconTextButtonIconColorHighlighted
                        : isEnabled
                            ? sbbTheme.iconTextButtonIconColor
                            : sbbTheme.iconTextButtonIconColorDisabled,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    widget.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _isPressed || _hasFocus
                        ? sbbTheme.iconTextButtonTextStyleHighlighted
                        : isEnabled
                            ? sbbTheme.iconTextButtonTextStyle
                            : sbbTheme.iconTextButtonTextStyleDisabled,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
