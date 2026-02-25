# V5 Migration guide

V5 introduces a lot of breaking changes to allow for a more flexible and modern Design System.

## Buttons

### Constructor arguments
* replace `label` with `labelText` (or custom Widget for `label` parameter)
* `SBBTertiaryButton`: replace `icon` with `iconData` (or custom Widget for `icon` parameter)
* customize appearance of a single button via the `style` parameter
* added `onLongPress`, `semanticLabel` and `autofocus` to all button variants

### Icon Buttons
* `SBBIconButtonLarge` / `SBBIconButtonSmall` are replaced by `SBBTertiaryButton` / `SBBTertiaryButtonSmall`
  with only `iconData` or `icon` set

### Theming
Buttons can now be themed ap wide using `SBBButtonThemeData` as input parameters to `SBBTheme`.
To access this data within your app, use:

* `Theme.of(context).sbbPrimaryButtonTheme` for the `SBBPrimaryButton` theme data
* `Theme.of(context).sbbSecondaryButtonTheme` for the `SBBSecondaryButton` theme data
* `Theme.of(context).sbbTertiaryButtonTheme` for the `SBBTertiaryButton` theme data

### ButtonLabelBuilder
Use the `foregroundBuilder` of the `SBBButtonStyle` as a replacement


## Checkbox

### Constructor
* added `focusNode` and `autofocus`

### Theming & Styling
* `padding`: replace the checkbox `padding` parameter with the `SBBCheckboxStyle.tapTargetPadding` to increase tappable area
* customize the theme of the `SBBCheckbox` with `SBBCheckboxThemeData`
* access the theme using `Theme.of(context).sbbCheckboxTheme`
* customize an individual checkbox by setting its `style` parameter in the constructor 


## Chip

### Constructor arguments
* replace `onSelection` with `onChanged`
* replace `label` with `labelText` (complete custom content with `label`)
* replace `badgeLabel` with `trailingText` (complete custom content with `label`)
* added the ability to control the Focus with a custom `focusNode`

### Theming & Styling
* customize the theme of the `SBBChip` with `SBBChipThemeData` as input to `SBBTheme`
* access the theme using `Theme.of(context).sbbChipTheme`
* customize a chip by setting its `style` parameter in the constructor


## Header

### Added SBBHeaderSmall
* replace `SBBHeader` with `SBBHeaderSmall` to keep the same size
* `SBBHeader` now has an added spacing matching the design spec.

### Constructor arguments
* replace `title` with `titleText` (complete custom content with `title`)
* replace `leadingWidget` with `leading`
* removed `blockSemantics`, check out `excludeHeaderSemantics`
* removed `systemOverlayStyle`, moved to style `SBBHeaderStyle.systemOverlayStyle`
* removed `onPressedLogo` and `logoTooltip`. To customize trailing content, provide actions yourself.
* added `useDefaultSemanticsOrder`, `excludeHeaderSemantics`, `bottom` and `style`

### Leading buttons
* removed factory methods `SBBHeader.back()`, `SBBHeader.close()` and `SBBHeader.menu()`.
* exposed new widgets `SBBHeaderLeadingBackButton`, `SBBHeaderLeadingCloseButton` and `SBBHeaderLeadingMenuButton`.
* If you previously used default `automaticallyImplyLeading: true`, the header will pick one of the above widgets automatically.

Old implementation:
```dart
SBBHeader.back(title: 'SBB Header')
```

New implementation:
```dart
SBBHeader(
   titleText: 'SBB Header',
   leading: SBBHeaderLeadingBackButton(),
)
```

### Theming & Styling
* customize the theme of the `SBBHeader` and `SBBHeaderSmall` with `SBBHeaderThemeData` as input to `SBBTheme`
* access the theme using `Theme.of(context).sbbHeaderTheme`
* customize a header by setting its `style` parameter in the constructor


## ListItem

The list item has received a lot of changes. In general the content is completely customizable now.

### Usage
* replace `onPressed` with `onTap`
* replace `title` with `titleText`
* replace `leadingIcon` with `leadingIconData`
* replace `subtitle` with `subtitleText`
* replace `trailingIcon` with `trailingIconData`
* use `title`, `subtitle`, `leading` and `trailing` of type Widget? for complete customization
* If you want a multi line title, use `title` with your own `Text` Widget, the `titleText` will clamp to one line
* replace `buttonIcon` and `onPressedButton` from the `button` constructor with a custom trailing widget. Do not forget
  to adjust the `padding`, since the `SBBTertiaryButtonSmall` has an inherent padding to the right
