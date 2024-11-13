import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class LinkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: <Widget>[
        const ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        SBBGroup(
          padding: const EdgeInsets.all(sbbDefaultSpacing),
          child: SBBLinkText(
            text:
                '''We are using a subset of the Markdown syntax for recognizing links in a text:

Inline-style link - [text](url)
[AppBakery SharePoint](https://sbb.sharepoint.com/sites/app-bakery)

URL in angle brackets - <url>
<https://sbb.sharepoint.com/sites/app-bakery>

Just the plain URL - url
https://sbb.sharepoint.com/sites/app-bakery''',
            onLaunch: (link) {
              sbbToast.show(message: link);
            },
          ),
        ),
      ],
    );
  }
}
