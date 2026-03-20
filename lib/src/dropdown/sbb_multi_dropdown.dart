import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

const _defaultScrollControlDisabledMaxHeightRatio = 9.0 / 16.0;

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
    // decorated text / trigger parameters
    this.triggerDecoration,
    this.triggerStyle,
    this.triggerMaxLines = 1,
    this.triggerMinLines,
    this.triggerExpands = false,
    this.triggerFocusNode,
    this.triggerAutofocus = false,
    // dropdown parameters
    this.confirmButtonLabel,
    required this.selectedItems,
    required this.items,
    required this.onChanged,
    this.selectionValidation,
    // bottom sheet parameters
    this.sheetTitle,
    this.sheetTitleText,
    this.sheetLeading,
    this.sheetLeadingIconData,
    this.sheetTrailing,
    this.sheetTrailingIconData,
    this.sheetStyle,
    this.sheetBarrierLabel,
    this.sheetUseRootNavigator = true,
    this.sheetIsDismissible = true,
    this.sheetEnableDrag = true,
    this.sheetUseSafeArea = true,
    this.sheetTransitionAnimationController,
    this.sheetAnimationStyle,
    this.scrollControlDisabledMaxHeightRatio,
    this.sheetShowCloseButton = true,
  });

  // Trigger parameters
  final SBBInputDecoration? triggerDecoration;
  final int? triggerMaxLines;
  final int? triggerMinLines;
  final bool triggerExpands;
  final FocusNode? triggerFocusNode;
  final bool triggerAutofocus;
  final SBBDecoratedTextStyle? triggerStyle;

  // Dropdown parameters
  final String? confirmButtonLabel;
  final List<T> selectedItems;
  final List<SBBDropdownItem<T>> items;
  final ValueChanged<List<T>>? onChanged;
  final SBBMultiDropdownValidation<T>? selectionValidation;

  // Bottom sheet parameters

  /// A custom widget displayed as the sheet's title.
  /// Cannot be used together with [sheetTitleText].
  final Widget? sheetTitle;

  /// Text string to display as the sheet's title.
  /// Cannot be used together with [sheetTitle].
  final String? sheetTitleText;

  /// A custom widget displayed at the leading edge of the sheet header.
  /// Cannot be used together with [sheetLeadingIconData].
  final Widget? sheetLeading;

  /// Icon data for an icon displayed at the leading edge of the sheet header.
  /// Cannot be used together with [sheetLeading].
  final IconData? sheetLeadingIconData;

  /// A custom widget displayed at the trailing edge of the sheet header.
  /// Cannot be used together with [sheetTrailingIconData].
  final Widget? sheetTrailing;

  /// Icon data for an icon displayed at the trailing edge of the sheet header.
  /// Cannot be used together with [sheetTrailing].
  final IconData? sheetTrailingIconData;

  /// Customizes the bottom sheet's appearance.
  final SBBBottomSheetStyle? sheetStyle;

  /// The semantic label of the dialog used by accessibility frameworks.
  final String? sheetBarrierLabel;

  /// Whether to use the root navigator when showing/popping the sheet.
  /// Defaults to true.
  final bool sheetUseRootNavigator;

  /// Whether the sheet can be dismissed by tapping outside.
  /// Defaults to true.
  final bool sheetIsDismissible;

  /// Whether the sheet can be dismissed by dragging downward.
  /// Defaults to true.
  final bool sheetEnableDrag;

  /// Whether to wrap the sheet in a [SafeArea].
  /// Defaults to true.
  final bool sheetUseSafeArea;

  /// An optional animation controller for the sheet's transition.
  final AnimationController? sheetTransitionAnimationController;

  /// An optional animation style for the sheet.
  final AnimationStyle? sheetAnimationStyle;

  final double? scrollControlDisabledMaxHeightRatio;

  /// Whether to show a close button in the sheet header.
  /// Defaults to true.
  final bool sheetShowCloseButton;

  @override
  Widget build(BuildContext context) {
    final displayValue = selectedItems.isEmpty
        ? ''
        : items.where((element) => selectedItems.contains(element.value)).map((element) => element.label).join(', ');

    return SBBDecoratedText(
      enabled: onChanged != null,
      onTap: () => SBBMultiDropdown.showMenu<T>(
        context: context,
        confirmButtonLabelText: confirmButtonLabel,
        selectedItems: selectedItems,
        items: items,
        onChanged: onChanged!,
        selectionValidation: selectionValidation,
        sheetTitle: sheetTitle,
        sheetTitleText: sheetTitleText,
        sheetLeading: sheetLeading,
        sheetLeadingIconData: sheetLeadingIconData,
        sheetTrailing: sheetTrailing,
        sheetTrailingIconData: sheetTrailingIconData,
        sheetStyle: sheetStyle,
        sheetBarrierLabel: sheetBarrierLabel,
        sheetUseRootNavigator: sheetUseRootNavigator,
        sheetIsDismissible: sheetIsDismissible,
        sheetEnableDrag: sheetEnableDrag,
        sheetUseSafeArea: sheetUseSafeArea,
        sheetTransitionAnimationController: sheetTransitionAnimationController,
        sheetAnimationStyle: sheetAnimationStyle,
        sheetShowCloseButton: sheetShowCloseButton,
        scrollControlDisabledMaxHeightRatio:
            scrollControlDisabledMaxHeightRatio ?? _defaultScrollControlDisabledMaxHeightRatio,
      ),
      value: displayValue,
      decoration: _effectiveTriggerDecoration(context),
      maxLines: triggerMaxLines,
      minLines: triggerMinLines,
      expands: triggerExpands,
      focusNode: triggerFocusNode,
      autofocus: triggerAutofocus,
      style: _effectiveTriggerStyle(context),
    );
  }

  SBBDecoratedTextStyle? _effectiveTriggerStyle(BuildContext context) {
    final themeTriggerStyle = Theme.of(context).sbbDropdownTheme?.triggerStyle;
    return themeTriggerStyle?.merge(triggerStyle) ?? triggerStyle;
  }

  SBBInputDecoration _effectiveTriggerDecoration(BuildContext context) {
    final themeDecoration = Theme.of(context).sbbDropdownTheme?.triggerDecorationTheme;
    final base = (triggerDecoration ?? const SBBInputDecoration()).applyThemeValues(themeDecoration);

    if (base.trailing != null || base.trailingIconData != null) return base;

    return base.copyWith(trailingIconData: SBBIcons.chevron_small_down_small);
  }

  static void showMenu<T>({
    required BuildContext context,
    String? confirmButtonLabelText,
    required List<T> selectedItems,
    required List<SBBDropdownItem<T>> items,
    required ValueChanged<List<T>> onChanged,
    SBBMultiDropdownValidation<T>? selectionValidation,
    Widget? sheetTitle,
    String? sheetTitleText,
    Widget? sheetLeading,
    IconData? sheetLeadingIconData,
    Widget? sheetTrailing,
    IconData? sheetTrailingIconData,
    SBBBottomSheetStyle? sheetStyle,
    String? sheetBarrierLabel,
    bool sheetUseRootNavigator = true,
    bool sheetIsDismissible = true,
    bool sheetEnableDrag = true,
    bool sheetUseSafeArea = true,
    AnimationController? sheetTransitionAnimationController,
    AnimationStyle? sheetAnimationStyle,
    bool sheetShowCloseButton = true,
    double scrollControlDisabledMaxHeightRatio = _defaultScrollControlDisabledMaxHeightRatio,
  }) {
    final isSelectionValid = selectionValidation ?? _defaultSelectionValidation;
    var selectedValues = List<T>.from(selectedItems);

    showSBBBottomSheet(
      context: context,
      title: sheetTitle,
      titleText: sheetTitleText,
      leading: sheetLeading,
      leadingIconData: sheetLeadingIconData,
      trailing: sheetTrailing,
      trailingIconData: sheetTrailingIconData,
      style: _effectiveSheetStyle(sheetStyle, context),
      barrierLabel: sheetBarrierLabel,
      useRootNavigator: sheetUseRootNavigator,
      isDismissible: sheetIsDismissible,
      enableDrag: sheetEnableDrag,
      useSafeArea: sheetUseSafeArea,
      transitionAnimationController: sheetTransitionAnimationController,
      sheetAnimationStyle: sheetAnimationStyle,
      showCloseButton: sheetShowCloseButton,
      isScrollControlled: false,
      scrollControlDisabledMaxHeightRatio: scrollControlDisabledMaxHeightRatio,
      body: StatefulBuilder(
        builder: (context, setModalState) {
          return Column(
            mainAxisSize: .min,
            children: [
              Flexible(
                child: SBBContentBox(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    separatorBuilder: (context, index) => const SBBDivider(),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return SBBCheckboxListItem(
                        value: selectedValues.contains(item.value),
                        titleText: item.label,
                        onChanged: (checked) {
                          setModalState(() {
                            if (checked == true) {
                              selectedValues = List.from(selectedValues)..add(item.value);
                            } else {
                              selectedValues = List.from(selectedValues)..remove(item.value);
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const .only(top: SBBSpacing.medium),
                child: SBBPrimaryButton(
                  labelText: confirmButtonLabelText ?? MaterialLocalizations.of(context).okButtonLabel,
                  onPressed: isSelectionValid(selectedItems, selectedValues)
                      ? () {
                          Navigator.of(context, rootNavigator: sheetUseRootNavigator).pop();
                          onChanged(selectedValues);
                        }
                      : null,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static bool _defaultSelectionValidation<T>(List<T> oldSelection, List<T> newSelection) {
    return !ListEquality().equals(oldSelection, newSelection);
  }

  static SBBBottomSheetStyle? _effectiveSheetStyle(SBBBottomSheetStyle? sheetStyle, BuildContext context) {
    final themeDropdownSheetStyle = Theme.of(context).sbbDropdownTheme?.sheetStyle;
    return themeDropdownSheetStyle?.merge(sheetStyle) ?? sheetStyle;
  }
}
