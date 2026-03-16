import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

/// SBB Select (multiple values). Use according to documentation.
///
/// See also:
///
/// * [SBBDropdown], variant for single value
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/select>
class SBBMultiDropdown<T> extends StatefulWidget {
  const SBBMultiDropdown({
    super.key,
    required this.label,
    this.icon,
    this.title,
    this.confirmButtonLabel,
    this.isLastElement = false,
    required this.values,
    required this.items,
    required this.onChanged,
    this.selectionValidation,
  });

  final String label;
  final IconData? icon;
  final String? title;
  final String? confirmButtonLabel;
  final bool isLastElement;
  final List<T> values;
  final List<SelectMenuItem<T>> items;
  final ValueChanged<List<T>>? onChanged;
  final SelectionValidation? selectionValidation;

  @override
  State<StatefulWidget> createState() => _SBBMultiDropdownState<T>();

  static showMenu<T>({
    required BuildContext context,
    required String title,
    String? confirmButtonLabelText,
    required List<T> values,
    required List<SelectMenuItem<T>> items,
    required ValueChanged<List<T>> onChanged,
    SelectionValidation<T>? selectionValidation,
  }) {
    final isSelectionValid = selectionValidation ?? defaultSelectionValidation;
    var selectedValues = values;
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
                    onPressed: isSelectionValid(values, selectedValues)
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

class _SBBMultiDropdownState<T> extends State<SBBMultiDropdown<T>> {
  SBBControlStyles get style => Theme.of(context).extension()!;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onChanged != null;
    final baseStyle = SBBBaseStyle.of(context);
    return InkWell(
      /// TODO: smallTrogdor - rm and move to own style
      focusColor: baseStyle.themeValue(SBBColors.platinum, SBBColors.midnight),
      hoverColor: baseStyle.themeValue(SBBColors.platinum, SBBColors.midnight),
      onTap: enabled
          ? () {
              SBBMultiDropdown.showMenu<T>(
                context: context,
                title: widget.title ?? widget.label,
                values: widget.values,
                items: widget.items,
                onChanged: widget.onChanged!,
                selectionValidation: widget.selectionValidation,
              );
            }
          : null,
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(minHeight: 48.0),
            color: SBBColors.transparent,
            child: Row(
              children: [
                const SizedBox(width: SBBSpacing.medium),
                if (widget.icon != null)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: SBBSpacing.xSmall),
                    child: Icon(
                      widget.icon,
                      color: enabled ? style.textField?.iconColor : style.textField?.iconColorDisabled,
                    ),
                  ),
                Expanded(
                  child: widget.values.isEmpty
                      ? Text(
                          widget.label,
                          style: enabled
                              ? style.textField?.placeholderTextStyle
                              : style.textField?.placeholderTextStyleDisabled,
                          maxLines: 1,
                          overflow: .ellipsis,
                        )
                      : Column(
                          crossAxisAlignment: .start,
                          children: [
                            const SizedBox(height: 5.0),
                            Text(
                              widget.label,
                              style: enabled ? style.selectLabel?.textStyle : style.selectLabel?.textStyleDisabled,
                              maxLines: 1,
                              overflow: .ellipsis,
                            ),
                            const SizedBox(height: 3.0),
                            Text(
                              widget.items
                                  .where((element) => widget.values.contains(element.value))
                                  .map((element) => element.label)
                                  .join(', '),
                              style: enabled ? style.textField?.textStyle : style.textField?.textStyleDisabled,
                              maxLines: 1,
                              overflow: .ellipsis,
                            ),
                          ],
                        ),
                ),
                Icon(
                  SBBIcons.chevron_small_down_small,
                  color: enabled ? style.textField?.iconColor : style.textField?.iconColorDisabled,
                ),
                const SizedBox(width: SBBSpacing.xSmall),
              ],
            ),
          ),
          if (!widget.isLastElement) Divider(indent: widget.icon == null ? SBBSpacing.medium : 48.0),
        ],
      ),
    );
  }
}
