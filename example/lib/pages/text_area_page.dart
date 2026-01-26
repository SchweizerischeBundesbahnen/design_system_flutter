import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class TextAreaPage extends StatefulWidget {
  const TextAreaPage({super.key});

  @override
  State<TextAreaPage> createState() => _TextAreaPageState();
}

class _TextAreaPageState extends State<TextAreaPage> {
  String? errorText;
  double _expandableHeight = 100.0;

  final emptyTextEditingController = TextEditingController();
  final defaultTextEditingController = TextEditingController.fromValue(TextEditingValue(text: 'This is a Text Area!'));
  final errorTextEditingController = TextEditingController.fromValue(
    TextEditingValue(text: 'One more char and I\nscream!'),
  );
  final expandableTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(child: ThemeModeSegmentedButton()),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            vertical: sbbDefaultSpacing * .5,
            horizontal: sbbDefaultSpacing * .5,
          ).copyWith(bottom: sbbDefaultSpacing * 3),
          sliver: SliverList.list(
            children: [
              SBBListHeader('Listed'),
              SBBContentBox(
                child: Column(
                  children: SBBListItem.divideListItems(
                    context: context,
                    items: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SBBTextInput(
                          decoration: SBBInputDecoration(
                            leading: Padding(
                              padding: EdgeInsets.only(top: 4.0, right: 8.0),
                              child: Icon(
                                SBBIcons.unicorn_small,
                              ),
                            ),
                            trailing: Padding(
                              padding: EdgeInsets.only(top: 4.0, left: 8.0),
                              child: Icon(
                                SBBIcons.circle_information_small_small,
                              ),
                            ),
                            labelText: 'Label',
                          ),
                          controller: defaultTextEditingController,
                          maxLines: 3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SBBTextInput(
                          decoration: SBBInputDecoration(
                            leading: Padding(
                              padding: EdgeInsets.only(top: 4.0, right: 8.0),
                              child: Icon(
                                SBBIcons.unicorn_small,
                              ),
                            ),
                            trailing: Padding(
                              padding: EdgeInsets.only(top: 4.0, left: 8.0),
                              child: Icon(
                                SBBIcons.circle_information_small_small,
                              ),
                            ),
                            labelText: 'Label',
                            errorText: errorText,
                          ),
                          controller: errorTextEditingController,
                          maxLines: 2,
                          onChanged: (value) {
                            if (errorText == null && value.length > 27) {
                              setState(() {
                                errorText = 'SCREAAAAAM! AAAAAH!';
                              });
                            } else if (errorText != null && value.length <= 27) {
                              setState(() {
                                errorText = null;
                              });
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SBBTextInput(
                          decoration: SBBInputDecoration(
                            leading: Padding(
                              padding: EdgeInsets.only(top: 4.0, right: 8.0),
                              child: Icon(
                                SBBIcons.unicorn_small,
                              ),
                            ),
                            trailing: Padding(
                              padding: EdgeInsets.only(top: 4.0, left: 8.0),
                              child: Icon(
                                SBBIcons.circle_information_small_small,
                              ),
                            ),
                            labelText: 'I extend from one line to maximum three lines!',
                          ),
                          controller: emptyTextEditingController,
                          maxLines: 3,
                          minLines: 1,
                        ),
                      ),
                    ],
                  ).toList(growable: false),
                ),
              ),
              SizedBox(height: sbbDefaultSpacing),
              SBBListHeader('Resizable with Drag Handle'),
              SBBContentBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 60.0,
                          maxHeight: _expandableHeight,
                        ),
                        child: SBBTextInput(
                          decoration: SBBInputDecoration(
                            labelText: 'Resizable Text Area',
                            leading: Padding(
                              padding: EdgeInsets.only(top: 4.0, right: 8.0),
                              child: Icon(
                                SBBIcons.pen_small,
                              ),
                            ),

                            placeholderText: 'Drag the handle below to resize...',
                          ),
                          controller: expandableTextEditingController,
                          expands: true,
                          maxLines: null,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onVerticalDragUpdate: (details) {
                        setState(() {
                          _expandableHeight = (_expandableHeight + details.delta.dy).clamp(60.0, 400.0);
                        });
                      },
                      child: Container(
                        height: 32,
                        color: SBBColors.silver,
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: SBBColors.iron,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: sbbDefaultSpacing),
              SBBListHeader('Boxed'),
              SBBContentBox(
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: SBBTextFormField(
                    labelText: 'Label',
                    hintText: 'Minimum of 8 characters',
                    controller: TextEditingController(),
                    validator: (value) => (value?.length ?? 0) > 7 ? null : 'Minimum of 8 characters required',
                    isLastElement: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
