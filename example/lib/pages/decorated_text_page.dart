import 'package:material_ui/material_ui.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class DecoratedTextPage extends StatelessWidget {
  const DecoratedTextPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);

    return DemoPageScaffold(
      body: Column(
        children: [
          SBBListHeader('Listed'),
          SBBContentBox(
            child: Column(
              mainAxisSize: .min,
              children: SBBDivider.divideItems(
                context: context,
                items: [
                  SBBDecoratedText(
                    value: '',
                    decoration: SBBDecoration(
                      labelText: 'Empty',
                    ),
                    onTap: () => sbbToast.show(titleText: 'Empty'),
                  ),
                  SBBDecoratedText(
                    value: '',
                    decoration: SBBDecoration(
                      labelText: 'With Placeholder',
                      placeholderText: 'Placeholder',
                    ),
                    onTap: () {
                      sbbToast.show(titleText: 'Empty');
                    },
                  ),
                  SBBDecoratedText(
                    decoration: SBBDecoration(labelText: 'Label', leadingIconData: SBBIcons.dog_small),
                    value: 'Value',
                    onTap: () {
                      sbbToast.show(titleText: 'With Leading Icon');
                    },
                  ),
                  SBBDecoratedText(
                    decoration: SBBDecoration(
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
                    decoration: SBBDecoration(
                      labelText: 'Label',
                      leadingIconData: SBBIcons.dog_small,
                      trailing: SBBTertiaryButtonSmall(
                        onPressed: () {
                          sbbToast.show(titleText: 'Button Pressed');
                        },
                        iconData: SBBIcons.dog_small,
                      ),
                      style: SBBDecorationStyle(
                        contentPadding: .only(left: SBBSpacing.medium, right: SBBSpacing.xSmall),
                      ),
                    ),
                    value: 'Value',
                    onTap: () {
                      sbbToast.show(titleText: 'With Button');
                    },
                  ),
                  SBBDecoratedText(
                    decoration: SBBDecoration(
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
                    decoration: SBBDecoration(
                      leadingIconData: SBBIcons.dog_small,
                      labelText: 'Multiple Lines',
                      style: SBBDecorationStyle(
                        contentPadding: .only(left: SBBSpacing.medium, top: SBBSpacing.xSmall),
                      ),
                    ),
                    value: 'I am \nmulti \nline',
                  ),
                  SBBDecoratedText(
                    decoration: SBBDecoration(labelText: 'Disabled', leadingIconData: SBBIcons.dog_small),
                    value: 'Value',
                    onTap: null,
                  ),
                  SizedBox(
                    height: 120.0,
                    child: SBBDecoratedText(
                      expands: true,
                      maxLines: null,
                      decoration: SBBDecoration(
                        leadingIconData: SBBIcons.dog_small,
                        labelText: 'Expands',
                        style: SBBDecorationStyle(
                          contentPadding: EdgeInsets.only(
                            left: SBBSpacing.medium,
                            top: SBBSpacing.xSmall,
                          ),
                        ),
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
                decoration: SBBDecoration(
                  labelText: 'Empty',
                  leadingIconData: SBBIcons.unicorn_small,
                ),
              ),
              SBBDecoratedTextBoxed(
                onTap: () => sbbToast.show(titleText: 'Trailing Icon'),
                value: 'Value',
                decoration: SBBDecoration(
                  labelText: 'With Trailing Icon',
                  leadingIconData: SBBIcons.unicorn_small,
                  trailingIconData: SBBIcons.circle_information_small_small,
                ),
              ),
              SBBDecoratedTextBoxed(
                value: '',
                onTap: () => sbbToast.show(titleText: 'Placeholder'),
                decoration: SBBDecoration(
                  labelText: 'With Placeholder',
                  placeholderText: 'Placeholder',
                  leadingIconData: SBBIcons.unicorn_small,
                ),
              ),
              SBBDecoratedTextBoxed(
                onTap: () => sbbToast.show(titleText: 'Button'),
                value: 'Value',
                decoration: SBBDecoration(
                  labelText: 'With Custom Button',
                  placeholderText: 'Press the Button!',
                  leadingIconData: SBBIcons.unicorn_small,
                  trailing: SBBTertiaryButtonSmall(
                    iconData: SBBIcons.dog_small,
                    onPressed: () => sbbToast.show(titleText: 'Button pressed'),
                  ),
                  style: SBBDecorationStyle(
                    contentPadding: .only(left: SBBSpacing.medium, right: SBBSpacing.xSmall),
                  ),
                ),
              ),
              SBBDecoratedTextBoxed(
                onTap: () => sbbToast.show(titleText: 'Error'),
                value: 'With Error',
                decoration: SBBDecoration(
                  labelText: 'With Error',
                  errorText: 'Error Text',
                  leadingIconData: SBBIcons.unicorn_small,
                ),
              ),
              SBBDecoratedTextBoxed(
                value: 'Disabled',
                onTap: null,
                decoration: SBBDecoration(leadingIconData: SBBIcons.unicorn_small, labelText: 'Disabled'),
              ),
              SizedBox(
                height: 120.0,
                child: SBBDecoratedTextBoxed(
                  expands: true,
                  maxLines: null,
                  value: 'I expand to fill\nthe available\nheight',
                  onTap: () => sbbToast.show(titleText: 'Expands'),
                  decoration: SBBDecoration(
                    leadingIconData: SBBIcons.unicorn_small,
                    labelText: 'Expands',
                    style: SBBDecorationStyle(
                      contentPadding: EdgeInsets.only(
                        left: SBBSpacing.medium,
                        top: SBBSpacing.xSmall,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
