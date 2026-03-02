import 'package:flutter/material.dart';
import 'package:sbb_design_system_mobile/sbb_design_system_mobile.dart';

import '../native_app.dart';

class ToastPage extends StatefulWidget {
  const ToastPage({super.key});

  @override
  State<ToastPage> createState() => _ToastPageState();
}

class _ToastPageState extends State<ToastPage> {
  final titleController = TextEditingController(text: 'This is a short title.');
  final actionController = TextEditingController(text: 'Hide');

  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
    return CustomScrollView(
      slivers: [
        SBBSliverHeaderbox.custom(
          child: Column(
            crossAxisAlignment: .start,
            spacing: SBBSpacing.xSmall,
            children: [
              const ThemeModeSegmentedButton(),
              SizedBox(height: SBBSpacing.xSmall),
              Text('Edit Toast Content', style: sbbTextStyle.small.boldStyle),
              SBBTextInput(
                decoration: SBBInputDecoration(labelText: 'Toast Title'),
                controller: titleController,
              ),
              SBBTextInput(
                decoration: SBBInputDecoration(labelText: 'Toast Action (empty action will hide action)'),
                controller: actionController,
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: SBBSpacing.xSmall),
          sliver: SliverList.list(
            children: [
              const SizedBox(height: SBBSpacing.medium),
              const SBBListHeader('Show Toast'),
              SBBContentBox(
                padding: const .all(SBBSpacing.medium),
                child: Column(
                  spacing: SBBSpacing.medium,
                  children: [
                    SBBPrimaryButton(
                      labelText: 'Show default',
                      onPressed: () {
                        sbbToast.show(
                          titleText: titleController.text,
                          action: actionController.text.isNotEmpty
                              ? SBBToastAction(onTap: () {}, title: actionController.text)
                              : null,
                        );
                      },
                    ),
                    SBBSecondaryButton(
                      labelText: 'Show with long duration',
                      onPressed: () {
                        sbbToast.show(
                          titleText: titleController.text,
                          duration: SBBToast.durationLong,
                          action: actionController.text.isNotEmpty
                              ? SBBToastAction(onTap: () {}, title: actionController.text)
                              : null,
                        );
                      },
                    ),
                    Row(
                      spacing: SBBSpacing.xSmall,
                      children: [
                        Expanded(
                          child: SBBTertiaryButton(
                            labelText: 'Custom bottom spacing and duration',
                            onPressed: () {
                              sbbToast.show(
                                titleText: titleController.text,
                                duration: const Duration(seconds: 5),
                                action: actionController.text.isNotEmpty
                                    ? SBBToastAction(onTap: () {}, title: actionController.text)
                                    : null,
                                bottom: 128,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: SBBTertiaryButton(
                            labelText: 'Completely custom toast',
                            iconData: SBBIcons.flame_warning_light_small,
                            onPressed: () {
                              sbbToast.builder(builder: (context, showToast) => _customToast(showToast));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SBBListHeader('Additional Toast actions'),
              SBBContentBox(
                padding: const .all(SBBSpacing.medium),
                child: Row(
                  spacing: SBBSpacing.xSmall,
                  children: [
                    Expanded(
                      child: SBBTertiaryButton(
                        labelText: 'Hide',
                        onPressed: () {
                          sbbToast.hide();
                        },
                      ),
                    ),
                    Expanded(
                      child: SBBTertiaryButton(
                        labelText: 'Remove',
                        onPressed: () {
                          sbbToast.remove();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  StreamBuilder<bool> _customToast(Stream<bool> showToast) {
    return StreamBuilder(
      stream: showToast,
      builder: (context, snap) => snap.data ?? false
          ? DecoratedBox(
              decoration: ShapeDecoration(shape: CircleBorder(), color: SBBColors.red),
              child: SizedBox.fromSize(size: Size(100, 100)),
            )
          : SizedBox.shrink(),
    );
  }
}
