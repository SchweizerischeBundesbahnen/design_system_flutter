import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class RadiobuttonPage extends StatelessWidget {
  const RadiobuttonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Content();
  }
}

class _Content extends StatefulWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  int? _groupValue = 1;
  int? _listItemGroupValue;
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(color: SBBColors.white),
        child: SingleChildScrollView(
          primary: false,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SBBWebText.headerOne(
                    'Radiobuttons',
                    color: SBBColors.red,
                  ),
                  SBBGroup(
                    padding: const EdgeInsets.all(sbbDefaultSpacing / 2),
                    child: Row(
                      children: [
                        SBBRadioButton<int>(
                          groupValue: _groupValue,
                          onChanged: (newValue) {
                            setState(() {
                              _groupValue = newValue;
                            });
                          },
                          value: 1,
                        ),
                        SBBRadioButton<int>(
                          groupValue: _groupValue,
                          onChanged: null,
                          value: 2,
                        ),
                        SBBRadioButton<int>(
                          groupValue: _groupValue,
                          onChanged: (newValue) {
                            setState(() {
                              _groupValue = newValue;
                            });
                          },
                          value: 2,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 600,
                    child: Column(
                      children: [
                        SBBRadioButtonListItem<int>(
                          value: 1,
                          groupValue: _listItemGroupValue,
                          onChanged: (newValue) {
                            setState(() {
                              _listItemGroupValue = newValue;
                            });
                          },
                          label: 'Label',
                        ),
                        SBBRadioButtonListItem<int>(
                          value: 2,
                          groupValue: _listItemGroupValue,
                          onChanged: (newValue) {
                            setState(() {
                              _listItemGroupValue = newValue;
                            });
                          },
                          label: 'Call to Action',
                          trailingIcon: SBBIconsSmall.circle_information_small_small,
                          onCallToAction: (){},
                        ),
                        SBBRadioButtonListItem<int>(
                          value: 3,
                          groupValue: _listItemGroupValue,
                          onChanged: (newValue) {
                            setState(() {
                              _listItemGroupValue = newValue;
                            });
                          },
                          label: 'Icon',
                          leadingIcon: SBBIconsSmall.alarm_clock_small,
                        ),
                        SBBRadioButtonListItem<int>(
                          value: 4,
                          groupValue: _listItemGroupValue,
                          onChanged: (newValue) {
                            setState(() {
                              _listItemGroupValue = newValue;
                            });
                          },
                          label: 'Icon, Call to Action',
                          leadingIcon: SBBIconsSmall.alarm_clock_small,
                          trailingIcon: SBBIconsSmall.circle_information_small_small,
                          onCallToAction: (){},
                        ),
                        SBBRadioButtonListItem<int>(
                          value: 4,
                          groupValue: _listItemGroupValue,
                          onChanged: null,
                          label: 'Disabled, Icon, Call to Action',
                          leadingIcon: SBBIconsSmall.alarm_clock_small,
                          trailingIcon: SBBIconsSmall.circle_information_small_small,
                          onCallToAction: (){},
                        ),
                        SBBRadioButtonListItem<int>.custom(
                          value: 5,
                          groupValue: _listItemGroupValue,
                          onChanged: (newValue) {
                            setState(() {
                              _listItemGroupValue = newValue;
                            });
                          },
                          label: 'Custom trailing Widget',
                          trailingWidget: const Padding(
                            padding: const EdgeInsetsDirectional.only(
                              top: sbbDefaultSpacing / 4 * 3,
                              end: sbbDefaultSpacing,
                            ),
                            child: Text('CHF 0.99'),
                          ),
                        ),
                        SBBRadioButtonListItem<int>(
                          value: 6,
                          groupValue: _listItemGroupValue,
                          onChanged: (newValue) {
                            setState(() {
                              _listItemGroupValue = newValue;
                            });
                          },
                          label: 'Multiline Label with\nSecondary Label',
                          allowMultilineLabel: true,
                          secondaryLabel:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut convallis leo et metus semper hendrerit. Duis nec nunc a ligula cursus vulputate. Donec sed elit ultricies, euismod erat et, eleifend augue.',
                          isLastElement: true,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