* `isLastElement` was removed, use the static method `SBBListItem.divideListItems` to separate list 
  items with a SBB themed divider (this is analogous to the Material implementation)

### Theming & Styling
* customize the theme of the `SBBListItem` with `SBBListThemeData` as input to `SBBTheme`
* access the theme using `Theme.of(context).sbbListTheme`
* customize a list item by setting its `style` parameter in the constructor

### Convenience wrappers SBBRadioListItem, SBBCheckboxListItem and SBBSwitchListItem
* basically, all of these have an underlying `SBBListItem` with either a custom trailing or leading widget
* the `onTap` callback is overridden to call the `onChanged` callbacks of the contents
* the parameters are a union between the individual trailing content and a standard `SBBListItem`

### Boxed Variant
* use `SBBListItemBoxed`, `SBBRadioListItemBoxed`, `SBBCheckboxListItemBoxed` and `SBBSwitchListItemBoxed`
* You do NOT need to wrap this in a `SBBContentBox` anymore


## ListHeader

### Constructor arguments
* Replace `title` with `titleText`
* Remove `maxLines`, `padding`, and `textStyle` parameters from constructor
* Use the `style` parameter with `SBBListHeaderStyle` for customization

### Theming & Styling
* customize the theme of all `SBBListHeader` with `SBBListHeaderThemeData` as input to `SBBTheme`
* access the theme using `Theme.of(context).sbbListHeaderTheme`
* customize an individual list header by setting its `style` parameter in the constructor


## Message

### Constructor arguments
* Replace required `title` with `titleText` (or use `title` for custom widgets)
* Replace required `description` with `subtitleText` (or use `subtitle` for custom widgets)
* Replace `messageCode` with `errorText` (or use `error` for custom widgets)
* Replace `customIllustration` with `illustration` parameter (accepts `SBBIllustration` or any custom widget)
* Replace `illustration: MessageIllustration.Display` with `illustration: SBBIllustration.display()` (use SBBIllustration widget or custom)
* Replace `onInteraction` callback and `interactionIcon` with an `action` widget parameter (typically `SBBTertiaryButton`)

### Theming & Styling
* customize the theme of all `SBBMessage` with `SBBMessageThemeData` as input to `SBBTheme`
* access the theme using `Theme.of(context).sbbMessageTheme`
* customize an individual message by setting its `style` parameter in the constructor


## Paginator

### Class Changes
* `SBBPagination` is now split into two separate widgets:
  * `SBBPaginator`: the standard paginator
  * `SBBPaginatorFloating`: the floating variant (inherits from `SBBPaginator`)
* Replace `isFloating: true` with `SBBPaginatorFloating` instead of `SBBPaginator`

### Theming & Styling
* customize the theme of all `SBBPaginator` with `SBBPaginatorThemeData` as input to `SBBTheme`
* access the theme using `Theme.of(context).sbbPaginatorTheme`
* customize an individual paginator by setting its `style` parameter in the constructor
* Old style access via `SBBControlStyles.of(context).pagination!` is replaced with theme extension pattern


## Radio

