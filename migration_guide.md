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


## Text Input

### From SBBTextField to SBBTextInput

The `SBBTextField` has been replaced by the more flexible `SBBTextInput`. 
This migration introduces a new decoration system (`SBBInputDecoration`) 
and theme support (`SBBInputDecorationThemeData` and `SBBTextInputThemeData`).

It allows to truly build expandable and multiline text input fields (Text Area).

A boxed variant is added: `SBBTextInputBoxed`

#### Key Differences

| Aspect | SBBTextField | SBBTextInput |
|--------|-------------|------------|
| **Leading widget** | `icon` (IconData only) | `decoration.leading` or `decoration.leadingIconData` |
| **Trailing widget** | `suffixIcon` (Widget) | `decoration.trailing` or `decoration.trailingIconData` |
| **Label** | `labelText` | `decoration.labelText` or `decoration.label` |
| **Placeholder** | `hintText` | `decoration.placeholderText` or `decoration.placeholder` |
| **Error handling** | `errorText` only | `decoration.errorText` or `decoration.error` (as Widget) |
| **Theming** | No theme support | `SBBInputDecorationThemeData` + `SBBTextInputThemeData` |
| **Disabled state** | `enabled` only | `enabled` + `readOnly` (more granular control) |
| **State management** | Custom underline widget | `SBBInputDecorator` with flexible styling |
| **Multiline icons** | Always center-aligned | Automatically top-aligned in multiline mode |

#### Basic Migration Example

**Before (SBBTextField):**
```dart
SBBTextField(
  controller: _controller,
  labelText: 'Username',
  hintText: 'Enter your username',
  errorText: _error,
  icon: Icons.person,
  suffixIcon: Icon(Icons.clear),
  onChanged: (value) => setState(() {}),
)
```

**After (SBBTextInput):**
```dart
SBBTextInput(
  controller: _controller,
  decoration: SBBInputDecoration(
    labelText: 'Username',
    placeholderText: 'Enter your username',
    errorText: _error,
    leadingIconData: Icons.person,
    trailingIconData: Icons.clear,
  ),
  onChanged: (value) => setState(() {}),
)
```

#### Property Mapping

| SBBTextField | SBBTextInput |
|------------|-----------|
| `controller` | `controller` |
| `enabled` | `enabled` |
| `labelText` | `decoration.labelText` |
| `hintText` | `decoration.placeholderText` |
| `errorText` | `decoration.errorText` |
| `icon` | `decoration.leadingIconData` |
| `suffixIcon` | `decoration.trailing` or `decoration.trailingIconData` |
| `obscureText` | `obscureText` |
| `obscuringCharacter` | `obscuringCharacter` |
| `maxLines` | `maxLines` |
| `minLines` | `minLines` |
| `keyboardType` | `keyboardType` |
| `textInputAction` | `textInputAction` |
| `inputFormatters` | `inputFormatters` |
| `onChanged` | `onChanged` |
| `onSubmitted` | `onSubmitted` |
| `onTap` | `onTap` |
| `onTapAlwaysCalled` | `onTapAlwaysCalled` |
| `focusNode` | `focusNode` |
| `autofocus` | `autofocus` |
| `textCapitalization` | `textCapitalization` |
| `enableInteractiveSelection` | `enableInteractiveSelection` |
| `isLastElement` | *(removed)* - use `SBBListItem.divideListItems()` if in lists |

#### Theming

**SBBTextField** had no theme support. **SBBTextInput** uses two theme classes:

1. **`SBBInputDecorationThemeData`**: Controls decoration-level styling
   - Access via `Theme.of(context).sbbInputDecorationTheme`
   - Configure default colors, gaps, text styles for labels, errors, placeholders

2. **`SBBTextInputThemeData`**: Controls input-specific styling
   - Access via `Theme.of(context).sbbTextInputTheme`
   - Configure input text style, foreground color, clear button behavior
   - Example:
   ```dart
   SBBTextInputThemeData(
     inputTextStyle: TextStyle(fontSize: 16),
     enableClearButton: true,
   )
   ```

#### Advanced Features

**SBBTextInput** provides features not available in **SBBTextField**:

1. **Custom Widgets instead of just text**:
   ```dart
   SBBTextInput(
     decoration: SBBInputDecoration(
       label: CustomLabelWidget(),  // Instead of just labelText
       error: CustomErrorWidget(),  // Instead of just errorText
       leading: CustomLeadingWidget(),  // Instead of just icon
     ),
   )
   ```

2. **More granular disabled state control**:
   ```dart
   SBBTextInput(
     enabled: false,  // Disables everything including trailing widgets
     // OR
     readOnly: true,  // Text can't be edited but trailing widgets stay interactive
     enableInteractiveSelection: false,
   )
   ```

3. **Clear button automation**:
A cross small will be displayed instead of the trailingIconData when focused and has non empty input.
   ```dart
   SBBTextInput(
     enableClearButton: true,  // Replaces trailing icon with clear button on focus + content (defaults to true)
     decoration: SBBInputDecoration(
       trailingIconData: Icons.search,
     ),
   )
   ```

5. **Floating label behavior control**:
   ```dart
   SBBTextInput(
     decoration: SBBInputDecoration(
       labelText: 'Email',
       floatingLabelBehavior: SBBFloatingLabelBehavior.always,
       // Label always floats, placeholder shows when empty
     ),
   )
   ```

#### Migration Checklist

- [ ] Replace `SBBTextField` with `SBBTextInput`
- [ ] Move `icon` → `decoration.leadingIconData`
- [ ] Move `hintText` → `decoration.placeholderText`
- [ ] Move `errorText` → `decoration.errorText`
- [ ] Move `suffixIcon` → `decoration.trailing` or `decoration.trailingIconData`
- [ ] Update `isLastElement` usage (remove parameter, use `SBBListItem.divideListItems` instead)
- [ ] Set up theme data if applying custom styles globally
- [ ] Test multiline mode if used (icons should be top-aligned now)
- [ ] Consider using `readOnly` instead of just `enabled` for readonly fields with interactive trailing widgets

