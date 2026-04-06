import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

const _defaultScrollControlDisabledMaxHeightRatio = 9.0 / 16.0;

/// The SBB Dropdown.
///
/// This is basically a convenience combination of a [SBBDecoratedText] and a [SBBBottomSheet].
///
/// When the user taps on the [SBBDecoratedText] field, an [SBBBottomSheet] is opened with a
/// scrollable list of [SBBRadioListItem]s. The user selects one item and the sheet closes
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
/// Use [triggerConfig] to configure the trigger field's layout and focus
/// behaviour (max/min lines, expands, focus node, autofocus). When omitted,
/// the defaults from [SBBDecoratedTextConfig] are used.
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
/// * [SBBDropdown._showMenu], which opens the selection sheet imperatively.
/// * [SBBDropdownItem], the model for each selectable entry.
/// * [SBBDecoratedText], the widget used as a trigger.
/// * [SBBDecoratedTextConfig], the configuration object for the trigger field.
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
  /// Use [triggerConfig] to configure layout and focus behaviour of the trigger
  /// field. See [SBBDecoratedTextConfig] for available options.
  ///
  /// For documentation of trigger decoration parameters, see [SBBDecoratedText].
  ///
  /// For documentation of sheet parameters, see [SBBBottomSheet].
  const SBBDropdown({
    super.key,
    // decorated text / trigger parameters
    this.triggerDecoration,
    this.triggerStyle,
    this.triggerConfig = const SBBDecoratedTextConfig(),
    // dropdown parameters
    required this.selectedItem,
    required this.items,
    required this.onChanged,
    // bottom sheet parameters
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
    final displayValue = items.where((item) => item.value == selectedItem).map((item) => item.label).firstOrNull ?? '';
    final effectiveConfig = sheetConfig ?? const SBBBottomSheetConfig();
    return SBBDecoratedText(
      onTap: onChanged != null
          ? () => _showMenu(
              context: context,
              value: selectedItem,
              items: items,
              onChanged: onChanged!,
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
    required T? value,
    required List<SBBDropdownItem<T>> items,
    required ValueChanged<T?> onChanged,
    SBBBottomSheetConfig? sheetConfig,
    String? sheetTitleText,
    SBBBottomSheetStyle? sheetStyle,
  }) {
    var selectedValue = value;
    final effectiveConfig = sheetConfig ?? const SBBBottomSheetConfig();

    showSBBBottomSheet(
      context: context,
      title: effectiveConfig.title,
      titleText: sheetTitleText?.isEmpty ?? false ? null : sheetTitleText,
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
      scrollControlDisabledMaxHeightRatio:
          effectiveConfig.scrollControlDisabledMaxHeightRatio ?? _defaultScrollControlDisabledMaxHeightRatio,
      isScrollControlled: false,
      body: StatefulBuilder(
        builder: (context, setState) {
          return SBBRadioGroup<T>(
            onChanged: (val) {
              setState(() => selectedValue = val);
              Navigator.of(context, rootNavigator: effectiveConfig.useRootNavigator).pop();
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
