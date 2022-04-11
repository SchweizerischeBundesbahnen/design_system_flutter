import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// The underline + error message for SBB TextField and TextFormField.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/textfield>
class SBBTextFieldUnderline extends StatelessWidget {
  const SBBTextFieldUnderline({
    this.errorText,
    required this.hasFocus,
    this.isLastElement = false,
    Key? key,
  }) : super(key: key);

  final String? errorText;
  final bool hasFocus;
  final bool isLastElement;

  @override
  Widget build(BuildContext context) {
    final sbbTheme = SBBTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (errorText != null)
          Padding (
            padding: const EdgeInsets.only(bottom: 9.0),
            child: Text(
              errorText!,
              style: sbbTheme.textFieldErrorTextStyle,
            ),
          ),
        Divider(
          color: errorText == null
              ? hasFocus
                  ? sbbTheme.textFieldDividerColorHighlighted
                  : isLastElement
                      ? SBBColors.transparent
                      : sbbTheme.textFieldDividerColor
              : sbbTheme.textFieldDividerColorError,
        )
      ],
    );
  }
}
