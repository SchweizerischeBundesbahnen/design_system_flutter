# Migration Guide for SBBTextStyles

The SBB TextStyles have been simplified: https://digital.sbb.ch/de/design-system-mobile-new/basics/typography

`SBBBaseTextStyles` itself and all `TextStyle` constants in it are now deprecated and are now to be replaced by following `TextStyle` constants in `SBBTextStyles`:
* `SBBTextStyles.extraLargeLight`
* `SBBTextStyles.largeLight`
* `SBBTextStyles.largeBold`
* `SBBTextStyles.mediumLight`
* `SBBTextStyles.mediumBold`
* `SBBTextStyles.smallLight`
* `SBBTextStyles.smallBold`
* `SBBTextStyles.extraSmallLight`
* `SBBTextStyles.helpersLabel`

The following table can be used as a guideline to replace the deprecated text styles.

It is recommended to use the text styles of `SBBTextStyles` without `copyWith` (column 2) to ensure consistency.

The text color will be set by the `Theme` automatically. It is either `SBBColors.white` for light theme or `SBBColors.black` for dark theme. Default text style is `SBBTextStyles.mediumLight`.

If you decide to keep the `color`, `fontSize` and `height` exactly the same as the deprecated text styles, use column 3 as the guideline.

Column 4 shows the equivalent text styles in the `SBBTheme` if there is one.

