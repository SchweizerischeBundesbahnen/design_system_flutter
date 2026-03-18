import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// Signature for custom selection validation to be used in [SBBMultiDropdown] to
/// determine whether the submit button is enabled or not.
///
/// The type `T` is the type of the value the entry represents. All the entries
/// in a given menu must represent values with consistent types.
typedef SBBMultiDropdownValidation<T> = bool Function(List<T> oldSelection, List<T> newSelection);

/// SBB Select (multiple values). Use according to documentation.
///
/// See also:
///
/// * [SBBDropdown], variant for single value
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/select>
class SBBMultiDropdown<T> extends StatelessWidget {
  const SBBMultiDropdown({
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
    this.title,
    this.confirmButtonLabel,
    required this.selectedItems,
    required this.items,
    required this.onChanged,
    this.selectionValidation,
  });

  final SBBInputDecoration? triggerDecoration;

  final int? triggerMaxLines;

  final int? triggerMinLines;

  final bool triggerExpands;

  final FocusNode? triggerFocusNode;

  final bool triggerAutofocus;

  final SBBDecoratedTextStyle? triggerStyle;

  final String? title;
  final String? confirmButtonLabel;
  final List<T> selectedItems;
  final List<SBBDropdownItem<T>> items;
  final ValueChanged<List<T>>? onChanged;
  final SBBMultiDropdownValidation<T>? selectionValidation;

  @override
  Widget build(BuildContext context) {
    final displayValue = selectedItems.isEmpty
        ? ''
        : items.where((element) => selectedItems.contains(element.value)).map((element) => element.label).join(', ');

    return SBBDecoratedText(
      enabled: onChanged != null,
      onTap: () => SBBMultiDropdown.showMenu<T>(
        context: context,
        title: title ?? '',
        confirmButtonLabelText: confirmButtonLabel,
        selectedItems: selectedItems,
        items: items,
        onChanged: onChanged!,
        selectionValidation: selectionValidation,
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
    String? confirmButtonLabelText,
    required List<T> selectedItems,
    required List<SBBDropdownItem<T>> items,
    required ValueChanged<List<T>> onChanged,
    SBBMultiDropdownValidation<T>? selectionValidation,
  }) {
    final isSelectionValid = selectionValidation ?? defaultSelectionValidation;
    var selectedValues = List<T>.from(selectedItems);
    showSBBBottomSheet(
      context: context,
      titleText: title,
      body: StatefulBuilder(
        builder: (context, setModalState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SBBContentBox(
                  margin: const EdgeInsetsDirectional.fromSTEB(
                    SBBSpacing.medium,
                    SBBSpacing.xSmall,
                    SBBSpacing.medium,
                    SBBSpacing.medium,
                  ),
                  child: Column(
                    children: SBBListItem.divideListItems(
                      context: context,
                      items: items.asMap().entries.map(
                        (entry) {
                          return SBBCheckboxListItem(
                            value: selectedValues.contains(entry.value.value),
                            titleText: entry.value.label,
                            onChanged: (checked) {
                              setModalState(() {
                                if (checked == true) {
                                  selectedValues = List.from(selectedValues)..add(entry.value.value);
                                } else {
                                  selectedValues = List.from(selectedValues)..remove(entry.value.value);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ).toList(growable: false),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    SBBSpacing.medium,
                    0.0,
                    SBBSpacing.medium,
                    SBBSpacing.medium,
                  ),
                  child: SBBPrimaryButton(
                    labelText: confirmButtonLabelText ?? MaterialLocalizations.of(context).okButtonLabel,
                    onPressed: isSelectionValid(selectedItems, selectedValues)
                        ? () {
                            Navigator.of(context).pop();
                            onChanged(selectedValues);
                          }
                        : null,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static bool defaultSelectionValidation<T>(List<T> oldSelection, List<T> newSelection) {
    if (oldSelection.length != newSelection.length) {
      return true;
    }
    return oldSelection.map((e) => newSelection.contains(e)).contains(false);
  }
}
