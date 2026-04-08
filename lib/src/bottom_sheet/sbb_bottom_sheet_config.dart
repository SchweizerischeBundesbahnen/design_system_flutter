import 'package:flutter/material.dart';

/// Configuration for parameters of [showSBBBottomSheet].
///
/// Pass an instance of this class to configure the appearance and behavior
/// of the bottom sheet in dropdowns and other components that use sheets.
///
/// See also:
///
/// * [SBBDropdown], which accepts this config via `sheetConfig`.
/// * [SBBMultiDropdown], which accepts this config via `sheetConfig`.
/// * [showSBBBottomSheet], the function that displays the bottom sheet.
class SBBBottomSheetConfig {
  const SBBBottomSheetConfig({
    this.title,
    this.titleText,
    this.leading,
    this.leadingIconData,
    this.trailing,
    this.trailingIconData,
    this.barrierLabel,
    this.useRootNavigator = true,
    this.isDismissible = true,
    this.enableDrag = true,
    this.useSafeArea = true,
    this.transitionAnimationController,
    this.animationStyle,
    this.scrollControlDisabledMaxHeightRatio,
    this.showCloseButton = true,
  });

  /// {@macro sbb_design_system.sbb_bottom_sheet.title}
  final Widget? title;

  /// {@macro sbb_design_system.sbb_bottom_sheet.title_text}
  final String? titleText;

  /// {@macro sbb_design_system.sbb_bottom_sheet.leading}
  final Widget? leading;

  /// {@macro sbb_design_system.sbb_bottom_sheet.leadingIconData}
  final IconData? leadingIconData;

  /// {@macro sbb_design_system.sbb_bottom_sheet.trailing}
  final Widget? trailing;

  /// {@macro sbb_design_system.sbb_bottom_sheet.trailingIconData}
  final IconData? trailingIconData;

  /// Semantic label for the barrier.
  ///
  /// Used for accessibility to describe the barrier that dismisses the sheet.
  final String? barrierLabel;

  /// Whether to use the root navigator when popping the sheet.
  ///
  /// When true, [Navigator.of] will use [rootNavigator: true] to dismiss
  /// the sheet. This is useful when the sheet needs to be dismissed from
  /// a context that is not the direct parent of the sheet.
  ///
  /// Defaults to true.
  final bool useRootNavigator;

  /// Whether the sheet can be dismissed by tapping outside of it.
  ///
  /// Defaults to true.
  final bool isDismissible;

  /// Whether the sheet can be dragged up and down to dismiss.
  ///
  /// Defaults to true.
  final bool enableDrag;

  /// Whether to wrap the sheet in a SafeArea.
  ///
  /// Defaults to true.
  final bool useSafeArea;

  /// An optional animation controller for controlling the transition animation.
  final AnimationController? transitionAnimationController;

  /// The animation style for the sheet transition.
  final AnimationStyle? animationStyle;

  /// The maximum height of the sheet as a ratio of the screen height when [isScrollControlled] is false.
  ///
  /// Defines the maximum height of the sheet as a ratio of the screen height.
  /// Valid range is typically 0.0 to 1.0. Ignored when [isScrollControlled] is true.
  final double? scrollControlDisabledMaxHeightRatio;

  /// {@macro sbb_design_system.sbb_bottom_sheet.showCloseButton}
  final bool showCloseButton;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SBBBottomSheetConfig &&
        other.title == title &&
        other.leading == leading &&
        other.leadingIconData == leadingIconData &&
        other.trailing == trailing &&
        other.trailingIconData == trailingIconData &&
        other.barrierLabel == barrierLabel &&
        other.useRootNavigator == useRootNavigator &&
        other.isDismissible == isDismissible &&
        other.enableDrag == enableDrag &&
        other.useSafeArea == useSafeArea &&
        other.transitionAnimationController == transitionAnimationController &&
        other.animationStyle == animationStyle &&
        other.scrollControlDisabledMaxHeightRatio == scrollControlDisabledMaxHeightRatio &&
        other.showCloseButton == showCloseButton;
  }

  @override
  int get hashCode => Object.hash(
    title,
    leading,
    leadingIconData,
    trailing,
    trailingIconData,
    barrierLabel,
    useRootNavigator,
    isDismissible,
    enableDrag,
    useSafeArea,
    transitionAnimationController,
    animationStyle,
    scrollControlDisabledMaxHeightRatio,
    showCloseButton,
  );

  @override
  String toString() {
    return 'SBBBottomSheetConfig('
        'title: $title, '
        'leading: $leading, '
        'leadingIconData: $leadingIconData, '
        'trailing: $trailing, '
        'trailingIconData: $trailingIconData, '
        'barrierLabel: $barrierLabel, '
        'useRootNavigator: $useRootNavigator, '
        'isDismissible: $isDismissible, '
        'enableDrag: $enableDrag, '
        'useSafeArea: $useSafeArea, '
        'transitionAnimationController: $transitionAnimationController, '
        'animationStyle: $animationStyle, '
        'scrollControlDisabledMaxHeightRatio: $scrollControlDisabledMaxHeightRatio, '
        'showCloseButton: $showCloseButton'
        ')';
  }
}
