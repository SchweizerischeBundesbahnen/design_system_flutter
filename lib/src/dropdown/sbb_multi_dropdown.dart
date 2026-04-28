import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

const _defaultScrollControlDisabledMaxHeightRatio = 9.0 / 16.0;

/// Signature for custom selection validation used in [SBBMultiDropdown] to
/// determine whether the confirm button is enabled.
///
/// Receives the original [oldSelection] that was active when the sheet opened
/// and the current [newSelection] reflecting the user's latest choices. Return
/// true to enable the confirm button, false to disable it.
///
/// The type `T` is the type of the value each entry represents. All entries in
/// a given menu must have consistent types.
typedef SBBMultiDropdownValidation<T> = bool Function(List<T> oldSelection, List<T> newSelection);

/// Signature for custom label aggregation used in [SBBMultiDropdown] to
/// produce the display string shown in the trigger field.
///
/// Receives [selectedItems] (the currently selected values). Returns the string to display in the
/// trigger.
///
/// The default behaviour joins the labels of selected items with `", "`.
typedef SBBMultiDropdownLabelAggregation<T> = String Function(List<SBBDropdownItem<T>> selectedItems);

/// The SBB Dropdown (multiple values).
///
/// This is basically a convenience combination of a [SBBDecoratedText] and a [SBBBottomSheet].
///
/// When the user taps on the [SBBDecoratedText] field, an [SBBBottomSheet] is opened with a
/// scrollable list of [SBBCheckboxListItem]s. The user may select any combination of
/// items and confirms the selection with a primary button.
///
/// The trigger widget itself does not hold selection state: when the user confirms the
/// selection it calls [onChanged] with the new list and relies on its parent to
/// rebuild it with an updated [selectedItems] value. The selection in the bottom sheet
/// is updated by the widget itself.
///
/// If [onChanged] is null the trigger is displayed as disabled and will not
/// respond to input gestures.
///
/// Use [triggerDecoration] to customise the trigger's label, icons, error text,
/// and other decoration properties. By default a [SBBIcons.chevron_small_down_small]
/// trailing icon is added automatically unless a custom trailing widget is provided.
///
/// Use [triggerConfig] to configure the trigger field's layout and focus
/// behaviour (max/min lines, expands, focus node, autofocus). When omitted,
/// the defaults from [SBBDecoratedTextConfig] are used.
///
/// Use [selectionValidation] to control when the confirm button is enabled. The
/// default validation disables the button when the new selection is identical
/// to the original selection.
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// For documentation of trigger parameters, see [SBBDecoratedText].
///
/// For documentation of sheet parameters, see [SBBBottomSheet].
///
/// See also:
///
/// * [SBBDropdown], variant for selecting a single value.
/// * [SBBMultiDropdown._showMenu], which opens the selection sheet imperatively.
/// * [SBBDropdownItem], the model for each selectable entry.
/// * [SBBDecoratedTextConfig], the configuration object for the trigger field.
/// * [SBBMultiDropdownValidation], the signature for custom validation callbacks.
/// * [SBBMultiDropdownLabelAggregation], the signature for custom label aggregation.
/// * [SBBDecoratedText], the widget used as a trigger.
/// * [SBBBottomSheet], the widget used to display the possible items.
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=326-8495&) (internal)
/// * <https://digital.sbb.ch/de/design-system/mobile/components/dropdown>
class SBBMultiDropdown<T> extends StatelessWidget {
  /// Creates an SBB Dropdown (multiple values).
  ///
  /// The following arguments are required:
  ///
  /// * [selectedItems], which is the list of currently selected values.
  /// * [items], which is the list of [SBBDropdownItem]s shown in the sheet.
  /// * [onChanged], which is called when the user confirms a new selection. If
  ///   null, the trigger is disabled.
  ///
  /// Use [triggerConfig] to configure layout and focus behaviour of the trigger
  /// field. See [SBBDecoratedTextConfig] for available options.
  ///
  /// For documentation of trigger decoration parameters, see [SBBDecoratedText].
  ///
  /// For documentation of sheet parameters, see [SBBBottomSheet].
  const SBBMultiDropdown({
    super.key,
    this.triggerDecoration,
    this.triggerStyle,
    this.triggerConfig = const SBBDecoratedTextConfig(),
    this.confirmButtonLabel,
    required this.selectedItems,
    required this.items,
    required this.onChanged,
    this.selectionValidation,
    this.labelAggregation,
    this.sheetConfig,
    this.sheetTitleText,
    this.sheetStyle,
  }) : assert(sheetConfig == null || sheetTitleText == null, 'sheetTitleText cannot be set while sheetConfig is set!');

