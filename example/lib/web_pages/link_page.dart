import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class LinkPage extends StatelessWidget {
  const LinkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: DecoratedBox(
            decoration: BoxDecoration(color: SBBColors.white),
            child: SingleChildScrollView(
                primary: false,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SBBWebText.headerOne(
                            'Link',
                            color: SBBColors.red,
                          ),
                          SBBLinkText(
                            text:
                                '''We are using a subset of the Markdown syntax for recognizing links in a text:

Inline-style link - [text](url)
[AppBakery SharePoint](https://sbb.sharepoint.com/sites/app-bakery)

URL in angle brackets - <url>
<https://sbb.sharepoint.com/sites/app-bakery>

Just the plain URL - url
https://sbb.sharepoint.com/sites/app-bakery''',
                            onLaunch: (link) {
                              html.window.open(link, '_blank');
                            },
                          )
                        ])))));
  }
}