### Usage
* the `onChanged` and `groupValue` in `SBBRadio<T>` parameters are moved to the `SBBRadioGroup<T>` ancestor
* see the [official Flutter guide](https://docs.flutter.dev/release/breaking-changes/radio-api-redesign) for usage of the new radio group concept
  * instead of a `RadioGroup<T>`, use a `SBBRadioGroup<T>`
* added: use `toggleable` for allowing a radio to return to unselected state without
  selecting a different radio in its group
* added `focusNode` & `autofocus`

All of the above also affects the `SBBRadioListItem`.

### Theming & Styling
* `padding`: replace the checkbox `padding` parameter with the `SBBRadioStyle.tapTargetPadding` to increase tappable area
* customize the theme of all `SBBRadio` with `SBBRadioThemeData`
* access the theme using `Theme.of(context).sbbRadioTheme`
* customize an individual radio by setting its `style` parameter in the constructor


## Slider

### Constructor arguments
* `startIcon` and `endIcon` are replaced with `leading`/`leadingIconData` and `trailing`/`trailingIconData`
  * for simple icons use `leadingIconData` and `trailingIconData`
  * for custom widgets use `leading` and `trailing`

### Styling Changes
* `SBBSliderStyle` properties now use `WidgetStateProperty<Color?>` instead of simple `Color` values
  * this allows different colors for enabled/disabled/pressed states
  * replace simple color assignments with state-aware properties
* icon styling changed:
  * old: `style.iconColor` and `style.disabledIconColor`
  * new: `leadingForegroundColor` and `trailingForegroundColor` using `WidgetStateProperty<Color?>`
* `padding` parameter replaces the hardcoded icon padding logic

### Theming & Styling
* customize the theme of all `SBBSlider` with `SBBSliderThemeData` as input to `SBBTheme`
* access the theme using `Theme.of(context).sbbSliderTheme`
* customize an individual slider by setting its `style` parameter in the constructor


## Status

### Constructor arguments
* replace `text` with `labelText`
* complete customization using `label` and `icon` parameters

### Theming & Styling
* customize the theme of all `SBBStatus` with `SBBStatusThemeData` as input parameter to `SBBTheme`.
* access the theme using `Theme.of(context).sbbStatusTheme`
* customize individual status by setting its `style` parameter in the constructor


## Segmented Button

### Filled Variant
use `SBBSegmentedButtonFilled` for the filled style variant (replaces `SBBSegmentedButton.redText` and `SBBSegmentedButton.redIcon`)

### Constructor arguments
* The new implementation uses `SBBButtonSegment` to describe each segment instead of widget builders
* Replace index-based selection (`selectedStateIndex`) with value-based selection (`selected`)
* Replace `selectedIndexChanged` callback with `onSelectionChanged` that provides the selected value instead of index
* For text segments: use `SBBButtonSegment(value: value, labelText: 'Text')`
* For icon segments: use `SBBButtonSegment(value: value, leadingIconData: iconData)`
* For icon with text: use `SBBButtonSegment(value: value, leadingIconData: iconData, labelText: 'Text')`
* Complete customization is possible using `label` and `leading` parameters in `SBBButtonSegment`

### Example Migration

Old implementation:
```dart
SBBSegmentedButton.text(
  values: ['Option 1', 'Option 2', 'Option 3'],
  selectedStateIndex: selectedIndex,
  selectedIndexChanged: (index) => setState(() => selectedIndex = index),
)
```

New implementation:
```dart
SBBSegmentedButton<int>(
  segments: [
    SBBButtonSegment(value: 0, labelText: 'Option 1'),
    SBBButtonSegment(value: 1, labelText: 'Option 2'),
    SBBButtonSegment(value: 2, labelText: 'Option 3'),
  ],
  selected: selectedValue,
  onSelectionChanged: (value) => setState(() => selectedValue = value),
)
```

Old icon implementation:
```dart
SBBSegmentedButton.icon(
  icons: {
    SBBIcons.train_medium: 'Train',
    SBBIcons.bus_medium: 'Bus',
  },
  selectedStateIndex: selectedIndex,
  selectedIndexChanged: (index) => setState(() => selectedIndex = index),
  withText: true,
)
```

New implementation:
```dart
SBBSegmentedButton<String>(
  segments: [
    SBBButtonSegment(value: 'train', leadingIconData: SBBIcons.train_medium, labelText: 'Train'),
    SBBButtonSegment(value: 'bus', leadingIconData: SBBIcons.bus_medium, labelText: 'Bus'),
  ],
  selected: selectedValue,
  onSelectionChanged: (value) => setState(() => selectedValue = value),
)
```
### Theming & Styling
* customize the theme of all `SBBSegmentedButton` with `SBBSegmentedButtonThemeData` as input to `SBBTheme`
* access the theme using `Theme.of(context).sbbSegmentedButtonTheme`
* customize an individual segmented button by setting its `style` parameter in the constructor
* customize individual segments by setting the `style` parameter in `SBBButtonSegment`
* `SBBSegmentedButtonStyle` and `SBBButtonSegmentStyle` use `WidgetStateProperty<T?>` for state-aware styling


## Stepper

### Constructor arguments

#### Changes to `SBBStepper`

* Renamed factory `SBBStepper.red` to `SBBStepper.filled` as theme's primary color is used

#### Changes to `SBBStepperItem`

* Use provided factories to create `SBBStepperItem`. They can also be combined.
    * `SBBStepperItem.icon`: Shows the provided `icon` in the step
    * `SBBStepperItem.text`: Shows the provided `text` in the step. Text will be scaled down if to big.
    * `SBBStepperItem.numbered`: Shows the number/position of the step
* Use `labelText` instead of `label` for text label. Use `label` for custom widget.
* `labelText` and `label` are now optional
* set `showBadgeWhenPassed` to `false` if badge should not be shown when passed
* added `badgeIcon` to customize badge icon of step

### Styling Changes
* `SBBStepperItemStyle` added to allow customizing each step on its own.
* `SBBStepperStyle` and `SBBStepperItemStyle` properties use `WidgetStateProperty<T?>` for state aware styles
    * this allows different colors for enabled/disabled states
    * replace simple color assignments with state-aware properties where needed
* `padding` parameter replaces the hardcoded padding logic

### Theming & Styling
* customize the theme of all `SBBStepper` with `SBBStepperThemeData` as input to `SBBTheme`
* access the theme using `Theme.of(context).sbbStepperTheme`
* customize an individual stepper by setting its `style` parameter in the constructor
* customize an individual step by setting the `SBBStepperItem`'s `style` parameter in the constructor

## Switch
* added `focusNode` & `autofocus`
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

| Aspect               | SBBTextField            | SBBTextInput                                             |
|----------------------|-------------------------|----------------------------------------------------------|
| **Leading widget**   | `icon` (IconData only)  | `decoration.leading` or `decoration.leadingIconData`     |
| **Trailing widget**  | `suffixIcon` (Widget)   | `decoration.trailing` or `decoration.trailingIconData`   |
| **Label**            | `labelText`             | `decoration.labelText` or `decoration.label`             |
| **Placeholder**      | `hintText`              | `decoration.placeholderText` or `decoration.placeholder` |
| **Error handling**   | `errorText` only        | `decoration.errorText` or `decoration.error` (as Widget) |
| **Theming**          | No theme support        | `SBBInputDecorationThemeData` + `SBBTextInputThemeData`  |
| **Disabled state**   | `enabled` only          | `enabled` + `readOnly` (more granular control)           |
| **State management** | Custom underline widget | `SBBInputDecorator` with flexible styling                |
| **Multiline icons**  | Always center-aligned   | Automatically top-aligned in multiline mode              |

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

| SBBTextField                 | SBBTextInput                                                  |
|------------------------------|---------------------------------------------------------------|
| `controller`                 | `controller`                                                  |
| `enabled`                    | `enabled`                                                     |
| `labelText`                  | `decoration.labelText`                                        |
| `hintText`                   | `decoration.placeholderText`                                  |
| `errorText`                  | `decoration.errorText`                                        |
| `icon`                       | `decoration.leadingIconData`                                  |
| `suffixIcon`                 | `decoration.trailing` or `decoration.trailingIconData`        |
| `obscureText`                | `obscureText`                                                 |
| `obscuringCharacter`         | `obscuringCharacter`                                          |
| `maxLines`                   | `maxLines`                                                    |
| `minLines`                   | `minLines`                                                    |
| `keyboardType`               | `keyboardType`                                                |
| `textInputAction`            | `textInputAction`                                             |
| `inputFormatters`            | `inputFormatters`                                             |
| `onChanged`                  | `onChanged`                                                   |
| `onSubmitted`                | `onSubmitted`                                                 |
| `onTap`                      | `onTap`                                                       |
| `onTapAlwaysCalled`          | `onTapAlwaysCalled`                                           |
| `focusNode`                  | `focusNode`                                                   |
| `autofocus`                  | `autofocus`                                                   |
| `textCapitalization`         | `textCapitalization`                                          |
| `enableInteractiveSelection` | `enableInteractiveSelection`                                  |
| `isLastElement`              | *(removed)* - use `SBBListItem.divideListItems()` if in lists |

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

4. **Floating label behavior control**:
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
