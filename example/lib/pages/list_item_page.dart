import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

const loremIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    ' Curabitur finibus, nulla nec tempor ornare, purus orci dictum tortor, non tristique velit tellus eu ligula.';

class ListItemPage extends StatelessWidget {
  const ListItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return DemoPageScaffold(
      body: Column(
        children: [
          SBBListHeader('Listed'),
          SBBContentBox(
            child: Column(
              children: SBBDivider.divideItems(
                context: context,
                items: [
                  SBBListItem(
                    titleText: 'Default',
                    leadingIconData: SBBIcons.dog_small,
                    onTap: () => sbbToast.show(titleText: 'Default'),
                  ),
                  SBBListItem(
                    titleText: 'Without Icon',
                    onTap: () => sbbToast.show(titleText: 'Without Icon'),
                  ),
                  SBBListItem(
                    titleText: 'With Subtext',
                    subtitleText: loremIpsum,
                    leadingIconData: SBBIcons.dog_small,
                    onTap: () => sbbToast.show(titleText: 'With Subtext'),
                  ),
                  SBBListItem(
                    titleText: 'With Trailing Icon',
                    leadingIconData: SBBIcons.dog_small,
                    trailingIconData: SBBIcons.chevron_small_right_small,
                    onTap: () => sbbToast.show(titleText: 'With Trailing Icon'),
                  ),
                  SBBListItem(
                    titleText: 'With Button',
                    leadingIconData: SBBIcons.dog_small,
                    trailingIconButton: SBBTertiaryButtonSmall(onPressed: () {}, iconData: SBBIcons.dog_small),
                    onTap: () => sbbToast.show(titleText: 'Mit Button'),
                  ),
                  SBBListItem(
                    titleText: 'With Status Message',
                    subtitle: SBBStatus.information(labelText: 'Lorem ipsum sit dolor amet unt.'),
                    onTap: () => sbbToast.show(titleText: 'With Status Message'),
                  ),
                  SBBListItem(
                    title: Text('With Links'),
                    leadingIconData: SBBIcons.globe_small,
                    onTap: () => sbbToast.show(titleText: 'With Links'),
                    links: [
                      SBBListItem(
                        titleText: 'Link',
                        trailingIconData: SBBIcons.chevron_small_right_small,
                        onTap: () => sbbToast.show(titleText: 'Link'),
                      ),
                      SBBListItem(
                        titleText: 'Link 2',
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
                titleText: 'Without Icon',
                onTap: () => sbbToast.show(titleText: 'Without Icon'),
              ),
              SBBListItemBoxed(
                titleText: 'With Subtext',
                subtitleText: loremIpsum,
                leadingIconData: SBBIcons.dog_small,
                onTap: () => sbbToast.show(titleText: 'With Subtext'),
              ),
              SBBListItemBoxed(
                titleText: 'With Trailing Icon',
                leadingIconData: SBBIcons.dog_small,
                trailingIconData: SBBIcons.chevron_small_right_small,
                onTap: () => sbbToast.show(titleText: 'With Trailing Icon'),
              ),
              SBBListItemBoxed(
                titleText: 'Loading',
                leadingIconData: SBBIcons.dog_small,
                onTap: () => sbbToast.show(titleText: 'Loading'),
                isLoading: true,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SBBSpacing.xSmall),
            child: SBBListHeader('Dynamically generated'),
          ),
          Padding(
            padding: EdgeInsets.all(SBBSpacing.xSmall).copyWith(bottom: SBBSpacing.xLarge),
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 50,
              itemBuilder: (context, idx) => SBBListItem(
                onTap: () {},
                titleText: 'Index ${idx + 1}',
              ),
              separatorBuilder: SBBDivider.separatorBuilder,
            ),
          ),
        ],
      ),
    );
  }
}