  /// Decoration applied to the trigger field.
  ///
  /// Customises the label, placeholder, icons, error text, and other visual
  /// elements of the trigger. See [SBBInputDecoration] for available options.
  ///
  /// When neither [SBBInputDecoration.trailing] nor
  /// [SBBInputDecoration.trailingIconData] is set, a
  /// [SBBIcons.chevron_small_down_small] icon is added automatically.
  ///
  /// Theme defaults are applied from [SBBDropdownThemeData.triggerDecorationTheme].
  final SBBInputDecoration? triggerDecoration;

  /// Customizes the visual appearance of the trigger field.
  ///
  /// Non-null properties override the corresponding properties in
  /// [SBBDropdownThemeData.triggerStyle] from the current theme.
  final SBBDecoratedTextStyle? triggerStyle;

  /// Configuration for the trigger field's layout and focus behaviour.
  ///
  /// Defaults to [SBBDecoratedTextConfig] with its default values.
  final SBBDecoratedTextConfig triggerConfig;

  /// Allows a custom label for the confirmation button at the bottom of the sheet.
  ///
  /// Defaults to `MaterialLocalizations.of(context).okButtonLabel`.
  final String? confirmButtonLabel;

  /// The currently selected values, or empty when nothing is selected.
  ///
  /// The trigger displays the [SBBDropdownItem.label] of the matching item.
  final List<T> selectedItems;

  /// The list of items displayed in the selection sheet.
  ///
  /// Each entry must have a unique [SBBDropdownItem.value]. All entries must
  /// represent values of the same type `T`.
  final List<SBBDropdownItem<T>> items;

  /// Called when the user selects an item from the sheet.
  ///
  /// The dropdown calls this callback with the chosen value but does not update
  /// its own internal state. The parent should update [selectedItem] and rebuild
  /// the widget accordingly.
  ///
  /// If this callback is null, the trigger is displayed as disabled and will not
  /// respond to taps.
  final ValueChanged<List<T>>? onChanged;

  /// Receives the original [oldSelection] that was active when the sheet opened
  /// and the current [newSelection] reflecting the user's latest choices. Return
  /// true to enable the confirm button, false to disable it.
  ///
  /// Defaults to `!ListEquality().equals(oldSelection, newSelection)`.
  final SBBMultiDropdownValidation<T>? selectionValidation;

  /// Produces the display string shown in the trigger field from the current
  /// selection.
  ///
  /// Receives the [SBBDropdownItem]s that are currently inside [selectedItems].
  /// Returns the string to display in the trigger widget.
  ///
  /// Defaults to joining the labels of the selected items with `", "`.
  final SBBMultiDropdownLabelAggregation<T>? labelAggregation;

  /// Configuration for the bottom sheet parameters.
  ///
  /// Defaults to [SBBBottomSheetConfig] with its default values.
  final SBBBottomSheetConfig? sheetConfig;

  /// This is a flat convenience parameter. If you need more control, use [sheetConfig] instead.
  /// Cannot be used together with [sheetConfig].
  final String? sheetTitleText;

  /// Customizes the bottom sheet appearance.
  ///
  /// Theme defaults are applied from [SBBDropdownThemeData.sheetStyle].
  final SBBBottomSheetStyle? sheetStyle;

