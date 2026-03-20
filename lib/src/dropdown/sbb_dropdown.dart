import 'package:flutter/material.dart';

import '../../sbb_design_system_mobile.dart';

// ALL TODOS apply to both SBBDropdown as well as SBBMultiDropdown
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
    this.sheetShowCloseButton = true,
    this.sheetBody,
    this.sheetIsScrollControlled = false,
    this.sheetScrollControlDisabledMaxHeightRatio = 9.0 / 16.0,
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
  final T? selectedItem;
  final List<SBBDropdownItem<T>> items;
  final ValueChanged<T?>? onChanged;

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

  /// Whether to show a close button in the sheet header.
  /// Defaults to true.
  final bool sheetShowCloseButton;

  /// A custom body widget for the bottom sheet.
  ///
  /// When null, the sheet will display a scroll-controlled [ListView] of
  /// [SBBRadioListItem]s. In that case, [sheetIsScrollControlled] and
  /// [sheetScrollControlDisabledMaxHeightRatio] are ignored and `isScrollControlled`
  /// is set to `true`.
  final Widget? sheetBody;

  /// Whether the bottom sheet can expand to full screen height.
  ///
  /// Only respected when a custom [sheetBody] is given. Otherwise `true` is used.
  /// Defaults to false.
  final bool sheetIsScrollControlled;

  /// The max height ratio when [sheetIsScrollControlled] is false.
  ///
  /// Only respected when a custom [sheetBody] is given. Otherwise ignored.
  /// Defaults to 9.0 / 16.0.
  final double sheetScrollControlDisabledMaxHeightRatio;

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
        sheetShowCloseButton: sheetShowCloseButton,
        sheetBody: sheetBody,
        sheetIsScrollControlled: sheetIsScrollControlled,
        sheetScrollControlDisabledMaxHeightRatio: sheetScrollControlDisabledMaxHeightRatio,
      ),
      value: displayValue,
      decoration: _triggerDecorationWithDefaultTrailingIcon,
      maxLines: triggerMaxLines,
      minLines: triggerMinLines,
      expands: triggerExpands,
      focusNode: triggerFocusNode,
      autofocus: triggerAutofocus,
      style: triggerStyle,
    );
  }

  SBBInputDecoration? get _triggerDecorationWithDefaultTrailingIcon {
    final baseDecoration = triggerDecoration ?? SBBInputDecoration();
    if (baseDecoration.trailing != null || baseDecoration.trailingIconData != null) return baseDecoration;

    return baseDecoration.copyWith(trailingIconData: SBBIcons.chevron_small_down_small);
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
    bool sheetShowCloseButton = true,
    Widget? sheetBody,
    bool sheetIsScrollControlled = false,
    double sheetScrollControlDisabledMaxHeightRatio = 9.0 / 16.0,
  }) {
    final hasCustomBody = sheetBody != null;
    var selectedValue = value;

    final Widget body;
    if (hasCustomBody) {
      body = sheetBody;
    } else {
      body = StatefulBuilder(
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
                itemBuilder: (context, index) => SBBRadioListItem<T>(
                  value: items[index].value,
                  titleText: items[index].label,
                ),
              ),
            ),
          );
        },
      );
    }

    showSBBBottomSheet(
      context: context,
      title: sheetTitle,
      titleText: sheetTitleText?.isEmpty ?? false ? null : sheetTitleText,
      leading: sheetLeading,
      leadingIconData: sheetLeadingIconData,
      trailing: sheetTrailing,
      trailingIconData: sheetTrailingIconData,
      style: sheetStyle,
      barrierLabel: sheetBarrierLabel,
      useRootNavigator: sheetUseRootNavigator,
      isDismissible: sheetIsDismissible,
      enableDrag: sheetEnableDrag,
      useSafeArea: sheetUseSafeArea,
      transitionAnimationController: sheetTransitionAnimationController,
      sheetAnimationStyle: sheetAnimationStyle,
      showCloseButton: sheetShowCloseButton,
      isScrollControlled: hasCustomBody ? sheetIsScrollControlled : false,
      scrollControlDisabledMaxHeightRatio: hasCustomBody ? sheetScrollControlDisabledMaxHeightRatio : 9.0 / 16.0,
      body: body,
    );
  }
}
