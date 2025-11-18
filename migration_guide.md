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
Buttons can now be themed using `SBBButtonThemeData` as input parameters to `SBBTheme`. To access this data within your
app, use:

* `Theme.of(context).filledButtonTheme` for the `SBBPrimaryButton` theme data
* `Theme.of(context).outlinedButtonTheme` for the `SBBSecondaryButton` theme data
* `Theme.of(context).textButtonTheme` for the `SBBTertiaryButton` theme data
