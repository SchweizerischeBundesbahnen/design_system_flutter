import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class AccordionPage extends StatefulWidget {
  const AccordionPage({Key? key}) : super(key: key);

  @override
  State<AccordionPage> createState() => _AccordionPageState();
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
          'The max title lines can be configured. Remaining text with ellipsis.',
      text:
          'The max title lines can be configured. Remaining text with ellipsis.',
    ),
    _Item(
      title: 'Lorem ipsum',
      text:
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
    ),
  ];

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
                        'Accordion',
                        color: SBBColors.red,
                      ),
                      SBBWebText.headerTwo('Single Accordion'),
                      SizedBox(
                        width: 400,
                        child: SBBAccordion.single(
                          title: 'Title text',
                          body: Text(
                              'The body is only visible when the Accordion item is expanded.'),
                          isExpanded: _singleAccordionExpanded,
                          singleAccordionCallback: (isExpanded) {
                            setState(() {
                              _singleAccordionExpanded = !isExpanded;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: sbbDefaultSpacing),
                      SBBWebText.headerTwo('Multi Accordion'),
                      SizedBox(
                        width: 400,
                        child: SBBAccordion(
                          titleMaxLines: 1,
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
                    ])),
          )),
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
