import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class DecoratedTextPage extends StatelessWidget {
  const DecoratedTextPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    final theme = Theme.of(context);
    final textInputDecorationTheme = theme.sbbInputDecorationTheme;
    final withVerticalPadding = textInputDecorationTheme?.copyWith(
      contentPadding: EdgeInsets.symmetric(horizontal: SBBSpacing.medium),
    );

    return ExtendedTheme<SBBInputDecorationThemeData>(
      style: withVerticalPadding!,
      child: CustomScrollView(
        slivers: [
          SBBSliverHeaderbox.custom(child: ThemeModeSegmentedButton()),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: SBBSpacing.xSmall).copyWith(bottom: SBBSpacing.xLarge),
            sliver: SliverList.list(
              children: [
                SBBListHeader('Listed'),
                SBBContentBox(
                  child: Column(
                    mainAxisSize: .min,
                    children: SBBListItem.divideListItems(
                      context: context,
                      items: [
                        SBBDecoratedText(
                          value: '',
                          decoration: SBBInputDecoration(
                            labelText: 'Empty',
                          ),
                          onTap: () => sbbToast.show(titleText: 'Empty'),
                        ),
                        SBBDecoratedText(
                          value: '',
                          decoration: SBBInputDecoration(
                            labelText: 'With Placeholder',
                            placeholderText: 'Placeholder',
                          ),
                          onTap: () {
                            sbbToast.show(titleText: 'Empty');
                          },
                        ),

                        SBBDecoratedText(
                          decoration: SBBInputDecoration(labelText: 'Label', leadingIconData: SBBIcons.dog_small),
                          value: 'Value',
                          onTap: () {
                            sbbToast.show(titleText: 'With Leading Icon');
                          },
                        ),
                        SBBDecoratedText(
                          decoration: SBBInputDecoration(
                            labelText: 'Label',
                            leadingIconData: SBBIcons.dog_small,
                            trailingIconData: SBBIcons.chevron_small_right_circle_small,
                          ),
                          value: 'Value',
                          onTap: () {
                            sbbToast.show(titleText: 'With Trailing Icon');
                          },
                        ),
                        SBBDecoratedText(
                          decoration: SBBInputDecoration(
                            contentPadding: .only(left: SBBSpacing.medium, right: SBBSpacing.xxSmall),
                            labelText: 'Label',
                            leadingIconData: SBBIcons.dog_small,
                            trailing: SBBTertiaryButtonSmall(
                              onPressed: () {
                                sbbToast.show(titleText: 'Button Pressed');
                              },
                              iconData: SBBIcons.dog_small,
                            ),
                          ),
                          value: 'Value',
                          onTap: () {
                            sbbToast.show(titleText: 'With Button');
                          },
                        ),
                        SBBDecoratedText(
                          decoration: SBBInputDecoration(
                            labelText: 'Error',
                            errorText: 'This is an error!',
                            leadingIconData: SBBIcons.dog_small,
                          ),
                          value: 'Value',
                          onTap: () {
                            sbbToast.show(titleText: 'Error');
                          },
                        ),
                        SBBDecoratedText(
                          onTap: () {},
                          maxLines: 4,
                          minLines: 4,
                          decoration: SBBInputDecoration(
                            contentPadding: .only(left: SBBSpacing.medium, top: SBBSpacing.xSmall),
                            leadingIconData: SBBIcons.dog_small,
                            labelText: 'Multiple Lines',
                          ),
                          value: 'I am \nmulti \nline',
                        ),
                        SBBDecoratedText(
                          decoration: SBBInputDecoration(labelText: 'Disabled', leadingIconData: SBBIcons.dog_small),
                          value: 'Value',
                          enabled: false,
                        ),
                        SizedBox(
                          height: 120.0,
                          child: SBBDecoratedText(
                            expands: true,
                            maxLines: null,
                            decoration: SBBInputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: SBBSpacing.medium,
                                top: SBBSpacing.xSmall,
                              ),
                              leadingIconData: SBBIcons.dog_small,
                              labelText: 'Expands',
                            ),
                            value: 'I expand to fill\nthe available\nheight',
                            onTap: () => sbbToast.show(titleText: 'Expands'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SBBSpacing.medium),
                SBBListHeader('Boxed'),
                Column(
                  spacing: SBBSpacing.xSmall,
                  children: [
                    SBBDecoratedTextBoxed(
                      value: '',
                      onTap: () => sbbToast.show(titleText: 'Empty'),
                      decoration: SBBInputDecoration(
                        labelText: 'Empty',
                        leadingIconData: SBBIcons.unicorn_small,
                      ),
                    ),
                    SBBDecoratedTextBoxed(
                      onTap: () => sbbToast.show(titleText: 'Trailing Icon'),
                      value: 'Value',
                      decoration: SBBInputDecoration(
                        labelText: 'With Trailing Icon',
                        leadingIconData: SBBIcons.unicorn_small,
                        trailingIconData: SBBIcons.circle_information_small_small,
                      ),
                    ),
                    SBBDecoratedTextBoxed(
                      value: '',
                      onTap: () => sbbToast.show(titleText: 'Placeholder'),
                      decoration: SBBInputDecoration(
                        labelText: 'With Placeholder',
                        placeholderText: 'Placeholder',
                        leadingIconData: SBBIcons.unicorn_small,
                      ),
                    ),
                    SBBDecoratedTextBoxed(
                      onTap: () => sbbToast.show(titleText: 'Button'),
                      value: 'Value',
                      decoration: SBBInputDecoration(
                        contentPadding: .only(left: SBBSpacing.medium, right: SBBSpacing.xxSmall),
                        labelText: 'With Custom Button',
                        placeholderText: 'Press the Button!',
                        leadingIconData: SBBIcons.unicorn_small,
                        trailing: SBBTertiaryButtonSmall(
                          iconData: SBBIcons.dog_small,
                          onPressed: () => sbbToast.show(titleText: 'Button pressed'),
                        ),
                      ),
                    ),
                    SBBDecoratedTextBoxed(
                      onTap: () => sbbToast.show(titleText: 'Error'),
                      value: 'With Error',
                      decoration: SBBInputDecoration(
                        labelText: 'With Error',
                        errorText: 'Error Text',
                        leadingIconData: SBBIcons.unicorn_small,
                      ),
                    ),
                    SBBDecoratedTextBoxed(
                      value: 'Disabled',
                      enabled: false,
                      decoration: SBBInputDecoration(leadingIconData: SBBIcons.unicorn_small, labelText: 'Disabled'),
                    ),
                    SizedBox(
                      height: 120.0,
                      child: SBBDecoratedTextBoxed(
                        expands: true,
                        maxLines: null,
                        value: 'I expand to fill\nthe available\nheight',
                        onTap: () => sbbToast.show(titleText: 'Expands'),
                        decoration: SBBInputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: SBBSpacing.medium,
                            top: SBBSpacing.xSmall,
                          ),
                          leadingIconData: SBBIcons.unicorn_small,
                          labelText: 'Expands',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExtendedTheme<T extends ThemeExtension<T>> extends StatelessWidget {
  const ExtendedTheme({
    super.key,
    required this.style,
    required this.child,
  });

  final ThemeExtension<T> style;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedTheme(
      data: theme.copyWith(
        extensions: {...theme.extensions, T: style}.values,
      ),
      child: child,
    );
  }
}
