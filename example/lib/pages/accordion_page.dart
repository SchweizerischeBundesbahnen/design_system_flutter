import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class AccordionPage extends StatefulWidget {
  @override
  _AccordionPageState createState() => _AccordionPageState();
}

class _AccordionPageState extends State<AccordionPage> {
  bool _singleAccordionExpanded = false;
  final List<_Item> _items1 = [
    _Item(
      title: 'Initially expanded',
      text:
          'This Accordion Item was already initially expanded. If you close the page and open it again, this item will be initially expanded again.',
      isExpanded: true,
    ),
    _Item(
      title:
          'The title text has only 1 line. So make sure to keep the title short.',
      text:
          'The title text has only 1 line. So make sure to keep the title short.',
    ),
    _Item(
      title: 'Lorem ipsum',
      text:
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
    ),
  ];
  int _expandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return ListView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      children: [
        ThemeModeSegmentedButton(),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Single item'),
        SBBGroup(
          child: SBBAccordion(
            accordionCallback: (int index, bool isExpanded) {
              setState(() {
                _singleAccordionExpanded = !isExpanded;
              });
            },
            children: [
              SBBAccordionItem(
                title: 'Title text',
                body: Text(
                  'The body is only visible when the Accordion item is expanded.',
                ),
                isExpanded: _singleAccordionExpanded,
              ),
            ],
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Multiple items (multiple expanded items allowed)'),
        SBBGroup(
          child: SBBAccordion(
            accordionCallback: (int index, bool isExpanded) {
              setState(() {
                _items1[index].isExpanded = !isExpanded;
              });
            },
            children: _items1.map<SBBAccordionItem>((_Item item) {
              return SBBAccordionItem.text(
                title: item.title,
                text: item.text,
                isExpanded: item.isExpanded,
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: sbbDefaultSpacing),
        const SBBListHeader('Multiple items (only one expanded item allowed)'),
        SBBGroup(
          child: SBBAccordion(
            accordionCallback: (int index, bool isExpanded) {
              setState(() {
                _expandedIndex = !isExpanded ? index : -1;
              });
            },
            children: [
              SBBAccordionItem.text(
                title: 'Text only',
                text:
                    'This Accordion Item was created using AccordionItem.text() that can be used for text only items. With this you only have to pass the text that should be displayed in the body instead of constructing the body widget yourself.',
                isExpanded: _expandedIndex == 0,
              ),
              SBBAccordionItem(
                title: 'Custom content',
                isExpanded: _expandedIndex == 1,
                body: Container(
                  color: SBBColors.cloud,
                  child: Column(
                    children: [
                      Text(
                          'This item was created with the default constructor where the complete body widget has to be defined. But as you can see by the body background color, there is still a default padding around the body if no custom padding is specified.'),
                      const SizedBox(
                        height: sbbDefaultSpacing,
                      ),
                      SBBTertiaryButtonLarge(
                          label: 'Button',
                          onPressed: () {
                            sbbToast.show(
                                message: 'This button does nothing...');
                          }),
                    ],
                  ),
                ),
              ),
              SBBAccordionItem(
                title: 'Custom content, custom padding',
                body: Container(
                  color: SBBColors.cloud,
                  child: Text(
                    'As you can see by the body background color, there is no padding around this body.',
                    style: SBBTextStyles.extraLargeLight,
                  ),
                ),
                padding: EdgeInsets.zero,
                isExpanded: _expandedIndex == 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Item {
  _Item({
    required this.title,
    required this.text,
    this.isExpanded = false,
  });

  String title;
  String text;
  bool isExpanded;
}
