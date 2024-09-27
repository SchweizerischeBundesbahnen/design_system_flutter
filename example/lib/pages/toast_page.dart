import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

import '../native_app.dart';

class ToastPage extends StatelessWidget {
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
                      child: SBBTertiaryButtonLarge(
                        label: 'Show Toast - Short (Default)',
                        onPressed: () {
                          sbbToast.show(
                            message:
                                'const SBBToast.durationShort: ${SBBToast.durationShort.inSeconds} seconds',
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: sbbDefaultSpacing),
                Row(
                  children: [
                    Expanded(
                      child: SBBTertiaryButtonLarge(
                        label: 'Show Toast - Long',
                        onPressed: () {
                          sbbToast.show(
                            message:
                                'const SBBToast.durationLong: ${SBBToast.durationLong.inSeconds} seconds',
                            duration: SBBToast.durationLong,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: sbbDefaultSpacing),
                Row(
                  children: [
                    Expanded(
                      child: SBBTertiaryButtonLarge(
                        label: 'Show Toast - 5 Seconds',
                        onPressed: () {
                          sbbToast.show(
                            message:
                                'This is a Toast with a duration of 5 seconds.',
                            duration: const Duration(seconds: 5),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: sbbDefaultSpacing),
          const SBBListHeader('Additional Toast actions'),
          SBBGroup(
            padding: const EdgeInsets.all(sbbDefaultSpacing),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SBBTertiaryButtonLarge(
                        label: 'Hide (with exit animation)',
                        onPressed: () {
                          sbbToast.hide();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: sbbDefaultSpacing),
                Row(
                  children: [
                    Expanded(
                      child: SBBTertiaryButtonLarge(
                        label: 'Remove (without exit animation)',
                        onPressed: () {
                          sbbToast.remove();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
