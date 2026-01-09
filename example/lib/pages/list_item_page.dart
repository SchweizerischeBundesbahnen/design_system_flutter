import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

const loremIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    ' Curabitur finibus, nulla nec tempor ornare, purus orci dictum tortor, non tristique velit tellus eu ligula.';

class ListItemPage extends StatelessWidget {
  const ListItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(child: ThemeModeSegmentedButton()),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            vertical: sbbDefaultSpacing * .5,
            horizontal: sbbDefaultSpacing * .5,
          ).copyWith(bottom: sbbDefaultSpacing * 3),
          sliver: SliverList.list(
            children: [
              SBBListHeader('Listed'),
              SBBContentBox(
                child: Column(
                  children: SBBListItemV5.divideListItems(
                    context: context,
                    items: [
                      SBBListItemV5(
                        titleText: 'Default',
                        leadingIconData: SBBIcons.dog_small,
                        onTap: () => sbbToast.show(title: 'Default'),
                      ),
                      SBBListItemV5(
                        titleText: 'Ohne Icon',
                        onTap: () => sbbToast.show(title: 'Ohne Icon'),
                      ),
                      SBBListItemV5(
                        titleText: 'Mit Subtext',
                        subtitleText: loremIpsum,
                        leadingIconData: SBBIcons.dog_small,
                        onTap: () => sbbToast.show(title: 'Mit Subtext'),
                      ),
                      SBBListItemV5(
                        titleText: 'Mit Icon Rechts',
                        leadingIconData: SBBIcons.dog_small,
                        trailingIconData: SBBIcons.chevron_small_right_small,
                        onTap: () => sbbToast.show(title: 'Mit Icon Rechts'),
                      ),
                      SBBListItemV5(
                        titleText: 'Mit Button',
                        leadingIconData: SBBIcons.dog_small,
                        trailing: SBBTertiaryButtonSmall(onPressed: () {}, iconData: SBBIcons.dog_small),
                        padding: SBBListItemV5Style.defaultPadding.copyWith(right: 8),
                        onTap: () => sbbToast.show(title: 'Mit Button'),
                      ),
                      SBBListItemV5(
                        titleText: 'Mit Status Nachricht',
                        leadingIconData: SBBIcons.dog_small,
                        subtitle: SBBStatus.information(labelText: 'Lorem ipsum sit dolor amet unt.'),
                        onTap: () => sbbToast.show(title: 'Mit Status Nachricht'),
                      ),
                      SBBListItemV5(
                        title: Text('Mit Links'),
                        leadingIconData: SBBIcons.globe_small,
                        onTap: () => sbbToast.show(title: 'Mit Links'),
                        links: [
                          SBBListItemV5(
                            titleText: "Link",
                            trailingIconData: SBBIcons.chevron_small_right_small,
                            onTap: () => sbbToast.show(title: 'Link'),
                          ),
                          SBBListItemV5(
                            titleText: "Link 2",
                            trailingIconData: SBBIcons.chevron_small_right_small,
                            onTap: () => sbbToast.show(title: 'Link 2'),
                          ),
                        ],
                      ),
                      SBBListItemV5(
                        titleText: 'Loading',
                        leadingIconData: SBBIcons.dog_small,
                        onTap: () => sbbToast.show(title: 'Loading'),
                        isLoading: true,
                      ),
                    ],
                  ).toList(),
                ),
              ),
              SizedBox(height: sbbDefaultSpacing),
              SBBListHeader('Boxed'),
              Column(
                spacing: sbbDefaultSpacing * .5,
                children: [
                  SBBListItemV5Boxed(
                    titleText: 'Default',
                    leadingIconData: SBBIcons.dog_small,
                    onTap: () => sbbToast.show(title: 'Default'),
                  ),
                  SBBListItemV5Boxed(
                    titleText: 'Ohne Icon',
                    onTap: () => sbbToast.show(title: 'Ohne Icon'),
                  ),
                  SBBListItemV5Boxed(
                    titleText: 'Mit Subtext',
                    subtitleText: loremIpsum,
                    leadingIconData: SBBIcons.dog_small,
                    onTap: () => sbbToast.show(title: 'Mit Subtext'),
                  ),
                  SBBListItemV5Boxed(
                    titleText: 'Mit Icon Rechts',
                    leadingIconData: SBBIcons.dog_small,
                    trailingIconData: SBBIcons.chevron_small_right_small,
                    onTap: () => sbbToast.show(title: 'Mit Icon Rechts'),
                  ),
                  SBBListItemV5Boxed(
                    titleText: 'Loading',
                    leadingIconData: SBBIcons.dog_small,
                    onTap: () => sbbToast.show(title: 'Loading'),
                    isLoading: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
