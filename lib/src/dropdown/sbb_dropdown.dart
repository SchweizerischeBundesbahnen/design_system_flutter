import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

// ALL TODOS apply to both SBBDropdown as well as SBBMultiDropdown
// TODO: change to use SBBDecoratedText
// TODO: remove isLastElement stuff
// TODO: make possible style customisation of both SBBDecoratedText widget as well as bottomSheet widget
// TODO: make possible customisation of the items in the bottom sheet list
// TODO: follow v5 theming / styling (like e.g. SBBChip with SBBChipStyle, SBBChipThemeData, etc. - think about the necessary / obvious fields for the corresponding ThemeData)
// TODO: documentation (write precise, clear documentation following the style found in e.g. SBBChip)
// TODO: migration (write a short, precise migration section in the correct alphabetical order in migration_guide_v5.md)
// TODO: tests

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
    required this.selectedItem,
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

  final T? selectedItem;
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
              value: selectedItem,
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

  static void showMenu<T>({
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
