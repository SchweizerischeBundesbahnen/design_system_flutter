import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// The underline + error message for SBB TextField and TextFormField.
///
/// See also:
///
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/textfield>
class SBBTextFieldUnderline extends StatelessWidget {
  const SBBTextFieldUnderline({this.errorText, required this.hasFocus, this.isLastElement = false, super.key});

  final String? errorText;
  final bool hasFocus;
  final bool isLastElement;

  @override
  Widget build(BuildContext context) {
    final style = SBBControlStyles.of(context).textField;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (errorText != null)
          Padding(padding: const EdgeInsets.only(bottom: 9.0), child: Text(errorText!, style: style?.errorTextStyle)),
        Divider(
          color: errorText == null
              ? hasFocus
                  ? style?.dividerColorHighlighted
                  : isLastElement
                      ? SBBColors.transparent
                      : style?.dividerColor
              : style?.dividerColorError,
        ),
      ],
    );
  }
}
