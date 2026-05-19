import 'package:flutter/material.dart';
import 'package:flutter_design_system_mobile_example/pages/scaffold/demo_page_scaffold.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

class HeaderPage extends StatelessWidget {
  const HeaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoPageScaffold(
      body: Column(
        children: [
          SBBListHeader('Default'),
          Column(
            spacing: SBBSpacing.medium,
            children: [
              _toolbarHeightSized(SBBHeader(titleText: 'No leading Widget', automaticallyImplyLeading: false)),
              _toolbarHeightSized(SBBHeader(titleText: 'Menu', leading: SBBHeaderLeadingMenuButton())),
              _toolbarHeightSized(SBBHeader(titleText: 'Back', leading: SBBHeaderLeadingBackButton())),
              _toolbarHeightSized(SBBHeader(titleText: 'Close', leading: SBBHeaderLeadingCloseButton())),
            ],
          ),

          SBBListHeader('Small'),
          Column(
            spacing: SBBSpacing.medium,
            children: [
              SBBHeaderSmall(titleText: 'No leading Widget', automaticallyImplyLeading: false),
              SBBHeaderSmall(titleText: 'Menu', leading: SBBHeaderLeadingMenuButton()),
              SBBHeaderSmall(titleText: 'Back', leading: SBBHeaderLeadingBackButton()),
              SBBHeaderSmall(titleText: 'Close', leading: SBBHeaderLeadingCloseButton()),
              _toolbarHeightSized(
                SBBHeaderSmall(
                  titleText: 'With a Header-Box',
                  automaticallyImplyLeading: false,
                  bottom: SBBHeaderBoxPreferredSize(
                    titleText: 'This is a Header-Box',
                    subtitleText: 'With a subtitle',
                    trailing: SBBTertiaryButton(
                      onPressed: () {},
                      iconData: SBBIcons.child_adult_small,
                    ),
                    textScaler: MediaQuery.textScalerOf(context),
                    flap: SBBHeaderBoxFlapPreferredSize(
                      labelText: 'And a flap.',
                      textScaler: MediaQuery.textScalerOf(context),
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

  /// needed as [SBBHeader] sets a bottom widget as spacer which leads to unconstrainted height.
  Widget _toolbarHeightSized(SBBHeader header) {
    return SizedBox(
      height: header.preferredSize.height,
      child: header,
    );
  }
}
