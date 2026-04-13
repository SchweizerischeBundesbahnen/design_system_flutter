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
          padding: EdgeInsets.all(SBBSpacing.xSmall),
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
                        onTap: () => sbbToast.show(titleText: 'Default'),
                      ),
                      SBBListItem(
                        titleText: 'Ohne Icon',
                        onTap: () => sbbToast.show(titleText: 'Ohne Icon'),
                      ),
                      SBBListItem(
                        titleText: 'Mit Subtext',
                        subtitleText: loremIpsum,
                        leadingIconData: SBBIcons.dog_small,
                        onTap: () => sbbToast.show(titleText: 'Mit Subtext'),
                      ),
                      SBBListItem(
                        titleText: 'Mit Icon Rechts',
                        leadingIconData: SBBIcons.dog_small,
                        trailingIconData: SBBIcons.chevron_small_right_small,
                        onTap: () => sbbToast.show(titleText: 'Mit Icon Rechts'),
                      ),
                      SBBListItem(
                        titleText: 'Mit Button',
                        leadingIconData: SBBIcons.dog_small,
                        trailing: SBBTertiaryButtonSmall(onPressed: () {}, iconData: SBBIcons.dog_small),
                        padding: .fromLTRB(16.0, 0.0, 8.0, 0.0),
                        onTap: () => sbbToast.show(titleText: 'Mit Button'),
                      ),
                      SBBListItem(
                        titleText: 'Mit Status Nachricht',
                        subtitle: SBBStatus.information(labelText: 'Lorem ipsum sit dolor amet unt.'),
                        onTap: () => sbbToast.show(titleText: 'Mit Status Nachricht'),
                      ),
                      SBBListItem(
                        title: Text('Mit Links'),
                        leadingIconData: SBBIcons.globe_small,
                        onTap: () => sbbToast.show(titleText: 'Mit Links'),
                        links: [
                          SBBListItem(
                            titleText: "Link",
                            trailingIconData: SBBIcons.chevron_small_right_small,
                            onTap: () => sbbToast.show(titleText: 'Link'),
                          ),
                          SBBListItem(
                            titleText: "Link 2",
                            trailingIconData: SBBIcons.chevron_small_right_small,
                            onTap: () => sbbToast.show(titleText: 'Link 2'),
                          ),
                        ],
                      ),
                      SBBListItem(
                        titleText: 'Loading',
                        leadingIconData: SBBIcons.dog_small,
                        onTap: () => sbbToast.show(titleText: 'Loading'),
                        isLoading: true,
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
                  SBBListItemBoxed(
                    titleText: 'Default',
                    leadingIconData: SBBIcons.dog_small,
                    onTap: () => sbbToast.show(titleText: 'Default'),
                  ),
                  SBBListItemBoxed(
                    titleText: 'Ohne Icon',
                    onTap: () => sbbToast.show(titleText: 'Ohne Icon'),
                  ),
                  SBBListItemBoxed(
                    titleText: 'Mit Subtext',
                    subtitleText: loremIpsum,
                    leadingIconData: SBBIcons.dog_small,
                    onTap: () => sbbToast.show(titleText: 'Mit Subtext'),
                  ),
                  SBBListItemBoxed(
                    titleText: 'Mit Icon Rechts',
                    leadingIconData: SBBIcons.dog_small,
                    trailingIconData: SBBIcons.chevron_small_right_small,
                    onTap: () => sbbToast.show(titleText: 'Mit Icon Rechts'),
                  ),
                  SBBListItemBoxed(
                    titleText: 'Loading',
                    leadingIconData: SBBIcons.dog_small,
                    onTap: () => sbbToast.show(titleText: 'Loading'),
                    isLoading: true,
                  ),
                ],
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: SBBSpacing.xSmall),
            child: SBBListHeader('Dynamically generated'),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(SBBSpacing.xSmall).copyWith(bottom: SBBSpacing.xLarge),
          sliver: SliverList.separated(
            itemCount: 50,
            itemBuilder: (context, idx) => SBBListItem(
              onTap: () {},
              titleText: 'Index ${idx + 1}',
            ),
            separatorBuilder: (_, _) => SBBDivider(),
          ),
        ),
      ],
    );
  }
}
