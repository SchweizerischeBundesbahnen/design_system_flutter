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
@Deprecated('IconTextButton is not part of the design system and will be removed.')
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
    final buttonStyle = SBBButtonStyles.of(context);
    final style = buttonStyle.iconTextStyle;
    final isEnabled = widget.onPressed != null;
    final textStyle = _isPressed || _hasFocus
        ? style?.textStyleHighlighted
        : isEnabled
            ? style?.textStyle
            : style?.textStyleDisabled;
    return Semantics(
      button: true,
      child: SBBGroup(
        useShadow: true,
        child: Material(
          color: isEnabled ? style?.backgroundColor : style?.backgroundColorDisabled,
          child: InkWell(
            splashColor: style?.backgroundColorHighlighted,
            focusColor: style?.backgroundColorHighlighted,
            highlightColor: SBBColors.transparent,
            hoverColor: SBBColors.transparent,
            onFocusChange: (hasFocus) => setState(() => _hasFocus = hasFocus),
            onTapDown: isEnabled ? (details) => setState(() => _isPressed = true) : null,
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
                        ? style?.iconColorHighlighted
                        : isEnabled
                            ? style?.iconColor
                            : style?.iconColorDisabled,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    widget.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _isPressed || _hasFocus
                        ? style?.textStyleHighlighted
                        : isEnabled
                            ? style?.textStyle
                            : style?.textStyleDisabled,
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
