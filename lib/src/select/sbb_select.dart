import 'package:flutter/material.dart';

import '../../design_system_flutter.dart';

/// Signature for custom selection validation to be used in [SBBMultiSelect] to
/// determine whether the submit button is enabled or not.
///
/// The type `T` is the type of the value the entry represents. All the entries
/// in a given menu must represent values with consistent types.
typedef bool SelectionValidation<T>(List<T> oldSelection, List<T> newSelection);

/// An item in a menu created by a [SBBSelect] or [SBBMultiSelect].
///
/// The type `T` is the type of the value the entry represents. All the entries
/// in a given menu must represent values with consistent types.
class SelectMenuItem<T> {
  const SelectMenuItem({required this.value, required this.label});

  final T value;
  final String label;
}

/// SBB Select (single value). Use according to documentation.
///
/// See also:
///
/// * [SBBMultiSelect], variant for multiple values
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/select>
class SBBSelect<T> extends StatelessWidget {
  const SBBSelect({
    Key? key,
    required this.label,
    this.icon,
    this.title,
    this.allowMultilineLabel = false,
    this.isLastElement = false,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final IconData? icon;
  final String? title;
  final bool allowMultilineLabel;
  final bool isLastElement;
  final T? value;
  final List<SelectMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  Widget build(BuildContext context) {
    final sbbTheme = SBBTheme.of(context);
    final enabled = onChanged != null;
    return InkWell(
      focusColor: sbbTheme.listItemBackgroundColorHighlighted,
      hoverColor: sbbTheme.listItemBackgroundColorHighlighted,
      onTap: enabled
          ? () => showMenu(
                context: context,
                title: title ?? label,
                value: value,
                items: items,
                onChanged: onChanged!,
                allowMultilineLabel: allowMultilineLabel,
              )
          : null,
      child: Container(
        height: 48.0,
        color: SBBColors.transparent,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(width: sbbDefaultSpacing),
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: sbbDefaultSpacing / 2,
                      ),
                      child: Icon(
                        icon,
                        color: enabled
                            ? sbbTheme.textFieldIconColor
                            : sbbTheme.textFieldIconColorDisabled,
                      ),
                    ),
                  Expanded(
                    child: value == null
                        ? Text(
                            label,
                            style: enabled
                                ? sbbTheme.textFieldPlaceholderTextStyle
                                : sbbTheme
                                    .textFieldPlaceholderTextStyleDisabled,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5.0),
                              Text(
                                label,
                                style: enabled
                                    ? sbbTheme.selectLabelTextStyle
                                    : sbbTheme.selectLabelTextStyleDisabled,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 3.0),
                              Text(
                                items
                                    .firstWhere(
                                        (element) => element.value == value)
                                    .label,
                                style: enabled
                                    ? sbbTheme.textFieldTextStyle
                                    : sbbTheme.textFieldTextStyleDisabled,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                  ),
                  Icon(
                    SBBIcons.chevron_small_down_small,
                    color: enabled
                        ? sbbTheme.textFieldIconColor
                        : sbbTheme.textFieldIconColorDisabled,
                  ),
                  const SizedBox(width: sbbDefaultSpacing / 2),
                ],
              ),
            ),
            if (!isLastElement)
              Divider(
                indent: icon == null ? sbbDefaultSpacing : 48.0,
              ),
          ],
        ),
      ),
    );
  }

  static showMenu<T>({
    required BuildContext context,
    required String title,
    required T? value,
    required List<SelectMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
    bool allowMultilineLabel = false,
  }) {
    var selectedValue = value;
    showSBBModalSheet(
      context: context,
      title: title,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SBBGroup(
              margin: const EdgeInsetsDirectional.fromSTEB(
                sbbDefaultSpacing,
                sbbDefaultSpacing / 2,
                sbbDefaultSpacing,
                sbbDefaultSpacing,
              ),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    children: items.asMap().entries.map((entry) {
                      final isLastElement = entry.key == items.length - 1;
                      return SBBRadioButtonListItem<T>(
                        value: entry.value.value,
                        groupValue: selectedValue,
                        allowMultilineLabel: allowMultilineLabel,
                        label: entry.value.label,
                        onChanged: (value) {
                          setState(() => selectedValue = value);
                          Navigator.of(context).pop();
                          onChanged(value);
                        },
                        isLastElement: isLastElement,
                      );
                    }).toList(growable: false),
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

/// SBB Select (multiple values). Use according to documentation.
///
/// See also:
///
/// * [SBBSelect], variant for single value
/// * <https://digital.sbb.ch/de/design-system-mobile-new/elemente/select>
class SBBMultiSelect<T> extends StatefulWidget {
  const SBBMultiSelect({
    Key? key,
    required this.label,
    this.icon,
    this.title,
    this.confirmButtonLabel,
    this.isLastElement = false,
    required this.values,
    required this.items,
    required this.onChanged,
    this.selectionValidation,
  }) : super(key: key);

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
  State<StatefulWidget> createState() => _SBBMultiSelectState<T>();

  static showMenu<T>({
    required BuildContext context,
    required String title,
    String? confirmButtonLabel,
    required List<T> values,
    required List<SelectMenuItem<T>> items,
    required ValueChanged<List<T>> onChanged,
    SelectionValidation<T>? selectionValidation,
  }) {
    final isSelectionValid = selectionValidation ?? defaultSelectionValidation;
    var _selectedValues = values;
    showSBBModalSheet(
      context: context,
      title: title,
      child: StatefulBuilder(
        builder: (context, setModalState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SBBGroup(
                  margin: const EdgeInsetsDirectional.fromSTEB(
                    sbbDefaultSpacing,
                    sbbDefaultSpacing / 2,
                    sbbDefaultSpacing,
                    sbbDefaultSpacing,
                  ),
                  child: Column(
                    children: items.asMap().entries.map((entry) {
                      final isLastElement = entry.key == items.length - 1;
                      return SBBCheckboxListItem(
                        value: _selectedValues.contains(entry.value.value),
                        label: entry.value.label,
                        onChanged: (checked) {
                          setModalState(() {
                            if (checked == true) {
                              _selectedValues = List.from(_selectedValues)
                                ..add(entry.value.value);
                            } else {
                              _selectedValues = List.from(_selectedValues)
                                ..remove(entry.value.value);
                            }
                          });
                        },
                        isLastElement: isLastElement,
                      );
                    }).toList(growable: false),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    sbbDefaultSpacing,
                    0.0,
                    sbbDefaultSpacing,
                    sbbDefaultSpacing,
                  ),
                  child: SBBPrimaryButton(
                    label: confirmButtonLabel ??
                        MaterialLocalizations.of(context).okButtonLabel,
                    onPressed: isSelectionValid(values, _selectedValues)
                        ? () {
                            Navigator.of(context).pop();
                            onChanged(_selectedValues);
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

  static bool defaultSelectionValidation<T>(
    List<T> oldSelection,
    List<T> newSelection,
  ) {
    if (oldSelection.length != newSelection.length) {
      return true;
    }
    return oldSelection.map((e) => newSelection.contains(e)).contains(false);
  }
}

class _SBBMultiSelectState<T> extends State<SBBMultiSelect<T>> {
  @override
  Widget build(BuildContext context) {
    final sbbTheme = SBBTheme.of(context);
    final enabled = widget.onChanged != null;
    return InkWell(
      focusColor: sbbTheme.listItemBackgroundColorHighlighted,
      hoverColor: sbbTheme.listItemBackgroundColorHighlighted,
      onTap: enabled
          ? () {
              SBBMultiSelect.showMenu<T>(
                context: context,
                title: widget.title ?? widget.label,
                values: widget.values,
                items: widget.items,
                onChanged: widget.onChanged!,
                selectionValidation: widget.selectionValidation,
              );
            }
          : null,
      child: Container(
        height: 48.0,
        color: SBBColors.transparent,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  const SizedBox(width: sbbDefaultSpacing),
                  if (widget.icon != null)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: sbbDefaultSpacing / 2,
                      ),
                      child: Icon(
                        widget.icon,
                        color: enabled
                            ? sbbTheme.textFieldIconColor
                            : sbbTheme.textFieldIconColorDisabled,
                      ),
                    ),
                  Expanded(
                    child: widget.values.isEmpty
                        ? Text(
                            widget.label,
                            style: enabled
                                ? sbbTheme.textFieldPlaceholderTextStyle
                                : sbbTheme
                                    .textFieldPlaceholderTextStyleDisabled,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5.0),
                              Text(
                                widget.label,
                                style: enabled
                                    ? sbbTheme.selectLabelTextStyle
                                    : sbbTheme.selectLabelTextStyleDisabled,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 3.0),
                              Text(
                                widget.items
                                    .where((element) =>
                                        widget.values.contains(element.value))
                                    .map((element) => element.label)
                                    .join(', '),
                                style: enabled
                                    ? sbbTheme.textFieldTextStyle
                                    : sbbTheme.textFieldTextStyleDisabled,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                  ),
                  Icon(
                    SBBIcons.chevron_small_down_small,
                    color: enabled
                        ? sbbTheme.textFieldIconColor
                        : sbbTheme.textFieldIconColorDisabled,
                  ),
                  const SizedBox(width: sbbDefaultSpacing / 2),
                ],
              ),
            ),
            if (!widget.isLastElement)
              Divider(
                indent: widget.icon == null ? sbbDefaultSpacing : 48.0,
              ),
          ],
        ),
      ),
    );
  }
}
