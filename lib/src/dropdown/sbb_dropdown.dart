import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

// ALL TODOS apply to both SBBDropdown as well as SBBMultiDropdown
// TODO: allow customisation of label aggregation in SBBMultiDropdown
// TODO: migration (write a short, precise migration section in the correct alphabetical order in migration_guide_v5.md)
// TODO: tests

const _defaultScrollControlDisabledMaxHeightRatio = 9.0 / 16.0;

/// The SBB Dropdown.
///
/// Displays a trigger field that, when tapped, opens an [SBBBottomSheet] with a
/// scrollable list of radio items. The user selects one item and the sheet closes
/// automatically.
///
/// When an item is selected it calls [onChanged] with the chosen value and also pops the bottomSheet.
/// It relies on the parent to rebuild with an updated [selectedItem].
///
/// If [onChanged] is null the trigger is displayed as disabled and will not
/// respond to input gestures.
///
/// Use [triggerDecoration] to customise the trigger's label, icons, error text,
/// and other decoration properties. By default a [SBBIcons.chevron_small_down_small]
/// trailing icon is added automatically unless a custom trailing widget or trailingIconData is provided.
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// For documentation of trigger parameters, see [SBBDecoratedText].
///
/// For documentation of sheet parameters, see [SBBBottomSheet].
///
/// See also:
///
/// * [SBBMultiDropdown], variant for selecting multiple values.
/// * [SBBDropdown.showMenu], which opens the selection sheet imperatively.
/// * [SBBDropdownItem], the model for each selectable entry.
/// * [SBBDecoratedText], the widget used as a trigger.
/// * [SBBBottomSheet], the widget used to display the possible items.
/// * [Figma design specs](https://www.figma.com/design/ZBotr4yqcEKqqVEJTQfSUa/Design-System-Mobile?node-id=326-8495&) (internal)
/// * <https://digital.sbb.ch/de/design-system/mobile/components/dropdown>
class SBBDropdown<T> extends StatelessWidget {
  /// Creates an SBB Dropdown (single value).
  ///
  /// The following arguments are required:
  ///
  /// * [selectedItem], which is the currently selected value (may be null when
  ///   nothing is selected).
  /// * [items], which is the list of [SBBDropdownItem]s shown in the sheet.
  /// * [onChanged], which is called when the user picks a new item. If null,
  ///   the trigger is disabled.
  ///
  /// For documentation of trigger parameters, see [SBBDecoratedText].
  ///
  /// For documentation of sheet parameters, see [SBBBottomSheet].
  const SBBDropdown({
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
    required this.selectedItem,
    required this.items,
    required this.onChanged,
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
    this.sheetScrollControlDisabledMaxHeightRatio,
    this.sheetShowCloseButton = true,
  });

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

  final int? triggerMaxLines;
  final int? triggerMinLines;
  final bool triggerExpands;
  final FocusNode? triggerFocusNode;
  final bool triggerAutofocus;

  /// Customizes the visual appearance of the trigger field.
  ///
  /// Non-null properties override the corresponding properties in
  /// [SBBDropdownThemeData.triggerStyle] from the current theme.
  final SBBDecoratedTextStyle? triggerStyle;

  /// The currently selected value, or null when nothing is selected.
  ///
  /// The trigger displays the [SBBDropdownItem.label] of the matching item.
  final T? selectedItem;

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
  final ValueChanged<T?>? onChanged;

  final Widget? sheetTitle;
  final String? sheetTitleText;
  final Widget? sheetLeading;
  final IconData? sheetLeadingIconData;
  final Widget? sheetTrailing;
  final IconData? sheetTrailingIconData;

  /// Customizes the bottom sheet appearance.
  ///
  /// Theme defaults are applied from [SBBDropdownThemeData.sheetStyle].
  final SBBBottomSheetStyle? sheetStyle;

  final String? sheetBarrierLabel;
  final bool sheetUseRootNavigator;
  final bool sheetIsDismissible;
  final bool sheetEnableDrag;
  final bool sheetUseSafeArea;
  final AnimationController? sheetTransitionAnimationController;
  final AnimationStyle? sheetAnimationStyle;
  final double? sheetScrollControlDisabledMaxHeightRatio;
  final bool sheetShowCloseButton;

  @override
  Widget build(BuildContext context) {
    final displayValue = items.where((item) => item.value == selectedItem).map((item) => item.label).firstOrNull ?? '';
    return SBBDecoratedText(
      enabled: onChanged != null,
      onTap: () => showMenu(
        context: context,
        value: selectedItem,
        items: items,
        onChanged: onChanged!,
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
        scrollControlDisabledMaxHeightRatio:
            sheetScrollControlDisabledMaxHeightRatio ?? _defaultScrollControlDisabledMaxHeightRatio,
        sheetShowCloseButton: sheetShowCloseButton,
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
    required T? value,
    required List<SBBDropdownItem<T>> items,
    required ValueChanged<T?> onChanged,
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
    double scrollControlDisabledMaxHeightRatio = _defaultScrollControlDisabledMaxHeightRatio,
    bool sheetShowCloseButton = true,
  }) {
    var selectedValue = value;

    showSBBBottomSheet(
      context: context,
      title: sheetTitle,
      titleText: sheetTitleText?.isEmpty ?? false ? null : sheetTitleText,
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
      scrollControlDisabledMaxHeightRatio: scrollControlDisabledMaxHeightRatio,
      isScrollControlled: false,
      body: StatefulBuilder(
        builder: (context, setState) {
          return SBBRadioGroup<T>(
            onChanged: (val) {
              setState(() => selectedValue = val);
              Navigator.of(context, rootNavigator: sheetUseRootNavigator).pop();
              onChanged(val);
            },
            groupValue: selectedValue,
            child: SBBContentBox(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: items.length,
                separatorBuilder: (context, index) => const SBBDivider(),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return SBBRadioListItem<T>(
                    value: item.value,
                    titleText: item.label,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  static SBBBottomSheetStyle? _effectiveSheetStyle(SBBBottomSheetStyle? sheetStyle, BuildContext context) {
    final themeDropdownSheetStyle = Theme.of(context).sbbDropdownTheme?.sheetStyle;
    return themeDropdownSheetStyle?.merge(sheetStyle) ?? sheetStyle;
  }
}
