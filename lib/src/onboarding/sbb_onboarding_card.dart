import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../design_system_flutter.dart';

class SBBOnboardingCard extends StatelessWidget {
  const SBBOnboardingCard({
    required this.widgetBuilder,
    this.onDismissed,
    Key? key,
  }) : super(key: key);

  SBBOnboardingCard.basic({required Widget embeddedChild, required String title, required String content, VoidCallback? onDismissed, Key? key})
      : this.extended(
          embeddedChild: embeddedChild,
          title: title,
          content: content,
          customContent: null,
          onDismissed: onDismissed,
          key: key,
        );

  SBBOnboardingCard.extended(
      {required Widget embeddedChild, required String title, required String content, required Widget? customContent, VoidCallback? onDismissed, Key? key})
      : this(
          key: key,
          onDismissed: onDismissed,
          widgetBuilder: (BuildContext context) => Column(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: embeddedChild,
                ),
              ),
              const SizedBox(height: 16.0),
              MergeSemantics(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        title,
                        style: SBBTextStyles.largeBold.copyWith(
                          height: 22.0 / 18.0,
                          color: SBBTheme.of(context).isDark ? SBBColors.white : SBBColors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        content,
                        style: SBBTextStyles.mediumLight.copyWith(
                          color: SBBTheme.of(context).isDark ? SBBColors.white : SBBColors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              if (customContent != null) customContent,
            ],
          ),
        );

  final WidgetBuilder widgetBuilder;
  final VoidCallback? onDismissed;

  @override
  Widget build(BuildContext context) => widgetBuilder(context);
}
