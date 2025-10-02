# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

It is expected that you keep this format strictly, since we depend on it in our release workflow.

## [Unreleased]

### Added

- added `SBBSliverFloatingHeaderbox` that allows the headerbox to expand and contract as the user scrolls. 

### Fixed

- `SBBTabBar`: properly clips icons as they get selected / unselected
- keyboard focus for `SBBTabBar`

### Changed

- (auto): updated icon lib to version 1.8.9
- aligned SBBColors to colors in Figma and specs
- error color in SBBTheme is used from `SBBBaseStyle.errorColor`
- use functional colors as in specs for `SBBStatus` and `SBBNotificationBox`

### Added

- added functional colors (e.g. `SBBColors.error`) and dark variants of additionalColors (e.g. `SBBColors.skyDark`)
- added `errorColor` to `SBBBaseStyle`
- added `systemOverlayStyle` to `SBBHeader`

## [4.1.0] - 2025-08-22

### Changed

- `SBBMessage`: default constructor does not include illustration
- `SBBMessage`: messageCode and illustration are excluded from semantics
- updated icon lib to version 1.8.0
- dropped support for Flutter SDK 3.27.x

### Fixed

- `SBBGroup`: clip behavior is respected - default ClipBehavior.hard

## [4.0.0] - 2025-07-14

### Changed

- BREAKING: `SBBToast`: `message` becomes `title`
- BREAKING: `TabBarItem` becomes `SBBTabBarItem`
- BREAKING: `TabBarController` becomes `SBBTabBarController`
- Simpler implementation of the `SBBTabBar`
- `SBBTabBar` now respects the `SafeArea` for the `systemNavigationBar`
- updated icon lib to version 1.7.1

### Added

- `SBBGroupStyle` is used to style `SBBGroup` in a theme extension like manner
- `SBBToastStyle` is used to style `SBBToast` in a theme extension like manner
- `SBBGroup` has `isSemanticContainer` flag for accessibility
- `SBBToastAction` to display an action with a callback in `SBBToast`
- add *semantics* to `SBBToast` (liveRegion and container)

### Removed

- `SBBGroup` does not have a shadow anymore (removed `useShadow` flag)
- `SBBToast` does not have `confirmation`, `error` or `warning` methods any more
- removed `toastBackgroundColor` from `SBBControlStyles` in favor of `SBBToastStyle`
- removed `toastTextStyle` from `SBBControlStyles` in favor of `SBBToastStyle`
- removed `groupBackgroundColor` from `SBBControlStyles`

## [3.2.0] - 2025-06-23

### Added

- added `style` to `SBBPromotionBox.custom` constructor

### Changed

- New design for `SBBSwitch`
- `SBBSegmentedButton`: Accepts `values` / `icons` with single item in `List` / `Map`

### Deprecated

- deprecated `badgeColor`, `badgeShadowColor` and `gradientColors` of `SBBPromotionBox.custom` constructor in favor of
  `style`

## [3.1.0] - 2025-05-22

### Changed

- updated the SBB Icons version to 1.6.2
- Dropped support for `Flutter SDK 3.24.5`: minimum supported version is 3.27.0

## [3.0.0] - 2025-04-24

### Added

- added `custom` constructor to `SBBPromotionBox` to allow for complete control over the content
- added `copyWith` to `PromotionBoxStyle`
- added `showCloseButton` and `backgroundColor` to `SBBModalPopup` and `SBBModalSheet` and their show methods
- added `onChangeStart` and `onChangeEnd` to `SBBSlider`

### Changed

- BREAKING: default constructor of `SBBPromotionBox` is not compile constant
- BREAKING: removed `isCloseable` in `SBBPromotionBox` - merge behavior with nullable `onClose`
- BREAKING: changed `description` to `subtitle` in `SBBPromotionBox` for more consistency with other Widgets
- BREAKING: renamed `CloseableBoxController` to `ClosableBoxController`

### Removed

- removed deprecated `SBBIconFormButton`
- removed deprecated `SBBRadioButton` in favor of `SBBRadio`
- removed deprecated `SBBRadioButtonListItem` in favor of `SBBRadioListItem`
- removed deprecated `sbbWebFont` in favor of `sbbFont`
- removed deprecated `SBBPrimaryButtonNegative`
- removed deprecated `SBBIconButtonSmallBorderless`

