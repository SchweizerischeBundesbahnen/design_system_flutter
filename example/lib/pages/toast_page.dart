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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(sbbDefaultSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const ThemeModeSegmentedButton(),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Show Toast'),
          SBBGroup(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SBBSecondaryButton(
                        labelText: 'Short (Default)',
                        onPressed: () {
                          sbbToast.show(
                            title: titleController.text,
                            action:
                                actionController.text.isNotEmpty
                                    ? SBBToastAction(onPressed: () {}, title: actionController.text)
                                    : null,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: sbbDefaultSpacing),
                    Expanded(
                      child: SBBTertiaryButton(
                        labelText: 'Long',
                        onPressed: () {
                          sbbToast.show(
                            title: titleController.text,
                            duration: SBBToast.durationLong,
                            action:
                                actionController.text.isNotEmpty
                                    ? SBBToastAction(onPressed: () {}, title: actionController.text)
                                    : null,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: sbbDefaultSpacing),
                SizedBox(
                  width: double.infinity,
                  child: SBBTertiaryButton(
                    labelText: 'Custom Bottom and Duration',
                    onPressed: () {
                      sbbToast.show(
                        title: titleController.text,
                        duration: const Duration(seconds: 5),
                        action:
                            actionController.text.isNotEmpty
                                ? SBBToastAction(onPressed: () {}, title: actionController.text)
                                : null,
                        bottom: 128,
                      );
                    },
                  ),
                ),
                const SizedBox(height: sbbDefaultSpacing),
                SizedBox(
                  width: double.infinity,
                  child: SBBTertiaryButton(
                    labelText: 'Custom Toast',
                    onPressed: () => sbbToast.builder(builder: (showToast) => _customToast(showToast)),
                  ),
                ),
              ],
            ),
          ),
          const SBBListHeader('Additional Toast actions'),
          SBBGroup(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: Row(
              children: [
                Expanded(
                  child: SBBSecondaryButton(
                    labelText: 'Hide',
                    onPressed: () {
                      sbbToast.hide();
                    },
                  ),
                ),
                const SizedBox(width: sbbDefaultSpacing),
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
          const SizedBox(height: sbbDefaultSpacing * 2),
          const SBBListHeader('Edit Toast Content'),
          SBBGroup(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: Column(
              children: [
                SBBTextField(labelText: 'Toast Title', controller: titleController),
                SBBTextField(labelText: 'Toast Action (empty action will hide action)', controller: actionController),
              ],
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder<bool> _customToast(Stream<bool> showToast) {
    return StreamBuilder(
      stream: showToast,
      builder:
          (context, snap) =>
              snap.data ?? false
                  ? DecoratedBox(
                    decoration: ShapeDecoration(shape: CircleBorder(), color: SBBColors.red),
                    child: SizedBox.fromSize(size: Size(100, 100)),
                  )
                  : SizedBox.shrink(),
    );
  }
}