  @override
  Widget build(BuildContext context) {
    final selected = List<SBBDropdownItem<T>>.from(items.where((i) => selectedItems.contains(i.value)));
    final displayValue = labelAggregation != null ? labelAggregation!(selected) : _defaultLabelAggregation(selected);
    final effectiveConfig = sheetConfig ?? const SBBBottomSheetConfig();

    return SBBDecoratedText(
      onTap: onChanged != null
          ? () => _showMenu<T>(
              context: context,
              confirmButtonLabelText: confirmButtonLabel,
              selectedItems: selectedItems,
              items: items,
              onChanged: onChanged!,
              selectionValidation: selectionValidation,
              sheetConfig: effectiveConfig,
              sheetTitleText: sheetTitleText,
              sheetStyle: sheetStyle,
            )
          : null,
      value: displayValue,
      decoration: _effectiveTriggerDecoration(context),
      maxLines: triggerConfig.maxLines,
      minLines: triggerConfig.minLines,
      expands: triggerConfig.expands,
      focusNode: triggerConfig.focusNode,
      autofocus: triggerConfig.autofocus,
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

  static void _showMenu<T>({
    required BuildContext context,
    String? confirmButtonLabelText,
    required List<T> selectedItems,
    required List<SBBDropdownItem<T>> items,
    required ValueChanged<List<T>> onChanged,
    SBBMultiDropdownValidation<T>? selectionValidation,
    SBBBottomSheetConfig? sheetConfig,
    String? sheetTitleText,
    SBBBottomSheetStyle? sheetStyle,
  }) {
    final isSelectionValid = selectionValidation ?? _defaultSelectionValidation;
    List<T> selectedValues = List.from(selectedItems);
    final effectiveConfig = sheetConfig ?? const SBBBottomSheetConfig();

    showSBBBottomSheet(
      context: context,
      title: effectiveConfig.title,
      titleText: effectiveConfig.titleText ?? (sheetTitleText?.isEmpty ?? false ? null : sheetTitleText),
      leading: effectiveConfig.leading,
      leadingIconData: effectiveConfig.leadingIconData,
      trailing: effectiveConfig.trailing,
      trailingIconData: effectiveConfig.trailingIconData,
      style: _effectiveSheetStyle(sheetStyle, context),
      barrierLabel: effectiveConfig.barrierLabel,
      useRootNavigator: effectiveConfig.useRootNavigator,
      isDismissible: effectiveConfig.isDismissible,
      enableDrag: effectiveConfig.enableDrag,
      useSafeArea: effectiveConfig.useSafeArea,
      transitionAnimationController: effectiveConfig.transitionAnimationController,
      sheetAnimationStyle: effectiveConfig.animationStyle,
      showCloseButton: effectiveConfig.showCloseButton,
      isScrollControlled: false,
      scrollControlDisabledMaxHeightRatio:
          effectiveConfig.scrollControlDisabledMaxHeightRatio ?? _defaultScrollControlDisabledMaxHeightRatio,
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
                          Navigator.of(context, rootNavigator: effectiveConfig.useRootNavigator).pop();
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

  static String _defaultLabelAggregation<T>(List<SBBDropdownItem<T>> selectedItems) {
    if (selectedItems.isEmpty) return '';
    return selectedItems.map((e) => e.label).join(', ');
  }

  static bool _defaultSelectionValidation<T>(List<T> oldSelection, List<T> newSelection) {
    return !ListEquality().equals(oldSelection, newSelection);
  }

  static SBBBottomSheetStyle? _effectiveSheetStyle(SBBBottomSheetStyle? sheetStyle, BuildContext context) {
    final themeDropdownSheetStyle = Theme.of(context).sbbDropdownTheme?.sheetStyle;
    return themeDropdownSheetStyle?.merge(sheetStyle) ?? sheetStyle;
  }
}
