import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

// ALL TODOS apply to both SBBDropdown as well as SBBMultiDropdown
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
class SBBDropdown<T> extends StatelessWidget {
  const SBBDropdown({
    super.key,
    // decorated text parameters
    this.triggerDecoration,
    this.triggerStyle,
    this.triggerMaxLines = 1,
    this.triggerMinLines,
    this.triggerExpands = false,
    this.triggerFocusNode,
    this.triggerAutofocus = false,
    // dropdown parameters
    required this.selectedItem,
    required this.items,
    required this.onChanged,
  });

  final SBBInputDecoration? triggerDecoration;

  final int? triggerMaxLines;

  final int? triggerMinLines;

  final bool triggerExpands;

  final FocusNode? triggerFocusNode;

  final bool triggerAutofocus;

  final SBBDecoratedTextStyle? triggerStyle;

  final T? selectedItem;
  final List<SBBDropdownItem<T>> items;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final displayValue = items.where((item) => item.value == selectedItem).map((item) => item.label).firstOrNull ?? '';
    return SBBDecoratedText(
      enabled: onChanged != null,
      onTap: () => showMenu(
        context: context,
        title: 'some title',
        value: selectedItem,
        items: items,
        onChanged: onChanged!,
      ),
      value: displayValue,
      // pass through parameters
      decoration: triggerDecoration,
      // TODO: copy with trailing arrow down
      maxLines: triggerMaxLines,
      minLines: triggerMinLines,
      expands: triggerExpands,
      focusNode: triggerFocusNode,
      autofocus: triggerAutofocus,
      style: triggerStyle,
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
