import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class LinkPage extends StatelessWidget {
  const LinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return ListView(
      padding: const .all(SBBSpacing.medium),
      children: <Widget>[
        const ThemeModeSegmentedButton(),
        const SizedBox(height: SBBSpacing.medium),
        SBBContentBox(
          padding: const .all(SBBSpacing.medium),
          child: SBBLinkText(
            text: '''We are using a subset of the Markdown syntax for recognizing links in a text:

Inline-style link - [text](url)
[AppBakery SharePoint](https://sbb.sharepoint.com/sites/app-bakery)

URL in angle brackets - <url>
<https://sbb.sharepoint.com/sites/app-bakery>

Just the plain URL - url
https://sbb.sharepoint.com/sites/app-bakery''',
            onLaunch: (link) {
              sbbToast.show(title: link);
            },
          ),
        ),
      ],
    );
  }
}
