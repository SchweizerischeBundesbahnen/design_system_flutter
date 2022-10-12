import 'package:design_system_flutter/design_system_flutter.dart';
import 'package:flutter/material.dart';

class ToastPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sbbToast = SBBToast.of(context);
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
                            'Toast',
                            color: SBBColors.red,
                          ),
                          SBBGroup(
                            padding: const EdgeInsets.all(sbbDefaultSpacing),
                            child: Column(
                              children: [
                                SBBGhostButton(
                                  label: 'Show Toast - Short (Default)',
                                  onPressed: () {
                                    sbbToast.show(
                                      message:
                                          'const SBBToast.durationShort: ${SBBToast.durationShort.inSeconds} seconds',
                                    );
                                  },
                                ),
                                const SizedBox(height: sbbDefaultSpacing),
                                SBBGhostButton(
                                  label: 'Show Toast - Long',
                                  onPressed: () {
                                    sbbToast.show(
                                      message:
                                          'const SBBToast.durationLong: ${SBBToast.durationLong.inSeconds} seconds',
                                      duration: SBBToast.durationLong,
                                    );
                                  },
                                ),
                                const SizedBox(height: sbbDefaultSpacing),
                                SBBGhostButton(
                                  label: 'Show Toast - 5 Seconds',
                                  onPressed: () {
                                    sbbToast.show(
                                      message:
                                          'This is a Toast with a duration of 5 seconds.',
                                      duration:
                                          const Duration(seconds: 5),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: sbbDefaultSpacing),
                          SBBGroup(
                            padding: const EdgeInsets.all(sbbDefaultSpacing),
                            child: Column(
                              children: [
                                SBBGhostButton(
                                  label: 'Confirmation Toast',
                                  onPressed: () {
                                    sbbToast.confirmation(
                                      message:
                                      'This is a confirmation toast!',
                                    );
                                  },
                                ),
                                const SizedBox(height: sbbDefaultSpacing),
                                SBBGhostButton(
                                  label: 'Warning Toast',
                                  onPressed: () {
                                    sbbToast.warning(
                                      message:
                                      'This is a warning toast!',
                                      duration: SBBToast.durationLong,
                                    );
                                  },
                                ),
                                const SizedBox(height: sbbDefaultSpacing),
                                SBBGhostButton(
                                  label: 'Error Toast',
                                  onPressed: () {
                                    sbbToast.error(
                                      message:
                                      'This is a error toast!',
                                      duration:
                                      const Duration(seconds: 5),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),


                          const SizedBox(height: sbbDefaultSpacing),
                          SBBListHeader('Additional Toast actions'),
                          SBBGroup(
                            padding: const EdgeInsets.all(sbbDefaultSpacing),
                            child: Column(
                              children: [
                                SBBGhostButton(
                                  label: 'Hide (with exit animation)',
                                  onPressed: () {
                                    sbbToast.hide();
                                  },
                                ),
                                const SizedBox(height: sbbDefaultSpacing),
                                SBBGhostButton(
                                  label:
                                      'Remove (without exit animation)',
                                  onPressed: () {
                                    sbbToast.remove();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ])))));
  }
}
