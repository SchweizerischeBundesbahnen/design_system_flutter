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
            vertical: SBBSpacing.xSmall,
            horizontal: SBBSpacing.xSmall,
          ).copyWith(bottom: SBBSpacing.xLarge),
          sliver: SliverList.list(
            children: [
              SBBListHeader('Listed'),
              SBBContentBox(
                child: Column(
                  children: SBBListItem.divideListItems(
                    context: context,
                    items: [
                      SBBTextInput(
                        decoration: SBBInputDecoration(
                          contentPadding: const EdgeInsets.only(top: SBBSpacing.xSmall),
                          leadingIconData: SBBIcons.unicorn_small,
                          trailingIconData: SBBIcons.circle_information_small_small,
                          labelText: 'Label',
                        ),
                        controller: defaultTextEditingController,
                        maxLines: 3,
                      ),
                      SBBTextInput(
                        decoration: SBBInputDecoration(
                          contentPadding: const EdgeInsets.only(top: SBBSpacing.xSmall),
                          leadingIconData: SBBIcons.unicorn_small,
                          trailingIconData: SBBIcons.circle_information_small_small,
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
                      SBBTextInput(
                        decoration: SBBInputDecoration(
                          contentPadding: const EdgeInsets.only(top: SBBSpacing.xSmall),
                          leadingIconData: SBBIcons.unicorn_small,
                          trailingIconData: SBBIcons.circle_information_small_small,
                          labelText: 'I extend from one line to maximum three lines!',
                        ),
                        controller: emptyTextEditingController,
                        maxLines: 3,
                        minLines: 1,
                      ),
                    ],
                  ).toList(growable: false),
                ),
              ),
              SizedBox(height: SBBSpacing.medium),
              SBBListHeader('Resizable with Drag Handle'),
              SBBContentBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 60.0,
                        maxHeight: _expandableHeight,
                      ),
                      child: SBBTextInput(
                        decoration: SBBInputDecoration(
                          contentPadding: const EdgeInsets.only(top: SBBSpacing.xSmall),
                          labelText: 'Resizable Text Area',
                          leadingIconData: SBBIcons.pen_small,
                          placeholderText: 'Drag the handle below to resize...',
                        ),
                        controller: expandableTextEditingController,
                        expands: true,
                        maxLines: null,
                      ),
                    ),
                    GestureDetector(
                      onVerticalDragUpdate: (details) {
                        setState(() {
                          _expandableHeight = (_expandableHeight + details.delta.dy).clamp(60.0, 400.0);
                        });
                      },
                      child: Container(
                        height: SBBSpacing.xLarge,
                        color: SBBColors.silver,
                        child: Center(
                          child: Container(
                            width: SBBSpacing.xLarge,
                            height: SBBSpacing.xxSmall,
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
              SizedBox(height: SBBSpacing.medium),
              SBBListHeader('Boxed'),
              SBBTextInputBoxed(
                decoration: SBBInputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: SBBSpacing.small,
                    horizontal: SBBSpacing.medium,
                  ),
                  leadingIconData: SBBIcons.unicorn_small,
                  trailingIconData: SBBIcons.circle_information_small_small,
                  labelText: 'Label',
                ),
                controller: defaultTextEditingController,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
