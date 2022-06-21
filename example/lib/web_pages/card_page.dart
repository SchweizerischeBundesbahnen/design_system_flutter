import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
                primary: false,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SBBWebText.headerOne(
                          'Card',
                          color: SBBColors.red,
                        ),
                        SBBWebText.headerThree('- Standard'),
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: SBBCard(
                            title: 'Link Example',
                            body: SBBLinkText(
                              text: '''[SBB Home](https://www.sbb.ch)''',
                              onLaunch: (link) {
                                html.window.open(link, '_blank');
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SBBWebText.headerThree('- Sized Card'),
                        SBBCard.sized(
                            width: 400,
                            height: 200,
                            title: 'Long Text Example',
                            body: Text(
                              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
                              maxLines: 6,
                              style: SBBWebTextStyles.medium
                                  .copyWith(overflow: TextOverflow.ellipsis),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        SBBWebText.headerThree('- Icon'),
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: SBBCard.icon(
                            icon: SBBIcons.house_medium,
                            body: SBBWebText.running('Take me Home'),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SBBWebText.headerThree('- Image with onTap callback'),
                        SizedBox(
                          width: 400,
                          height: 400,
                          child: SBBCard.image(
                            head: Image.asset('assets/images/sbbtrain.jpg'),
                            title: 'Image Example',
                            body: SBBWebText.running(
                                'You are able add an image as head in card item'),
                            onTap: () {
                              html.window.open('https://www.sbb.ch', '_blank');
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )))));
  }
}
