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
          _toolbarHeightSized(SBBHeader(titleText: 'No leading Widget', automaticallyImplyLeading: false)),
          SizedBox(height: SBBSpacing.medium),
          _toolbarHeightSized(SBBHeader(titleText: 'Menu', leading: SBBHeaderLeadingMenuButton())),
          SizedBox(height: SBBSpacing.medium),
          _toolbarHeightSized(SBBHeader(titleText: 'Back', leading: SBBHeaderLeadingBackButton())),
          SizedBox(height: SBBSpacing.medium),
          _toolbarHeightSized(SBBHeader(titleText: 'Close', leading: SBBHeaderLeadingCloseButton())),
          SBBListHeader('Small'),
          SBBHeaderSmall(titleText: 'No leading Widget', automaticallyImplyLeading: false),
          SizedBox(height: SBBSpacing.medium),
          SBBHeaderSmall(titleText: 'Menu', leading: SBBHeaderLeadingMenuButton()),
          SizedBox(height: SBBSpacing.medium),
          SBBHeaderSmall(titleText: 'Back', leading: SBBHeaderLeadingBackButton()),
          SizedBox(height: SBBSpacing.medium),
          SBBHeaderSmall(titleText: 'Close', leading: SBBHeaderLeadingCloseButton()),
        ],
      ),
    );
  }

  /// needed as [SBBHeader] set's a bottom widget as spacer which leads to unconstrainted height.
  Widget _toolbarHeightSized(SBBHeader header) {
    return SizedBox(
      height: SBBHeaderStyle.toolbarHeight,
      child: header,
    );
  }
}
