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

### ButtonLabelBuilder
Use the `foregroundBuilder` of the `SBBButtonStyle` as a replacement


## Checkbox

### Theming & Styling
* `padding`: replace the checkbox `padding` parameter with the `SBBCheckboxStyle.tapTargetPadding` to increase tappable area
* customize the theme of the `SBBCheckbox` with `SBBCheckboxThemeData`
* access the theme using `Theme.of(context).sbbCheckboxTheme`
* customize an individual checkbox by setting its `style` parameter in the constructor 

## Chip

### Constructor arguments
* To use `SBBChip` the same way as before:
  * replace `onSelection` with `onChanged`
  * replace `label` with `labelText`
  * replace `badgeLabel` with `trailingText`
* complete customization of the `SBBChip` content with `label` and `trailing`
* added the ability to control the Focus with a custom `focusNode`

### Theming & Styling
* customize the theme of the `SBBChip` with `SBBChipThemeData` as input to `SBBTheme`
* access the theme using `Theme.of(context).sbbChipTheme`
* customize a chip by setting its `style` parameter in the constructor

## ListItem

The list item has received a lot of changes. In general the content is completely customizable now.

### Usage
* replace `title` with `titleText` to have a standard styled title
* replace `leadingIcon` with `leadingIconData` to have a standard style leading icon Widget
* replace `subtitle` with `subtitleText` to have a standard styled subtitle
* replace `trailingIcon` with `trailingIconData` to have standard styled trailing icon Widget
* use `title`, `subtitle`, `leading` and `trailing` to completely customize the content with custom Widgets
* set the gap widths between `title`, `subtitle` and `trailing` with the corresponding parameters ()
  * `trailingHorizontalGapWidth`
  * `leadingHorizontalGapWidth`
  * `subtitleVerticalGapHeight`
* If you want a multi line title, use `title` with your own `Text` Widget, the `titleText` will clamp to one line.
* replace `onPressed` with `onTap`
* replace `buttonIcon` and `onPressedButton` from the `button` constructor with a custom trailing widget. Do not forget
  to adjust the `padding`, since the `SBBTertiaryButtonSmall` has an inherent padding to the right
* `isLastElement` was removed, use the static method `divideListItems` to separate list items with a SBB themed divider
  (this is analogous to the Material implementation)

### Theming & Styling
* customize the theme of the `SBBListItem` with `SBBListThemeData` as input to `SBBTheme`
* access the theme using `Theme.of(context).sbbListTheme`
* customize a list item by setting its `style` parameter in the constructor

### Convenience wrappers SBBRadioListItem, SBBCheckboxListItem and SBBSwitchListItem
* basically, all of these have an underlying `SBBListItem` with either a custom trailing or leading widget
* the `onTap` callback is overridden to call the `onChanged` callbacks of the contents
* the parameters are a union between the individual content and a standard `SBBListItem`

### Boxed Variant
* use `SBBListItemBoxed`, `SBBRadioListItemBoxed`, `SBBCheckboxListItemBoxed` and `SBBSwitchListItemBoxed`
* You do not need to wrap this in a `SBBContentBox` anymore

## Radio

### Usage
* the `onChanged` and `groupValue` parameters are obsolete and moved to the corresponding `SBBRadioGroup` ancestor
* see the [official Flutter guide](https://docs.flutter.dev/release/breaking-changes/radio-api-redesign) for
  usage of the new radio group concept
  * instead of a `RadioGroup`, use a `SBBRadioGroup`
* added: use `toggleable` for allowing a radio to return to unselected state without
  selecting a different radio in its group

This also accounts for the `SBBRadioListItem`.

### Theming & Styling
* `padding`: replace the checkbox `padding` parameter with the `SBBRadioStyle.tapTargetPadding` to increase tappable area
* customize the theme of all `SBBRadio` with `SBBRadioThemeData`
* access the theme using `Theme.of(context).sbbRadioTheme`
* customize an individual radio by setting its `style` parameter in the constructor

## Status

### Constructor arguments
* To use `SBBStatus` the same way as before, replace `text` with `labelText`
* The content of the `SBBStatus` can now be completely customized using `label` and `icon` parameters.

### Theming & Styling
* customize the theme of all `SBBStatus` with `SBBStatusThemeData` as input parameter to `SBBTheme`.
* access the theme using `Theme.of(context).sbbStatusTheme`
* customize individual status by setting its `style` parameter in the constructor



## Switch
* increase the tappable area of the switch by setting the `SBBSwitchStyle.tapTargetPadding` value
* customize the theme of all `SBBSwitch` with `SBBSwitchThemeData`
* access the theme using `Theme.of(context).sbbSwitchTheme`
* customize an individual switch by setting its `style` parameter in the constructor
