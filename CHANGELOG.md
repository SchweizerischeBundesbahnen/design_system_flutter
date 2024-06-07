# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

It is expected that you keep this format strictly, since we depend on it in our release workflow.

## [Unreleased]

## [1.4.0] - 2024-06-07

### Added

- (#133) Added the `SBBStepper` [digital.sbb.ch#figma](https://www.figma.com/design/tZnqGkmyGDColC9D176MEu/DSM-Beta-Components?node-id=12302-13869\&t=8jZ7c63YUMMZAe8y-0)

### Changed

- (#130) using icons from CDN version `0.1.81`
- (#137) use [flutter\_lints](https://pub.dev/packages/flutter_lints) instead of outdated dart linter

## [1.3.0] - 2024-05-30

### Added

- Added the release github actions workflow.
- (#110) Match typography specifications from [design.sbb.ch](design.sbb.ch) by adding extraSmallFont.
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
- `SBBListItem`: Default constructor builds (trailing) icon variant instead of button variant when `trailingIcon` is not `null`
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

- Refactored theming to use [`ThemeExtensions`](https://api.flutter.dev/flutter/material/ThemeExtension-class.html) introduced in Flutter 3
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
- `SBBMultiSelect`: Added field `selectionValidation` and static function `defaultSelectionValidation` for custom selection validation
- `SBBSelect`: Added field `allowMultilineLabel`
- `SBBSelect`: Added field `hint`
- `SBBAccordion`: Added field `titleMaxLines` (with default value `null`, meaning titles are now multiline by default)
- `SBBAccordion`: Added constructor `single` for simpler usage when only one item is needed
- `SBBListHeader`: Added field `maxLines` (with default value `null`, meaning list headers are now multiline by default)
- `SBBListItem`: Added field `titleMaxLines` (with default value `null`, meaning titles are now multiline by default)
- `SBBListItem`: Added field `subtitleMaxLines` (with default value `null`, meaning subtitles are now multiline by default)

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
- `SBBSelect`: Added class `SelectMenuItem<T>>` that is now to be used for the items list to match semantics of `DropdownButton`
- `SBBSelect`: Added static method `showMenu<T>()` that can now be used to directly show the SBBSelect menu without building the widget
- `SBBModalPopup`: Added field `clipBehavior` for clipping possibilities if popup content overflows.

### Changed

- Null safety migration
- `SBBThemeData`: Constructors `light` and `dark` no longer have parameters because it is now obsolete due to the introduction of `copyWith`
- `SBBHeader`: Set value of `AppBar.brightness` to `Brightness.dark`, which means that the icons in the status bar are now always white, regardless of the theme
- `SBBHeader`: Set value of `AppBar.titleSpacing` to `0.0` to allow more characters in title
- `SBBHeader`: Set value of `AppBar.titleSpacing` to `0.0` to allow more characters in title
- `SBBSelect`: Renamed field `labelText` to `label`
- `SBBSelect`: Renamed field `modalTitle` to `title`
- `SBBSelect`: Changed field type of `items` from `List<T>` to `List<SelectMenuItem<T>>` to match semantics of `DropdownButton`
- `SBBListItem`: The trailing `SBBIconButtonSmall` now ignores gestures if `onCallToAction` is `null`
- `SBBListItem`: The trailing `SBBIconButtonSmall` now not focusable if `onCallToAction` is `null`
- `Tooltip`: Set theme match `SBBToast` look and feel
- There were many minor changes in this release to match the current specifications of the Design System Mobile Sketch file

### Deprecated

- `SBBBaseTextStyles` is now deprecated, use `SBBTextStyles` instead (see [TEXTSTYLES-MIGRATION-GUIDE.md](https://code.sbb.ch/projects/KD_FLUTTER/repos/design_system_flutter/browse/TEXTSTYLES-MIGRATION-GUIDE.md))
- `SBBGroup`: Removed variant `red` to match the current specifications
- `SBBGroup`: Removed variant `grey` to match the current specifications
- `SBBGroup`: Removed field `useBlackForDarkMode` to match the current specifications
- `SBBGroup`: Removed field `color` to match the current specifications
- `SBBSelect`: Removed field `modalButtonLabel` because the modal submit button has been removed to match the current specifications
- `SBBSelect`: Removed field `itemToString` because it is now obsolete due to the introduction of `SelectMenuItem<T>>` to match semantics of `DropdownButton`
- `SBBCheckbox`: Removed fields `mouseCursor`, `materialTapTargetSize`, `focusNode`, `autofocus`, `shape` and `side`
- `SBBRadioButton`: Removed fields `mouseCursor`, `toggleable`, `materialTapTargetSize`, `focusNode` and `autofocus`

### Fixed

- `SBBTertiaryButtonLarge`: Was still clickable in loading state
- `SBBRadioButton`: Completely reworked implementation from ground up because old implementation was very heavily based on the material `Radio` widget and therefore kept breaking from changes of the material widget that came with flutter updates
- `SBBCheckbox`: Completely reworked implementation from ground up because old implementation was very heavily based on the material `Checkbox` widget and therefore kept breaking from changes of the material widget that came with flutter updates

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

[Unreleased]: https://github.com/SchweizerischeBundesbahnen/design_system_flutter/compare/1.4.0...HEAD

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
