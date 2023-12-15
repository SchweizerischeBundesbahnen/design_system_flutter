# Changelog

---

## [Unreleased]

### Added

* Added `SBBStatus` (for web)
* Added `SBBToast` (for web)
* Added `SBBLogo` (SBB Signet)
* Added `SBBWebLogo` (for web)
* Added `SBBTabBar`
* Added `SBBBreadcrumb` (for web)
* Added `SBBWebHeader` (for web)
* Added `SBBResponsive` (for web)
* Added `SBBSideBar` (for web)
* Added `SBBMenuButton` (for web)
* Added `SBBUserMenu` (for web)
* Added `SBBNotificationBox`
* Added `SBBStatusMobile`
* Added global function `showCustomSBBModalSheet`
* `SBBPrimaryButton`: Added different theme based on hostType (for web)
* `SBBTheme`:Added field `hostType`
* `SBBIcons`: Added new icons
* `SBBThemeData`: Added constructor `override` for easier targeted theme customizing
* `SBBThemeData`: Added field `defaultRootContainerPadding`
* `SBBThemeData`: Added function `allStates`
* `SBBThemeData`: Added function `resolveStateWith`
* `SBBTextField`: Added field `obscureText`
* `SBBTextField`: Added field `autofocus`
* `SBBTextFormField`: Added field `autofocus`
* `SBBPrimaryButton`: Added field `focusNode`
* `SBBPrimaryButtonNegative`: Added field `focusNode`
* `SBBSecondaryButton`: Added field `focusNode`
* `SBBTertiaryButtonLarge`: Added field `focusNode`
* `SBBTertiaryButtonSmall`: Added field `focusNode`
* `SBBIconButtonLarge`: Added field `focusNode`
* `SBBIconButtonSmall`: Added field `focusNode`
* `SBBIconButtonSmallNegative`: Added field `focusNode`
* `SBBIconButtonSmallBorderless`: Added field `focusNode`
* `SBBIconFormButton`: Added field `focusNode`
* `SBBIconTextButton`: Added field `focusNode`
* `SBBModalSheet`: Added field `useRootNavigator` (with default value `true`)
* `SBBModalSheet`: Added constructor `custom` for header customizing
* `SBBToast`: Added field `bottom`
* `SBBMultiSelect`: Added field `selectionValidation` and static function `defaultSelectionValidation` for custom selection validation
* `SBBSelect`: Added field `allowMultilineLabel`
* `SBBSelect`: Added field `hint`
* `SBBAccordion`: Added field `titleMaxLines` (with default value `null`, meaning titles are now multiline by default)
* `SBBAccordion`: Added constructor `single` for simpler usage when only one item is needed
* `SBBListHeader`: Added field `maxLines` (with default value `null`, meaning list headers are now multiline by default)
### Changed

- `SBBThemeData`: Adjusted some colors to match the current specifications
- `SBBHeader`: Renamed field `onPressedSBBSignet` to `onPressedLogo`
- `SBBHeader`: Renamed field `sbbSignetTooltip` to `logoTooltip`
- `SBBOnboarding`: Padding now defined by `SBBThemeData.defaultRootContainerPadding`
- `SBBTextStyles`: Adjusted `fontSize` and `height` values to match the current specifications
- `SBBListHeader`: Adjusted paddings to match the current specifications
- `SBBTextField`: Adjusted paddings to match the current specifications
- `SBBSelect`: Adjusted paddings to match the current specifications
- `SBBMultiSelect`: Adjusted paddings to match the current specifications
- `SBBRadioButtonListItem`: Adjusted paddings to match the current specifications
- `SBBSelect`: Field `label` is now optional because there is now a variant without label
- `SBBAccordion`: Adjusted paddings, text style and icon rotation to match the current specifications
- `SBBIcons`: Imported version 0.1.61 from https://icons.app.sbb.ch/.

### Deprecated

### Removed

- `SBBListHeader`: Removed fields `icon` and `onCallToAction` to match the current specifications
- `SBBTextField`: Removed field `alignLabelWithHint`

### Fixed

- `SBBHeader`: SBB Logo now excluded from semantics if `onPressedLogo` is `null`
- `SBBModalSheet`: Fine line that sometimes was visible below the header is now gone
- `SBBCheckboxListItem`: Added missing bottom padding for multi line without secondary label
- `SBBIconTextButton`: Button is not clickable anymore when disabled

---

---

## [0.3.0](https://code.sbb.ch/projects/KD_FLUTTER/repos/design_system_flutter/compare/diff?targetBranch=refs/tags/0.2.0&sourceBranch=refs/tags/0.3.0) - 29.07.2021

### Added

- `SBBRadioButtonListItem`: Added field `allowMultilineLabel`
- `SBBRadioButtonListItem`: Added field `secondaryLabel`
- `SBBIcons`: Added new small and medium icons

---

## [0.2.0](https://code.sbb.ch/projects/KD_FLUTTER/repos/design_system_flutter/compare/diff?targetBranch=refs/tags/0.1.0&sourceBranch=refs/tags/0.2.0) - 08.06.2021

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

### Removed

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

---

## [0.1.0](https://code.sbb.ch/projects/KD_FLUTTER/repos/design_system_flutter/compare/diff?targetBranch=refs/tags/0.0.2&sourceBranch=refs/tags/0.1.0) - 05.02.2021

### Added

- Added more widgets

### Changed

- Changed a lot

---

## [0.0.2](https://code.sbb.ch/projects/KD_FLUTTER/repos/design_system_flutter/compare/diff?targetBranch=refs/tags/0.0.1&sourceBranch=refs/tags/0.0.2) - 15.01.2021

### Added

- Added a lot of widgets

### Changed

- Changed a lot

---

## [0.0.1](https://code.sbb.ch/projects/KD_FLUTTER/repos/design_system_flutter/compare/diff?targetBranch=48d4c63d89f78f14f54bef0eea9455ca1f456ad1&sourceBranch=refs%2Ftags%2F0.0.1) - 29.05.2020

### Added

- Initial project setup
- Added some widgets