| Old `SBBBaseTextStyles`            | `SBBTextStyles`   | `SBBTextStyles` (keep `color`, `fontSize` and `height` exactly the same)         | `SBBTheme.of(context)`                  |
| ---------------------------------- | ----------------- | -------------------------------------------------------------------------------- | --------------------------------------- |
| `primaryButton`                    | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.white)`                                   | `primaryButtonTextStyle`                |
| `secondaryButtonDefault`           | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.red)`                                     | `secondaryButtonTextStyle`              |
| `secondaryButtonDisabledOrLoading` | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.metal)`                                   | `secondaryButtonTextStyleDisabled`      |
| `secondaryButtonPressed`           | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.red125)`                                  | `secondaryButtonTextStyleHighlighted`   |
| `tertiaryButtonLargeDark`          | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.white)`                                   | `tertiaryButtonLargeTextStyle`          |
| `tertiaryButtonLargeLight`         | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.black)`                                   | `tertiaryButtonLargeTextStyle`          |
| `tertiaryButtonSmallDark`          | `smallLight`      | `smallLight.copyWith(color: SBBColors.white, height: 1.25)`                      | `tertiaryButtonSmallTextStyle`          |
| `tertiaryButtonSmallLight`         | `smallLight`      | `smallLight.copyWith(color: SBBColors.black, height: 1.25)`                      | `tertiaryButtonSmallTextStyle`          |
| `iconTextButtonLight`              | `smallLight`      | `smallLight.copyWith(color: SBBColors.black, height: 1.25)`                      | `iconTextButtonTextStyle`               |
| `iconTextButtonDark`               | `smallLight`      | `smallLight.copyWith(color: SBBColors.white, height: 1.25)`                      | `iconTextButtonTextStyle`               |
| `formLightDefault`                 | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.black)`                                   | `textFieldTextStyle`                    |
| `formDarkDefault`                  | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.white)`                                   | `textFieldTextStyle`                    |
| `formLightDisabledDefault`         | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.metal)`                                   | `textFieldTextStyleDisabled`            |
| `formDarkDisabledDefault`          | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.metal)`                                   | `textFieldTextStyleDisabled`            |
| `formLightLabel`                   | `helpersLabel`    | `helpersLabel.copyWith(color: SBBColors.metal, fontSize: 10.0, height: 1.2)`     | `selectLabelTextStyle`                  |
| `formDarkLabel`                    | `helpersLabel`    | `helpersLabel.copyWith(color: SBBColors.cement, fontSize: 10.0, height: 1.2)`    | `selectLabelTextStyle`                  |
| `formLightDisabledLabel`           | `helpersLabel`    | `helpersLabel.copyWith(color: SBBColors.metal, fontSize: 10.0, height: 1.2)`     | `selectLabelTextStyleDisabled`          |
| `formDarkDisabledLabel`            | `helpersLabel`    | `helpersLabel.copyWith(color: SBBColors.metal, fontSize: 10.0, height: 1.2)`     | `selectLabelTextStyleDisabled`          |
| `formLightPlaceholder`             | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.metal)`                                   | `textFieldPlaceholderTextStyle`         |
| `formDarkPlaceholder`              | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.cement)`                                  | `textFieldPlaceholderTextStyle`         |
| `formLightDisabledPlaceholder`     | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.metal)`                                   | `textFieldPlaceholderTextStyleDisabled` |
| `formDarkDisabledPlaceholder`      | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.metal)`                                   | `textFieldPlaceholderTextStyleDisabled` |
| `formLightError`                   | `helpersLabel`    | `helpersLabel.copyWith(color: SBBColors.red150, fontSize: 10.0, height: 1.2)`    | `textFieldErrorTextStyle`               |
| `formDarkError`                    | `helpersLabel`    | `helpersLabel.copyWith(color: SBBColors.red, fontSize: 10.0, height: 1.2)`       | `textFieldErrorTextStyle`               |
| `listItemTitleLight`               | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.black)`                                   | `listItemTitleTextStyle`                |
| `listItemTitleDark`                | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.white)`                                   | `listItemTitleTextStyle`                |
| `listItemSubtitleLight`            | `extraSmallLight` | `extraSmallLight.copyWith(color: SBBColors.metal, height: 1.25)`                 | `listItemSubtitleTextStyle`             |
| `listItemSubtitleDark`             | `extraSmallLight` | `extraSmallLight.copyWith(color: SBBColors.cement, height: 1.25)`                | `listItemSubtitleTextStyle`             |
| `modalTitleLight`                  | `largeLight`      | `largeLight.copyWith(color: SBBColors.black`                                     | `modalTitleTextStyle`                   |
| `modalTitleDark`                   | `largeLight`      | `largeLight.copyWith(color: SBBColors.white`                                     | `modalTitleTextStyle`                   |
| `header`                           | `largeLight`      | `largeLight.copyWith(color: SBBColors.white, fontSize: 22.0, height: 1.55)`      | -                                       |
| `headline_black`                   | `largeBold`       | `largeBold.copyWith(color: SBBColors.black, height: 1.0)`                        | -                                       |
| `headline_white`                   | `largeBold`       | `largeBold.copyWith(color: SBBColors.white, height: 1.0)`                        | -                                       |
| `title_default_black`              | `mediumBold`      | `mediumBold.copyWith(color: SBBColors.black, height: 1.0)`                       | -                                       |
| `title_default_metal`              | `mediumBold`      | `mediumBold.copyWith(color: SBBColors.metal, height: 1.0)`                       | -                                       |
| `title_module`                     | `largeLight`      | `largeLight.copyWith(color: SBBColors.red, height: 1.0)`                         | -                                       |
| `subtitle_black`                   | `smallBold`       | `smallBold.copyWith(color: SBBColors.black)`                                     | -                                       |
| `subtitle_metal`                   | `smallBold`       | `smallBold.copyWith(color: SBBColors.metal)`                                     | -                                       |
| `copy_black`                       | `largeLight`      | `largeLight.copyWith(color: SBBColors.black, height: 1.0)`                       | -                                       |
| `copy_white`                       | `largeLight`      | `largeLight.copyWith(color: SBBColors.white, height: 1.0)`                       | -                                       |
| `body_black`                       | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.black, height: 1.0)`                      | -                                       |
| `body_metal`                       | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.metal, height: 1.0)`                      | -                                       |
| `body_red`                         | `mediumLight`     | `mediumLight.copyWith(color: SBBColors.red, height: 1.0)`                        | -                                       |
| `legend_normal_black`              | `smallLight`      | `smallLight.copyWith(color: SBBColors.black)`                                    | -                                       |
| `legend_normal_metal`              | `smallLight`      | `smallLight.copyWith(color: SBBColors.metal)`                                    | -                                       |
| `legend_normal_red`                | `smallLight`      | `smallLight.copyWith(color: SBBColors.red)`                                      | -                                       |
| `legend_normal_white`              | `smallLight`      | `smallLight.copyWith(color: SBBColors.white)`                                    | -                                       |
| `legend_small_black`               | `extraSmallLight` | `extraSmallLight.copyWith(color: SBBColors.black, height: 1.0)`                  | -                                       |
    