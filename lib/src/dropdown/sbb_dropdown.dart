import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

// TODO:
// change value to selected (of type SBBDropdownItem?)
// change to use SBBInputDecoration
// remove isLastElement stuff
// make possible style customisation of both input as well as bottomSheet
// make possible customisation of the items in the bottom sheet list
// follow v5 theming / styling
// migration / documentation
// tests

/// Signature for custom selection validation to be used in [SBBMultiDropdown] to
/// determine whether the submit button is enabled or not.
///
/// The type `T` is the type of the value the entry represents. All the entries
/// in a given menu must represent values with consistent types.
typedef SBBMultiDropdownValidation<T> = bool Function(List<T> oldSelection, List<T> newSelection);

/// SBB Select (single value). Use according to documentation.
///
/// See also:
///
/// * [SBBMultiDropdown], variant for multiple values
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/select>
// readonly true
// enableInteractiveSelection false
class SBBDropdown<T> extends StatelessWidget {
  const SBBDropdown({
    super.key,
    // input field parameters
    this.inputDecoration,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.focusNode,
    this.autofocus = false,
    this.inputTextStyle,
    this.inputForegroundColor,
    // dropdown parameters
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final SBBInputDecoration? inputDecoration;

  final int? maxLines;

  final int? minLines;

  final bool expands;

  final FocusNode? focusNode;

  final bool autofocus;

  final TextStyle? inputTextStyle;

  final WidgetStateProperty<Color?>? inputForegroundColor;

  final T? value;
  final List<SBBDropdownItem<T>> items;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final enabled = onChanged != null;
    return SBBTextInput(
      enabled: enabled,
      readOnly: true,
      enableInteractiveSelection: false,
      enableClearButton: false,
      showCursor: false,
      onTap: enabled
          ? () => showMenu(
              context: context,
              title: 'some title',
              value: value,
              items: items,
              onChanged: onChanged!,
            )
          : null,

      // pass trough parameters
      decoration: inputDecoration,
      // TODO: copy with trailing arrow down
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      focusNode: focusNode,
      autofocus: autofocus,
      inputTextStyle: inputTextStyle,
      inputForegroundColor: inputForegroundColor,
    );
  }

  static showMenu<T>({
    required BuildContext context,
    required String title,
    required T? value,
    required List<SBBDropdownItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    var selectedValue = value;
    showSBBBottomSheet(
      context: context,
      titleText: title,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SBBContentBox(
              margin: const EdgeInsetsDirectional.fromSTEB(
                SBBSpacing.medium,
                SBBSpacing.xSmall,
                SBBSpacing.medium,
                SBBSpacing.medium,
              ),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return SBBRadioGroup<T>(
                    onChanged: (value) {
                      setState(() => selectedValue = value);
                      Navigator.of(context).pop();
                      onChanged(value);
                    },
                    groupValue: selectedValue,
                    child: Column(
                      children: SBBListItem.divideListItems(
                        context: context,
                        items: items.asMap().entries.map((entry) {
                          return SBBRadioListItem<T>(
                            value: entry.value.value,
                            titleText: entry.value.label,
                          );
                        }),
                      ).toList(growable: false),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
