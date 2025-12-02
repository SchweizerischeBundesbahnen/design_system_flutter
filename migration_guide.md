# V5 Migration guide

V5 introduces a lot of breaking changes to allow for a more flexible and modern Design System.

## Buttons

### Constructor arguments
To use buttons the same way as before, replace `label` with `labelText`.
To use `SBBTertiaryButton` with an icon the same way as in v4, replace `icon` with `iconData`.

Button content can be completely customized using the `label` parameter of type `Widget?`.

### Icon Buttons
Instead of using `SBBIconButtonLarge` / `SBBIconButtonSmall`,
use `SBBTertiaryButton` / `SBBTertiaryButtonSmall` with only `iconData` or `icon` set.

### Button Theming
Buttons can now be themed ap wide using `SBBButtonThemeData` as input parameters to `SBBTheme`.
To access this data within your app, use:

* `Theme.of(context).sbbPrimaryButtonTheme` for the `SBBPrimaryButton` theme data
* `Theme.of(context).sbbSecondaryButtonTheme` for the `SBBSecondaryButton` theme data
* `Theme.of(context).sbbTertiaryButtonTheme` for the `SBBTertiaryButton` theme data


## Checkbox

### Theming & Styling
* `padding`: replace the checkbox `padding` parameter with the `SBBCheckboxStyle.padding` to increase tappable area
* customize the theme of the `SBBCheckbox` with `SBBCheckboxThemeData`
* access the theme using `Theme.of(context).sbbCheckboxTheme`
* customize n individual checkbox by setting its `style` parameter in the constructor 


## Status

### Constructor arguments
* To use `SBBStatus` the same way as before, replace `text` with `labelText`
* The content of the `SBBStatus` can now be completely customized using `label` and `icon` parameters.

### Theming & Styling
* customize the theme of all `SBBStatus` with `SBBStatusThemeData` as input parameter to `SBBTheme`.
* access the theme using `Theme.of(context).sbbStatusTheme`
* customize individual status by setting its `style` parameter in the constructor