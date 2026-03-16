import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class StaticInputPage extends StatelessWidget {
  const StaticInputPage({super.key});

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
                        SBBStaticInput(
                          decoration: SBBInputDecoration(
                            labelText: 'Empty',
                          ),
                          onTap: () => sbbToast.show(titleText: 'Empty'),
                        ),
                        SBBStaticInput(
                          decoration: SBBInputDecoration(
                            labelText: 'With Placeholder',
                            placeholderText: 'Placeholder',
                            floatingLabelBehavior: .always,
                          ),
                          onTap: () {
                            sbbToast.show(titleText: 'Empty');
                          },
                        ),

                        SBBStaticInput(
                          decoration: SBBInputDecoration(labelText: 'Label', leadingIconData: SBBIcons.dog_small),
                          childText: 'Value',
                          onTap: () {
                            sbbToast.show(titleText: 'With Leading Icon');
                          },
                        ),
                        SBBStaticInput(
                          decoration: SBBInputDecoration(
                            labelText: 'Label',
                            leadingIconData: SBBIcons.dog_small,
                            trailingIconData: SBBIcons.chevron_small_right_circle_small,
                          ),
                          childText: 'Value',
                          onTap: () {
                            sbbToast.show(titleText: 'With Trailing Icon');
                          },
                        ),
                        SBBStaticInput(
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
                          childText: 'Value',
                          onTap: () {
                            sbbToast.show(titleText: 'With Button');
                          },
                        ),
                        SBBStaticInput(
                          decoration: SBBInputDecoration(
                            labelText: 'Error',
                            errorText: 'This is an error!',
                            leadingIconData: SBBIcons.dog_small,
                          ),
                          childText: 'Value',
                          onTap: () {
                            sbbToast.show(titleText: 'Error');
                          },
                        ),
                        SBBStaticInput(
                          onTap: () {},
                          maxLines: 4,
                          minLines: 4,
                          decoration: SBBInputDecoration(
                            contentPadding: .only(left: SBBSpacing.medium, top: SBBSpacing.xSmall),
                            leadingIconData: SBBIcons.dog_small,
                            labelText: 'Multiple Lines',
                          ),
                          childText: 'I am \nmulti \nline',
                        ),
                        SBBStaticInput(
                          decoration: SBBInputDecoration(labelText: 'Disabled', leadingIconData: SBBIcons.dog_small),
                          childText: 'Value',
                          onTap: null,
                        ),
                      ],
                    ).toList(growable: false),
                  ),
                ),
                SizedBox(height: SBBSpacing.medium),
                SBBListHeader('Boxed'),
                Column(
                  spacing: SBBSpacing.xSmall,
                  children: [
                    SBBStaticInputBoxed(
                      onTap: () => sbbToast.show(titleText: 'Empty'),
                      decoration: SBBInputDecoration(
                        labelText: 'Empty',
                        leadingIconData: SBBIcons.unicorn_small,
                      ),
                    ),
                    SBBStaticInputBoxed(
                      onTap: () => sbbToast.show(titleText: 'Trailing Icon'),
                      childText: 'Value',
                      decoration: SBBInputDecoration(
                        labelText: 'With Trailing Icon',
                        leadingIconData: SBBIcons.unicorn_small,
                        trailingIconData: SBBIcons.circle_information_small_small,
                      ),
                    ),
                    SBBStaticInputBoxed(
                      onTap: () => sbbToast.show(titleText: 'Placeholder'),
                      decoration: SBBInputDecoration(
                        labelText: 'With Placeholder',
                        placeholderText: 'Placeholder',
                        floatingLabelBehavior: .always,
                        leadingIconData: SBBIcons.unicorn_small,
                      ),
                    ),
                    SBBStaticInputBoxed(
                      onTap: () => sbbToast.show(titleText: 'Button'),
                      childText: 'Value',
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
                    SBBStaticInputBoxed(
                      onTap: () => sbbToast.show(titleText: 'Error'),
                      childText: 'With Error',
                      decoration: SBBInputDecoration(
                        labelText: 'With Error',
                        errorText: 'Error Text',
                        leadingIconData: SBBIcons.unicorn_small,
                      ),
                    ),
                    SBBStaticInputBoxed(
                      decoration: SBBInputDecoration(leadingIconData: SBBIcons.unicorn_small, labelText: 'Disabled'),
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