### Fixed

- fixed `onChanged` of `SBBAutocompletion` (#304)

## [2.3.0] - 2025-03-04

### Added

- added customization to `SBBTextStyles` via `TextStylesExtensions` - refer to documentation in `SBBTextStyles`
- added `sbbTextStyle` for easier use of extension methods in `TextStylesExtensions`
- added `xxLargeFontSize` and `xLargeFontSize` to `SBBTextStyles`
- added `extraExtraLargeBold` and `extraExtraLargeLight` to `SBBTextStyles`
- added `SBBFontFamily` to access all font families in `SBB Design System Mobile`

### Changed

- Dropped support for `Flutter SDK 3.22.x`: minimum supported version is 3.24.0

### Deprecated

- deprecated `sbbWebFont` in favor of `sbbFont` for clearer naming convention

### Fixed

- fixed all wrong font weights of existing textStyles in `SBBTextStyles` via switching font family

## [2.2.0] - 2025-01-14

### Changed

- changed behavior of the trailing widget and icon of the following widgets:
  - `SBBCheckboxListItem`
  - `SBBRadioButtonListItem`
  - `SBBRadioListItem`
- updated the SBB Icons version to 1.2.0

### Added

- added the `SBBHeaderBox` and `SBBSliverHeaderbox`
- added an animated bottom loading indicator with a `isLoading` parameter to these widgets:
  - `SBBCheckboxListItem`
  - `SBBRadioButtonListItem`
  - `SBBRadioListItem`
  - `SBBSwitchListItem`
- added `boxed` variant via redirecting constructor to these widgets:
  - `SBBCheckboxListItem`
  - `SBBRadioButtonListItem`
  - `SBBRadioListItem`
  - `SBBSwitchListItem`
- added Semantics to the following widgets:
  - `SBBCheckboxListItem`
  - `SBBRadioButtonListItem`
  - `SBBRadioListItem`
- added animation to `SBBPagination`
- added the `SBBIconsIndex` allowing String to IconData mapping

### Fixed

- correct layout of `SBBCheckbox`
- correct color usage of the `SBBCheckboxListItem`
- `allowMultilineLabel` of `SBBSwitchListItem` is respected

### Deprecated

- Deprecated `SBBRadioButton` in favor of `SBBRadio`
- Deprecated `SBBRadioButtonListItem` in favor of `SBBRadioListItem`

## [2.1.1] - 2024-12-14

### Fixed

- `SafeArea` is applied to content of `showSBBModalSheet` - not to the sheet itself

## [2.1.0] - 2024-12-13

### Added

- added `constraints` to `showSBBModalSheet` to allow varying screen sizes (tablet)

### Changed

- Dropped support for `Flutter SDK 3.19.6`: minimum supported version is 3.22.3
- `showSBBModalSheet` & `showCustomSBBModalSheet`: add bottom safe area of content if `useSafeArea` is true

### Deprecated

- `SBBIconFormButton`
- `SBBIconButtonSmallBorderless`
- `SBBPrimaryButtonNegative`

### Fixed

- correct height for `SBBTertiaryButtonSmall` (40px => 32px)
- coloring of:
  - `SBBSecondaryButton` (onHighlighted)
  - `SBBTertiaryButton` (darkMode)
  - `SBBIconButtonSmall`
  - `SBBIconButtonLarge`
- `iconColor` in `SBBButtonStyle` is correctly overriden to support Flutter SDK >=3.27.0

## [2.0.0] - 2024-09-06

### Changed

- Renamed `SBBStatusMobile` to `SBBStatus`

### Fixed

- Bugfix for semantics in `SBBSegmentedButton`

### Removed

- Removed web widgets:
  - `SBBBreadcrumb`
  - `SBBCard`
  - `SBBDropdown`
  - `SBBGhostButton`
  - `SBBMenu`
  - `SBBResponsive`
  - `SBBSidebar`
  - `SBBStatus` (is now mobile default)
  - `SBBUserMenu`
  - `SBBWebHeader`
  - `SBBWebNotification`

- Remove deprecated `SBBBaseTextStyles`

- Removed web typography:
  - `SBBLeanTextStyles`
  - `SBBWebText`
  - `SBBWebTextStyles`

- Removed web mode from the following widgets:
  - `SBBAccordion`
  - `SBBAutocompletion`
  - `SBBCheckbox`
  - `SBBCheckboxListItem`
  - `SBBIconButton` (all variants)
  - `SBBLinkText` (including refactoring)
  - `SBBListItem`
  - `SBBLoadingIndicator`
  - `SBBPrimaryButton`
  - `SBBRadioButton`
  - `SBBRadioButtonListItem`
  - `SBBSelect`
  - `SBBSecondaryButton`
  - `SBBTextField`
  - `SBBTextFormField`
  - `SBBToast`

- Removed `HostPlatform` from `SBBTheme`

- Removed and cleaned web parts in `SBBControlStyles`

- Removed web parts in `SBBButtonStyles`

- Removed web mode in example app

- Removed deprecated `onCallToAction` from SBBListItem

- Removed deprecated `SBBIconTextButton`

## [1.6.0] - 2024-09-04

### Changed

- (#164) Updated icon version to `1.0.3` (was `1.0.0`).

### Deprecated

- (#162) Deprecated Web Widgets:
  - `SBBResponsive`
  - `SBBWebHeader`
  - `SBBMenu`
  - `SBBUserMenu`
  - `SBBCard`
  - `SBBSidebar`

## [1.5.0] - 2024-08-15

### Added

- (#150) Added `SBBDateInput`
- (#150) Added `SBBDateTimeInput`
- (#150) Added `SBBTimeInput`
- (#150) Added `SBBInputTrigger`

### Changed

- (#148) Update SBB icons to version 1.0.0
- Implement all Notification Box
  Styles [Figma Link](https://www.figma.com/design/WOtLIam1xwrqcgnAITsEhV/Design-System-Mobile?m=auto\&node-id=7271-28\&t=gismRyaDdiCfaHBj-1)
- (#150) Added function `showModal` in `SBBDatePicker`, `SBBDateTimePicker`, `SBBTimePicker`
- Minimum supported dart sdk is 3.3.0.

### Deprecated

- (#142) Deprecated Web Components:
  - `SBBStatus`
  - `SBBWebLogo`
  - `SBBLeanTextStyles`
  - `SBBWebText`
  - `SBBWebTextStyles`
  - `SBBBreadcrumb`

### Fixed

- (#113) `SBBTimePicker`: Added support for time ranges that span over midnight

## [1.4.0] - 2024-06-07

### Added

- (#133) Added the
  `SBBStepper` [digital.sbb.ch#figma](https://www.figma.com/design/tZnqGkmyGDColC9D176MEu/DSM-Beta-Components?node-id=12302-13869\&t=8jZ7c63YUMMZAe8y-0)
- (#153) `SBBModalSheet`: Added parameters `useSafeArea` and `enableDrag` to global functions `showSBBModalSheet` and
  `showCustomSBBModalSheet`

### Changed

- (#130) using icons from CDN version `0.1.81`
- (#137) use [flutter\_lints](https://pub.dev/packages/flutter_lints) instead of outdated dart linter

## [1.3.0] - 2024-05-30

### Added

- Added the release github actions workflow.
- (#110) Match typography specifications
  from [design.sbb.ch](https://digital.sbb.ch/en/design-system/mobile/basics/typography/) by adding extraSmallFont.
- (#107) `SBBTabBar`: Added field `onTap`, which allows for reacting to taps on tab items.
- (#106) `FontScripts`: Added utils to update the SBB Icon fonts with a script.

### Changed

- (#118) Changed the test flow to include CHANGELOG.md validation.
- (#111) `SBBMessage`: Make `SBBMessage` only as big as needed to prevent content being pushed on top.

### Fixed

- (#115) Golden Tests by replacing golden\_toolkit package.
- (#114) Support Flutter 3.22 by replacing `TextTheme.subtitle` getter.

## [1.2.0] - 2023-12-19

### Added

- (#63) Added `SBBMessage`
- (#89) Added `SBBNotificationBox`
- (#90) Added `SBBStatusMobile`
- (#57) Added `SBBPicker`
- (#57) Added `SBBDatePicker`
- (#57) Added `SBBTimePicker`
- (#57) Added `SBBDateTimePicker`

## [1.1.0] - 2023-09-01

### Added

- (#73) Added `SBBSlider`
- (#59) Added `SBBSwitch`
- (#67) Added `SBBPromotionBox`
- (#74) Added `SBBChip`
- (#82) Added `SBBPagination`
- `SBBListItem`: Added constructor `custom` for custom trailing Widget
- `SBBListItem`: Added constructor `button` for button variant

### Changed

- `SBBBaseStyle`: Changed value of `labelColor` to match current specifications
- `SBBListItemStyle`: Changed color values to match current specifications
- `SBBListItem`: Default constructor builds (trailing) icon variant instead of button variant when `trailingIcon` is not
  `null`
  - For backwards compatibility default constructor still builds button variant if `onCallToAction` is not `null`

### Deprecated

- `SBBListItem`: Parameter `onCallToAction` is now `deprecated`
  - Use the newly added constructor `custom` for the button variant

### Fixed

- (#83) `SBBTabBar`: Fixed bug where animations were not symmetric

## [1.0.0] - 2023-05-26

### Added

- (#62) `SBBColors`: Added new colors to match current specifications

### Changed

- (#60) Migration to Flutter 3.10.0
- (#52) `SBBSegmentedButton`: Updated UI to match current specifications
- (#62) `SBBColors`: Changed color `green` to match current specifications
- `SBBOnboarding`: Changed screen reader behaviour

## [0.7.1] - 2023-01-19

### Fixed

- `SBBIconTextButton`: Button is not clickable anymore when disabled
- `SBBSelect`: No pixel overflow when using larger font
- `SBBAutocompletion`: Corrected colors

## [0.7.0] - 2022-11-25

### Added

- `SBBTabBar`: Added functionality to show warnings
  - `SBBTabBar`: Added field `showWarning` (with default value `false`)
  - `SBBTabBar`: Added field `warningIndex`
  - `TabItemWidget`: Added field `warning` (with default value `false`)
- `SBBSegmentedButton`: Added more fields to customise
  - `SBBSegmentedButton`: Added field `borderColor`
  - `SBBSegmentedButton`: Added field `boxShadow`
- Added `SBBRadioButton` (for web)
- Added `SBBAutocompletion` (for web)
- Added `SBBCard` (for web)
- Added `SBBAccordion` (for web)
- Added `SBBTextFormField` (for web)
- Added `SBBTextField` (for web)
- Added `SBBDropdownButton` (for web)
- Added `SBBWebNotification` (for web)

### Changed

- Refactored theming to use [`ThemeExtensions`](https://api.flutter.dev/flutter/material/ThemeExtension-class.html)
  introduced in Flutter 3
- `SBBLeanLogo` renamed to `SBBWebLogo`

## [0.6.0] - 2022-05-19

### Changed

- Migration to Flutter 3.0.0

## [0.5.0] - 2022-05-19

### Added

- Added `SBBLeanLogo` (for web)
- Added `SBBBreadcrumb` (for web)
- Added `SBBWebHeader` (for web)
- Added `SBBResponsive` (for web)
- Added `SBBSideBar` (for web)
- Added `SBBMenuButton` (for web)
- Added `SBBUserMenu` (for web)
- `SBBPrimaryButton`: Added different theme based on hostType (for web)
- `SBBTheme`:Added field `hostType`
- `SBBIcons`: Added new icons
- `SBBThemeData`: Added function `allStates`
- `SBBThemeData`: Added function `resolveStateWith`
- `SBBTextField`: Added field `autofocus`
- `SBBTextFormField`: Added field `autofocus`
- `SBBTextField`: Added field `autofocus`
- `SBBTextFormField`: Added field `autofocus`
- `SBBMultiSelect`: Added field `selectionValidation` and static function `defaultSelectionValidation` for custom
  selection validation
- `SBBSelect`: Added field `allowMultilineLabel`
- `SBBSelect`: Added field `hint`
- `SBBAccordion`: Added field `titleMaxLines` (with default value `null`, meaning titles are now multiline by default)
- `SBBAccordion`: Added constructor `single` for simpler usage when only one item is needed
- `SBBListHeader`: Added field `maxLines` (with default value `null`, meaning list headers are now multiline by default)
- `SBBListItem`: Added field `titleMaxLines` (with default value `null`, meaning titles are now multiline by default)
- `SBBListItem`: Added field `subtitleMaxLines` (with default value `null`, meaning subtitles are now multiline by
  default)

### Changed

- `SBBThemeData`: Adjusted some colors to match the current specifications
- `SBBOnboarding`: Padding now defined by `SBBThemeData.defaultRootContainerPadding`
- `SBBSelect`: Adjusted paddings to match the current specifications
- `SBBMultiSelect`: Adjusted paddings to match the current specifications
- `SBBRadioButtonListItem`: Adjusted paddings to match the current specifications
- `SBBSelect`: Field `label` is now optional because there is now a variant without label
- `SBBAccordion`: Adjusted paddings, text style and icon rotation to match the current specifications

### Fixed

- `SBBCheckboxListItem`: Added missing bottom padding for multiline without secondary label

## [0.4.0] - 2022-05-19

### Added

- Added `SBBTabBar`
- Added global function `showCustomSBBModalSheet`
- `SBBModalSheet`: Added field `useRootNavigator` (with default value `true`)
- `SBBModalSheet`: Added constructor `custom` for header customizing
- `SBBToast`: Added field `bottom`

### Changed

- `SBBTextStyles`: Adjusted `fontSize` and `height` values to match the current specifications
- `SBBListHeader`: Adjusted paddings to match the current specifications
- `SBBTextField`: Adjusted paddings to match the current specifications

### Deprecated

- `SBBListHeader`: Removed fields `icon` and `onCallToAction` to match the current specifications
- `SBBTextField`: Removed field `alignLabelWithHint`

### Fixed

- `SBBModalSheet`: Fine line that sometimes was visible below the header is now gone

## [0.3.0] - 2021-07-29

### Added

- `SBBRadioButtonListItem`: Added field `allowMultilineLabel`
- `SBBRadioButtonListItem`: Added field `secondaryLabel`
- `SBBIcons`: Added new small and medium icons

***

## [0.2.0] - 2021-06-08

### Added

- Added actual content to CHANGELOG.md
- Added [TEXTSTYLES-MIGRATION-GUIDE.md](https://code.sbb.ch/projects/KD_FLUTTER/repos/design_system_flutter/browse/TEXTSTYLES-MIGRATION-GUIDE.md)
- Added `SBBToast`
- Added `SBBAccordion`
- Added `SBBMultiSelect`
- Added `SBBPrimaryButtonNegative`
- Added `SBBIconButtonSmallNegative`
- Added `SBBIconButtonSmallBorderless`
- Added `SBBOnboarding`
- Added `SBBLinkText`
- Added global constant `sbbDefaultSpacing` (16.0)
- Added global constant `sbbIconSizeSmall` (24.0)
- Added global constant `sbbIconSizeMedium` (36.0)
- Added global constant `sbbIconSizeLarge` (48.0)
- `SBBThemeData`: Added method `copyWith` for easier theme customizing
- `SBBThemeData`: Added field `defaultTextStyle`
- `SBBThemeData`: Added field `headerButtonBackgroundColorHighlighted`
- `SBBColors`: Added constant `midnight`
- `SBBHeader`: Added field `sbbSignetTooltip`
- `SBBTertiaryButtonLarge`: Added field `icon`
- `SBBTertiaryButtonSmall`: Added field `icon`
- `SBBCheckboxListItem`: Added field `allowMultilineLabel`
- `SBBCheckboxListItem`: Added field `secondaryLabel`
- `SBBTextField`: Added field `hintMaxLines`
- `SBBSelect`: Added class `SelectMenuItem<T>>` that is now to be used for the items list to match semantics of
  `DropdownButton`
- `SBBSelect`: Added static method `showMenu<T>()` that can now be used to directly show the SBBSelect menu without
  building the widget
- `SBBModalPopup`: Added field `clipBehavior` for clipping possibilities if popup content overflows.

### Changed

- Null safety migration
- `SBBThemeData`: Constructors `light` and `dark` no longer have parameters because it is now obsolete due to the
  introduction of `copyWith`
- `SBBHeader`: Set value of `AppBar.brightness` to `Brightness.dark`, which means that the icons in the status bar are
  now always white, regardless of the theme
- `SBBHeader`: Set value of `AppBar.titleSpacing` to `0.0` to allow more characters in title
- `SBBHeader`: Set value of `AppBar.titleSpacing` to `0.0` to allow more characters in title
- `SBBSelect`: Renamed field `labelText` to `label`
- `SBBSelect`: Renamed field `modalTitle` to `title`
- `SBBSelect`: Changed field type of `items` from `List<T>` to `List<SelectMenuItem<T>>` to match semantics of
  `DropdownButton`
- `SBBListItem`: The trailing `SBBIconButtonSmall` now ignores gestures if `onCallToAction` is `null`
- `SBBListItem`: The trailing `SBBIconButtonSmall` now not focusable if `onCallToAction` is `null`
- `Tooltip`: Set theme match `SBBToast` look and feel
- There were many minor changes in this release to match the current specifications of the Design System Mobile Sketch
  file

### Deprecated

- `SBBBaseTextStyles` is now deprecated, use `SBBTextStyles` instead (
  see [TEXTSTYLES-MIGRATION-GUIDE.md](https://code.sbb.ch/projects/KD_FLUTTER/repos/design_system_flutter/browse/TEXTSTYLES-MIGRATION-GUIDE.md))
- `SBBGroup`: Removed variant `red` to match the current specifications
- `SBBGroup`: Removed variant `grey` to match the current specifications
- `SBBGroup`: Removed field `useBlackForDarkMode` to match the current specifications
- `SBBGroup`: Removed field `color` to match the current specifications
- `SBBSelect`: Removed field `modalButtonLabel` because the modal submit button has been removed to match the current
  specifications
- `SBBSelect`: Removed field `itemToString` because it is now obsolete due to the introduction of `SelectMenuItem<T>>`
  to match semantics of `DropdownButton`
- `SBBCheckbox`: Removed fields `mouseCursor`, `materialTapTargetSize`, `focusNode`, `autofocus`, `shape` and `side`
- `SBBRadioButton`: Removed fields `mouseCursor`, `toggleable`, `materialTapTargetSize`, `focusNode` and `autofocus`

### Fixed

- `SBBTertiaryButtonLarge`: Was still clickable in loading state
- `SBBRadioButton`: Completely reworked implementation from ground up because old implementation was very heavily based
  on the material `Radio` widget and therefore kept breaking from changes of the material widget that came with flutter
  updates
- `SBBCheckbox`: Completely reworked implementation from ground up because old implementation was very heavily based on
  the material `Checkbox` widget and therefore kept breaking from changes of the material widget that came with flutter
  updates

***

## [0.1.0] - 2021-02-05

### Added

- Added more widgets

### Changed

- Changed a lot

***

## [0.0.2] - 2021-01-15

### Added

- Added a lot of widgets

### Changed

- Changed a lot

***

## [0.0.1] - 2020-05-29

### Added

- Initial project setup
- Added some widgets

[Unreleased]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/4.1.0...HEAD

[4.1.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/4.0.0...4.1.0

[4.0.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/3.2.0...4.0.0

[3.2.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/3.1.0...3.2.0

[3.1.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/3.0.0...3.1.0

[3.0.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/2.3.0...3.0.0

[2.3.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/2.2.0...2.3.0

[2.2.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/2.1.1...2.2.0

[2.1.1]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/2.1.0...2.1.1

[2.1.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/2.0.0...2.1.0

[2.0.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/1.6.0...2.0.0

[1.6.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/1.5.0...1.6.0

[1.5.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/1.4.0...1.5.0

[1.4.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/1.3.0...1.4.0

[1.3.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/1.2.0...1.3.0

[1.2.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/1.1.0...1.2.0

[1.1.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/1.0.0...1.1.0

[1.0.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/0.7.1...1.0.0

[0.7.1]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/0.7.0...0.7.1

[0.7.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/0.6.0...0.7.0

[0.6.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/0.5.0...0.6.0

[0.5.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/0.4.0...0.5.0

[0.4.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/0.3.0...0.4.0

[0.3.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/0.2.0...0.3.0

[0.2.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/0.1.0...0.2.0

[0.1.0]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/0.0.2...0.1.0

[0.0.2]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/0.0.1...0.0.2

[0.0.1]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/releases/tag/0.0.1
