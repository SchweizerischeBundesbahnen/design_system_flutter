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
                  children: SBBListItem.divideListItems(
                    context: context,
                    items: [
                      SBBListItem(
                        titleText: 'Default',
                        leadingIconData: SBBIcons.dog_small,
                        onTap: () => sbbToast.show(title: 'Default'),
                      ),
                      SBBListItem(
                        titleText: 'Ohne Icon',
                        onTap: () => sbbToast.show(title: 'Ohne Icon'),
                      ),
                      SBBListItem(
                        titleText: 'Mit Subtext',
                        subtitleText: loremIpsum,
                        leadingIconData: SBBIcons.dog_small,
                        onTap: () => sbbToast.show(title: 'Mit Subtext'),
                      ),
                      SBBListItem(
                        titleText: 'Mit Icon Rechts',
                        leadingIconData: SBBIcons.dog_small,
                        trailingIconData: SBBIcons.chevron_small_right_small,
                        onTap: () => sbbToast.show(title: 'Mit Icon Rechts'),
                      ),
                      SBBListItem(
                        titleText: 'Mit Button',
                        leadingIconData: SBBIcons.dog_small,
                        trailing: SBBTertiaryButtonSmall(onPressed: () {}, iconData: SBBIcons.dog_small),
                        padding: SBBListItemStyle.defaultPadding.copyWith(right: 8),
                        onTap: () => sbbToast.show(title: 'Mit Button'),
                      ),
                      SBBListItem(
                        titleText: 'Mit Status Nachricht',
                        leadingIconData: SBBIcons.dog_small,
                        subtitle: SBBStatus.information(labelText: 'Lorem ipsum sit dolor amet unt.'),
                        onTap: () => sbbToast.show(title: 'Mit Status Nachricht'),
                      ),
                      SBBListItem(
                        title: Text('Mit Links'),
                        leadingIconData: SBBIcons.globe_small,
                        onTap: () => sbbToast.show(title: 'Mit Links'),
                        links: [
                          SBBListItem(
                            titleText: "Link",
                            trailingIconData: SBBIcons.chevron_small_right_small,
                            onTap: () => sbbToast.show(title: 'Link'),
                          ),
                          SBBListItem(
                            titleText: "Link 2",
                            trailingIconData: SBBIcons.chevron_small_right_small,
                            onTap: () => sbbToast.show(title: 'Link 2'),
                          ),
                        ],
                      ),
                      SBBListItem(
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
                  SBBListItemBoxed(
                    titleText: 'Default',
                    leadingIconData: SBBIcons.dog_small,
                    onTap: () => sbbToast.show(title: 'Default'),
                  ),
                  SBBListItemBoxed(
                    titleText: 'Ohne Icon',
                    onTap: () => sbbToast.show(title: 'Ohne Icon'),
                  ),
                  SBBListItemBoxed(
                    titleText: 'Mit Subtext',
                    subtitleText: loremIpsum,
                    leadingIconData: SBBIcons.dog_small,
                    onTap: () => sbbToast.show(title: 'Mit Subtext'),
                  ),
                  SBBListItemBoxed(
                    titleText: 'Mit Icon Rechts',
                    leadingIconData: SBBIcons.dog_small,
                    trailingIconData: SBBIcons.chevron_small_right_small,
                    onTap: () => sbbToast.show(title: 'Mit Icon Rechts'),
                  ),
                  SBBListItemBoxed(
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
